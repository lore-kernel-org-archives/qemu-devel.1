Received: from eggs.gnu.org ([2001:4830:134:3::10]:50382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRIJ-0000d7-D2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRII-0007X5-2k
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:19 -0400
Date: Wed, 20 Jun 2018 10:14:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620001400.GC3546@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<b28d3ac4d357b86a1b4c9c868e148396857c36da.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <b28d3ac4d357b86a1b4c9c868e148396857c36da.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 01/11] ppc4xx_i2c: Remove unimplemented
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


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> We don't emulate slave mode so related registers are not needed.
> [lh]sadr are only retained to avoid too many warnings and simplify
> debugging but sdata is not even correct because device has a 4 byte
> FIFO instead so just remove this unimplemented register for now.
>=20
> The intr register is also not implemented correctly, it is for
> diagnostics and normally not even visible on device without explicitly
> enabling it. As no guests are known to need this remove it as well.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v4: Updated commit message

Applied to ppc-for-3.0, thanks.

>=20
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

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlspnEQACgkQbDjKyiDZ
s5LzsxAAz0C/LTmpxucg7Oho4csV6FinCVgk1m+1b9JBOcX5kteSJsYMBtXQr+17
jV/EtWfPs8OUCRlLWyrIRhKIrsHNL3SqWXULQhR4C8X6HRstn4OZlYftNvJX1cd2
u/nZGN9mCsOa5MaJGPh/AuAYTzj8RFZ5ehlc+IXKd98GcA9B6IPbG2p5Ng0Sokw8
wooDkjSeEJe+FSAnbbER6YHhKgmvI3sAwJEi4hRp5HmF7wX89XACA04rYARnZ5EW
dUUzX+JH8x17BIIYGvVeLXF6Kh8c6eiGSw+wDJ4hQlcmZPkfZaAEK3q6PcKNEr4W
1xfXvqFNIYvCP2qbTSypAULEgEUIBWq3THPFoTMaTOj2wm2QVIu9dDlO9RQpDGch
zOP1WAaTiw0QWYDnkJbxsb9w3LeSH+lpmj2DpRA01huYxAovOLKoumIgFZRr1lEh
aweTEJ1pgm0ygt3+RsPakJ2k7WUWIIQxHNMfMBuf6Zvsp2UAXf9U+IfbXQ6FS08g
H0O3UbADaeCiEKZDAylR/1SfCQ9yG2yq1mPIV10IHV2SO/O62F+rKP2S0NgA/Mu4
P8cE4cog72/jmZ/uWo32Y9jI6EefcpUQDu3fIIqwCEU/YrbItDvzvIhY/7SKRrB7
5ykUUhxmhi3wq0Qsof/D0Ptgc8lx+3jQhEuzRcsp0UgASxQ0G2w=
=2V9z
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
