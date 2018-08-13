Received: from eggs.gnu.org ([2001:4830:134:3::10]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpBYM-0000Mq-4C
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpBYI-0002eI-Ut
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:02:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpBYI-0002eD-OW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:02:26 -0400
References: <20180813102037.12097-1-jusual@mail.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9aee6f27-6a6d-2703-f49d-78c6bd3f7bc3@redhat.com>
Date: Mon, 13 Aug 2018 14:02:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180813102037.12097-1-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

Thanks Julia, just a few cleanups to simplify the prototypes of some
functions.

On 13/08/2018 12:20, Julia Suvorova wrote:
> New option "websock" added to allow using websocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websock,id=3D...
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 75 ++++++++++++++++++++++++++++++++++++-------
>  chardev/char.c        |  3 ++
>  qapi/char.json        |  3 ++
>  3 files changed, 70 insertions(+), 11 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index efbad6ee7c..4464446511 100644
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
> =20
> +    bool is_websock;
> +
>      GSource *reconnect_timer;
>      int64_t reconnect_time;
>      bool connect_err_reported;
> @@ -386,12 +389,14 @@ static void tcp_chr_free_connection(Chardev *chr)
>  }
> =20
>  static char *SocketAddress_to_str(const char *prefix, SocketAddress *a=
ddr,
> -                                  bool is_listen, bool is_telnet)
> +                                  bool is_listen, bool is_telnet,
> +                                  bool is_websock)

The only caller passes the four arguments as "s->addr, s->is_listen,
s->is_telner, s->is_websock".  Can you change the arguments to
"SocketChardev *s, const char *prefix" and rename to
qemu_chr_socket_address?  Or even remove "const char *prefix" and rename
to "qemu_chr_compute_disconnected_filename", as you prefer.

>  {
>      switch (addr->type) {
>      case SOCKET_ADDRESS_TYPE_INET:
>          return g_strdup_printf("%s%s:%s:%s%s", prefix,
> -                               is_telnet ? "telnet" : "tcp",
> +                               is_telnet ? "telnet"
> +                                         : (is_websock ? "websock" : "=
tcp"),
>                                 addr->u.inet.host,
>                                 addr->u.inet.port,
>                                 is_listen ? ",server" : "");
> @@ -420,7 +425,8 @@ static void update_disconnected_filename(SocketChar=
dev *s)
> =20
>      g_free(chr->filename);
>      chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
> -                                         s->is_listen, s->is_telnet);
> +                                         s->is_listen, s->is_telnet,
> +                                         s->is_websock);
>  }
> =20
>  /* NB may be called even if tcp_chr_connect has not been
> @@ -508,7 +514,7 @@ static int tcp_chr_sync_read(Chardev *chr, const ui=
nt8_t *buf, int len)
> =20
>  static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss=
_len,
>                               struct sockaddr_storage *ps, socklen_t ps=
_len,
> -                             bool is_listen, bool is_telnet)
> +                             bool is_listen, bool is_telnet, bool is_w=
ebsock)

Likewise here, the function only needs a single argument SocketChardev
*s and can be renamed to qemu_chr_compute_filename (since the result is
assigned to chr->filename).

>  {
>      char shost[NI_MAXHOST], sserv[NI_MAXSERV];
>      char phost[NI_MAXHOST], pserv[NI_MAXSERV];
> @@ -531,7 +537,8 @@ static char *sockaddr_to_str(struct sockaddr_storag=
e *ss, socklen_t ss_len,
>          getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phos=
t),
>                      pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICS=
ERV);
>          return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
> -                               is_telnet ? "telnet" : "tcp",
> +                               is_telnet ? "telnet"
> +                                         : (is_websock ? "websock" : "=
tcp"),

... and finally add a new function
qemu_chr_socket_protocol(SocketChardev *s) that returns one of "telnet",
"websock" or "tcp".

> diff --git a/qapi/char.json b/qapi/char.json
> index b7b2a05766..135ccddaf7 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -251,6 +251,8 @@
>  #          sockets (default: false)
>  # @tn3270: enable tn3270 protocol on server
>  #          sockets (default: false) (Since: 2.10)
> +# @websock: enable websocket protocol on server
> +#           sockets (default: false)

"(Since: 3.1)".

Thanks,

Paolo

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
> =20
>=20
