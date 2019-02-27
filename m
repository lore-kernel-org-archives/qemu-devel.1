Received: from eggs.gnu.org ([209.51.188.92]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gz0Ds-0000Hg-Cb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gz0Cw-0007Fl-A4
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:29:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gz0Cw-0007FP-3U
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:29:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so6075008wmh.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 06:29:14 -0800 (PST)
References: <20190227135523.16952-1-berrange@redhat.com>
	<20190227135523.16952-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <424db93e-70b1-8432-4570-74d44bf93305@redhat.com>
Date: Wed, 27 Feb 2019 15:29:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190227135523.16952-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] chardev: add support for authorization
 for TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2/27/19 2:55 PM, Daniel P. Berrangé wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Currently any client which can complete the TLS handshake is able to use
> a chardev server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509
> certificate. This means the client will have to acquire a certificate
> from the CA before they are permitted to use the chardev server. This is
> still a fairly low bar.
> 
> This adds a 'tls-authz=OBJECT-ID' option to the socket chardev backend
> which takes the ID of a previously added 'QAuthZ' object instance. This
> will be used to validate the client's x509 distinguished name. Clients
> failing the check will not be permitted to use the chardev server.
> 
> For example to setup authorization that only allows connection from a
> client whose x509 certificate distinguished name contains 'CN=fred', you
> would use:
> 
>   $QEMU -object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
>                 endpoint=server,verify-peer=yes \
>         -object authz-simple,id=authz0,identity=CN=laptop.example.com,,\
>                 O=Example Org,,L=London,,ST=London,,C=GB \
>         -chardev socket,host=127.0.0.1,port=9000,server,\
> 	         tls-creds=tls0,tls-authz=authz0 \
>         ...other qemu args...
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 12 +++++++++++-
>  chardev/char.c        |  3 +++
>  qapi/char.json        |  6 ++++++
>  qemu-options.hx       |  9 +++++++--
>  4 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4fcdd8aedd..12e78426aa 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -59,6 +59,7 @@ typedef struct {
>      QIONetListener *listener;
>      GSource *hup_source;
>      QCryptoTLSCreds *tls_creds;
> +    char *tls_authz;
>      TCPChardevState state;
>      int max_size;
>      int do_telnetopt;
> @@ -807,7 +808,7 @@ static void tcp_chr_tls_init(Chardev *chr)
>      if (s->is_listen) {
>          tioc = qio_channel_tls_new_server(
>              s->ioc, s->tls_creds,
> -            NULL, /* XXX Use an ACL */
> +            s->tls_authz,
>              &err);
>      } else {
>          tioc = qio_channel_tls_new_client(
> @@ -1055,6 +1056,7 @@ static void char_socket_finalize(Object *obj)
>      if (s->tls_creds) {
>          object_unref(OBJECT(s->tls_creds));
>      }
> +    g_free(s->tls_authz);
>  
>      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>  }
> @@ -1242,6 +1244,11 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>          break;
>      }
>  
> +    if (sock->has_tls_authz && !sock->has_tls_creds) {
> +        error_setg(errp, "'tls_authz' option requires 'tls_creds' option");
> +        return false;
> +    }
> +
>      /* Validate any options which have a dependancy on client vs server */
>      if (!sock->has_server || sock->server) {
>          if (sock->has_reconnect) {
> @@ -1320,6 +1327,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>              }
>          }
>      }
> +    s->tls_authz = g_strdup(sock->tls_authz);
>  
>      s->addr = addr = socket_address_flatten(sock->addr);
>  
> @@ -1399,6 +1407,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>      sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
>      sock->has_tls_creds = qemu_opt_get(opts, "tls-creds");
>      sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
> +    sock->has_tls_authz = qemu_opt_get(opts, "tls-authz");
> +    sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
>  
>      addr = g_new0(SocketAddressLegacy, 1);
>      if (path) {
> diff --git a/chardev/char.c b/chardev/char.c
> index f6d61fa5f8..514cd6b0c3 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -880,6 +880,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "tls-creds",
>              .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "tls-authz",
> +            .type = QEMU_OPT_STRING,
>          },{
>              .name = "websocket",
>              .type = QEMU_OPT_BOOL,
> diff --git a/qapi/char.json b/qapi/char.json
> index 77ed847972..7847c98d05 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -248,6 +248,11 @@
>  # @addr: socket address to listen on (server=true)
>  #        or connect to (server=false)
>  # @tls-creds: the ID of the TLS credentials object (since 2.6)
> +# @tls-authz: the ID of the QAuthZ authorization object against which
> +#             the client's x509 distinguished name will validated. This
> +#             object is only resolved at time of use, so can be deleted
> +#             and recreated on the fly while the chardev server is active.
> +#             If missing, it will default to denying access (since 4.0)
>  # @server: create server socket (default: true)
>  # @wait: wait for incoming connection on server
>  #        sockets (default: false).
> @@ -268,6 +273,7 @@
>  { 'struct': 'ChardevSocket',
>    'data': { 'addr': 'SocketAddressLegacy',
>              '*tls-creds': 'str',
> +            '*tls-authz'  : 'str',
>              '*server': 'bool',
>              '*wait': 'bool',
>              '*nodelay': 'bool',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1cf9aac1fe..aecbb2ca9c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2413,7 +2413,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4][,ipv6][,nodelay][,reconnect=seconds]\n"
>      "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
> -    "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID] (tcp)\n"
> +    "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
>      "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
>      "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
>      "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
> @@ -2542,7 +2542,7 @@ The available backends are:
>  A void device. This device will not emit any data, and will drop any data it
>  receives. The null backend does not take any options.
>  
> -@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,websocket][,reconnect=@var{seconds}][,tls-creds=@var{id}]
> +@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,websocket][,reconnect=@var{seconds}][,tls-creds=@var{id}][,tls-authz=@var{id}]
>  
>  Create a two-way stream socket, which can be either a TCP or a unix socket. A
>  unix socket will be created if @option{path} is specified. Behaviour is
> @@ -2568,6 +2568,11 @@ and specifies the id of the TLS credentials to use for the handshake. The
>  credentials must be previously created with the @option{-object tls-creds}
>  argument.
>  
> +@option{tls-auth} provides the ID of the QAuthZ authorization object against
> +which the client's x509 distinguished name will validated. This object is only
> +resolved at time of use, so can be deleted and recreated on the fly while the
> +chardev server is active. If missing, it will default to denying access.
> +
>  TCP and unix socket options are given below:
>  
>  @table @option
> 

LGTM:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
