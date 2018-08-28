Received: from eggs.gnu.org ([2001:4830:134:3::10]:40977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuZty-0006wj-NN
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuZtr-0006hO-G9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:03:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fuZtr-0006hI-9T
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 05:02:59 -0400
Date: Tue, 28 Aug 2018 10:02:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828090249.GB25114@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180827184103.32190-1-jusual@mail.ru>
	<20180827184103.32190-2-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827184103.32190-2-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <mail@steffen-goertz.de>

On Mon, Aug 27, 2018 at 09:41:02PM +0300, Julia Suvorova wrote:
> New option "websock" added to allow using websocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websock,id=...
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 124 +++++++++++++++++++++++++++++++-----------
>  chardev/char.c        |   8 ++-
>  qapi/char.json        |   3 +
>  3 files changed, 103 insertions(+), 32 deletions(-)

Also needs changes to qemu-options.hx to document the new
websock option.  This doc ends up included in the main
qemu-doc.html published on the website, and also forms the
man page for qemu.

> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index efbad6ee7c..1d3c14d85d 100644
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
> @@ -69,6 +70,8 @@ typedef struct {
>      GSource *telnet_source;
>      TCPChardevTelnetInit *telnet_init;
>  
> +    bool is_websock;
> +
>      GSource *reconnect_timer;
>      int64_t reconnect_time;
>      bool connect_err_reported;
> @@ -385,30 +388,37 @@ static void tcp_chr_free_connection(Chardev *chr)
>      s->connected = 0;
>  }
>  
> -static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
> -                                  bool is_listen, bool is_telnet)
> +static const char *qemu_chr_socket_protocol(SocketChardev *s)
> +{
> +    if (s->is_telnet) {
> +        return "telnet";
> +    }
> +    return s->is_websock ? "websock" : "tcp";
> +}
> +
> +static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>  {
> -    switch (addr->type) {
> +    switch (s->addr->type) {
>      case SOCKET_ADDRESS_TYPE_INET:
>          return g_strdup_printf("%s%s:%s:%s%s", prefix,
> -                               is_telnet ? "telnet" : "tcp",
> -                               addr->u.inet.host,
> -                               addr->u.inet.port,
> -                               is_listen ? ",server" : "");
> +                               qemu_chr_socket_protocol(s),
> +                               s->addr->u.inet.host,
> +                               s->addr->u.inet.port,
> +                               s->is_listen ? ",server" : "");
>          break;
>      case SOCKET_ADDRESS_TYPE_UNIX:
>          return g_strdup_printf("%sunix:%s%s", prefix,
> -                               addr->u.q_unix.path,
> -                               is_listen ? ",server" : "");
> +                               s->addr->u.q_unix.path,
> +                               s->is_listen ? ",server" : "");
>          break;
>      case SOCKET_ADDRESS_TYPE_FD:
> -        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
> -                               is_listen ? ",server" : "");
> +        return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
> +                               s->is_listen ? ",server" : "");
>          break;
>      case SOCKET_ADDRESS_TYPE_VSOCK:
>          return g_strdup_printf("%svsock:%s:%s", prefix,
> -                               addr->u.vsock.cid,
> -                               addr->u.vsock.port);
> +                               s->addr->u.vsock.cid,
> +                               s->addr->u.vsock.port);
>      default:
>          abort();
>      }
> @@ -419,8 +429,7 @@ static void update_disconnected_filename(SocketChardev *s)
>      Chardev *chr = CHARDEV(s);
>  
>      g_free(chr->filename);
> -    chr->filename = SocketAddress_to_str("disconnected:", s->addr,
> -                                         s->is_listen, s->is_telnet);
> +    chr->filename = qemu_chr_socket_address(s, "disconnected:");
>  }
>  
>  /* NB may be called even if tcp_chr_connect has not been
> @@ -506,10 +515,12 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
>      return size;
>  }
>  
> -static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
> -                             struct sockaddr_storage *ps, socklen_t ps_len,
> -                             bool is_listen, bool is_telnet)
> +static char *qemu_chr_compute_filename(SocketChardev *s)
>  {
> +    struct sockaddr_storage *ss = &s->sioc->localAddr;
> +    struct sockaddr_storage *ps = &s->sioc->remoteAddr;
> +    socklen_t ss_len = s->sioc->localAddrLen;
> +    socklen_t ps_len = s->sioc->remoteAddrLen;
>      char shost[NI_MAXHOST], sserv[NI_MAXSERV];
>      char phost[NI_MAXHOST], pserv[NI_MAXSERV];
>      const char *left = "", *right = "";
> @@ -519,7 +530,7 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
>      case AF_UNIX:
>          return g_strdup_printf("unix:%s%s",
>                                 ((struct sockaddr_un *)(ss))->sun_path,
> -                               is_listen ? ",server" : "");
> +                               s->is_listen ? ",server" : "");
>  #endif
>      case AF_INET6:
>          left  = "[";
> @@ -531,9 +542,9 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
>          getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost),
>                      pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSERV);
>          return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
> -                               is_telnet ? "telnet" : "tcp",
> +                               qemu_chr_socket_protocol(s),
>                                 left, shost, right, sserv,
> -                               is_listen ? ",server" : "",
> +                               s->is_listen ? ",server" : "",
>                                 left, phost, right, pserv);
>  
>      default:
> @@ -547,10 +558,7 @@ static void tcp_chr_connect(void *opaque)
>      SocketChardev *s = SOCKET_CHARDEV(opaque);
>  
>      g_free(chr->filename);
> -    chr->filename = sockaddr_to_str(
> -        &s->sioc->localAddr, s->sioc->localAddrLen,
> -        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
> -        s->is_listen, s->is_telnet);
> +    chr->filename = qemu_chr_compute_filename(s);
>  
>      s->connected = 1;
>      chr->gsource = io_add_watch_poll(chr, s->ioc,

Everything above this point is refactoring of existing code, mixed in with
a few websock additions.

Everything below this is implementing the websocket feature.

These two distinct tasks should be separated, so that refactoring is in
the first patch, and websocks impl is in a second patch.

> @@ -699,6 +707,48 @@ cont:
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
> +    if (s->is_listen) {
> +        wioc = qio_channel_websock_new_server(s->ioc);
> +    };

You've already rejected the !is_listen codepath later on, so
this if () is redundant and can be removed.

> +
> +    if (wioc == NULL) {
> +        tcp_chr_disconnect(chr);
> +        return;
> +    }

qio_channel_websock_new_server() cannot fail, so wioc will never
be NULL.

> +    name = g_strdup_printf("chardev-websock-server-%s", chr->label);
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
> @@ -708,7 +758,9 @@ static void tcp_chr_tls_handshake(QIOTask *task,
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
> @@ -799,12 +851,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
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
> @@ -948,14 +1000,21 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_listen      = sock->has_server  ? sock->server  : true;
>      bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
>      bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
> +    bool is_websock     = sock->has_websock ? sock->websock : false;
>      bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
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
> @@ -1061,6 +1120,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
>      bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
>      bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
> +    bool is_websock     = qemu_opt_get_bool(opts, "websock", false);
>      bool do_nodelay     = !qemu_opt_get_bool(opts, "delay", true);
>      int64_t reconnect   = qemu_opt_get_number(opts, "reconnect", 0);
>      const char *path = qemu_opt_get(opts, "path");
> @@ -1109,6 +1169,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      sock->telnet = is_telnet;
>      sock->has_tn3270 = true;
>      sock->tn3270 = is_tn3270;
> +    sock->has_websock = true;
> +    sock->websock = is_websock;
>      sock->has_wait = true;
>      sock->wait = is_waitconnect;
>      sock->has_reconnect = true;
> diff --git a/chardev/char.c b/chardev/char.c
> index 1ab80e0f68..c045b8183b 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -404,7 +404,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
>      }
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
> -        strstart(filename, "tn3270:", &p)) {
> +        strstart(filename, "tn3270:", &p) ||
> +        strstart(filename, "websock:", &p)) {
>          if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
>              host[0] = 0;
>              if (sscanf(p, ":%32[^,]%n", port, &pos) < 1)
> @@ -424,6 +425,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
>              qemu_opt_set(opts, "telnet", "on", &error_abort);
>          } else if (strstart(filename, "tn3270:", &p)) {
>              qemu_opt_set(opts, "tn3270", "on", &error_abort);
> +        } else if (strstart(filename, "websock:", &p)) {
> +            qemu_opt_set(opts, "websock", "on", &error_abort);
>          }
>          return opts;
>      }
> @@ -837,6 +840,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "tls-creds",
>              .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "websock",
> +            .type = QEMU_OPT_BOOL,
>          },{
>              .name = "width",
>              .type = QEMU_OPT_NUMBER,
> diff --git a/qapi/char.json b/qapi/char.json
> index b7b2a05766..aa48a150a8 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -251,6 +251,8 @@
>  #          sockets (default: false)
>  # @tn3270: enable tn3270 protocol on server
>  #          sockets (default: false) (Since: 2.10)
> +# @websock: enable websocket protocol on server
> +#           sockets (default: false) (Since: 3.1)
>  # @reconnect: For a client socket, if a socket is disconnected,
>  #          then attempt a reconnect after the given number of seconds.
>  #          Setting this to zero disables this function. (default: 0)
> @@ -265,6 +267,7 @@
>                                       '*nodelay'   : 'bool',
>                                       '*telnet'    : 'bool',
>                                       '*tn3270'    : 'bool',
> +                                     '*websock'   : 'bool',
>                                       '*reconnect' : 'int' },
>    'base': 'ChardevCommon' }
>  
> -- 
> 2.17.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
