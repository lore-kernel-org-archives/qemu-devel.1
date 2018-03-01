Received: from eggs.gnu.org ([2001:4830:134:3::10]:55224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erHi6-0005pb-Be
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erHi3-0001SY-6Q
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:28:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erHi3-0001Qm-0p
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:28:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51E2B40FB657
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 06:28:36 +0000 (UTC)
Date: Thu, 1 Mar 2018 14:28:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180301062826.GP27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-15-peterx@redhat.com>
	<20180228132237.GK17774@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228132237.GK17774@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/14] qio/chardev: specify gcontext for
 TLS handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:22:37PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 01:06:33PM +0800, Peter Xu wrote:
> > We allow the TLS code to be run with non-default gcontext by providin=
g a
> > new qio_channel_tls_handshake_full() API.
> >=20
> > With the new API, we can re-setup the TLS handshake GSource by callin=
g
> > it again with the correct gcontext.  Any call to the function will cl=
ean
> > up existing GSource tasks, and re-setup using the new gcontext.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c    | 30 +++++++++++++---
> >  include/io/channel-tls.h | 22 +++++++++++-
> >  io/channel-tls.c         | 91 ++++++++++++++++++++++++++++++++++++++=
++--------
> >  3 files changed, 123 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 164a64ff34..406d33c04f 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -72,6 +72,9 @@ typedef struct {
> > =20
> >  static gboolean socket_reconnect_timeout(gpointer opaque);
> >  static void tcp_chr_telnet_init(Chardev *chr);
> > +static void tcp_chr_tls_handshake_setup(Chardev *chr,
> > +                                        QIOChannelTLS *tioc,
> > +                                        GMainContext *context);
> > =20
> >  static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
> >  {
> > @@ -570,6 +573,7 @@ static void tcp_chr_telnet_destroy(SocketChardev =
*s)
> >  static void tcp_chr_update_read_handler(Chardev *chr)
> >  {
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > +    QIOChannelTLS *tioc;
> > =20
> >      if (s->listener) {
> >          /*
> > @@ -589,6 +593,17 @@ static void tcp_chr_update_read_handler(Chardev =
*chr)
> >          qio_task_context_set(s->thread_task, chr->gcontext);
> >      }
> > =20
> > +    tioc =3D (QIOChannelTLS *)object_dynamic_cast(OBJECT(s->ioc),
> > +                                                TYPE_QIO_CHANNEL_TLS=
);
> > +    if (tioc) {
> > +        /*
> > +         * TLS session enabled; reconfigure things up.  Note that, i=
f
> > +         * there is existing handshake task, it'll be cleaned up fir=
st
> > +         * in QIO code.
> > +         */
> > +        tcp_chr_tls_handshake_setup(chr, tioc, chr->gcontext);
> > +    }
>=20
> This is crazy - we should not be looking at specific implementations of
> the channel. If the TLS object needs to use a specific GMainContext we
> should make sure that is done right from the start and not try to chang=
e
> the GMainContext on the fly.

I'm not sure whether I can do it since current code has already let
the chardev frontends depend on the backends, so we cannot simply let
it be reverted (setup context basically means we need to have the
frontend be inited before backends since the context is now
frontend-specific).

However I'm thinking maybe I can postpone some of the chardev
initialization process after everything has been setup.  Then it'll
look like:

- init chardev backends, phase 1 (e.g., only create chardevs but
  postpone open)
- init chardev frontends (e.g., monitors)
- init chardev backends, phase 2 (e.g., do the real socket open work)

Actually I already spotted an existing user of it
(muxes_realize_notify).  Maybe I can do similar thing to postpone some
of the socket chardev operations after machine init finished.  Thanks,

--=20
Peter Xu
