Received: from eggs.gnu.org ([2001:4830:134:3::10]:48483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGtL-0000fP-K6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGtH-00072N-He
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:17:35 -0400
Date: Thu, 14 Jun 2018 11:14:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614011449.GR30690@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<16139dc707e8de2b79bcdb2b0fcb4749216f2e86.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlZi+g8Ywt2nzGP6"
Content-Disposition: inline
In-Reply-To: <16139dc707e8de2b79bcdb2b0fcb4749216f2e86.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 1/9] ppc4xx_i2c: Remove unimplemented
 sdata and intr registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--HlZi+g8Ywt2nzGP6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

But.. they are implemented.  Albeit as an entirely software controlled
register.

I'm guessing that's not what they're supposed to do, which is why
you're removing them, but that needs to be explained in the commit
message.

As a general rule cases where a one line commit message is acceptable
are *very* rare.

> ---
>  hw/i2c/ppc4xx_i2c.c         | 16 +---------------
>  include/hw/i2c/ppc4xx_i2c.h |  4 +---
>  2 files changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index d1936db..4e0aaae 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2007 Jocelyn Mayer
>   * Copyright (c) 2012 Fran=E7ois Revol
> - * Copyright (c) 2016 BALATON Zoltan
> + * Copyright (c) 2016-2018 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -63,7 +63,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>      i2c->mdcntl =3D 0;
>      i2c->sts =3D 0;
>      i2c->extsts =3D 0x8f;
> -    i2c->sdata =3D 0;
>      i2c->lsadr =3D 0;
>      i2c->hsadr =3D 0;
>      i2c->clkdiv =3D 0;
> @@ -71,7 +70,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>      i2c->xfrcnt =3D 0;
>      i2c->xtcntlss =3D 0;
>      i2c->directcntl =3D 0xf;
> -    i2c->intr =3D 0;
>  }
> =20
>  static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
> @@ -139,9 +137,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
 addr, unsigned int size)
>                            TYPE_PPC4xx_I2C, __func__);
>          }
>          break;
> -    case 2:
> -        ret =3D i2c->sdata;
> -        break;
>      case 4:
>          ret =3D i2c->lmadr;
>          break;
> @@ -181,9 +176,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
 addr, unsigned int size)
>      case 16:
>          ret =3D i2c->directcntl;
>          break;
> -    case 17:
> -        ret =3D i2c->intr;
> -        break;
>      default:
>          if (addr < PPC4xx_I2C_MEM_SIZE) {
>              qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
> @@ -229,9 +221,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
>              }
>          }
>          break;
> -    case 2:
> -        i2c->sdata =3D value;
> -        break;
>      case 4:
>          i2c->lmadr =3D value;
>          if (i2c_bus_busy(i2c->bus)) {
> @@ -302,9 +291,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
>      case 16:
>          i2c->directcntl =3D value & 0x7;
>          break;
> -    case 17:
> -        i2c->intr =3D value;
> -        break;
>      default:
>          if (addr < PPC4xx_I2C_MEM_SIZE) {
>              qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index 3c60307..e4b6ded 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2007 Jocelyn Mayer
>   * Copyright (c) 2012 Fran=E7ois Revol
> - * Copyright (c) 2016 BALATON Zoltan
> + * Copyright (c) 2016-2018 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -49,7 +49,6 @@ typedef struct PPC4xxI2CState {
>      uint8_t mdcntl;
>      uint8_t sts;
>      uint8_t extsts;
> -    uint8_t sdata;
>      uint8_t lsadr;
>      uint8_t hsadr;
>      uint8_t clkdiv;
> @@ -57,7 +56,6 @@ typedef struct PPC4xxI2CState {
>      uint8_t xfrcnt;
>      uint8_t xtcntlss;
>      uint8_t directcntl;
> -    uint8_t intr;
>  } PPC4xxI2CState;
> =20
>  #endif /* PPC4XX_I2C_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HlZi+g8Ywt2nzGP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshwYcACgkQbDjKyiDZ
s5I6hg/+MB3CdghrpjectRcdpQ8jLNcYof1XXF4S/D6HVCgGY3d/Tg4C7MGtJsqF
SrN+iu7ao8cnvXQM90Yk8bR25QzpaRfFBSpUzoHIbjEodpgJCF3oVpzNVa2cHY5J
E9BRfj/kz8+Qw3U3e9mj6IxcR4MPs3cAbju/BX0xgyy/U08nmFqqeaZtPIDWMFjy
Wc845rUxQxFOeoix46GmF8dzBFZvEn3VdiTtD2kZ9yBn6rrpAUZRJ7eU/eT3BaaZ
QBBwmVh3lE06xD3vzxPNCOOJTqCt7NBaYWmFI9VNAxRiuIdsUYWO56PIAE/GBT1J
dMIPtk4dI7gRbNAjcR5Eufpwnm9+d4iABsVpJZmKN+DpzKyCi+x2jAD82M4uS46F
9iHUgNetDHYH14sjZzzYkKRDWc0LBzzAgkCXCuBCA2RjT3hmCUcXW9alXFkS6Gxt
PK0NWmlqytFi2OeKbB4PDfSCp3IIBU3M6BBFuVopDKkQq43erm0vBv91v9E+zcYy
gacrk+7OSv7NZhsqF2sN1AFuEhObitMfeYgzV9xTWHHMHwey6mh5YAVhqvu/YPqF
qED8R4ooScC+LbTSiAWQ6kumAX/pYcgqfmPsW3o9PoGt+E7k2t1sX5N8bWaxVCpL
mSp9RUJHwFi3qcM/SiW+rU3t7ex8ADZ+kilQ5lk3WIrh9Ybgb2c=
=4Sqh
-----END PGP SIGNATURE-----

--HlZi+g8Ywt2nzGP6--
