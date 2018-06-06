Received: from eggs.gnu.org ([2001:4830:134:3::10]:35256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQS3R-0001JN-8y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQS3O-0001kk-Bb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:36:21 -0400
Date: Wed, 6 Jun 2018 16:36:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606063606.GJ17757@umbus.fritz.box>
References: <cover.1528069840.git.balaton@eik.bme.hu>
	<6f3e8e1070c12d1a8321f4fdb6f65d56adc2767b.1528069840.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <6f3e8e1070c12d1a8321f4fdb6f65d56adc2767b.1528069840.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc4xx_i2c: Rewrite PPC4xx I2C
 emulation
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


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 01:50:40AM +0200, BALATON Zoltan wrote:
> I2C emulation currently is just enough for U-Boot to access SPD
> EEPROMs but features that guests use to access I2C devices are not
> correctly emulated. Rewrite to implement missing features to make it
> work with all clients.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Maybe this could be split up into more patches but because the
> previous implementation was wrong only allowing U-Boot to pass and no
> clients could access I2C devices before this rewrite it probably does
> not worth to try to make it a lot of small changes instead of dropping
> the previous hack and rewrite following features of real hardware more
> closely. (It turns out that each client driver accesses I2C in a
> different way so we need to implement almost all features of the
> hardware to please everyone.)

The trouble is that because I don't really have a good test setup for
this, I'm pretty reluctant to apply such a total rewrite without acks
=66rom more people who've tested it.  That or reviewing the changes
myself, which I can't really do when it's in one big lump like this.

>=20
> default-configs/ppc-softmmu.mak |   1 +
>  hw/i2c/ppc4xx_i2c.c             | 366 +++++++++++++++++++++-------------=
------
>  include/hw/i2c/ppc4xx_i2c.h     |  19 +--
>  3 files changed, 197 insertions(+), 189 deletions(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 4d7be45..7d0dc2f 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_SM501=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
> +CONFIG_BITBANG_I2C=3Dy
> =20
>  # For Macs
>  CONFIG_MAC=3Dy
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index ab64d19..638bb01 100644
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
> @@ -30,281 +30,300 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> +#include "bitbang_i2c.h"
> =20
> -#define PPC4xx_I2C_MEM_SIZE 0x12
> +#define PPC4xx_I2C_MEM_SIZE 18
> =20
>  #define IIC_CNTL_PT         (1 << 0)
>  #define IIC_CNTL_READ       (1 << 1)
>  #define IIC_CNTL_CHT        (1 << 2)
>  #define IIC_CNTL_RPST       (1 << 3)
> +#define IIC_CNTL_AMD        (1 << 6)
> +#define IIC_CNTL_HMT        (1 << 7)
> +
> +#define IIC_MDCNTL_EINT     (1 << 2)
> +#define IIC_MDCNTL_ESM      (1 << 3)
> +#define IIC_MDCNTL_FMDB     (1 << 6)
> =20
>  #define IIC_STS_PT          (1 << 0)
> +#define IIC_STS_IRQA        (1 << 1)
>  #define IIC_STS_ERR         (1 << 2)
> +#define IIC_STS_MDBF        (1 << 4)
>  #define IIC_STS_MDBS        (1 << 5)
> =20
>  #define IIC_EXTSTS_XFRA     (1 << 0)
> =20
> +#define IIC_INTRMSK_EIMTC   (1 << 0)
> +#define IIC_INTRMSK_EITA    (1 << 1)
> +#define IIC_INTRMSK_EIIC    (1 << 2)
> +#define IIC_INTRMSK_EIHE    (1 << 3)
> +
>  #define IIC_XTCNTLSS_SRST   (1 << 0)
> =20
> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> +
> +typedef struct {
> +    bitbang_i2c_interface *bitbang;
> +    int mdidx;
> +    uint8_t mdata[4];
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
> -    /* FIXME: Should also reset bus?
> -     *if (s->address !=3D ADDR_RESET) {
> -     *    i2c_end_transfer(s->bus);
> -     *}
> -     */
> -
> -    i2c->mdata =3D 0;
> -    i2c->lmadr =3D 0;
> -    i2c->hmadr =3D 0;
> +    i2c->mdidx =3D -1;
> +    memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
> +    /* [hl][ms]addr are not affected by reset */
>      i2c->cntl =3D 0;
>      i2c->mdcntl =3D 0;
>      i2c->sts =3D 0;
> -    i2c->extsts =3D 0x8f;
> -    i2c->sdata =3D 0;
> -    i2c->lsadr =3D 0;
> -    i2c->hsadr =3D 0;
> +    i2c->extsts =3D (1 << 6);
>      i2c->clkdiv =3D 0;
>      i2c->intrmsk =3D 0;
>      i2c->xfrcnt =3D 0;
>      i2c->xtcntlss =3D 0;
> -    i2c->directcntl =3D 0x0f;
> -    i2c->intr =3D 0;
> -}
> -
> -static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
> -{
> -    return true;
> +    i2c->directcntl =3D 0xf;
>  }
> =20
>  static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
>  {
> -    PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CRegs *i2c =3D s->regs;
>      uint64_t ret;
> +    int i;
> =20
>      switch (addr) {
> -    case 0x00:
> -        ret =3D i2c->mdata;
> -        if (ppc4xx_i2c_is_master(i2c)) {
> +    case 0:
> +        if (i2c->mdidx < 0) {
>              ret =3D 0xff;
> -
> -            if (!(i2c->sts & IIC_STS_MDBS)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
> -                              "without starting transfer\n",
> -                              TYPE_PPC4xx_I2C, __func__);
> -            } else {
> -                int pending =3D (i2c->cntl >> 4) & 3;
> -
> -                /* get the next byte */
> -                int byte =3D i2c_recv(i2c->bus);
> -
> -                if (byte < 0) {
> -                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
> -                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C,
> -                                  __func__, i2c->lmadr);
> -                    ret =3D 0xff;
> -                } else {
> -                    ret =3D byte;
> -                    /* Raise interrupt if enabled */
> -                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
> -                }
> -
> -                if (!pending) {
> -                    i2c->sts &=3D ~IIC_STS_MDBS;
> -                    /*i2c_end_transfer(i2c->bus);*/
> -                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
> -                } else if (pending) {
> -                    /* current smbus implementation doesn't like
> -                       multibyte xfer repeated start */
> -                    i2c_end_transfer(i2c->bus);
> -                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
> -                        /* if non zero is returned, the adress is not va=
lid */
> -                        i2c->sts &=3D ~IIC_STS_PT;
> -                        i2c->sts |=3D IIC_STS_ERR;
> -                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                    } else {
> -                        /*i2c->sts |=3D IIC_STS_PT;*/
> -                        i2c->sts |=3D IIC_STS_MDBS;
> -                        i2c->sts &=3D ~IIC_STS_ERR;
> -                        i2c->extsts =3D 0;
> -                    }
> -                }
> -                pending--;
> -                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
> -            }
> -        } else {
> -            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented=
\n",
> -                          TYPE_PPC4xx_I2C, __func__);
> +            break;
> +        }
> +        ret =3D i2c->mdata[0];
> +        if (i2c->mdidx =3D=3D 3) {
> +            i2c->sts &=3D ~IIC_STS_MDBF;
> +        } else if (i2c->mdidx =3D=3D 0) {
> +            i2c->sts &=3D ~IIC_STS_MDBS;
> +        }
> +        for (i =3D 0; i < i2c->mdidx; i++) {
> +            i2c->mdata[i] =3D i2c->mdata[i + 1];
> +        }
> +        if (i2c->mdidx >=3D 0) {
> +            i2c->mdidx--;
>          }
>          break;
> -    case 0x02:
> -        ret =3D i2c->sdata;
> -        break;
> -    case 0x04:
> +    case 4:
>          ret =3D i2c->lmadr;
>          break;
> -    case 0x05:
> +    case 5:
>          ret =3D i2c->hmadr;
>          break;
> -    case 0x06:
> +    case 6:
>          ret =3D i2c->cntl;
>          break;
> -    case 0x07:
> +    case 7:
>          ret =3D i2c->mdcntl;
>          break;
> -    case 0x08:
> +    case 8:
>          ret =3D i2c->sts;
>          break;
> -    case 0x09:
> +    case 9:
>          ret =3D i2c->extsts;
> +        ret |=3D !!i2c_bus_busy(s->bus) << 4;
>          break;
> -    case 0x0A:
> +    case 10:
>          ret =3D i2c->lsadr;
>          break;
> -    case 0x0B:
> +    case 11:
>          ret =3D i2c->hsadr;
>          break;
> -    case 0x0C:
> +    case 12:
>          ret =3D i2c->clkdiv;
>          break;
> -    case 0x0D:
> +    case 13:
>          ret =3D i2c->intrmsk;
>          break;
> -    case 0x0E:
> +    case 14:
>          ret =3D i2c->xfrcnt;
>          break;
> -    case 0x0F:
> +    case 15:
>          ret =3D i2c->xtcntlss;
>          break;
> -    case 0x10:
> +    case 16:
>          ret =3D i2c->directcntl;
>          break;
> -    case 0x11:
> -        ret =3D i2c->intr;
> -        break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
> -                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
> +        if (addr < PPC4xx_I2C_MEM_SIZE) {
> +            qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
> +                          HWADDR_PRIx "\n", __func__, addr);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%"
> +                          HWADDR_PRIx "\n", __func__, addr);
> +        }
>          ret =3D 0;
>          break;
>      }
> -
>      return ret;
>  }
> =20
>  static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>                                unsigned int size)
>  {
> -    PPC4xxI2CState *i2c =3D opaque;
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    PPC4xxI2CRegs *i2c =3D s->regs;
> =20
>      switch (addr) {
> -    case 0x00:
> -        i2c->mdata =3D value;
> -        if (!i2c_bus_busy(i2c->bus)) {
> -            /* assume we start a write transfer */
> -            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
> -                /* if non zero is returned, the adress is not valid */
> -                i2c->sts &=3D ~IIC_STS_PT;
> -                i2c->sts |=3D IIC_STS_ERR;
> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -            } else {
> -                i2c->sts |=3D IIC_STS_PT;
> -                i2c->sts &=3D ~IIC_STS_ERR;
> -                i2c->extsts =3D 0;
> -            }
> +    case 0:
> +        if (i2c->mdidx >=3D 3) {
> +            break;
>          }
> -        if (i2c_bus_busy(i2c->bus)) {
> -            if (i2c_send(i2c->bus, i2c->mdata)) {
> -                /* if the target return non zero then end the transfer */
> -                i2c->sts &=3D ~IIC_STS_PT;
> -                i2c->sts |=3D IIC_STS_ERR;
> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                i2c_end_transfer(i2c->bus);
> -            }
> +        i2c->mdata[++i2c->mdidx] =3D value;
> +        if (i2c->mdidx =3D=3D 3) {
> +            i2c->sts |=3D IIC_STS_MDBF;
> +        } else if (i2c->mdidx =3D=3D 0) {
> +            i2c->sts |=3D IIC_STS_MDBS;
>          }
>          break;
> -    case 0x02:
> -        i2c->sdata =3D value;
> -        break;
> -    case 0x04:
> +    case 4:
>          i2c->lmadr =3D value;
> -        if (i2c_bus_busy(i2c->bus)) {
> -            i2c_end_transfer(i2c->bus);
> -        }
>          break;
> -    case 0x05:
> +    case 5:
>          i2c->hmadr =3D value;
>          break;
> -    case 0x06:
> -        i2c->cntl =3D value;
> -        if (i2c->cntl & IIC_CNTL_PT) {
> -            if (i2c->cntl & IIC_CNTL_READ) {
> -                if (i2c_bus_busy(i2c->bus)) {
> -                    /* end previous transfer */
> -                    i2c->sts &=3D ~IIC_STS_PT;
> -                    i2c_end_transfer(i2c->bus);
> +    case 6:
> +        i2c->cntl =3D value & 0xfe;
> +        if (value & IIC_CNTL_AMD) {
> +            qemu_log_mask(LOG_UNIMP, "%s: only 7 bit addresses supported=
\n",
> +                          __func__);
> +        }
> +        if (value & IIC_CNTL_HMT && i2c_bus_busy(s->bus)) {
> +            i2c_end_transfer(s->bus);
> +            if (i2c->mdcntl & IIC_MDCNTL_EINT &&
> +                i2c->intrmsk & IIC_INTRMSK_EIHE) {
> +                    i2c->sts |=3D IIC_STS_IRQA;
> +                    qemu_irq_raise(s->irq);
> +            }
> +        } else if (value & IIC_CNTL_PT) {
> +            int recv =3D (value & IIC_CNTL_READ) >> 1;
> +            int tct =3D value >> 4 & 3;
> +            int i;
> +
> +            if (recv && (i2c->lmadr >> 1) >=3D 0x50 && (i2c->lmadr >> 1)=
 < 0x58) {
> +                /* smbus emulation does not like multi byte reads w/o re=
start */
> +                value |=3D IIC_CNTL_RPST;
> +            }
> +
> +            for (i =3D 0; i <=3D tct; i++) {
> +                if (!i2c_bus_busy(s->bus)) {
> +                    i2c->extsts =3D (1 << 6);
> +                    if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, recv=
)) {
> +                        i2c->sts |=3D IIC_STS_ERR;
> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                        break;
> +                    } else {
> +                        i2c->sts &=3D ~IIC_STS_ERR;
> +                    }
>                  }
> -                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
> -                    /* if non zero is returned, the adress is not valid =
*/
> -                    i2c->sts &=3D ~IIC_STS_PT;
> -                    i2c->sts |=3D IIC_STS_ERR;
> -                    i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                } else {
> -                    /*i2c->sts |=3D IIC_STS_PT;*/
> -                    i2c->sts |=3D IIC_STS_MDBS;
> -                    i2c->sts &=3D ~IIC_STS_ERR;
> -                    i2c->extsts =3D 0;
> +                if (!(i2c->sts & IIC_STS_ERR) &&
> +                    i2c_send_recv(s->bus, &i2c->mdata[i], !recv)) {
> +                        i2c->sts |=3D IIC_STS_ERR;
> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                        break;
>                  }
> -            } else {
> -                /* we actually already did the write transfer... */
> -                i2c->sts &=3D ~IIC_STS_PT;
> +                if (value & IIC_CNTL_RPST || !(value & IIC_CNTL_CHT)) {
> +                    i2c_end_transfer(s->bus);
> +                }
> +            }
> +            i2c->xfrcnt =3D i;
> +            i2c->mdidx =3D i - 1;
> +            if (recv && i2c->mdidx >=3D 0) {
> +                i2c->sts |=3D IIC_STS_MDBS;
> +            }
> +            if (recv && i2c->mdidx =3D=3D 3) {
> +                i2c->sts |=3D IIC_STS_MDBF;
> +            }
> +            if (i && i2c->mdcntl & IIC_MDCNTL_EINT &&
> +                i2c->intrmsk & IIC_INTRMSK_EIMTC) {
> +                i2c->sts |=3D IIC_STS_IRQA;
> +                qemu_irq_raise(s->irq);
>              }
>          }
>          break;
> -    case 0x07:
> -        i2c->mdcntl =3D value & 0xDF;
> +    case 7:
> +        i2c->mdcntl =3D value & 0x3d;
> +        if (value & IIC_MDCNTL_ESM) {
> +            qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
> +                          __func__);
> +        }
> +        if (value & IIC_MDCNTL_FMDB) {
> +            i2c->mdidx =3D -1;
> +            memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
> +            i2c->sts &=3D ~(IIC_STS_MDBF | IIC_STS_MDBS);
> +        }
>          break;
> -    case 0x08:
> -        i2c->sts &=3D ~(value & 0x0A);
> +    case 8:
> +        i2c->sts &=3D ~(value & 0xa);
> +        if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_MDCNTL_EINT) {
> +            qemu_irq_lower(s->irq);
> +        }
>          break;
> -    case 0x09:
> -        i2c->extsts &=3D ~(value & 0x8F);
> +    case 9:
> +        i2c->extsts &=3D ~(value & 0x8f);
>          break;
> -    case 0x0A:
> +    case 10:
>          i2c->lsadr =3D value;
> -        /*i2c_set_slave_address(i2c->bus, i2c->lsadr);*/
>          break;
> -    case 0x0B:
> +    case 11:
>          i2c->hsadr =3D value;
>          break;
> -    case 0x0C:
> +    case 12:
>          i2c->clkdiv =3D value;
>          break;
> -    case 0x0D:
> +    case 13:
>          i2c->intrmsk =3D value;
>          break;
> -    case 0x0E:
> -        i2c->xfrcnt =3D value & 0x77;
> +    case 14:
> +        i2c->xfrcnt =3D value;
>          break;
> -    case 0x0F:
> +    case 15:
> +        i2c->xtcntlss &=3D ~(value & 0xf0);
>          if (value & IIC_XTCNTLSS_SRST) {
>              /* Is it actually a full reset? U-Boot sets some regs before=
 */
> -            ppc4xx_i2c_reset(DEVICE(i2c));
> +            ppc4xx_i2c_reset(DEVICE(s));
>              break;
>          }
> -        i2c->xtcntlss =3D value;
>          break;
> -    case 0x10:
> -        i2c->directcntl =3D value & 0x7;
> -        break;
> -    case 0x11:
> -        i2c->intr =3D value;
> +    case 16:
> +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
> +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl &=
 1);
> +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_S=
DA,
> +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0) << =
1;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
> -                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
> +        if (addr < PPC4xx_I2C_MEM_SIZE) {
> +            qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
> +                          HWADDR_PRIx "\n", __func__, addr);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%"
> +                          HWADDR_PRIx "\n", __func__, addr);
> +        }
>          break;
>      }
>  }
> @@ -322,12 +341,15 @@ static const MemoryRegionOps ppc4xx_i2c_ops =3D {
>  static void ppc4xx_i2c_init(Object *o)
>  {
>      PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> +    PPC4xxI2CRegs *r =3D g_malloc0(sizeof(PPC4xxI2CRegs));
> =20
> +    s->regs =3D r;
>      memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
>                            TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>      s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> +    r->bitbang =3D bitbang_i2c_init(s->bus);
>  }
> =20
>  static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
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

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXgNYACgkQbDjKyiDZ
s5I26Q//TE/cZNOhAiOreKL/2HZQUIokVV3BLIn500y4X/vPF/afi5Sze3aYYEmJ
p3AAcZ6QXwn9NsCkw62U4RPpdoXmAicgdMx42J4l7QzLPew8BAKZ3ucFbK3ndCrB
l7piymY8GPFPlNYVTcTpZx6Fe7s17RyTxAPBDgcxp0kodfWxbcQQQQp9aUb30wch
qm4NxdcvyRUz7xZmeKD/H8VhQ0NtWt6YlDwBwrTge4Jk7dvH1GEWt7691zDIwXfg
qBBnFEVoubR5NauiXV8Dm/z98nmucZjRu9KiwEH3hcd1oCWTwNR8MJxHOW2wR608
ApHF4V/N0ZnGLphz7LTBsZ8VqO0DRN/lopwVSDQcZVRuE0T8l8Dl0BljL3EMu1RJ
gvdDaKS3DFs9USd/iKuHQ5VKcOP0NCxzI9DWzF4dzhbCi4Oqmoe7LdPDcbeOKCog
TbxSF59z+Ayzw1hnlA8pu8/JUz+UGWm1Mq3qRxsSyoFeaS5N6iHTL1ATo7dmsCCG
TxGCzbj8h8fhF1Hc7l3Q9RE7WZoZuxXlO6gutCj5k/kUtpuJMNS9YCN4od/Ojfkm
pvQ7g8u0zZIRSgfhu/cGsb5yY24x8hTFfAToFHZbkFoCbIlQZXDVegaj75LGxFpu
/SZMyvK6EXhuKHWlVhCiGTRK7wm6B8qOE1IUS1HzUrHPVA2wKaA=
=VYlh
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
