Received: from eggs.gnu.org ([2001:4830:134:3::10]:56185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gZG4Q-0001j0-PX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gZG4N-0002sf-Ju
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:10:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gZG4N-0002ri-D9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:09:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so18236924qtq.9
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
In-Reply-To: <20181218100002.11219-2-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 16:24:26 +0400
Message-ID: <CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 1/7] chardev: Add disconnected
 option for chardev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, xieyongji@baidu.com

Hi

On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> New option "disconnected" is added to init the chardev socket
> in disconnected state. Then we can use qemu_chr_fe_wait_connected()
> to connect when necessary. Now it would be used for unix domain
> socket of vhost-user-blk device to support reconnect.

What difference does that make if you wait for connection in
qemu_chr_fe_wait_connected(), or during chardev setup?

"disconnected" is misleading, would it be possible to reuse
"wait/nowait" instead?

Tests would be welcome.

>
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
>  chardev/char-socket.c | 10 ++++++++++
>  chardev/char.c        |  3 +++
>  qapi/char.json        |  3 +++
>  qemu-options.hx       | 28 ++++++++++++++++------------
>  4 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index eaa8e8b68f..2464d7abad 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -70,6 +70,7 @@ typedef struct {
>      TCPChardevTelnetInit *telnet_init;
>
>      bool is_websock;
> +    bool is_disconnected;
>
>      GSource *reconnect_timer;
>      int64_t reconnect_time;
> @@ -1000,6 +1001,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
>      bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
>      bool is_websock     = sock->has_websocket ? sock->websocket : false;
> +    bool is_disconnected = sock->has_disconnected ? sock->disconnected : false;
>      int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
>      QIOChannelSocket *sioc = NULL;
>      SocketAddress *addr;
> @@ -1072,6 +1074,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          s->reconnect_time = reconnect;
>      }
>
> +    if (!s->is_listen && is_disconnected) {
> +        return;
> +    }
> +
>      if (s->reconnect_time) {
>          tcp_chr_connect_async(chr);
>      } else {
> @@ -1125,6 +1131,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
>      bool is_websock     = qemu_opt_get_bool(opts, "websocket", false);
>      bool do_nodelay     = !qemu_opt_get_bool(opts, "delay", true);
> +    bool is_disconnected = !is_listen &&
> +                           qemu_opt_get_bool(opts, "disconnected", false);
>      int64_t reconnect   = qemu_opt_get_number(opts, "reconnect", 0);
>      const char *path = qemu_opt_get(opts, "path");
>      const char *host = qemu_opt_get(opts, "host");
> @@ -1176,6 +1184,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      sock->websocket = is_websock;
>      sock->has_wait = true;
>      sock->wait = is_waitconnect;
> +    sock->has_disconnected = true;
> +    sock->disconnected = is_disconnected;
>      sock->has_reconnect = qemu_opt_find(opts, "reconnect");
>      sock->reconnect = reconnect;
>      sock->tls_creds = g_strdup(tls_creds);
> diff --git a/chardev/char.c b/chardev/char.c
> index ccba36bafb..fb916eb176 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -862,6 +862,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "delay",
>              .type = QEMU_OPT_BOOL,
> +        },{
> +            .name = "disconnected",
> +            .type = QEMU_OPT_BOOL,
>          },{
>              .name = "reconnect",
>              .type = QEMU_OPT_NUMBER,
> diff --git a/qapi/char.json b/qapi/char.json
> index 77ed847972..b634442229 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -258,6 +258,8 @@
>  #          sockets (default: false) (Since: 2.10)
>  # @websocket: enable websocket protocol on server
>  #           sockets (default: false) (Since: 3.1)
> +# @disconnected: init a client socket in disconnected
> +#                state (default: false) (Since: 4.0)
>  # @reconnect: For a client socket, if a socket is disconnected,
>  #          then attempt a reconnect after the given number of seconds.
>  #          Setting this to zero disables this function. (default: 0)
> @@ -274,6 +276,7 @@
>              '*telnet': 'bool',
>              '*tn3270': 'bool',
>              '*websocket': 'bool',
> +            '*disconnected': 'bool',
>              '*reconnect': 'int' },
>    'base': 'ChardevCommon' }
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index df42116ecc..f9d3495dc8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2418,10 +2418,10 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev help\n"
>      "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4][,ipv6][,nodelay][,reconnect=seconds]\n"
> -    "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
> -    "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID] (tcp)\n"
> -    "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
> -    "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
> +    "         [,server][,nowait][,telnet][,websocket][,disconnected][,reconnect=seconds]\n"
> +    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,tls-creds=ID] (tcp)\n"
> +    "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,disconnected]\n"
> +    "         [,reconnect=seconds][,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
>      "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
>      "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
>      "         [,logfile=PATH][,logappend=on|off]\n"
> @@ -2548,7 +2548,7 @@ The available backends are:
>  A void device. This device will not emit any data, and will drop any data it
>  receives. The null backend does not take any options.
>
> -@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,websocket][,reconnect=@var{seconds}][,tls-creds=@var{id}]
> +@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,websocket][,disconnected][,reconnect=@var{seconds}][,tls-creds=@var{id}]
>
>  Create a two-way stream socket, which can be either a TCP or a unix socket. A
>  unix socket will be created if @option{path} is specified. Behaviour is
> @@ -2565,6 +2565,9 @@ escape sequences.
>  @option{websocket} specifies that the socket uses WebSocket protocol for
>  communication.
>
> +@option{disconnected} specifies that the non-server socket should not try
> +to connect the remote during initialization.
> +
>  @option{reconnect} sets the timeout for reconnecting on non-server sockets when
>  the remote end goes away.  qemu will delay this many seconds and then attempt
>  to reconnect.  Zero disables reconnecting, and is the default.
> @@ -3087,18 +3090,19 @@ telnet on port 5555 to access the QEMU port.
>  localhost 5555
>  @end table
>
> -@item tcp:[@var{host}]:@var{port}[,@var{server}][,nowait][,nodelay][,reconnect=@var{seconds}]
> +@item tcp:[@var{host}]:@var{port}[,@var{server}][,nowait][,nodelay][,disconnected]
> +[,reconnect=@var{seconds}]
>  The TCP Net Console has two modes of operation.  It can send the serial
>  I/O to a location or wait for a connection from a location.  By default
>  the TCP Net Console is sent to @var{host} at the @var{port}.  If you use
>  the @var{server} option QEMU will wait for a client socket application
>  to connect to the port before continuing, unless the @code{nowait}
>  option was specified.  The @code{nodelay} option disables the Nagle buffering
> -algorithm.  The @code{reconnect} option only applies if @var{noserver} is
> -set, if the connection goes down it will attempt to reconnect at the
> -given interval.  If @var{host} is omitted, 0.0.0.0 is assumed. Only
> -one TCP connection at a time is accepted. You can use @code{telnet} to
> -connect to the corresponding character device.
> +algorithm.  If @var{noserver} is specified, the @code{disconnected} will disallow
> +QEMU to connect during initialization, and the @code{reconnect} will ask QEMU
> +to reconnect at the given interval when the connection goes down.  If @var{host}
> +is omitted, 0.0.0.0 is assumed. Only one TCP connection at a time is accepted.
> +You can use @code{telnet} to connect to the corresponding character device.
>  @table @code
>  @item Example to send tcp console to 192.168.0.2 port 4444
>  -serial tcp:192.168.0.2:4444
> @@ -3121,7 +3125,7 @@ type "send break" followed by pressing the enter key.
>  The WebSocket protocol is used instead of raw tcp socket. The port acts as
>  a WebSocket server. Client mode is not supported.
>
> -@item unix:@var{path}[,server][,nowait][,reconnect=@var{seconds}]
> +@item unix:@var{path}[,server][,nowait][,disconnected][,reconnect=@var{seconds}]
>  A unix domain socket is used instead of a tcp socket.  The option works the
>  same as if you had specified @code{-serial tcp} except the unix domain socket
>  @var{path} is used for connections.
> --
> 2.17.1
>
