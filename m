Received: from eggs.gnu.org ([2001:4830:134:3::10]:46805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gDRoh-0007wf-5d
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gDRoa-0001j8-UZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:15:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gDRoT-0001UY-DF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:15:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so37600191qtl.8
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181018223501.21683-1-jusual@mail.ru>
	<20181018223501.21683-3-jusual@mail.ru>
In-Reply-To: <20181018223501.21683-3-jusual@mail.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Oct 2018 14:15:10 +0400
Message-ID: <CAMxuvawyME-vDek6mcbfwLcCE1iE9AmqUgu1_r+Ka9ejZyGodQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jusual@mail.ru
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Blake, Eric" <eblake@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, joel@jms.id.au, jim@groklearning.com, mail@steffen-goertz.de

Hi

On Fri, Oct 19, 2018 at 2:35 AM Julia Suvorova <jusual@mail.ru> wrote:
>
> New option "websocket" added to allow using WebSocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websocket,server,id=...
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 64 ++++++++++++++++++++++++++++++++++++++-----
>  chardev/char.c        |  8 +++++-
>  qapi/char.json        |  3 ++
>  qemu-options.hx       | 13 +++++++--
>  4 files changed, 77 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index effde65a89..ba4ae9dfb0 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -26,6 +26,7 @@
>  #include "chardev/char.h"
>  #include "io/channel-socket.h"
>  #include "io/channel-tls.h"
> +#include "io/channel-websock.h"
>  #include "io/net-listener.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> @@ -68,6 +69,8 @@ typedef struct {
>      GSource *telnet_source;
>      TCPChardevTelnetInit *telnet_init;
>
> +    bool is_websock;
> +
>      GSource *reconnect_timer;
>      int64_t reconnect_time;
>      bool connect_err_reported;
> @@ -394,7 +397,7 @@ static const char *qemu_chr_socket_protocol(SocketChardev *s)
>      if (s->is_telnet) {
>          return "telnet";
>      }
> -    return "tcp";
> +    return s->is_websock ? "websocket" : "tcp";
>  }
>
>  static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
> @@ -714,6 +717,41 @@ cont:
>  }
>
>
> +static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
> +{
> +    Chardev *chr = user_data;
> +    SocketChardev *s = user_data;
> +
> +    if (qio_task_propagate_error(task, NULL)) {
> +        tcp_chr_disconnect(chr);

What about error_report() the error?

> +    } else {
> +        if (s->do_telnetopt) {
> +            tcp_chr_telnet_init(chr);
> +        } else {
> +            tcp_chr_connect(chr);
> +        }
> +    }
> +}
> +
> +
> +static void tcp_chr_websock_init(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +    QIOChannelWebsock *wioc = NULL;
> +    gchar *name;
> +
> +    wioc = qio_channel_websock_new_server(s->ioc);
> +
> +    name = g_strdup_printf("chardev-websocket-server-%s", chr->label);
> +    qio_channel_set_name(QIO_CHANNEL(wioc), name);
> +    g_free(name);
> +    object_unref(OBJECT(s->ioc));
> +    s->ioc = QIO_CHANNEL(wioc);
> +
> +    qio_channel_websock_handshake(wioc, tcp_chr_websock_handshake, chr, NULL);
> +}
> +
> +
>  static void tcp_chr_tls_handshake(QIOTask *task,
>                                    gpointer user_data)
>  {
> @@ -723,7 +761,9 @@ static void tcp_chr_tls_handshake(QIOTask *task,
>      if (qio_task_propagate_error(task, NULL)) {
>          tcp_chr_disconnect(chr);
>      } else {
> -        if (s->do_telnetopt) {
> +        if (s->is_websock) {
> +            tcp_chr_websock_init(chr);
> +        } else if (s->do_telnetopt) {
>              tcp_chr_telnet_init(chr);
>          } else {
>              tcp_chr_connect(chr);
> @@ -809,12 +849,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
>
>      if (s->tls_creds) {
>          tcp_chr_tls_init(chr);
> +    } else if (s->is_websock) {
> +        tcp_chr_websock_init(chr);
> +    } else if (s->do_telnetopt) {
> +        tcp_chr_telnet_init(chr);
>      } else {
> -        if (s->do_telnetopt) {
> -            tcp_chr_telnet_init(chr);
> -        } else {
> -            tcp_chr_connect(chr);
> -        }
> +        tcp_chr_connect(chr);
>      }
>
>      return 0;
> @@ -959,13 +999,20 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
>      bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
>      bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
> +    bool is_websock     = sock->has_websocket ? sock->websocket : false;
>      int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
>      QIOChannelSocket *sioc = NULL;
>      SocketAddress *addr;
>
> +    if (!is_listen && is_websock) {
> +        error_setg(errp, "%s", "Websocket client is not implemented");
> +        goto error;
> +    }
> +
>      s->is_listen = is_listen;
>      s->is_telnet = is_telnet;
>      s->is_tn3270 = is_tn3270;
> +    s->is_websock = is_websock;
>      s->do_nodelay = do_nodelay;
>      if (sock->tls_creds) {
>          Object *creds;
> @@ -1072,6 +1119,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
>      bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
>      bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
> +    bool is_websock     = qemu_opt_get_bool(opts, "websocket", false);
>      bool do_nodelay     = !qemu_opt_get_bool(opts, "delay", true);
>      int64_t reconnect   = qemu_opt_get_number(opts, "reconnect", 0);
>      const char *path = qemu_opt_get(opts, "path");
> @@ -1120,6 +1168,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      sock->telnet = is_telnet;
>      sock->has_tn3270 = true;
>      sock->tn3270 = is_tn3270;
> +    sock->has_websocket = true;
> +    sock->websocket = is_websock;
>      sock->has_wait = true;
>      sock->wait = is_waitconnect;
>      sock->has_reconnect = true;
> diff --git a/chardev/char.c b/chardev/char.c
> index e115166995..a8790017e6 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -409,7 +409,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>      }
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
> -        strstart(filename, "tn3270:", &p)) {
> +        strstart(filename, "tn3270:", &p) ||
> +        strstart(filename, "websocket:", &p)) {
>          if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
>              host[0] = 0;
>              if (sscanf(p, ":%32[^,]%n", port, &pos) < 1)
> @@ -429,6 +430,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>              qemu_opt_set(opts, "telnet", "on", &error_abort);
>          } else if (strstart(filename, "tn3270:", &p)) {
>              qemu_opt_set(opts, "tn3270", "on", &error_abort);
> +        } else if (strstart(filename, "websocket:", &p)) {
> +            qemu_opt_set(opts, "websocket", "on", &error_abort);
>          }
>          return opts;
>      }
> @@ -860,6 +863,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "tls-creds",
>              .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "websocket",
> +            .type = QEMU_OPT_BOOL,
>          },{
>              .name = "width",
>              .type = QEMU_OPT_NUMBER,
> diff --git a/qapi/char.json b/qapi/char.json
> index b7b2a05766..79bac598a0 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -251,6 +251,8 @@
>  #          sockets (default: false)
>  # @tn3270: enable tn3270 protocol on server
>  #          sockets (default: false) (Since: 2.10)
> +# @websocket: enable websocket protocol on server
> +#           sockets (default: false) (Since: 3.1)
>  # @reconnect: For a client socket, if a socket is disconnected,
>  #          then attempt a reconnect after the given number of seconds.
>  #          Setting this to zero disables this function. (default: 0)
> @@ -265,6 +267,7 @@
>                                       '*nodelay'   : 'bool',
>                                       '*telnet'    : 'bool',
>                                       '*tn3270'    : 'bool',
> +                                     '*websocket' : 'bool',
>                                       '*reconnect' : 'int' },
>    'base': 'ChardevCommon' }
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f139459e80..022c793162 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2409,9 +2409,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev help\n"
>      "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4][,ipv6][,nodelay][,reconnect=seconds]\n"
> -    "         [,server][,nowait][,telnet][,reconnect=seconds][,mux=on|off]\n"
> +    "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
>      "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID] (tcp)\n"
> -    "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,reconnect=seconds]\n"
> +    "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
>      "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
>      "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
>      "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
> @@ -2539,7 +2539,7 @@ The available backends are:
>  A void device. This device will not emit any data, and will drop any data it
>  receives. The null backend does not take any options.
>
> -@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,reconnect=@var{seconds}][,tls-creds=@var{id}]
> +@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,websocket][,reconnect=@var{seconds}][,tls-creds=@var{id}]
>
>  Create a two-way stream socket, which can be either a TCP or a unix socket. A
>  unix socket will be created if @option{path} is specified. Behaviour is
> @@ -2553,6 +2553,9 @@ connect to a listening socket.
>  @option{telnet} specifies that traffic on the socket should interpret telnet
>  escape sequences.
>
> +@option{websocket} specifies that the socket uses WebSocket protocol for
> +communication.
> +
>  @option{reconnect} sets the timeout for reconnecting on non-server sockets when
>  the remote end goes away.  qemu will delay this many seconds and then attempt
>  to reconnect.  Zero disables reconnecting, and is the default.
> @@ -3101,6 +3104,10 @@ MAGIC_SYSRQ sequence if you use a telnet that supports sending the break
>  sequence.  Typically in unix telnet you do it with Control-] and then
>  type "send break" followed by pressing the enter key.
>
> +@item websocket:@var{host}:@var{port},server[,nowait][,nodelay]
> +The WebSocket protocol is used instead of raw tcp socket. The port acts as
> +a WebSocket server. Client mode is not supported.
> +
>  @item unix:@var{path}[,server][,nowait][,reconnect=@var{seconds}]
>  A unix domain socket is used instead of a tcp socket.  The option works the
>  same as if you had specified @code{-serial tcp} except the unix domain socket
> --
> 2.17.1
>
