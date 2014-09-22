package core
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	import org.flashdevelop.utils.FlashConnect;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width=400, height=400, frameRate=30)]
	/**
	 * ...
	 * @author Paraknight
	 */
	public class Main extends Sprite {
		
		public var worldScale:Number = 30;
		public var world:b2World = new b2World(new b2Vec2(0, 9.81), true);
		//private var txtHello:TextField = new TextField();
		
		public function Main():void {
			super();
			addEventListener(Event.ENTER_FRAME, update);
			debugDraw();
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
		}
		
		private function debugDraw():void {
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debugDraw);
		}
		
		private function addCircle(x:Number, y:Number):void {
			var body:b2BodyDef = new b2BodyDef();
			body.position.Set(x / worldScale, y / worldScale);
			body.type = b2Body.b2_dynamicBody;
			var circle:b2CircleShape = new b2CircleShape(10 / worldScale);
			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = circle;
			fixture.density = 1.0;
			fixture.friction = 1;
			var body2:b2Body = world.CreateBody(body);
			body2.CreateFixture(fixture);
		}
		
		private function update(e:Event):void {
			world.Step(1 / stage.frameRate, 10, 10);
			world.ClearForces();
			world.DrawDebugData();
		}
		
		private function mouseClick(event:MouseEvent):void {
			addCircle(event.stageX, event.stageY);
		}
		
		public static function sysout(line:String):void {
			FlashConnect.trace(line);
		}
	}
}