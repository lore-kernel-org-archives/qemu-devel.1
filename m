Received: from eggs.gnu.org ([2001:4830:134:3::10]:51950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDDT-0002F5-Cr
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDDP-0003Oo-DR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:51 -0400
Date: Fri, 8 Jun 2018 18:56:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608085618.GT3344@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3dBJfKlFjfsS/piO"
Content-Disposition: inline
In-Reply-To: <7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] ppc4xx_i2c: Move register state to
 private struct and remove unimplemented sdata and intr registers
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


--3dBJfKlFjfsS/piO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

It's not clear to me why this is preferable to having the registers
embedded in the state structure.  The latter is pretty standard
practice for qemu.

> ---
>  hw/i2c/ppc4xx_i2c.c         | 75 +++++++++++++++++++++++++--------------=
------
>  include/hw/i2c/ppc4xx_i2c.h | 19 ++----------
>  2 files changed, 43 insertions(+), 51 deletions(-)
>=20
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index d1936db..a68b5f7 100644
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
> @@ -46,9 +46,26 @@
> =20
>  #define IIC_XTCNTLSS_SRST   (1 << 0)
> =20
> +typedef struct {
> +    uint8_t mdata;
> +    uint8_t lmadr;
> +    uint8_t hmadr;
> +    uint8_t cntl;
> +    uint8_t mdcntl;
> +    uint8_t sts;
> +    uint8_t extsts;
> +    uint8_t lsadr;
> +    uint8_t hsadr;
> +    uint8_t clkdiv;
> +    uint8_t intrmsk;
> +    uint8_t xfrcnt;
> +    uint8_t xtcntlss;
> +    uint8_t directcntl;
> +} PPC4xxI2CRegs;
> +
>  static void ppc4xx_i2c_reset(DeviceState *s)
>  {
> -    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> +    PPC4xxI2CRegs *i2c =3D PPC4xx_I2C(s)->regs;
> =20
>      /* FIXME: Should also reset bus?
>       *if (s->address !=3D ADDR_RESET) {
> @@ -63,7 +80,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>      i2c->mdcntl =3D 0;
>      i2c->sts =3D 0;
>      i2c->extsts =3D 0x8f;
> -    i2c->sdata =3D 0;
>      i2c->lsadr =3D 0;
>      i2c->hsadr =3D 0;
>      i2c->clkdiv =3D 0;
> @@ -71,7 +87,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>      i2c->xfrcnt =3D 0;
>      i2c->xtcntlss =3D 0;
>      i2c->directcntl =3D 0xf;
> -    i2c->intr =3D 0;
>  }
> =20
>  static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
> @@ -81,13 +96,14 @@ static inline bool ppc4xx_i2c_is_master(PPC4xxI2CStat=
e *i2c)
> =20
>  static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
>  {
> -    PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CRegs *i2c =3D s->regs;
>      uint64_t ret;
> =20
>      switch (addr) {
>      case 0:
>          ret =3D i2c->mdata;
> -        if (ppc4xx_i2c_is_master(i2c)) {
> +        if (ppc4xx_i2c_is_master(s)) {
>              ret =3D 0xff;
> =20
>              if (!(i2c->sts & IIC_STS_MDBS)) {
> @@ -98,7 +114,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr =
addr, unsigned int size)
>                  int pending =3D (i2c->cntl >> 4) & 3;
> =20
>                  /* get the next byte */
> -                int byte =3D i2c_recv(i2c->bus);
> +                int byte =3D i2c_recv(s->bus);
> =20
>                  if (byte < 0) {
>                      qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
> @@ -113,13 +129,13 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwad=
dr addr, unsigned int size)
> =20
>                  if (!pending) {
>                      i2c->sts &=3D ~IIC_STS_MDBS;
> -                    /*i2c_end_transfer(i2c->bus);*/
> +                    /*i2c_end_transfer(s->bus);*/
>                  /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
>                  } else if (pending) {
>                      /* current smbus implementation doesn't like
>                         multibyte xfer repeated start */
> -                    i2c_end_transfer(i2c->bus);
> -                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
> +                    i2c_end_transfer(s->bus);
> +                    if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 1)) {
>                          /* if non zero is returned, the adress is not va=
lid */
>                          i2c->sts &=3D ~IIC_STS_PT;
>                          i2c->sts |=3D IIC_STS_ERR;
> @@ -139,9 +155,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
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
> @@ -181,9 +194,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
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
> @@ -201,14 +211,15 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwad=
dr addr, unsigned int size)
>  static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>                                unsigned int size)
>  {
> -    PPC4xxI2CState *i2c =3D opaque;
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CRegs *i2c =3D s->regs;
> =20
>      switch (addr) {
>      case 0:
>          i2c->mdata =3D value;
> -        if (!i2c_bus_busy(i2c->bus)) {
> +        if (!i2c_bus_busy(s->bus)) {
>              /* assume we start a write transfer */
> -            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
> +            if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 0)) {
>                  /* if non zero is returned, the adress is not valid */
>                  i2c->sts &=3D ~IIC_STS_PT;
>                  i2c->sts |=3D IIC_STS_ERR;
> @@ -219,23 +230,20 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
>                  i2c->extsts =3D 0;
>              }
>          }
> -        if (i2c_bus_busy(i2c->bus)) {
> -            if (i2c_send(i2c->bus, i2c->mdata)) {
> +        if (i2c_bus_busy(s->bus)) {
> +            if (i2c_send(s->bus, i2c->mdata)) {
>                  /* if the target return non zero then end the transfer */
>                  i2c->sts &=3D ~IIC_STS_PT;
>                  i2c->sts |=3D IIC_STS_ERR;
>                  i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                i2c_end_transfer(i2c->bus);
> +                i2c_end_transfer(s->bus);
>              }
>          }
>          break;
> -    case 2:
> -        i2c->sdata =3D value;
> -        break;
>      case 4:
>          i2c->lmadr =3D value;
> -        if (i2c_bus_busy(i2c->bus)) {
> -            i2c_end_transfer(i2c->bus);
> +        if (i2c_bus_busy(s->bus)) {
> +            i2c_end_transfer(s->bus);
>          }
>          break;
>      case 5:
> @@ -245,12 +253,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
>          i2c->cntl =3D value;
>          if (i2c->cntl & IIC_CNTL_PT) {
>              if (i2c->cntl & IIC_CNTL_READ) {
> -                if (i2c_bus_busy(i2c->bus)) {
> +                if (i2c_bus_busy(s->bus)) {
>                      /* end previous transfer */
>                      i2c->sts &=3D ~IIC_STS_PT;
> -                    i2c_end_transfer(i2c->bus);
> +                    i2c_end_transfer(s->bus);
>                  }
> -                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
> +                if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 1)) {
>                      /* if non zero is returned, the adress is not valid =
*/
>                      i2c->sts &=3D ~IIC_STS_PT;
>                      i2c->sts |=3D IIC_STS_ERR;
> @@ -294,7 +302,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
>      case 15:
>          if (value & IIC_XTCNTLSS_SRST) {
>              /* Is it actually a full reset? U-Boot sets some regs before=
 */
> -            ppc4xx_i2c_reset(DEVICE(i2c));
> +            ppc4xx_i2c_reset(DEVICE(s));
>              break;
>          }
>          i2c->xtcntlss =3D value;
> @@ -302,9 +310,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
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
> @@ -330,7 +335,9 @@ static const MemoryRegionOps ppc4xx_i2c_ops =3D {
>  static void ppc4xx_i2c_init(Object *o)
>  {
>      PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> +    PPC4xxI2CRegs *r =3D g_malloc0(sizeof(PPC4xxI2CRegs));
> =20
> +    s->regs =3D r;
>      memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
>                            TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index 3c60307..1d5ba0c 100644
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
> @@ -37,27 +37,12 @@
>  typedef struct PPC4xxI2CState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> +    void *regs;
> =20
>      /*< public >*/
>      I2CBus *bus;
>      qemu_irq irq;
>      MemoryRegion iomem;
> -    uint8_t mdata;
> -    uint8_t lmadr;
> -    uint8_t hmadr;
> -    uint8_t cntl;
> -    uint8_t mdcntl;
> -    uint8_t sts;
> -    uint8_t extsts;
> -    uint8_t sdata;
> -    uint8_t lsadr;
> -    uint8_t hsadr;
> -    uint8_t clkdiv;
> -    uint8_t intrmsk;
> -    uint8_t xfrcnt;
> -    uint8_t xtcntlss;
> -    uint8_t directcntl;
> -    uint8_t intr;
>  } PPC4xxI2CState;
> =20
>  #endif /* PPC4XX_I2C_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3dBJfKlFjfsS/piO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaRLIACgkQbDjKyiDZ
s5LdbA//Vz5IiZHP4lUtdZB1sGkPNaHH5iwH0nAhnwOFph9tG0IUdsaR3exDGmyx
IHEkmQVwMEtdcEE3OgZPvR+G+7inAJUnzmmyxrlOFIFk4SuMahC7EM0EiX4uaJVp
f2q5fI1tFmmWJot9aSM4oFWaCMqzy/gQU0xVPCghUhMAGVuo1CEZBCEQdefFD2mt
GXGNZriZBMURvK4ltCUnQN/Ey4XWzOQkGRiEbDIbkJz5MecI3gCBSXbo9FtoYQ71
FuYooODiU+/qYRcJA9prE1usMm0rIeIkSZbUJyQTbmywGm2A1nPo3xf8W8KS54pJ
fxrpy1WpZlrWACyxSjSrHIfc4L6PvGt6jJmChjzhOCNyhqDeGma/YATnXo2L24pY
uQ1297D3SQGcaXkwegLh9rDdIC70k7vOTe3vRMO+Nei2VcVmLwrsR4WNaudcxup2
+4djl5mVVVcEUHBbvsKwv7NEL986PfbWBs+coR9qZhSAWTJ+edW66bKd8Oq/Kmhc
xnSK4RplTG20oEu68uQ17IX2dq5iKY44ZkQ9Zs5FZvtkM3KSWHtdNt0vp7EUdqA/
mjSpn0I7ixPyBpdK2CeCcvFvjs8yvjZkDEl04BPxRVWvQ1m7gh3m+SkPBQ6tatVE
xrNcM2cDtQiDMz69h5DvwWXHTSrQYMksRslLn1Wcp0wbCyvpiQ8=
=jQa7
-----END PGP SIGNATURE-----

--3dBJfKlFjfsS/piO--
