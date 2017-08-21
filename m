Received: from eggs.gnu.org ([2001:4830:134:3::10]:33462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djm9x-0001eV-6L
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djm9u-0003MC-V6
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:50:25 -0400
Date: Mon, 21 Aug 2017 20:54:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821105437.GN12356@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<b08c0b6ffb65d9073cc729f274317b689dce593c.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
Content-Disposition: inline
In-Reply-To: <b08c0b6ffb65d9073cc729f274317b689dce593c.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 07/15] ppc4xx_i2c: Move to hw/i2c
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


--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.11.

> ---
>  default-configs/ppc-softmmu.mak    |   1 +
>  default-configs/ppc64-softmmu.mak  |   1 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  hw/i2c/Makefile.objs               |   1 +
>  hw/i2c/ppc4xx_i2c.c                | 216 +++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/Makefile.objs               |   2 +-
>  hw/ppc/ppc4xx_i2c.c                | 216 -------------------------------=
------
>  7 files changed, 221 insertions(+), 217 deletions(-)
>  create mode 100644 hw/i2c/ppc4xx_i2c.c
>  delete mode 100644 hw/ppc/ppc4xx_i2c.c
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 1f1cd85..d4d44eb 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -3,6 +3,7 @@
>  include pci.mak
>  include sound.mak
>  include usb.mak
> +CONFIG_PPC4XX=3Dy
>  CONFIG_ESCC=3Dy
>  CONFIG_M48T59=3Dy
>  CONFIG_SERIAL=3Dy
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index 46c9599..af32589 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -3,6 +3,7 @@
>  include pci.mak
>  include sound.mak
>  include usb.mak
> +CONFIG_PPC4XX=3Dy
>  CONFIG_VIRTIO_VGA=3Dy
>  CONFIG_ESCC=3Dy
>  CONFIG_M48T59=3Dy
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> index 94340de..635923a 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -3,6 +3,7 @@
>  include pci.mak
>  include sound.mak
>  include usb.mak
> +CONFIG_PPC4XX=3Dy
>  CONFIG_M48T59=3Dy
>  CONFIG_SERIAL=3Dy
>  CONFIG_SERIAL_ISA=3Dy
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index a081b8e..0594dea 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -8,3 +8,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
>  common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
>  obj-$(CONFIG_OMAP) +=3D omap_i2c.o
> +obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> new file mode 100644
> index 0000000..5a6bde9
> --- /dev/null
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -0,0 +1,216 @@
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
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/i2c/ppc4xx_i2c.h"
> +
> +/*#define DEBUG_I2C*/
> +
> +#define PPC4xx_I2C_MEM_SIZE 0x11
> +
> +static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
> +{
> +    PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
> +    uint64_t ret;
> +
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> +#endif
> +    switch (addr) {
> +    case 0x00:
> +        /*i2c_readbyte(&i2c->mdata);*/
> +        ret =3D i2c->mdata;
> +        break;
> +    case 0x02:
> +        ret =3D i2c->sdata;
> +        break;
> +    case 0x04:
> +        ret =3D i2c->lmadr;
> +        break;
> +    case 0x05:
> +        ret =3D i2c->hmadr;
> +        break;
> +    case 0x06:
> +        ret =3D i2c->cntl;
> +        break;
> +    case 0x07:
> +        ret =3D i2c->mdcntl;
> +        break;
> +    case 0x08:
> +        ret =3D i2c->sts;
> +        break;
> +    case 0x09:
> +        ret =3D i2c->extsts;
> +        break;
> +    case 0x0A:
> +        ret =3D i2c->lsadr;
> +        break;
> +    case 0x0B:
> +        ret =3D i2c->hsadr;
> +        break;
> +    case 0x0C:
> +        ret =3D i2c->clkdiv;
> +        break;
> +    case 0x0D:
> +        ret =3D i2c->intrmsk;
> +        break;
> +    case 0x0E:
> +        ret =3D i2c->xfrcnt;
> +        break;
> +    case 0x0F:
> +        ret =3D i2c->xtcntlss;
> +        break;
> +    case 0x10:
> +        ret =3D i2c->directcntl;
> +        break;
> +    default:
> +        ret =3D 0x00;
> +        break;
> +    }
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr=
, ret);
> +#endif
> +
> +    return ret;
> +}
> +
> +static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
> +                              unsigned int size)
> +{
> +    PPC4xxI2CState *i2c =3D opaque;
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
> +           __func__, addr, value);
> +#endif
> +    switch (addr) {
> +    case 0x00:
> +        i2c->mdata =3D value;
> +        /*i2c_sendbyte(&i2c->mdata);*/
> +        break;
> +    case 0x02:
> +        i2c->sdata =3D value;
> +        break;
> +    case 0x04:
> +        i2c->lmadr =3D value;
> +        break;
> +    case 0x05:
> +        i2c->hmadr =3D value;
> +        break;
> +    case 0x06:
> +        i2c->cntl =3D value;
> +        break;
> +    case 0x07:
> +        i2c->mdcntl =3D value & 0xDF;
> +        break;
> +    case 0x08:
> +        i2c->sts &=3D ~(value & 0x0A);
> +        break;
> +    case 0x09:
> +        i2c->extsts &=3D ~(value & 0x8F);
> +        break;
> +    case 0x0A:
> +        i2c->lsadr =3D value;
> +        break;
> +    case 0x0B:
> +        i2c->hsadr =3D value;
> +        break;
> +    case 0x0C:
> +        i2c->clkdiv =3D value;
> +        break;
> +    case 0x0D:
> +        i2c->intrmsk =3D value;
> +        break;
> +    case 0x0E:
> +        i2c->xfrcnt =3D value & 0x77;
> +        break;
> +    case 0x0F:
> +        i2c->xtcntlss =3D value;
> +        break;
> +    case 0x10:
> +        i2c->directcntl =3D value & 0x7;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps ppc4xx_i2c_ops =3D {
> +    .read =3D ppc4xx_i2c_readb,
> +    .write =3D ppc4xx_i2c_writeb,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 1,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void ppc4xx_i2c_reset(DeviceState *s)
> +{
> +    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> +
> +    i2c->mdata =3D 0x00;
> +    i2c->sdata =3D 0x00;
> +    i2c->cntl =3D 0x00;
> +    i2c->mdcntl =3D 0x00;
> +    i2c->sts =3D 0x00;
> +    i2c->extsts =3D 0x00;
> +    i2c->clkdiv =3D 0x00;
> +    i2c->xfrcnt =3D 0x00;
> +    i2c->directcntl =3D 0x0F;
> +}
> +
> +static void ppc4xx_i2c_init(Object *o)
> +{
> +    PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
> +                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> +    s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> +}
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
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 2077216..7efc686 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -13,7 +13,7 @@ endif
>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>  # PowerPC 4xx boards
>  obj-y +=3D ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
> -obj-y +=3D ppc4xx_pci.o ppc4xx_i2c.o
> +obj-y +=3D ppc4xx_pci.o
>  # PReP
>  obj-$(CONFIG_PREP) +=3D prep.o
>  obj-$(CONFIG_PREP) +=3D prep_systemio.o
> diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
> deleted file mode 100644
> index 5a6bde9..0000000
> --- a/hw/ppc/ppc4xx_i2c.c
> +++ /dev/null
> @@ -1,216 +0,0 @@
> -/*
> - * PPC4xx I2C controller emulation
> - *
> - * Copyright (c) 2007 Jocelyn Mayer
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qapi/error.h"
> -#include "qemu-common.h"
> -#include "cpu.h"
> -#include "hw/hw.h"
> -#include "hw/i2c/ppc4xx_i2c.h"
> -
> -/*#define DEBUG_I2C*/
> -
> -#define PPC4xx_I2C_MEM_SIZE 0x11
> -
> -static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
> -{
> -    PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
> -    uint64_t ret;
> -
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    switch (addr) {
> -    case 0x00:
> -        /*i2c_readbyte(&i2c->mdata);*/
> -        ret =3D i2c->mdata;
> -        break;
> -    case 0x02:
> -        ret =3D i2c->sdata;
> -        break;
> -    case 0x04:
> -        ret =3D i2c->lmadr;
> -        break;
> -    case 0x05:
> -        ret =3D i2c->hmadr;
> -        break;
> -    case 0x06:
> -        ret =3D i2c->cntl;
> -        break;
> -    case 0x07:
> -        ret =3D i2c->mdcntl;
> -        break;
> -    case 0x08:
> -        ret =3D i2c->sts;
> -        break;
> -    case 0x09:
> -        ret =3D i2c->extsts;
> -        break;
> -    case 0x0A:
> -        ret =3D i2c->lsadr;
> -        break;
> -    case 0x0B:
> -        ret =3D i2c->hsadr;
> -        break;
> -    case 0x0C:
> -        ret =3D i2c->clkdiv;
> -        break;
> -    case 0x0D:
> -        ret =3D i2c->intrmsk;
> -        break;
> -    case 0x0E:
> -        ret =3D i2c->xfrcnt;
> -        break;
> -    case 0x0F:
> -        ret =3D i2c->xtcntlss;
> -        break;
> -    case 0x10:
> -        ret =3D i2c->directcntl;
> -        break;
> -    default:
> -        ret =3D 0x00;
> -        break;
> -    }
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr=
, ret);
> -#endif
> -
> -    return ret;
> -}
> -
> -static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
> -                              unsigned int size)
> -{
> -    PPC4xxI2CState *i2c =3D opaque;
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
> -           __func__, addr, value);
> -#endif
> -    switch (addr) {
> -    case 0x00:
> -        i2c->mdata =3D value;
> -        /*i2c_sendbyte(&i2c->mdata);*/
> -        break;
> -    case 0x02:
> -        i2c->sdata =3D value;
> -        break;
> -    case 0x04:
> -        i2c->lmadr =3D value;
> -        break;
> -    case 0x05:
> -        i2c->hmadr =3D value;
> -        break;
> -    case 0x06:
> -        i2c->cntl =3D value;
> -        break;
> -    case 0x07:
> -        i2c->mdcntl =3D value & 0xDF;
> -        break;
> -    case 0x08:
> -        i2c->sts &=3D ~(value & 0x0A);
> -        break;
> -    case 0x09:
> -        i2c->extsts &=3D ~(value & 0x8F);
> -        break;
> -    case 0x0A:
> -        i2c->lsadr =3D value;
> -        break;
> -    case 0x0B:
> -        i2c->hsadr =3D value;
> -        break;
> -    case 0x0C:
> -        i2c->clkdiv =3D value;
> -        break;
> -    case 0x0D:
> -        i2c->intrmsk =3D value;
> -        break;
> -    case 0x0E:
> -        i2c->xfrcnt =3D value & 0x77;
> -        break;
> -    case 0x0F:
> -        i2c->xtcntlss =3D value;
> -        break;
> -    case 0x10:
> -        i2c->directcntl =3D value & 0x7;
> -        break;
> -    }
> -}
> -
> -static const MemoryRegionOps ppc4xx_i2c_ops =3D {
> -    .read =3D ppc4xx_i2c_readb,
> -    .write =3D ppc4xx_i2c_writeb,
> -    .valid.min_access_size =3D 1,
> -    .valid.max_access_size =3D 4,
> -    .impl.min_access_size =3D 1,
> -    .impl.max_access_size =3D 1,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -};
> -
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
> -static void ppc4xx_i2c_init(Object *o)
> -{
> -    PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> -
> -    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
> -                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> -    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> -    s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> -}
> -
> -static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->reset =3D ppc4xx_i2c_reset;
> -}
> -
> -static const TypeInfo ppc4xx_i2c_type_info =3D {
> -    .name =3D TYPE_PPC4xx_I2C,
> -    .parent =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(PPC4xxI2CState),
> -    .instance_init =3D ppc4xx_i2c_init,
> -    .class_init =3D ppc4xx_i2c_class_init,
> -};
> -
> -static void ppc4xx_i2c_register_types(void)
> -{
> -    type_register_static(&ppc4xx_i2c_type_info);
> -}
> -
> -type_init(ppc4xx_i2c_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmau+0ACgkQbDjKyiDZ
s5IOxBAAzys7s6lOmukzOFKRSUirdo+gPcQB1I9cj3j9EVUo4AtbYUeqOoKXpker
+O1zG/R5dYItqfG81yIT5cG9aLHG3lX9VxtQ1QKprFT0N0lsFGTZkqPYlj7dDKbL
sbTRtmiTpaF7krYx6N5K4BOULeJ9cISjy2chLCvZiSSB4cDEKdzCe3Cv4ZJGVP6j
pEgBAQjXz69qn4CsAg9rIw3WnyHDJneVmXFQDzA5e4YxgvcXYdsBz5271j2YNaUt
JzsuuGIywr/DRBiC3P8Cf1lIP7yOyPaPGSg5ir1FHUS4AckKsBHAxL5mqWUXe5DU
fnTQ1m5Ef68L9mG9wOIOXoKnbnsy0coDyABpXySYtdb6ajm0M1kqBQS5YToJFtwG
1Mlup6iqdjYeeXsfs7DKFQjah1flhd5bGGESLFMLmz3IW+UvdOdRaCwGtsJLBOgb
DX/dWDSw+aX+BPQMh2HsV92E0wbS6LTyZ+lKZZ2hZ0qvqi+lL3HCxvqnHEASAfhm
oYds1j9T9XlYqhntYNnrjaiQERuxjSIQp5v4F+rQzsP4JZcS4j7mvoAYaajgzDon
FiD2iASG0DiODQmTE+4S0EYDhqvs4WFGoz3kXjJuXO4NdVKsukYyy7Ky5+I03TeR
INMni4vqxkjZqbmNA5T4CL1O9LvKI4Y6mD8UrZRQRE63XjrrfPU=
=uN1O
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
