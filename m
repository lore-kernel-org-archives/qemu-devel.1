Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fh-0000dT-Hh
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fd-0005c0-8x
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:17 -0400
Date: Mon, 14 Aug 2017 14:41:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814044123.GE3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 05/12] ppc4xx: Split off 4xx I2C
 emulation from ppc405_uc to its own file
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


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:

Needs a commit message: why is this a useful thing to do?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/Makefile.objs |   2 +-
>  hw/ppc/ppc405.h      |   2 +
>  hw/ppc/ppc405_uc.c   | 241 ---------------------------------------------
>  hw/ppc/ppc4xx_i2c.c  | 272 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 275 insertions(+), 242 deletions(-)
>  create mode 100644 hw/ppc/ppc4xx_i2c.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 7efc686..2077216 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -13,7 +13,7 @@ endif
>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>  # PowerPC 4xx boards
>  obj-y +=3D ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
> -obj-y +=3D ppc4xx_pci.o
> +obj-y +=3D ppc4xx_pci.o ppc4xx_i2c.o
>  # PReP
>  obj-$(CONFIG_PREP) +=3D prep.o
>  obj-$(CONFIG_PREP) +=3D prep_systemio.o
> diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
> index a9ffc87..61ec739 100644
> --- a/hw/ppc/ppc405.h
> +++ b/hw/ppc/ppc405.h
> @@ -59,6 +59,8 @@ struct ppc4xx_bd_info_t {
>  ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>                                  uint32_t flags);
> =20
> +void ppc405_i2c_init(hwaddr base, qemu_irq irq);
> +
>  CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
>                          MemoryRegion ram_memories[4],
>                          hwaddr ram_bases[4],
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 03856d5..3925e4c 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -40,7 +40,6 @@
>  //#define DEBUG_GPIO
>  //#define DEBUG_SERIAL
>  //#define DEBUG_OCM
> -//#define DEBUG_I2C
>  //#define DEBUG_GPT
>  //#define DEBUG_CLOCKS
>  //#define DEBUG_CLOCKS_LL
> @@ -993,246 +992,6 @@ static void ppc405_ocm_init(CPUPPCState *env)
>  }
> =20
>  /***********************************************************************=
******/
> -/* I2C controller */
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
> -
> -static uint32_t ppc4xx_i2c_readb (void *opaque, hwaddr addr)
> -{
> -    ppc4xx_i2c_t *i2c;
> -    uint32_t ret;
> -
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    i2c =3D opaque;
> -    switch (addr) {
> -    case 0x00:
> -        //        i2c_readbyte(&i2c->mdata);
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
> -    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr=
, ret);
> -#endif
> -
> -    return ret;
> -}
> -
> -static void ppc4xx_i2c_writeb (void *opaque,
> -                               hwaddr addr, uint32_t value)
> -{
> -    ppc4xx_i2c_t *i2c;
> -
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> -           value);
> -#endif
> -    i2c =3D opaque;
> -    switch (addr) {
> -    case 0x00:
> -        i2c->mdata =3D value;
> -        //        i2c_sendbyte(&i2c->mdata);
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
> -static uint32_t ppc4xx_i2c_readw (void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    ret =3D ppc4xx_i2c_readb(opaque, addr) << 8;
> -    ret |=3D ppc4xx_i2c_readb(opaque, addr + 1);
> -
> -    return ret;
> -}
> -
> -static void ppc4xx_i2c_writew (void *opaque,
> -                               hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> -           value);
> -#endif
> -    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
> -    ppc4xx_i2c_writeb(opaque, addr + 1, value);
> -}
> -
> -static uint32_t ppc4xx_i2c_readl (void *opaque, hwaddr addr)
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
> -
> -static void ppc4xx_i2c_writel (void *opaque,
> -                               hwaddr addr, uint32_t value)
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
> -}
> -
> -static const MemoryRegionOps i2c_ops =3D {
> -    .old_mmio =3D {
> -        .read =3D { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl=
, },
> -        .write =3D { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_wr=
itel, },
> -    },
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -};
> -
> -static void ppc4xx_i2c_reset (void *opaque)
> -{
> -    ppc4xx_i2c_t *i2c;
> -
> -    i2c =3D opaque;
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
> -static void ppc405_i2c_init(hwaddr base, qemu_irq irq)
> -{
> -    ppc4xx_i2c_t *i2c;
> -
> -    i2c =3D g_malloc0(sizeof(ppc4xx_i2c_t));
> -    i2c->irq =3D irq;
> -#ifdef DEBUG_I2C
> -    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
> -#endif
> -    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011=
);
> -    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
> -    qemu_register_reset(ppc4xx_i2c_reset, i2c);
> -}
> -
> -/***********************************************************************=
******/
>  /* General purpose timers */
>  typedef struct ppc4xx_gpt_t ppc4xx_gpt_t;
>  struct ppc4xx_gpt_t {
> diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
> new file mode 100644
> index 0000000..15f2dea
> --- /dev/null
> +++ b/hw/ppc/ppc4xx_i2c.c
> @@ -0,0 +1,272 @@
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
> +#include "exec/address-spaces.h"
> +#include "hw/ppc/ppc.h"
> +#include "ppc405.h"
> +
> +/*#define DEBUG_I2C*/
> +
> +typedef struct ppc4xx_i2c_t ppc4xx_i2c_t;
> +struct ppc4xx_i2c_t {
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
> +};
> +
> +static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
> +{
> +    ppc4xx_i2c_t *i2c;
> +    uint32_t ret;
> +
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> +#endif
> +    i2c =3D opaque;
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
> +    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr=
, ret);
> +#endif
> +
> +    return ret;
> +}
> +
> +static void ppc4xx_i2c_writeb(void *opaque,
> +                              hwaddr addr, uint32_t value)
> +{
> +    ppc4xx_i2c_t *i2c;
> +
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> +           value);
> +#endif
> +    i2c =3D opaque;
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
> +static uint32_t ppc4xx_i2c_readw(void *opaque, hwaddr addr)
> +{
> +    uint32_t ret;
> +
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> +#endif
> +    ret =3D ppc4xx_i2c_readb(opaque, addr) << 8;
> +    ret |=3D ppc4xx_i2c_readb(opaque, addr + 1);
> +
> +    return ret;
> +}
> +
> +static void ppc4xx_i2c_writew(void *opaque,
> +                              hwaddr addr, uint32_t value)
> +{
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> +           value);
> +#endif
> +    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
> +    ppc4xx_i2c_writeb(opaque, addr + 1, value);
> +}
> +
> +static uint32_t ppc4xx_i2c_readl(void *opaque, hwaddr addr)
> +{
> +    uint32_t ret;
> +
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> +#endif
> +    ret =3D ppc4xx_i2c_readb(opaque, addr) << 24;
> +    ret |=3D ppc4xx_i2c_readb(opaque, addr + 1) << 16;
> +    ret |=3D ppc4xx_i2c_readb(opaque, addr + 2) << 8;
> +    ret |=3D ppc4xx_i2c_readb(opaque, addr + 3);
> +
> +    return ret;
> +}
> +
> +static void ppc4xx_i2c_writel(void *opaque,
> +                              hwaddr addr, uint32_t value)
> +{
> +#ifdef DEBUG_I2C
> +    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
> +           value);
> +#endif
> +    ppc4xx_i2c_writeb(opaque, addr, value >> 24);
> +    ppc4xx_i2c_writeb(opaque, addr + 1, value >> 16);
> +    ppc4xx_i2c_writeb(opaque, addr + 2, value >> 8);
> +    ppc4xx_i2c_writeb(opaque, addr + 3, value);
> +}
> +
> +static const MemoryRegionOps i2c_ops =3D {
> +    .old_mmio =3D {
> +        .read =3D { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl=
, },
> +        .write =3D { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_wr=
itel, },
> +    },
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void ppc4xx_i2c_reset(void *opaque)
> +{
> +    ppc4xx_i2c_t *i2c;
> +
> +    i2c =3D opaque;
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
> +void ppc405_i2c_init(hwaddr base, qemu_irq irq)
> +{
> +    ppc4xx_i2c_t *i2c;
> +
> +    i2c =3D g_malloc0(sizeof(ppc4xx_i2c_t));
> +    i2c->irq =3D irq;
> +#ifdef DEBUG_I2C
> +    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
> +#endif
> +    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011=
);
> +    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
> +    qemu_register_reset(ppc4xx_i2c_reset, i2c);
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKfMACgkQbDjKyiDZ
s5LSCxAA4njNWHcXhe8DToN4ejMptfmDLApx3DTCBo+9glbbyrgwIlj4cHatwJGr
gvK8Zy2iZKDtUZ8yMpVklbSQwYjMICjne4CYYtq1YCdJqFSfK8DcDgdYDb1Dk7Ye
gmY3RhAGmaWK6WEPClBLu0dQv+ypoFQirY6ROY9YH24bkcrU2eAbPIc7nPIxg22a
cs3R4fSth5PjHGiT1GVh+2JR+qXX/iNW1lM8GclplTTdL5746XS/xwhS3M/jrBeW
okhVEAhzWbknQoE2YTHCD64oyuvYAWhRfSaQqBhJCWM+NkSMFBdpJsoCweqgpAab
OUwEG3dAZwXwuvArGoV7QJHwMYRcaFfh1J1+oMGZVvnJuHMkRT3yL3Lh1tQc9WLX
O2Bw6tlj6j/DNYY1ckFdNu+QTV6mxckRX8lojhTXbxdHaRE9awtk8K5NFZi2RamE
sTI6qOqnW0EmcXrexBVR9ZAMY4HfuU9VF8HZ2g6ixL7f/dt2vutxvo4hRTL+g/Ev
Y1TA+EYDCNiVaxQ06z2IVzv85oqDWybapBM624xH7PZtTDuQi11ia2S2hy55yRdL
HhoeOG2Kl+rBc/dAwaiuyXKpiLFVub/Nn70t+CZxbokUWYLccJgMvs1Fkn4KcJbT
1fpPhOrhyWEuZA0821aFuATAeflcS7FtdbCdNPYF6GlBXpFpJ5s=
=cn40
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
