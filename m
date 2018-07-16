Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fezPy-000307-1O
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fezPu-0001ry-O3
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:03:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fezPu-0001rW-EU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:03:38 -0400
Date: Mon, 16 Jul 2018 11:03:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716110330.7caa7448@redhat.com>
In-Reply-To: <CAJ+F1CJVQn5zucYgn9dUFOu76MZkqd2Vaep52c89AORWF=sOrA@mail.gmail.com>
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<20180710154800.7ea50b73@redhat.com>
	<CAJ+F1CJVQn5zucYgn9dUFOu76MZkqd2Vaep52c89AORWF=sOrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 13 Jul 2018 16:55:15 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Tue, Jul 10, 2018 at 3:48 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Tue, 5 Jun 2018 11:18:35 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > =20
> >> On 05/06/2018 09:54, Sergio Lopez wrote: =20
> >> > Only retry on serial_xmit if qemu_chr_fe_write returns 0, as this is=
 the
> >> > only recoverable error.
> >> >
> >> > Retrying with any other scenario, in addition to being a waste of CPU
> >> > cycles, can compromise the Guest stability if by the vCPU issuing the
> >> > write and the main loop thread are, by chance or explicit pinning,
> >> > running on the same pCPU.
> >> >
> >> > Previous discussion:
> >> >
> >> > https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06998.ht=
ml
> >> >
> >> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> >> > ---
> >> >  hw/char/serial.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> >> > index 605b0d0..6de6c29 100644
> >> > --- a/hw/char/serial.c
> >> > +++ b/hw/char/serial.c
> >> > @@ -260,7 +260,7 @@ static void serial_xmit(SerialState *s)
> >> >          if (s->mcr & UART_MCR_LOOP) {
> >> >              /* in loopback mode, say that we just received a char */
> >> >              serial_receive1(s, &s->tsr, 1);
> >> > -        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
> >> > +        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 =
&&
> >> >                     s->tsr_retry < MAX_XMIT_RETRY) {
> >> >              assert(s->watch_tag =3D=3D 0);
> >> >              s->watch_tag =3D
> >> > =20
> > Hi Sergio, Paolo,
> >
> > it looks like commit
> > commit 019288bf137183bf3407c9824655b753bfafc99f
> > Author: Sergio Lopez <slp@redhat.com>
> > Date:   Tue Jun 5 03:54:55 2018 -0400
> >
> >     hw/char/serial: Only retry if qemu_chr_fe_write returns 0
> >
> > introduced regression wrt 2.12 and broke windows guest remote kernel de=
bug over
> > serial, where windbg can't connect to target and target hangs when wind=
bg tries
> > to connect to it.
> >
> > Reverting the commit fixes issue
> > =20
>=20
> is this a possible solution?
it fixes windbg over serial (with and without EINTR)


> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index cd7d747c68..046c4684ff 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -261,15 +261,20 @@ static void serial_xmit(SerialState *s)
>          if (s->mcr & UART_MCR_LOOP) {
>              /* in loopback mode, say that we just received a char */
>              serial_receive1(s, &s->tsr, 1);
> -        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 &&
> -                   s->tsr_retry < MAX_XMIT_RETRY) {
> -            assert(s->watch_tag =3D=3D 0);
> -            s->watch_tag =3D
> -                qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> -                                      serial_watch_cb, s);
> -            if (s->watch_tag > 0) {
> -                s->tsr_retry++;
> -                return;
> +        } else {
> +            int rc =3D qemu_chr_fe_write(&s->chr, &s->tsr, 1);
> +
> +            if ((rc =3D=3D 0 ||
> +                 (rc =3D=3D -1 && (errno =3D=3D EAGAIN || errno =3D=3D E=
INTR))) &&
> +                s->tsr_retry < MAX_XMIT_RETRY) {
> +                assert(s->watch_tag =3D=3D 0);
> +                s->watch_tag =3D
> +                    qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                          serial_watch_cb, s);
> +                if (s->watch_tag > 0) {
> +                    s->tsr_retry++;
> +                    return;
> +                }
>              }
>          }
>          s->tsr_retry =3D 0;
>=20
>=20
