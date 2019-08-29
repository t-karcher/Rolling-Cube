extends MeshInstance

var t : Transform 
var offset = Vector3.ZERO
var rot_speed = .15 # smaller numbers = higher speed

func _ready():
	transform = transform.translated(Vector3(1,1,1))
	t = transform

func _input(event):
	if event.is_action_pressed("ui_left") and !$Tween.is_active():
		tween_rot(Vector3(0,0,1), 1)
		offset = Vector3(-2,0,0)
	if event.is_action_pressed("ui_right") and !$Tween.is_active():
		get_parent().translate(Vector3(2,0,0))
		transform = transform.translated(Vector3(-2,0,0))	
		tween_rot(Vector3(0,0,1), -1)
		offset = Vector3(0,0,0)
	if event.is_action_pressed("ui_up") and !$Tween.is_active():
		tween_rot(Vector3(1,0,0), -1)
		offset = Vector3(0,0,-2)
	if event.is_action_pressed("ui_down") and !$Tween.is_active():
		get_parent().translate(Vector3(0,0,2))
		transform = transform.translated(Vector3(0,0,-2))
		tween_rot(Vector3(1,0,0), 1)
		offset = Vector3(0,0,0)

func tween_rot(axis, direction):
	$Tween.interpolate_property(self,"transform",null,transform.rotated(axis, PI/4 * direction),rot_speed,Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.interpolate_property(self,"transform",transform.rotated(axis, PI/4 * direction), transform.rotated(axis, PI/2 * direction),rot_speed,Tween.TRANS_SINE, Tween.EASE_OUT, rot_speed)
	$Tween.start()

func _on_Tween_tween_all_completed():
	transform = t # reset transformation
	get_parent().translate(offset) # move cube