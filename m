Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOkTz-0007Ti-1B
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOkTw-0002KP-9r
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:48:11 -0400
MIME-Version: 1.0
In-Reply-To: <0fcc007c-c308-38bc-02c8-045ad1330dc1@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-3-git-send-email-sundeep.lkml@gmail.com>
	<0fcc007c-c308-38bc-02c8-045ad1330dc1@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Sat, 24 Jun 2017 18:18:06 +0530
Message-ID: <CALHRZur0p6TGQ3CG3kFFK9SXPECPhesP59sEXKDgB47AwS8MhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Tue, May 30, 2017 at 6:21 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Subbaraya,
>
> This patch looks good.
>
>
> On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
>
>> Added Sytem register block of Smartfusion2.
>> This block has PLL registers which are accessed by guest.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/misc/Makefile.objs         |   1 +
>>  hw/misc/msf2-sysreg.c         | 161 ++++++++++++++++++++++++++++++
>> ++++++++++++
>>  include/hw/misc/msf2-sysreg.h |  80 +++++++++++++++++++++
>>  3 files changed, 242 insertions(+)
>>  create mode 100644 hw/misc/msf2-sysreg.c
>>  create mode 100644 include/hw/misc/msf2-sysreg.h
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index c8b4893..0f52354 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -56,3 +56,4 @@ obj-$(CONFIG_EDU) +=3D edu.o
>>  obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>>  obj-$(CONFIG_AUX) +=3D auxbus.o
>>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>> +obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
>> diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
>> new file mode 100644
>> index 0000000..8d3118f
>> --- /dev/null
>> +++ b/hw/misc/msf2-sysreg.c
>> @@ -0,0 +1,161 @@
>> +/*
>> + * System Register block model of Microsemi SmartFusion2.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "hw/misc/msf2-sysreg.h"
>> +
>> +#ifndef MSF2_SYSREG_ERR_DEBUG
>> +#define MSF2_SYSREG_ERR_DEBUG  0
>> +#endif
>> +
>> +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> +    if (MSF2_SYSREG_ERR_DEBUG >=3D lvl) { \
>> +        qemu_log("%s: " fmt, __func__, ## args); \
>> +    } \
>> +} while (0);
>> +
>> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>> +
>> +static void msf2_sysreg_reset(DeviceState *d)
>> +{
>> +    MSF2SysregState *s =3D MSF2_SYSREG(d);
>> +
>> +    DB_PRINT("RESET\n");
>> +
>> +    s->regs[MSSDDR_PLL_STATUS_LOW_CR] =3D 0x021A2358;
>> +    s->regs[MSSDDR_FACC1_CR] =3D 0x0B800124;
>> +    s->regs[MSSDDR_PLL_STATUS] =3D 0x3;
>>
>
> I'll have a closer look a those values.


I just used values from real hardware board.

>
>
> +}
>> +
>> +static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
>> +    unsigned size)
>> +{
>> +    MSF2SysregState *s =3D opaque;
>> +    offset /=3D 4;
>> +    uint32_t ret =3D 0;
>> +
>> +    if (offset < ARRAY_SIZE(s->regs)) {
>> +        ret =3D s->regs[offset];
>> +        DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx32 "\n",
>> +                    offset * 4, ret);
>> +    } else {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                    "%s: Bad offset 0x%08" HWADDR_PRIx "\n", __func__,
>> +                    offset * 4);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void msf2_sysreg_write(void *opaque, hwaddr offset,
>> +                          uint64_t val, unsigned size)
>> +{
>> +    MSF2SysregState *s =3D (MSF2SysregState *)opaque;
>> +    uint32_t newval =3D val;
>> +    uint32_t oldval;
>> +
>> +    offset /=3D 4;
>> +
>> +    DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx64 "\n",
>> +            offset * 4, val);
>> +
>> +    switch (offset) {
>> +    case MSSDDR_PLL_STATUS:
>> +        break;
>> +
>> +    case ESRAM_CR:
>> +        oldval =3D s->regs[ESRAM_CR];
>> +        if (oldval ^ newval) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                       TYPE_MSF2_SYSREG": eSRAM remapping not
>> supported\n");
>> +            abort();
>> +        }
>> +        break;
>> +
>> +    case DDR_CR:
>> +        oldval =3D s->regs[DDR_CR];
>> +        if (oldval ^ newval) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                       TYPE_MSF2_SYSREG": DDR remapping not
>> supported\n");
>> +            abort();
>> +        }
>> +        break;
>> +
>> +    case ENVM_REMAP_BASE_CR:
>> +        oldval =3D s->regs[ENVM_REMAP_BASE_CR];
>> +        if (oldval ^ newval) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                       TYPE_MSF2_SYSREG": eNVM remapping not
>> supported\n");
>> +            abort();
>> +        }
>> +        break;
>>
>
> Thanks for adding the remap checks :)
>
> :)

>
> +
>> +    default:
>> +        if (offset < ARRAY_SIZE(s->regs)) {
>> +            s->regs[offset] =3D val;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                        "%s: Bad offset 0x%08" HWADDR_PRIx "\n",
>> __func__,
>> +                        offset * 4);
>> +        }
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps sysreg_ops =3D {
>> +    .read =3D msf2_sysreg_read,
>> +    .write =3D msf2_sysreg_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>> +static void msf2_sysreg_init(Object *obj)
>> +{
>> +    MSF2SysregState *s =3D MSF2_SYSREG(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &sysreg_ops, s,
>> TYPE_MSF2_SYSREG,
>> +                          MSF2_SYSREG_MMIO_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>> +}
>> +
>> +static const VMStateDescription vmstate_msf2_sysreg =3D {
>> +    .name =3D TYPE_MSF2_SYSREG,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(regs, MSF2SysregState,
>> MSF2_SYSREG_NUM_REGS),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->vmsd =3D &vmstate_msf2_sysreg;
>> +    dc->reset =3D msf2_sysreg_reset;
>> +}
>> +
>> +static const TypeInfo msf2_sysreg_info =3D {
>> +    .name  =3D TYPE_MSF2_SYSREG,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .class_init =3D msf2_sysreg_class_init,
>> +    .instance_size  =3D sizeof(MSF2SysregState),
>> +    .instance_init =3D msf2_sysreg_init,
>> +};
>> +
>> +static void msf2_sysreg_register_types(void)
>> +{
>> +    type_register_static(&msf2_sysreg_info);
>> +}
>> +
>> +type_init(msf2_sysreg_register_types)
>> diff --git a/include/hw/misc/msf2-sysreg.h b/include/hw/misc/msf2-sysreg=
.
>> h
>> new file mode 100644
>> index 0000000..a485ed6
>> --- /dev/null
>> +++ b/include/hw/misc/msf2-sysreg.h
>> @@ -0,0 +1,80 @@
>> +/*
>> + * Microsemi SmartFusion2 SYSREG
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_MSF2_SYSREG_H
>> +#define HW_MSF2_SYSREG_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/hw.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/log.h"
>> +
>> +enum {
>> +    ESRAM_CR        =3D 0x00 / 4,
>> +    ESRAM_MAX_LAT,
>> +    DDR_CR,
>> +    ENVM_CR,
>> +    ENVM_REMAP_BASE_CR,
>> +    ENVM_REMAP_FAB_CR,
>> +    CC_CR,
>> +    CC_REGION_CR,
>> +    CC_LOCK_BASE_ADDR_CR,
>> +    CC_FLUSH_INDX_CR,
>> +    DDRB_BUF_TIMER_CR,
>> +    DDRB_NB_ADDR_CR,
>> +    DDRB_NB_SIZE_CR,
>> +    DDRB_CR,
>> +
>> +    SOFT_RESET_CR  =3D 0x48 / 4,
>> +    M3_CR,
>> +
>> +    GPIO_SYSRESET_SEL_CR =3D 0x58 / 4,
>> +
>> +    MDDR_CR =3D 0x60 / 4,
>> +
>> +    MSSDDR_PLL_STATUS_LOW_CR =3D 0x90 / 4,
>> +    MSSDDR_PLL_STATUS_HIGH_CR,
>> +    MSSDDR_FACC1_CR,
>> +    MSSDDR_FACC2_CR,
>> +
>> +    MSSDDR_PLL_STATUS =3D 0x150 / 4,
>> +
>> +};
>> +
>> +#define MSF2_SYSREG_MMIO_SIZE     0x300
>> +#define MSF2_SYSREG_NUM_REGS      (MSF2_SYSREG_MMIO_SIZE / 4)
>>
>
> I don't think this define is very useful.
>

It is used in VMSTATE_UINT32_ARRAY(regs, MSF2SysregState,
MSF2_SYSREG_NUM_REGS).
Ok I will use MSF2_SYSREG_MMIO_SIZE / 4 directly instead.

>
> +
>> +#define TYPE_MSF2_SYSREG          "msf2-sysreg"
>> +#define MSF2_SYSREG(obj)  OBJECT_CHECK(MSF2SysregState, (obj),
>> TYPE_MSF2_SYSREG)
>> +
>> +typedef struct MSF2SysregState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +
>> +    uint32_t regs[MSF2_SYSREG_NUM_REGS];
>> +} MSF2SysregState;
>> +
>> +#endif /* HW_MSF2_SYSREG_H */
>>
>>
> Thanks,
Sundeep


> Regards,
>
> Phil.
>
