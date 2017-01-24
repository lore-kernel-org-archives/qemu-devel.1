Received: from eggs.gnu.org ([2001:4830:134:3::10]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVyeo-0007cM-Qo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVyek-000524-0k
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:48:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVyej-000511-QY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:48:53 -0500
Message-ID: <1485254930.32716.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 24 Jan 2017 11:48:50 +0100
In-Reply-To: <237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
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

> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index 379910d..7ddd289 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -277,7 +277,8 @@ static bool blit_region_is_unsafe(struct CirrusVGAS=
tate *s,
> >      }
> >      if (pitch < 0) {
> >          int64_t min =3D addr
> > -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> > +            + ((int64_t)s->cirrus_blt_height-1) * pitch
> > +            - s->cirrus_blt_width;
> >          int32_t max =3D addr
> >              + s->cirrus_blt_width;
> >          if (min < 0 || max > s->vga.vram_size) {
> >=20
>=20
> I believe this is incorrect. In this case (AFAIR), "addr" points to the
> left-most pixel (=3D lowest address) of the bottom line (=3D highest
> address).

If I read the code correctly it is backwards *both* x and y axis, so
addr is the right-most pixel of the bottom line.

cheers,
  Gerd
