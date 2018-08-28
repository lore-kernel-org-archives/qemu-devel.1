Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fub3o-00065V-7K
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuaw9-0000P1-JW
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:09:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fuaw8-0000OU-UZ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:09:25 -0400
Date: Tue, 28 Aug 2018 11:09:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828100914.GE25114@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180827184103.32190-1-jusual@mail.ru>
	<20180827184103.32190-2-jusual@mail.ru>
	<20180828090249.GB25114@redhat.com>
	<c5fbae21-21cb-db73-dd2e-029f0e2d5126@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5fbae21-21cb-db73-dd2e-029f0e2d5126@mail.ru>
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 28, 2018 at 01:04:41PM +0300, Julia Suvorova wrote:
> On 28.08.2018 12:02, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Aug 27, 2018 at 09:41:02PM +0300, Julia Suvorova wrote:
> > > New option "websock" added to allow using websocket protocol for
> > > chardev socket backend.
> > > Example:
> > >      -chardev socket,websock,id=3D...
> > >=20
> > > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > > ---
> > >   chardev/char-socket.c | 124 +++++++++++++++++++++++++++++++------=
-----
> > >   chardev/char.c        |   8 ++-
> > >   qapi/char.json        |   3 +
> > >   3 files changed, 103 insertions(+), 32 deletions(-)
> >=20
> > Also needs changes to qemu-options.hx to document the new
> > websock option.  This doc ends up included in the main
> > qemu-doc.html published on the website, and also forms the
> > man page for qemu.
> >=20
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index efbad6ee7c..1d3c14d85d 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -26,6 +26,7 @@
> > >   #include "chardev/char.h"
> > >   #include "io/channel-socket.h"
> > >   #include "io/channel-tls.h"
> > > +#include "io/channel-websock.h"
> > >   #include "io/net-listener.h"
> > >   #include "qemu/error-report.h"
> > >   #include "qemu/option.h"
> > > @@ -69,6 +70,8 @@ typedef struct {
> > >       GSource *telnet_source;
> > >       TCPChardevTelnetInit *telnet_init;
> > > +    bool is_websock;
> > > +
> > >       GSource *reconnect_timer;
> > >       int64_t reconnect_time;
> > >       bool connect_err_reported;
> > > @@ -385,30 +388,37 @@ static void tcp_chr_free_connection(Chardev *=
chr)
> > >       s->connected =3D 0;
> > >   }
> > > -static char *SocketAddress_to_str(const char *prefix, SocketAddres=
s *addr,
> > > -                                  bool is_listen, bool is_telnet)
> > > +static const char *qemu_chr_socket_protocol(SocketChardev *s)
> > > +{
> > > +    if (s->is_telnet) {
> > > +        return "telnet";
> > > +    }
> > > +    return s->is_websock ? "websock" : "tcp";
> > > +}
> > > +
> > > +static char *qemu_chr_socket_address(SocketChardev *s, const char =
*prefix)
> > >   {
> > > -    switch (addr->type) {
> > > +    switch (s->addr->type) {
> > >       case SOCKET_ADDRESS_TYPE_INET:
> > >           return g_strdup_printf("%s%s:%s:%s%s", prefix,
> > > -                               is_telnet ? "telnet" : "tcp",
> > > -                               addr->u.inet.host,
> > > -                               addr->u.inet.port,
> > > -                               is_listen ? ",server" : "");
> > > +                               qemu_chr_socket_protocol(s),
> > > +                               s->addr->u.inet.host,
> > > +                               s->addr->u.inet.port,
> > > +                               s->is_listen ? ",server" : "");
> > >           break;
> > >       case SOCKET_ADDRESS_TYPE_UNIX:
> > >           return g_strdup_printf("%sunix:%s%s", prefix,
> > > -                               addr->u.q_unix.path,
> > > -                               is_listen ? ",server" : "");
> > > +                               s->addr->u.q_unix.path,
> > > +                               s->is_listen ? ",server" : "");
> > >           break;
> > >       case SOCKET_ADDRESS_TYPE_FD:
> > > -        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str=
,
> > > -                               is_listen ? ",server" : "");
> > > +        return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.=
str,
> > > +                               s->is_listen ? ",server" : "");
> > >           break;
> > >       case SOCKET_ADDRESS_TYPE_VSOCK:
> > >           return g_strdup_printf("%svsock:%s:%s", prefix,
> > > -                               addr->u.vsock.cid,
> > > -                               addr->u.vsock.port);
> > > +                               s->addr->u.vsock.cid,
> > > +                               s->addr->u.vsock.port);
> > >       default:
> > >           abort();
> > >       }
> > > @@ -419,8 +429,7 @@ static void update_disconnected_filename(Socket=
Chardev *s)
> > >       Chardev *chr =3D CHARDEV(s);
> > >       g_free(chr->filename);
> > > -    chr->filename =3D SocketAddress_to_str("disconnected:", s->add=
r,
> > > -                                         s->is_listen, s->is_telne=
t);
> > > +    chr->filename =3D qemu_chr_socket_address(s, "disconnected:");
> > >   }
> > >   /* NB may be called even if tcp_chr_connect has not been
> > > @@ -506,10 +515,12 @@ static int tcp_chr_sync_read(Chardev *chr, co=
nst uint8_t *buf, int len)
> > >       return size;
> > >   }
> > > -static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_=
t ss_len,
> > > -                             struct sockaddr_storage *ps, socklen_=
t ps_len,
> > > -                             bool is_listen, bool is_telnet)
> > > +static char *qemu_chr_compute_filename(SocketChardev *s)
> > >   {
> > > +    struct sockaddr_storage *ss =3D &s->sioc->localAddr;
> > > +    struct sockaddr_storage *ps =3D &s->sioc->remoteAddr;
> > > +    socklen_t ss_len =3D s->sioc->localAddrLen;
> > > +    socklen_t ps_len =3D s->sioc->remoteAddrLen;
> > >       char shost[NI_MAXHOST], sserv[NI_MAXSERV];
> > >       char phost[NI_MAXHOST], pserv[NI_MAXSERV];
> > >       const char *left =3D "", *right =3D "";
> > > @@ -519,7 +530,7 @@ static char *sockaddr_to_str(struct sockaddr_st=
orage *ss, socklen_t ss_len,
> > >       case AF_UNIX:
> > >           return g_strdup_printf("unix:%s%s",
> > >                                  ((struct sockaddr_un *)(ss))->sun_=
path,
> > > -                               is_listen ? ",server" : "");
> > > +                               s->is_listen ? ",server" : "");
> > >   #endif
> > >       case AF_INET6:
> > >           left  =3D "[";
> > > @@ -531,9 +542,9 @@ static char *sockaddr_to_str(struct sockaddr_st=
orage *ss, socklen_t ss_len,
> > >           getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof=
(phost),
> > >                       pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUM=
ERICSERV);
> > >           return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
> > > -                               is_telnet ? "telnet" : "tcp",
> > > +                               qemu_chr_socket_protocol(s),
> > >                                  left, shost, right, sserv,
> > > -                               is_listen ? ",server" : "",
> > > +                               s->is_listen ? ",server" : "",
> > >                                  left, phost, right, pserv);
> > >       default:
> > > @@ -547,10 +558,7 @@ static void tcp_chr_connect(void *opaque)
> > >       SocketChardev *s =3D SOCKET_CHARDEV(opaque);
> > >       g_free(chr->filename);
> > > -    chr->filename =3D sockaddr_to_str(
> > > -        &s->sioc->localAddr, s->sioc->localAddrLen,
> > > -        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
> > > -        s->is_listen, s->is_telnet);
> > > +    chr->filename =3D qemu_chr_compute_filename(s);
> > >       s->connected =3D 1;
> > >       chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> >=20
> > Everything above this point is refactoring of existing code, mixed in=
 with
> > a few websock additions.
> >=20
> > Everything below this is implementing the websocket feature.
> >=20
> > These two distinct tasks should be separated, so that refactoring is =
in
> > the first patch, and websocks impl is in a second patch.
>=20
> Thus, I will have second patch based on the first patch, and the
> first will contain code that will never be used. If it's okay, I will
> divide the patch.

Don't really know why you're saying the first patch code won't be used.
The code you're refactoring here is already used today, and you are just
renaming methods & changing what parameters are passed to it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
