Received: from eggs.gnu.org ([2001:4830:134:3::10]:36634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuj-0006kR-C9
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuh-0004iu-JU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:13 -0400
Date: Tue, 15 Aug 2017 14:17:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815041749.GQ3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<d3e53aa950aad746a7c9ddf46528b4bffa1e13ed.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
In-Reply-To: <d3e53aa950aad746a7c9ddf46528b4bffa1e13ed.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 06/12] ppc4xx_i2c: QOMify
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


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Mostly good, one niggle below.

> ---
>  hw/ppc/ppc405.h             |   2 -
>  hw/ppc/ppc405_uc.c          |   5 +-
>  hw/ppc/ppc4xx_i2c.c         | 153 +++++++++++++++++---------------------=
------
>  include/hw/i2c/ppc4xx_i2c.h |  59 +++++++++++++++++
>  4 files changed, 121 insertions(+), 98 deletions(-)
>  create mode 100644 include/hw/i2c/ppc4xx_i2c.h
>=20
> diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
> index 61ec739..a9ffc87 100644
> --- a/hw/ppc/ppc405.h
> +++ b/hw/ppc/ppc405.h
> @@ -59,8 +59,6 @@ struct ppc4xx_bd_info_t {
>  ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>                                  uint32_t flags);
> =20
> -void ppc405_i2c_init(hwaddr base, qemu_irq irq);
> -
>  CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
>                          MemoryRegion ram_memories[4],
>                          hwaddr ram_bases[4],
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 3925e4c..8f44cb4 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -28,6 +28,7 @@
>  #include "hw/hw.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/boards.h"
> +#include "hw/i2c/ppc4xx_i2c.h"
>  #include "ppc405.h"
>  #include "hw/char/serial.h"
>  #include "qemu/timer.h"
> @@ -1663,7 +1664,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_sp=
ace_mem,
>                         DEVICE_BIG_ENDIAN);
>      }
>      /* IIC controller */
> -    ppc405_i2c_init(0xef600500, pic[2]);
> +    sysbus_create_simple(TYPE_PPC4xx_I2C, 0xef600500, pic[2]);
>      /* GPIO */
>      ppc405_gpio_init(0xef600700);
>      /* CPU control */
> @@ -2010,7 +2011,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
>      dma_irqs[3] =3D pic[8];
>      ppc405_dma_init(env, dma_irqs);
>      /* IIC controller */
> -    ppc405_i2c_init(0xef600500, pic[2]);
> +    sysbus_create_simple(TYPE_PPC4xx_I2C, 0xef600500, pic[2]);
>      /* GPIO */
>      ppc405_gpio_init(0xef600700);
>      /* Serial ports */
> diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
> index 15f2dea..fafbb34 100644
> --- a/hw/ppc/ppc4xx_i2c.c
> +++ b/hw/ppc/ppc4xx_i2c.c
> @@ -27,42 +27,19 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> -#include "exec/address-spaces.h"
> -#include "hw/ppc/ppc.h"
> -#include "ppc405.h"
> +#include "hw/i2c/ppc4xx_i2c.h"
> =20
>  /*#define DEBUG_I2C*/
> =20
> -typedef struct ppc4xx_i2c_t ppc4xx_i2c_t;
> -struct ppc4xx_i2c_t {
> -    qemu_irq irq;
> -    MemoryRegion iomem;
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
> -};
> +#define PPC4xx_I2C_MEM_SIZE 0x11
> =20
> -static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
> +static uint8_t ppc4xx_i2c_readb(PPC4xxI2CState *i2c, hwaddr addr)
>  {
> -    ppc4xx_i2c_t *i2c;
> -    uint32_t ret;
> +    uint8_t ret;
> =20
>  #ifdef DEBUG_I2C
>      printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
>  #endif
> -    i2c =3D opaque;
>      switch (addr) {
>      case 0x00:
>          /*i2c_readbyte(&i2c->mdata);*/
> @@ -121,16 +98,12 @@ static uint32_t ppc4xx_i2c_readb(void *opaque, hwadd=
r addr)
>      return ret;
>  }
> =20
> -static void ppc4xx_i2c_writeb(void *opaque,
> -                              hwaddr addr, uint32_t value)
> +static void ppc4xx_i2c_writeb(PPC4xxI2CState *i2c, hwaddr addr, uint8_t =
value)
>  {
> -    ppc4xx_i2c_t *i2c;
> -
>  #ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> -           value);
> +    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n",
> +           __func__, addr, value);
>  #endif
> -    i2c =3D opaque;
>      switch (addr) {
>      case 0x00:
>          i2c->mdata =3D value;
> @@ -181,71 +154,44 @@ static void ppc4xx_i2c_writeb(void *opaque,
>      }
>  }
> =20
> -static uint32_t ppc4xx_i2c_readw(void *opaque, hwaddr addr)
> +static uint64_t ppc4xx_i2c_read(void *opaque, hwaddr addr, unsigned int =
size)
>  {
> -    uint32_t ret;
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    int i;
> +    uint64_t ret =3D 0;
> =20
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    ret =3D ppc4xx_i2c_readb(opaque, addr) << 8;
> -    ret |=3D ppc4xx_i2c_readb(opaque, addr + 1);
> +    for (i =3D 0; i < size; i++) {
> +        ret <<=3D 8;
> +        ret |=3D ppc4xx_i2c_readb(s, addr + i);
> +    }

You shouldn't need to implement your own multibyte accessors in terms
of the byte accessors..

> =20
>      return ret;
>  }
> =20
> -static void ppc4xx_i2c_writew(void *opaque,
> -                              hwaddr addr, uint32_t value)
> +static void ppc4xx_i2c_write(void *opaque, hwaddr addr, uint64_t value,
> +                             unsigned int size)
>  {
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> -           value);
> -#endif
> -    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
> -    ppc4xx_i2c_writeb(opaque, addr + 1, value);
> -}
> -
> -static uint32_t ppc4xx_i2c_readl(void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    ret =3D ppc4xx_i2c_readb(opaque, addr) << 24;
> -    ret |=3D ppc4xx_i2c_readb(opaque, addr + 1) << 16;
> -    ret |=3D ppc4xx_i2c_readb(opaque, addr + 2) << 8;
> -    ret |=3D ppc4xx_i2c_readb(opaque, addr + 3);
> -
> -    return ret;
> -}
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
> +    int i;
> =20
> -static void ppc4xx_i2c_writel(void *opaque,
> -                              hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> -           value);
> -#endif
> -    ppc4xx_i2c_writeb(opaque, addr, value >> 24);
> -    ppc4xx_i2c_writeb(opaque, addr + 1, value >> 16);
> -    ppc4xx_i2c_writeb(opaque, addr + 2, value >> 8);
> -    ppc4xx_i2c_writeb(opaque, addr + 3, value);
> +    for (i =3D 0; i < size; i++) {
> +        ppc4xx_i2c_writeb(s, addr + i, value & 0xff);
> +        value >>=3D 8;
> +    }
>  }
> =20
> -static const MemoryRegionOps i2c_ops =3D {
> -    .old_mmio =3D {
> -        .read =3D { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl=
, },
> -        .write =3D { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_wr=
itel, },
> -    },
> +static const MemoryRegionOps ppc4xx_i2c_ops =3D {
> +    .read =3D ppc4xx_i2c_read,
> +    .write =3D ppc4xx_i2c_write,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,

=2E. instead you should be able to set .valid.* to one thing and .impl.*
to just 1,1 and the memory acces core should break up the accesses
into bytes for you.

>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
> =20
> -static void ppc4xx_i2c_reset(void *opaque)
> +static void ppc4xx_i2c_reset(DeviceState *s)
>  {
> -    ppc4xx_i2c_t *i2c;
> +    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> =20
> -    i2c =3D opaque;
>      i2c->mdata =3D 0x00;
>      i2c->sdata =3D 0x00;
>      i2c->cntl =3D 0x00;
> @@ -257,16 +203,35 @@ static void ppc4xx_i2c_reset(void *opaque)
>      i2c->directcntl =3D 0x0F;
>  }
> =20
> -void ppc405_i2c_init(hwaddr base, qemu_irq irq)
> +static void ppc4xx_i2c_init(Object *o)
>  {
> -    ppc4xx_i2c_t *i2c;
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> =20
> -    i2c =3D g_malloc0(sizeof(ppc4xx_i2c_t));
> -    i2c->irq =3D irq;
> -#ifdef DEBUG_I2C
> -    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
> -#endif
> -    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011=
);
> -    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
> -    qemu_register_reset(ppc4xx_i2c_reset, i2c);
> +    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
> +                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> +    s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
>  }
> +
> +static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D ppc4xx_i2c_reset;
> +}
> +
> +static const TypeInfo ppc4xx_i2c_type_info =3D {
> +    .name =3D TYPE_PPC4xx_I2C,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(PPC4xxI2CState),
> +    .instance_init =3D ppc4xx_i2c_init,
> +    .class_init =3D ppc4xx_i2c_class_init,
> +};
> +
> +static void ppc4xx_i2c_register_types(void)
> +{
> +    type_register_static(&ppc4xx_i2c_type_info);
> +}
> +
> +type_init(ppc4xx_i2c_register_types)
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> new file mode 100644
> index 0000000..7f1e6be
> --- /dev/null
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -0,0 +1,59 @@
> +/*
> + * PPC4xx I2C controller emulation
> + *
> + * Copyright (c) 2007 Jocelyn Mayer
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef PPC4XX_I2C_H
> +#define PPC4XX_I2C_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_PPC4xx_I2C "ppc4xx-i2c"
> +#define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
> +
> +typedef struct PPC4xxI2CState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    qemu_irq irq;
> +    MemoryRegion iomem;
> +    uint8_t mdata;
> +    uint8_t lmadr;
> +    uint8_t hmadr;
> +    uint8_t cntl;
> +    uint8_t mdcntl;
> +    uint8_t sts;
> +    uint8_t extsts;
> +    uint8_t sdata;
> +    uint8_t lsadr;
> +    uint8_t hsadr;
> +    uint8_t clkdiv;
> +    uint8_t intrmsk;
> +    uint8_t xfrcnt;
> +    uint8_t xtcntlss;
> +    uint8_t directcntl;
> +} PPC4xxI2CState;
> +
> +#endif /* PPC4XX_I2C_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmSde0ACgkQbDjKyiDZ
s5IQbw//cqvwhK1S3s7SuK6Ji4dU9DQv9Jr0msVOPM8If7mcd2GJAW5GiyeEIX9l
4x8d2GZMcdGX7LTOa7STi41I/hzUjQWVjXi/luEFSTqXb+6hDpyaQgjkqsi6UVIg
ZFdLPcXI1j72qNHqro4UC93bo39rAYyoN82v9+pyaWBkhnztTj/PP0hgwJKVykds
J4pn7H3vhqAnmD7igFSBJHN+abO0lP/l50tEiJAnBvknFtC9b0NdUgBa1SG278vU
4Xk3F1Uy9ADVF+jphyHu0TCHijSs/hvcZ5wuf37hNX/pT7FMHZ6CfxkM9RigzpOy
gwURYoD/y0xKTeNRm9THuo547pPwP5czZJg2OybdcuU/xWuSCgDwLeg8UX4aX6Tv
CgI4LgM2KgOo+XMPyt6P51gQsG02L2gSuNFq6KOcbj70IXTmZu5/NlrRv4P660eo
S7NW9E84dy2GgEChB9PFAHMCMcP98juj10rldWEOd7piHEqCVoycEj2+Ba9muPEH
tlGzAzWIKWiTFoLJcM589Onz9I1ewpHlPABdtHaAGFjCRsq8QiH6lQB+DkLUsTUn
L3l+/02V9g2ZMUy1cbJw4GCTUha5/3fodAbM4m9isWfzyEj5ZCcAFKras+VnHITD
8JppWWk75gTLceKmidWPLTj2Ficz1lxbPGDIY9SMkDVITk3vAc8=
=gFHV
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
