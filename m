Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOibR-0007ZZ-Qr
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOibQ-0005Zr-GU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:52:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOibQ-0005ZU-C9
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:52:16 -0400
Date: Fri, 1 Jun 2018 12:52:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601115212.GU3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Thu, May 31, 2018 at 11:52:01AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
> > If writing to the frontend channel failed with EPIPE, don't set up a
> > retry. EPIPE is not a recoverable error, so trying again is a waste o=
f CPU
> > cycles.
> >
> > If the vCPU writing to the serial device and emulator thread are pinn=
ed
> > to the same pCPU, it can also compromise the stability of the Guest O=
S,
> > as both threads will be competing for pCPU's time, with the vCPU
> > actively polling the serial device and barely giving time to the
> > emulator thread to make actual progress.
> > ---
> >  hw/char/serial.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 2c080c9..f26e86b 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -262,6 +262,7 @@ static void serial_xmit(SerialState *s)
> >              /* in loopback mode, say that we just received a char */
> >              serial_receive1(s, &s->tsr, 1);
> >          } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
> > +                   errno !=3D EPIPE &&
> >                     s->tsr_retry < MAX_XMIT_RETRY) {
>=20
> Instead of adding explicit handling of EPIPE, shouldn't the code be
> rewritten to treat -1 return && errno !=3D EAGAIN as fatal?

Yes, exactly this code is already broken for every single errno
value, not simply EPIPE. It needs fixing to treat '-1' return code
correctly instead of retrying everything.

>=20
> >              assert(s->watch_tag =3D=3D 0);
> >              s->watch_tag =3D

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
