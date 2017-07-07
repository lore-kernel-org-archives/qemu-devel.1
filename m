Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dTNNB-0006fz-7d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dTNN6-0005xI-5u
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:08:14 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKORKWWOUSAQ8_GtF6rOspE0mtJOEhJTvfuJ6h7JAru74A@mail.gmail.com>
References: <1499057115-6773-1-git-send-email-sundeep.lkml@gmail.com>
	<1499057115-6773-3-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKORKWWOUSAQ8_GtF6rOspE0mtJOEhJTvfuJ6h7JAru74A@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Fri, 7 Jul 2017 12:38:10 +0530
Message-ID: <CALHRZuo7Y2RpS3EWnd55_Te_p2YSo03JcdTYB31MDz7p07bSGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v6 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi Alistair,

On Wed, Jul 5, 2017 at 11:36 PM, Alistair Francis <alistair23@gmail.com>
wrote:

> On Sun, Jul 2, 2017 at 9:45 PM, Subbaraya Sundeep
> <sundeep.lkml@gmail.com> wrote:
> > Added Sytem register block of Smartfusion2.
> > This block has PLL registers which are accessed by guest.
> >
> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > ---
> >  hw/misc/Makefile.objs         |   1 +
> >  hw/misc/msf2-sysreg.c         | 200 ++++++++++++++++++++++++++++++
> ++++++++++++
> >  include/hw/misc/msf2-sysreg.h |  82 +++++++++++++++++
> >  3 files changed, 283 insertions(+)
> >  create mode 100644 hw/misc/msf2-sysreg.c
> >  create mode 100644 include/hw/misc/msf2-sysreg.h
> >
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index c8b4893..0f52354 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -56,3 +56,4 @@ obj-$(CONFIG_EDU) += edu.o
> >  obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
> >  obj-$(CONFIG_AUX) += auxbus.o
> >  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> > +obj-$(CONFIG_MSF2) += msf2-sysreg.o
> > diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
> > new file mode 100644
> > index 0000000..64ee141
> > --- /dev/null
> > +++ b/hw/misc/msf2-sysreg.c
> > @@ -0,0 +1,200 @@
> > +/*
> > + * System Register block model of Microsemi SmartFusion2.
> > + *
> > + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "hw/misc/msf2-sysreg.h"
>
> Same #include comment from patch 1.
>

Ok will change.

>
> > +
> > +#ifndef MSF2_SYSREG_ERR_DEBUG
> > +#define MSF2_SYSREG_ERR_DEBUG  0
> > +#endif
> > +
> > +#define DB_PRINT_L(lvl, fmt, args...) do { \
> > +    if (MSF2_SYSREG_ERR_DEBUG >= lvl) { \
> > +        qemu_log("%s: " fmt "\n", __func__, ## args); \
> > +    } \
> > +} while (0);
> > +
> > +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
> > +
> > +static inline int msf2_divbits(uint32_t div)
> > +{
> > +    int ret = 0;
> > +
> > +    switch (div) {
> > +    case 1:
> > +        ret = 0;
> > +        break;
> > +    case 2:
> > +        ret = 1;
> > +        break;
> > +    case 4:
> > +        ret = 2;
> > +        break;
> > +    case 8:
> > +        ret = 4;
> > +        break;
> > +    case 16:
> > +        ret = 5;
> > +        break;
> > +    case 32:
> > +        ret = 6;
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static void msf2_sysreg_reset(DeviceState *d)
> > +{
> > +    MSF2SysregState *s = MSF2_SYSREG(d);
> > +
> > +    DB_PRINT("RESET");
> > +
> > +    s->regs[MSSDDR_PLL_STATUS_LOW_CR] = 0x021A2358;
> > +    s->regs[MSSDDR_PLL_STATUS] = 0x3;
> > +    s->regs[MSSDDR_FACC1_CR] = msf2_divbits(s->apb0div) << 5 |
> > +                               msf2_divbits(s->apb1div) << 2;
> > +}
> > +
> > +static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
> > +    unsigned size)
> > +{
> > +    MSF2SysregState *s = opaque;
> > +    offset /= 4;
>
> Probably best to use a bitshift.
>

Ok will change.

>
> > +    uint32_t ret = 0;
> > +
> > +    if (offset < ARRAY_SIZE(s->regs)) {
> > +        ret = s->regs[offset];
> > +        DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx32,
> > +                    offset * 4, ret);
>
> Bitshift here as well.
>

Ok will change.

>
> > +    } else {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                    "%s: Bad offset 0x%08" HWADDR_PRIx "\n", __func__,
> > +                    offset * 4);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static void msf2_sysreg_write(void *opaque, hwaddr offset,
> > +                          uint64_t val, unsigned size)
> > +{
> > +    MSF2SysregState *s = (MSF2SysregState *)opaque;
> > +    uint32_t newval = val;
> > +    uint32_t oldval;
> > +
> > +    DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx64,
> > +            offset, val);
> > +
> > +    offset /= 4;
>
> Same here


Ok will change

>
> > +
> > +    switch (offset) {
> > +    case MSSDDR_PLL_STATUS:
> > +        break;
> > +
> > +    case ESRAM_CR:
> > +        oldval = s->regs[ESRAM_CR];
> > +        if (oldval ^ newval) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                       TYPE_MSF2_SYSREG": eSRAM remapping not
> supported\n");
> > +            abort();
>
> The guest should not be able to kill QEMU, a guest error should never
> result in an abort.
>

Philippe suggested to abort because:
If guest tries to remap since firmware do a remap, the code flow will be
completely wrong.
Reporting a GUEST_ERROR here is not enough since code flow continuing would
be
pretty hard to understand/debug.
We decided to abort for now.


> > +        }
> > +        break;
> > +
> > +    case DDR_CR:
> > +        oldval = s->regs[DDR_CR];
> > +        if (oldval ^ newval) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                       TYPE_MSF2_SYSREG": DDR remapping not
> supported\n");
> > +            abort();
> > +        }
> > +        break;
> > +
> > +    case ENVM_REMAP_BASE_CR:
> > +        oldval = s->regs[ENVM_REMAP_BASE_CR];
> > +        if (oldval ^ newval) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                       TYPE_MSF2_SYSREG": eNVM remapping not
> supported\n");
> > +            abort();
> > +        }
> > +        break;
> > +
> > +    default:
> > +        if (offset < ARRAY_SIZE(s->regs)) {
> > +            s->regs[offset] = val;
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                        "%s: Bad offset 0x%08" HWADDR_PRIx "\n",
> __func__,
> > +                        offset * 4);
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps sysreg_ops = {
> > +    .read = msf2_sysreg_read,
> > +    .write = msf2_sysreg_write,
> > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static void msf2_sysreg_init(Object *obj)
> > +{
> > +    MSF2SysregState *s = MSF2_SYSREG(obj);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &sysreg_ops, s,
> TYPE_MSF2_SYSREG,
> > +                          MSF2_SYSREG_MMIO_SIZE);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> > +}
> > +
> > +static const VMStateDescription vmstate_msf2_sysreg = {
> > +    .name = TYPE_MSF2_SYSREG,
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, MSF2SysregState,
> MSF2_SYSREG_MMIO_SIZE / 4),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
>
> This just reminded me that I don't think your first patch has a
> VMState. Can you add that
>

Sure thanks for pointing it.

Thanks,
Sundeep


>
> Thanks,
> Alistair
>
> > +
> > +static Property msf2_sysreg_properties[] = {
> > +    /* default divisors in Libero GUI */
> > +    DEFINE_PROP_UINT32("apb0divisor", MSF2SysregState, apb0div, 2),
> > +    DEFINE_PROP_UINT32("apb1divisor", MSF2SysregState, apb1div, 2),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->vmsd = &vmstate_msf2_sysreg;
> > +    dc->reset = msf2_sysreg_reset;
> > +    dc->props = msf2_sysreg_properties;
> > +}
> > +
> > +static const TypeInfo msf2_sysreg_info = {
> > +    .name  = TYPE_MSF2_SYSREG,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .class_init = msf2_sysreg_class_init,
> > +    .instance_size  = sizeof(MSF2SysregState),
> > +    .instance_init = msf2_sysreg_init,
> > +};
> > +
> > +static void msf2_sysreg_register_types(void)
> > +{
> > +    type_register_static(&msf2_sysreg_info);
> > +}
> > +
> > +type_init(msf2_sysreg_register_types)
> > diff --git a/include/hw/misc/msf2-sysreg.h
> b/include/hw/misc/msf2-sysreg.h
> > new file mode 100644
> > index 0000000..5e9ea99
> > --- /dev/null
> > +++ b/include/hw/misc/msf2-sysreg.h
> > @@ -0,0 +1,82 @@
> > +/*
> > + * Microsemi SmartFusion2 SYSREG
> > + *
> > + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_MSF2_SYSREG_H
> > +#define HW_MSF2_SYSREG_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/hw.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qemu/log.h"
> > +
> > +enum {
> > +    ESRAM_CR        = 0x00 / 4,
> > +    ESRAM_MAX_LAT,
> > +    DDR_CR,
> > +    ENVM_CR,
> > +    ENVM_REMAP_BASE_CR,
> > +    ENVM_REMAP_FAB_CR,
> > +    CC_CR,
> > +    CC_REGION_CR,
> > +    CC_LOCK_BASE_ADDR_CR,
> > +    CC_FLUSH_INDX_CR,
> > +    DDRB_BUF_TIMER_CR,
> > +    DDRB_NB_ADDR_CR,
> > +    DDRB_NB_SIZE_CR,
> > +    DDRB_CR,
> > +
> > +    SOFT_RESET_CR  = 0x48 / 4,
> > +    M3_CR,
> > +
> > +    GPIO_SYSRESET_SEL_CR = 0x58 / 4,
> > +
> > +    MDDR_CR = 0x60 / 4,
> > +
> > +    MSSDDR_PLL_STATUS_LOW_CR = 0x90 / 4,
> > +    MSSDDR_PLL_STATUS_HIGH_CR,
> > +    MSSDDR_FACC1_CR,
> > +    MSSDDR_FACC2_CR,
> > +
> > +    MSSDDR_PLL_STATUS = 0x150 / 4,
> > +
> > +};
> > +
> > +#define MSF2_SYSREG_MMIO_SIZE     0x300
> > +
> > +#define TYPE_MSF2_SYSREG          "msf2-sysreg"
> > +#define MSF2_SYSREG(obj)  OBJECT_CHECK(MSF2SysregState, (obj),
> TYPE_MSF2_SYSREG)
> > +
> > +typedef struct MSF2SysregState {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion iomem;
> > +
> > +    uint32_t apb0div;
> > +    uint32_t apb1div;
> > +
> > +    uint32_t regs[MSF2_SYSREG_MMIO_SIZE / 4];
> > +} MSF2SysregState;
> > +
> > +#endif /* HW_MSF2_SYSREG_H */
> > --
> > 2.5.0
> >
>
