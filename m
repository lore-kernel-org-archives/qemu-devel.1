Received: from eggs.gnu.org ([2001:4830:134:3::10]:59996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSVV-0002H8-PV
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSVQ-0004FR-Cg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSVO-0004Dc-B2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:59:48 -0400
Date: Fri, 19 Oct 2018 11:59:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019105934.GJ13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181018223501.21683-1-jusual@mail.ru>
	<20181018223501.21683-3-jusual@mail.ru>
	<CAMxuvawyME-vDek6mcbfwLcCE1iE9AmqUgu1_r+Ka9ejZyGodQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawyME-vDek6mcbfwLcCE1iE9AmqUgu1_r+Ka9ejZyGodQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: jusual@mail.ru, qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, joel@jms.id.au, jim@groklearning.com, mail@steffen-goertz.de

On Fri, Oct 19, 2018 at 02:15:10PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 19, 2018 at 2:35 AM Julia Suvorova <jusual@mail.ru> wrote:
> >
> > New option "websocket" added to allow using WebSocket protocol for
> > chardev socket backend.
> > Example:
> >     -chardev socket,websocket,server,id=3D...
> >
> > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > ---
> >  chardev/char-socket.c | 64 ++++++++++++++++++++++++++++++++++++++---=
--
> >  chardev/char.c        |  8 +++++-
> >  qapi/char.json        |  3 ++
> >  qemu-options.hx       | 13 +++++++--
> >  4 files changed, 77 insertions(+), 11 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index effde65a89..ba4ae9dfb0 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -26,6 +26,7 @@
> >  #include "chardev/char.h"
> >  #include "io/channel-socket.h"
> >  #include "io/channel-tls.h"
> > +#include "io/channel-websock.h"
> >  #include "io/net-listener.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/option.h"
> > @@ -68,6 +69,8 @@ typedef struct {
> >      GSource *telnet_source;
> >      TCPChardevTelnetInit *telnet_init;
> >
> > +    bool is_websock;
> > +
> >      GSource *reconnect_timer;
> >      int64_t reconnect_time;
> >      bool connect_err_reported;
> > @@ -394,7 +397,7 @@ static const char *qemu_chr_socket_protocol(Socke=
tChardev *s)
> >      if (s->is_telnet) {
> >          return "telnet";
> >      }
> > -    return "tcp";
> > +    return s->is_websock ? "websocket" : "tcp";
> >  }
> >
> >  static char *qemu_chr_socket_address(SocketChardev *s, const char *p=
refix)
> > @@ -714,6 +717,41 @@ cont:
> >  }
> >
> >
> > +static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_d=
ata)
> > +{
> > +    Chardev *chr =3D user_data;
> > +    SocketChardev *s =3D user_data;
> > +
> > +    if (qio_task_propagate_error(task, NULL)) {
> > +        tcp_chr_disconnect(chr);
>=20
> What about error_report() the error?

None of the rest of the code (telnet, tls, and other i/o related
funcs) uses error_report(). In some ways this is good as it
prevents a client app from flooding the qemu log file. It does
make debugging harder though when things are not working as
expected.

I wonder if we should add a tracing probe point in the
error_setg* methods in util/error.c ? There's quite a few
places in QEMU that discard errors which could benefit from
this when debugging.

I don't think it needs to blck this patch though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
