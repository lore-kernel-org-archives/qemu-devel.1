Received: from eggs.gnu.org ([208.118.235.92]:44027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1gfN7r-0007dQ-C1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1gfN7o-0005Bv-6b
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:54:51 -0500
Date: Fri, 4 Jan 2019 13:54:44 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20190104135444.01b4689b768453fa22fca68a@gmail.com>
In-Reply-To: <20190104081741.mxdgg4dwm4l5s4ki@pengutronix.de>
References: <20190104015641.e6d525f098c5e272694faa62@gmail.com>
	<20190104081741.mxdgg4dwm4l5s4ki@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] barebox on Canon A1100
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Barebox List <barebox@lists.infradead.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, 4 Jan 2019 09:17:41 +0100
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Fri, Jan 04, 2019 at 01:56:41AM +0300, Antony Pavlov wrote:
> > Hi Sascha!
> >=20
> > I have some good news and some bad news.
> >=20
> > First the good news.
> >=20
> > Barebox was used for Day 18 of QEMU 2018 advent (https://www.qemu-adven=
t-calendar.org/2018/).
> >=20
> > Here is a quote:
> >=20
> >   > This is an image for QEMU's emulated Canon A1100 Arm machine:
> >   > Play 2048 in the Barebox firmware environment.
>=20
> Hey nice :)
>=20
> >=20
> > The bad news.
> >=20
> > Current master branch barebox for Canon A1100 does not work under qemu,
> > barebox v2017.02.0 was used for qemu advent.
> >=20
> > Thomas Huth reported the problem in the qemu-devel mailing
> > list two months ago. Please see https://www.mail-archive.com/qemu-devel=
@nongnu.org/msg571887.html
> > for details.
> >=20
> > The commit a43e2bbc468a71 breaks barebox for Canon A1100:
> >=20
> >   > commit a43e2bbc468a71fb8825e8acafb7fac7ad7c6dad
> >   > Author: Sascha Hauer <s.hauer@pengutronix.de>
> >   > Date:   Wed Mar 7 10:04:07 2018 +0100
> >   >
> >   >    ARM: return positive offset in get_runtime_offset()
> >=20
> > Any suggestion?
>=20
> Yes, try again with a recent barebox. There was a bug in this commit that
> should be fixed with the following:
>
> | commit 0230365df6601cd561c9e3e368c96222076ec9f5
> | Author: Sascha Hauer <s.hauer@pengutronix.de>
> | Date:   Wed Dec 12 08:55:31 2018 +0100
> |=20
> |     ARM: fix setup_c when runtime offset is !=3D 0
> |    =20
> |     The runtime offset has to be added to the memcpy source address and
> |     substracted from the return address. This should have been changed =
in
> |     a43e2bbc46 which changed from returning the negative runtime offset
> |     into changing the positive runtime offset. Instead a43e2bbc46 only
> |     changed a zero substraction ("subs r4, r0, #0") into a zero addition
> |     ("adds r4, r0, #0") which was used as a equal to zero test and chan=
ged
> |     nothing. This part is reverted here.
> |    =20
> |     Fixes wrong copy / return locations when setup_c is called with
> |     different runtime and link addresses.
> |    =20
> |     fixes: a43e2bbc46 ("ARM: return positive offset in get_runtime_offs=
et()")
> |    =20
> |     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for noting!

I have just tested recent master branch barebox with qemu-3.1.0 from Debian=
 unstable.
It works!

Here is the log:

$ qemu-system-arm --version
QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-2)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
$ qemu-system-arm -M canon-a1100 -display none -serial stdio -bios barebox.=
canon-a1100.bin
Switch to console [cs0]


barebox 2018.12.0-00140-g64fc4ac1b5 #1 Fri Jan 4 13:36:42 MSK 2019


Board: Canon PowerShot A1100 IS
digic-gpio c0220000.gpio.of: probed gpiochip-1 with base 0
cfi_flash f8000000.flash@f8000000.of: found cfi flash at 0xf8000000, size 4=
 MiB
malloc space: 0x00100000 -> 0x002fffff (size 2 MiB)
running /env/bin/init...
/env/bin/init not found
canon-a1100 > /


--=20
Best regards,
=A0 Antony Pavlov
