Received: from eggs.gnu.org ([2001:4830:134:3::10]:34684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSIfk-0005eD-OV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSIfg-0007Kb-Qq
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSIfg-0007JJ-IB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:59:28 -0400
Date: Mon, 11 Jun 2018 09:59:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180611085922.GA11636@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-2-marcandre.lureau@redhat.com>
	<496cef6a-35a1-5ad7-fa43-771f877c5c13@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <496cef6a-35a1-5ad7-fa43-771f877c5c13@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 01/12] chardev: avoid crash if no
 associated address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jun 08, 2018 at 11:52:11AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 06/01/2018 01:27 PM, Marc-Andr=C3=A9 Lureau wrote:
> > A socket chardev may not have associated address (when adding client
> > fd manually for example). But on disconnect, updating socket filename
> > expects an address and may lead to this crash:
> >=20
> >   Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fa=
ult.
> >   0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x555556043062=
 "disconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) at /h=
ome/elmarco/src/qq/chardev/char-socket.c:388
> >   388	    switch (addr->type) {
> >   (gdb) bt
> >   #0  0x0000555555d8c70c in SocketAddress_to_str (prefix=3D0x55555604=
3062 "disconnected:", addr=3D0x0, is_listen=3Dfalse, is_telnet=3Dfalse) a=
t /home/elmarco/src/qq/chardev/char-socket.c:388
> >   #1  0x0000555555d8c8aa in update_disconnected_filename (s=3D0x55555=
6b1ed00) at /home/elmarco/src/qq/chardev/char-socket.c:419
> >   #2  0x0000555555d8c959 in tcp_chr_disconnect (chr=3D0x555556b1ed00)=
 at /home/elmarco/src/qq/chardev/char-socket.c:438
> >   #3  0x0000555555d8cba1 in tcp_chr_hup (channel=3D0x555556b75690, co=
nd=3DG_IO_HUP, opaque=3D0x555556b1ed00) at /home/elmarco/src/qq/chardev/c=
har-socket.c:482
> >   #4  0x0000555555da596e in qio_channel_fd_source_dispatch (source=3D=
0x555556bb68b0, callback=3D0x555555d8cb58 <tcp_chr_hup>, user_data=3D0x55=
5556b1ed00) at /home/elmarco/src/qq/io/channel-watch.c:84
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-socket.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 159e69c3b1..f1b7907798 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -416,8 +416,11 @@ static void update_disconnected_filename(SocketC=
hardev *s)
> >      Chardev *chr =3D CHARDEV(s);
> > =20
> >      g_free(chr->filename);
> > -    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
> > -                                         s->is_listen, s->is_telnet)=
;
> > +    chr->filename =3D NULL;
> > +    if (s->addr) {
>=20
> Isn't it more robust to add this check in SocketAddress_to_str()?

IMHO that just shifts the problem elsewhere - currently SocketAddress_to_=
str
is assumed to return non-NULL, or to abort(). Shifting the check means it
can now return NULL, so there's every chance the caller will now referenc=
e
the NULL pointer that's returned.

>=20
>     static char *SocketAddress_to_str(const char *prefix, SocketAddress
> *addr,
>                                       bool is_listen, bool is_telnet)
>     {
>         if (!addr) {
>             return NULL;
>         }
>         switch (addr->type) {
>             ...
>=20
> > +        chr->filename =3D SocketAddress_to_str("disconnected:", s->a=
ddr,
> > +                                             s->is_listen, s->is_tel=
net);
> > +    }
> >  }
> > =20
> >  /* NB may be called even if tcp_chr_connect has not been
> >=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
