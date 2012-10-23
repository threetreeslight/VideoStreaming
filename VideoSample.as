

package {
  import flash.display.Sprite;
  import flash.media.Video;
  import flash.net.NetConnection;
  import flash.net.NetStream;
  import flash.events.*;


  [SWF(width="800",height="600",frameRate="24",backgroundColor="#000066")]
  public class VideoSample extends Sprite  {
  	private var streamingURL:String = "rtmp://s1vwndv4h594e4.cloudfront.net:1935/cfx/st";
  	private var play_nc:NetConnection;
  	private var play_ns:NetStream;
  	private var stat:Number;
  	private var video:Video;

  	public function VideoSample(){
      video = new Video(320,240);
      this.addChild(video);
      playVideo();
  	}
  	
  	public function playVideo():void{
	    play_nc = new NetConnection();
	    play_nc.client = new CustomClient();
	    play_nc.addEventListener(NetStatusEvent.NET_STATUS, play_netStatus);
	    play_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, netSecurityError);
	    play_nc.connect(streamingURL);
  	}
  	
  	private function play_netStatus(event:NetStatusEvent):void {
	    trace("netStatus: " + event.info.code);
	    if (event.info.code == "NetConnection.Connect.Success") {
    		play_ns = new NetStream(play_nc);
    		play_ns.play("track/1350742581811");
    		video.attachNetStream(play_ns);
	    } else{
  	    trace("error");
	    }
  	}
  
  	private function netSecurityError(event:SecurityErrorEvent):void {
	    trace("netSecurityError:" + event);
  	}

  }// end of VideoSample class
}

    



class CustomClient {
  public function onBWDone():void {
  	trace("onBWDone");
  }    
  public function onMetaData(infoObj:Object):void {
  	trace("onMetaData");
  }
  public function onPlayStatus(infoObj:Object):void {
		trace("playStatus");
  }
}