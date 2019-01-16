Received: from eggs.gnu.org ([209.51.188.92]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhe3-00008M-35
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhe0-0002PD-S6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjhe0-0002Ep-JV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:56 -0500
Date: Wed, 16 Jan 2019 09:37:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116093746.GG20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-12-berrange@redhat.com>
	<CAMxuvazNKWGXGJSDWaf8NetmarhaqAKbmoF+L77kaqxrqr0cDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazNKWGXGJSDWaf8NetmarhaqAKbmoF+L77kaqxrqr0cDg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/12] chardev: disallow
 TLS/telnet/websocket with tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 16, 2019 at 01:54:54AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Tue, Jan 15, 2019 at 6:54 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > In the previous commit
> >
> >     commit 1dc8a6695c731abb7461c637b2512c3670d82be4
> >     Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >     Date:   Tue Aug 16 12:33:32 2016 +0400
> >
> >       char: fix waiting for TLS and telnet connection
> >
> > the tcp_chr_wait_connected() method was changed to check for a non-NU=
LL
> > 's->ioc' as a sign that there is already a connection present, as
> > opposed to checking the "connected" flag to supposedly fix handling o=
f
> > TLS/telnet connections.
> >
> > The original code would repeatedly call tcp_chr_wait_connected creati=
ng
> > many connections as 'connected' would never become true. The changed
> > code would still repeatedly call tcp_chr_wait_connected busy waiting
> > because s->ioc is set but the chardev will never see CHR_EVENT_OPENED=
.
> > IOW, the code is still broken with TLS/telnet, but in a different way=
.
> >
> > Checking for a non-NULL 's->ioc' does not mean that a CHR_EVENT_OPENE=
D
> > will be ready for a TLS/telnet connection. These protocols (and the
> > websocket protocol) all require the main loop to be running in order
> > to complete the protocol handshake before emitting CHR_EVENT_OPENED.
> > The tcp_chr_wait_connected() method is only used during early startup
> > before a main loop is running, so TLS/telnet/websock connections can
> > never complete initialization.
> >
> > Making this work would require changing tcp_chr_wait_connected to run
> > a main loop. This is quite complex since we must not allow GSource's
> > that other parts of QEMU have registered to run yet. The current call=
ers
> > of tcp_chr_wait_connected do not require use of the TLS/telnet/websoc=
ket
> > protocols, so the simplest option is to just forbid this combination
> > completely for now.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> > ---
> >  chardev/char-socket.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 91d775e9c5..7e98a95bbd 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -951,8 +951,20 @@ static void tcp_chr_accept_server_sync(Chardev *=
chr)
> >  static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
> >  {
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > -    /* It can't wait on s->connected, since it is set asynchronously
> > -     * in TLS and telnet cases, only wait for an accepted socket */
> > +    const char *opts[] =3D { "telnet", "tn3270", "websock", "tls-cre=
ds" };
> > +    bool optset[] =3D { s->is_telnet, s->is_tn3270, s->is_websock, s=
->tls_creds };
> > +    size_t i;
> > +
> > +    QEMU_BUILD_BUG_ON(G_N_ELEMENTS(opts) !=3D G_N_ELEMENTS(optset));
> > +    for (i =3D 0; i < G_N_ELEMENTS(opts); i++) {
> > +        if (optset[i]) {
> > +            error_setg(errp,
> > +                       "'%s' option is incompatible with waiting for=
 "
> > +                       "connection during early startup", opts[i]);
>=20
> "during early startup" ? I think you could also reach this by using
> chardev-add & netdev_add.

Yes, I didn't realize that at first. It also means that patch 12 is in
fact still broken in the hotplug case.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
