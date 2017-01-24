Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cW0Eh-0006nm-BT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cW0Ec-0008Gb-7D
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cW0Ec-0008GQ-1I
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:30:02 -0500
Message-ID: <1485260998.32716.45.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 24 Jan 2017 13:29:58 +0100
In-Reply-To: <b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
	<1485254930.32716.23.camel@redhat.com>
	<b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, ghoffman@redhat.com, liqiang6-s@360.cn

> >>>      if (pitch < 0) {
> >>>          int64_t min =3D addr
> >>> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> >>> +            + ((int64_t)s->cirrus_blt_height-1) * pitch
> >>> +            - s->cirrus_blt_width;
> >>>          int32_t max =3D addr
> >>>              + s->cirrus_blt_width;
> >>>          if (min < 0 || max > s->vga.vram_size) {
> >>>
> >>
> >> I believe this is incorrect. In this case (AFAIR), "addr" points to th=
e
> >> left-most pixel (=3D lowest address) of the bottom line (=3D highest
> >> address).
> >=20
> > If I read the code correctly it is backwards *both* x and y axis, so
> > addr is the right-most pixel of the bottom line.
>=20
> What is "max" then? If "addr" is the right-most pixel of the bottom
> line, then "max" has the highest address just past the rectangle, and
> then adding anything non-negative to it makes no sense.

That is (with the patch applied) inconsistent indeed.  We must either
subtract s->cirrus_blt_width from min (addr =3D=3D right-most), or add it t=
o
max (addr =3D=3D left-most), but certainly not both.

> ... Really as I remember it from the downstream review, the pitch is
> negative (bottom-up), but the horizontal direction remains left to right.

Looking at cirrus_vga_rop.h I see:
 - cirrus_bitblt_rop_fwd_*() increment src and dst while walking the
   scanline, and
 - cirrus_bitblt_rop_bkwd_*() decrement src and dst ...

I still think x axis goes backwards too and therefore addr is the
right-most pixel.

cheers,
  Gerd
