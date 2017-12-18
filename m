Received: from eggs.gnu.org ([2001:4830:134:3::10]:52133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmko-0001OH-Ey
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmkk-0007O8-AT
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:10:14 -0500
Date: Mon, 18 Dec 2017 15:03:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218040303.GR7753@umbus.fritz.box>
References: <20171216224842.F37CC7456B4@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Qexx6XJGNEACt6j"
Content-Disposition: inline
In-Reply-To: <20171216224842.F37CC7456B4@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2] ppc4xx_i2c: Implement basic I2C
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--0Qexx6XJGNEACt6j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 11:42:14PM +0100, BALATON Zoltan wrote:
> Enough to please U-Boot and make it able to detect SDRAM SPD EEPROMs
>=20
> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-2.12, thanks.

> ---
> v2:
> - Removed DPRINTFs, no other change
> - R-b from: http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg0019=
3.html
>=20
>  hw/i2c/ppc4xx_i2c.c         | 198 +++++++++++++++++++++++++++++++++++++-=
------
>  include/hw/i2c/ppc4xx_i2c.h |   3 +
>  2 files changed, 171 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index 5a6bde9..e873a44 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -2,6 +2,8 @@
>   * PPC4xx I2C controller emulation
>   *
>   * Copyright (c) 2007 Jocelyn Mayer
> + * Copyright (c) 2012 Fran=E7ois Revol
> + * Copyright (c) 2016 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -25,26 +27,118 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> +#include "qemu/log.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> =20
> -/*#define DEBUG_I2C*/
> +#define PPC4xx_I2C_MEM_SIZE 0x12
> =20
> -#define PPC4xx_I2C_MEM_SIZE 0x11
> +#define IIC_CNTL_PT         (1 << 0)
> +#define IIC_CNTL_READ       (1 << 1)
> +#define IIC_CNTL_CHT        (1 << 2)
> +#define IIC_CNTL_RPST       (1 << 3)
> +
> +#define IIC_STS_PT          (1 << 0)
> +#define IIC_STS_ERR         (1 << 2)
> +#define IIC_STS_MDBS        (1 << 5)
> +
> +#define IIC_EXTSTS_XFRA     (1 << 0)
> +
> +#define IIC_XTCNTLSS_SRST   (1 << 0)
> +
> +static void ppc4xx_i2c_reset(DeviceState *s)
> +{
> +    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> +
> +    /* FIXME: Should also reset bus?
> +     *if (s->address !=3D ADDR_RESET) {
> +     *    i2c_end_transfer(s->bus);
> +     *}
> +     */
> +
> +    i2c->mdata =3D 0;
> +    i2c->lmadr =3D 0;
> +    i2c->hmadr =3D 0;
> +    i2c->cntl =3D 0;
> +    i2c->mdcntl =3D 0;
> +    i2c->sts =3D 0;
> +    i2c->extsts =3D 0x8f;
> +    i2c->sdata =3D 0;
> +    i2c->lsadr =3D 0;
> +    i2c->hsadr =3D 0;
> +    i2c->clkdiv =3D 0;
> +    i2c->intrmsk =3D 0;
> +    i2c->xfrcnt =3D 0;
> +    i2c->xtcntlss =3D 0;
> +    i2c->directcntl =3D 0x0f;
> +    i2c->intr =3D 0;
> +}
> +
> +static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
> +{
> +    return true;
> +}
> =20
>  static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
>  {
>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
>      uint64_t ret;
> =20
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
>      switch (addr) {
>      case 0x00:
> -        /*i2c_readbyte(&i2c->mdata);*/
>          ret =3D i2c->mdata;
> +        if (ppc4xx_i2c_is_master(i2c)) {
> +            ret =3D 0xff;
> +
> +            if (!(i2c->sts & IIC_STS_MDBS)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
> +                              "without starting transfer\n",
> +                              TYPE_PPC4xx_I2C, __func__);
> +            } else {
> +                int pending =3D (i2c->cntl >> 4) & 3;
> +
> +                /* get the next byte */
> +                int byte =3D i2c_recv(i2c->bus);
> +
> +                if (byte < 0) {
> +                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
> +                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C,
> +                                  __func__, i2c->lmadr);
> +                    ret =3D 0xff;
> +                } else {
> +                    ret =3D byte;
> +                    /* Raise interrupt if enabled */
> +                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
> +                }
> +
> +                if (!pending) {
> +                    i2c->sts &=3D ~IIC_STS_MDBS;
> +                    /*i2c_end_transfer(i2c->bus);*/
> +                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
> +                } else if (pending) {
> +                    /* current smbus implementation doesn't like
> +                       multibyte xfer repeated start */
> +                    i2c_end_transfer(i2c->bus);
> +                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
> +                        /* if non zero is returned, the adress is not va=
lid */
> +                        i2c->sts &=3D ~IIC_STS_PT;
> +                        i2c->sts |=3D IIC_STS_ERR;
> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                    } else {
> +                        /*i2c->sts |=3D IIC_STS_PT;*/
> +                        i2c->sts |=3D IIC_STS_MDBS;
> +                        i2c->sts &=3D ~IIC_STS_ERR;
> +                        i2c->extsts =3D 0;
> +                    }
> +                }
> +                pending--;
> +                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
> +            }
> +        } else {
> +            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented=
\n",
> +                          TYPE_PPC4xx_I2C, __func__);
> +        }
>          break;
>      case 0x02:
>          ret =3D i2c->sdata;
> @@ -88,13 +182,15 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwadd=
r addr, unsigned int size)
>      case 0x10:
>          ret =3D i2c->directcntl;
>          break;
> +    case 0x11:
> +        ret =3D i2c->intr;
> +        break;
>      default:
> -        ret =3D 0x00;
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
> +                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
> +        ret =3D 0;
>          break;
>      }
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr=
, ret);
> -#endif
> =20
>      return ret;
>  }
> @@ -103,26 +199,70 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
>                                unsigned int size)
>  {
>      PPC4xxI2CState *i2c =3D opaque;
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
> -           __func__, addr, value);
> -#endif
> +
>      switch (addr) {
>      case 0x00:
>          i2c->mdata =3D value;
> -        /*i2c_sendbyte(&i2c->mdata);*/
> +        if (!i2c_bus_busy(i2c->bus)) {
> +            /* assume we start a write transfer */
> +            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
> +                /* if non zero is returned, the adress is not valid */
> +                i2c->sts &=3D ~IIC_STS_PT;
> +                i2c->sts |=3D IIC_STS_ERR;
> +                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +            } else {
> +                i2c->sts |=3D IIC_STS_PT;
> +                i2c->sts &=3D ~IIC_STS_ERR;
> +                i2c->extsts =3D 0;
> +            }
> +        }
> +        if (i2c_bus_busy(i2c->bus)) {
> +            if (i2c_send(i2c->bus, i2c->mdata)) {
> +                /* if the target return non zero then end the transfer */
> +                i2c->sts &=3D ~IIC_STS_PT;
> +                i2c->sts |=3D IIC_STS_ERR;
> +                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                i2c_end_transfer(i2c->bus);
> +            }
> +        }
>          break;
>      case 0x02:
>          i2c->sdata =3D value;
>          break;
>      case 0x04:
>          i2c->lmadr =3D value;
> +        if (i2c_bus_busy(i2c->bus)) {
> +            i2c_end_transfer(i2c->bus);
> +        }
>          break;
>      case 0x05:
>          i2c->hmadr =3D value;
>          break;
>      case 0x06:
>          i2c->cntl =3D value;
> +        if (i2c->cntl & IIC_CNTL_PT) {
> +            if (i2c->cntl & IIC_CNTL_READ) {
> +                if (i2c_bus_busy(i2c->bus)) {
> +                    /* end previous transfer */
> +                    i2c->sts &=3D ~IIC_STS_PT;
> +                    i2c_end_transfer(i2c->bus);
> +                }
> +                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
> +                    /* if non zero is returned, the adress is not valid =
*/
> +                    i2c->sts &=3D ~IIC_STS_PT;
> +                    i2c->sts |=3D IIC_STS_ERR;
> +                    i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                } else {
> +                    /*i2c->sts |=3D IIC_STS_PT;*/
> +                    i2c->sts |=3D IIC_STS_MDBS;
> +                    i2c->sts &=3D ~IIC_STS_ERR;
> +                    i2c->extsts =3D 0;
> +                }
> +            } else {
> +                /* we actually already did the write transfer... */
> +                i2c->sts &=3D ~IIC_STS_PT;
> +            }
> +        }
>          break;
>      case 0x07:
>          i2c->mdcntl =3D value & 0xDF;
> @@ -135,6 +275,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
>          break;
>      case 0x0A:
>          i2c->lsadr =3D value;
> +        /*i2c_set_slave_address(i2c->bus, i2c->lsadr);*/
>          break;
>      case 0x0B:
>          i2c->hsadr =3D value;
> @@ -149,11 +290,23 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
>          i2c->xfrcnt =3D value & 0x77;
>          break;
>      case 0x0F:
> +        if (value & IIC_XTCNTLSS_SRST) {
> +            /* Is it actually a full reset? U-Boot sets some regs before=
 */
> +            ppc4xx_i2c_reset(DEVICE(i2c));
> +            break;
> +        }
>          i2c->xtcntlss =3D value;
>          break;
>      case 0x10:
>          i2c->directcntl =3D value & 0x7;
>          break;
> +    case 0x11:
> +        i2c->intr =3D value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
> +                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
> +        break;
>      }
>  }
> =20
> @@ -167,21 +320,6 @@ static const MemoryRegionOps ppc4xx_i2c_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
> =20
> -static void ppc4xx_i2c_reset(DeviceState *s)
> -{
> -    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> -
> -    i2c->mdata =3D 0x00;
> -    i2c->sdata =3D 0x00;
> -    i2c->cntl =3D 0x00;
> -    i2c->mdcntl =3D 0x00;
> -    i2c->sts =3D 0x00;
> -    i2c->extsts =3D 0x00;
> -    i2c->clkdiv =3D 0x00;
> -    i2c->xfrcnt =3D 0x00;
> -    i2c->directcntl =3D 0x0F;
> -}
> -
>  static void ppc4xx_i2c_init(Object *o)
>  {
>      PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index e53042f..71fb392 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -2,6 +2,8 @@
>   * PPC4xx I2C controller emulation
>   *
>   * Copyright (c) 2007 Jocelyn Mayer
> + * Copyright (c) 2012 Fran=E7ois Revol
> + * Copyright (c) 2016 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -56,6 +58,7 @@ typedef struct PPC4xxI2CState {
>      uint8_t xfrcnt;
>      uint8_t xtcntlss;
>      uint8_t directcntl;
> +    uint8_t intr;
>  } PPC4xxI2CState;
> =20
>  #endif /* PPC4XX_I2C_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0Qexx6XJGNEACt6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3PfcACgkQbDjKyiDZ
s5JtFQ/6A2bclCzXkrnCx88MkamvuXYkHhbdBB6oFiIdZOFhIfrlUOVI6ClwFFFR
zcjA0JvcS5rEGOJeIOAUEdx7X2x0H5iS9/bh32EHhEmMH+/yhFZYa6jqhR86Lz/U
6+X2W/K5SW64+DQqIg5iBOXCZJ5FkZIxY6gVORouw7OmesDxcFlFXa9842/MHaGp
FOq0TLZkfkfPMiflF56co9JZm8vXKCWiyK16kQi43ZVg1V0SeZ5BYCDdV9l9hAKB
u1TrGfLXCpo39DiSi/0gpOU22NkKZCZfR3lX9u+SiM2IqMXKxPVDCa2dUv+OQmIi
ea+3AwXshZtkT5ZD+hUAW85JM69KjdF1i/K3dQZjdWJOuVGlzYYL+aO7Kh9fgsYz
vmLN7fxJiWqg3zIwVpb9od1dCS1dho74CMu9ooU9A2o1ie6c3eJ3njqzYnMSv4Zv
yK5G1H5/yrmumrMiAJvsXA3boClMX7mSw8b5F+vyKvHOqWogKR0eOvKpQrTiyeZs
Xj7FszmQIKKHeqfptlCAQ2GTeCSQ46ccpP+KxbuGfAzccuNZmQWx/RKq1ny7ZngT
T+CUYTfb/GsP56HPc2/kizMuuKa4auy53Z1wD2SMTwJtsDU8BKmkDO5deDqRupVX
6r9NKiF78hdSpO+I3WJS+Vtm5U7YKx6VpxzSuuSjMGwn5FvBXcI=
=B97H
-----END PGP SIGNATURE-----

--0Qexx6XJGNEACt6j--
