Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1aOU-0008DF-6r
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1aOS-0006Lb-Sz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:55:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WWzrcRHQZK4oXxz30hcOMuRpr+om7r=+reg7OysX3hA@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-14-andrew.smirnov@gmail.com>
	<CAFEAcA-WWzrcRHQZK4oXxz30hcOMuRpr+om7r=+reg7OysX3hA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 9 Oct 2017 08:54:56 -0700
Message-ID: <CAHQ1cqEvjvCM0UT7ZndTZiuHAMMAH2TSZ-B+cEbL8M62F3JFwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/17] i.MX: Add code to emulate i.MX2
 watchdog IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Oct 6, 2017 at 7:22 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Add enough code to emulate i.MX2 watchdog IP block so it would be
>> possible to reboot the machine running Linux Guest.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/misc/Makefile.objs      |   1 +
>>  hw/misc/imx2_wdt.c         | 117 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/misc/imx2_wdt.h |  36 ++++++++++++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 hw/misc/imx2_wdt.c
>>  create mode 100644 include/hw/misc/imx2_wdt.h
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index ac1be05a03..c393a93456 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_IMX) += imx25_ccm.o
>>  obj-$(CONFIG_IMX) += imx6_ccm.o
>>  obj-$(CONFIG_IMX) += imx6_src.o
>>  obj-$(CONFIG_IMX) += imx7_ccm.o
>> +obj-$(CONFIG_IMX) += imx2_wdt.o
>>  obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>>  obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>>  obj-$(CONFIG_MAINSTONE) += mst_fpga.o
>> diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
>> new file mode 100644
>> index 0000000000..9d97a19511
>> --- /dev/null
>> +++ b/hw/misc/imx2_wdt.c
>> @@ -0,0 +1,117 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * i.MX2 Watchdog IP block
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu-common.h"
>> +#include "hw/hw.h"
>> +#include "exec/memory.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/log.h"
>> +#include "qemu/timer.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/watchdog.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/sizes.h"
>
> That's an awful lot of includes for a very simple device. Are
> you sure they're all needed?

No, I am not sure. I'll double-check.

>
>> +
>> +#include "hw/misc/imx2_wdt.h"
>> +
>> +
>> +#define IMX2_WDT_WCR_WDA       BIT(5)          /* -> External Reset WDOG_B */
>> +#define IMX2_WDT_WCR_SRS       BIT(4)          /* -> Software Reset Signal */
>> +
>> +static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
>> +                              unsigned int size)
>> +{
>> +    IMX2WdtState *s = opaque;
>> +    const size_t index = addr / sizeof(s->reg[0]);
>> +
>> +    if (index < ARRAY_SIZE(s->reg))
>> +        return s->reg[index];
>> +    else
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
>> +
>> +    return 0xDEADBEEF;
>> +}
>> +
>> +static void imx2_wdt_write(void *opaque, hwaddr addr,
>> +                           uint64_t val64, unsigned int size)
>> +{
>> +    uint16_t value  = val64;
>> +    IMX2WdtState *s = opaque;
>> +    const size_t index = addr / sizeof(s->reg[0]);
>> +
>> +    switch (index) {
>> +    case IMX2_WDT_WCR:
>> +        if (value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))
>> +            watchdog_perform_action();
>
> Missing "break"?
>

Oops, good catch! Will fix in v2.

> Also checkpatch should tell you you need more braces.
>

Yeah, I definitely forgot to run this through checkpatch, sorry.

>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps imx2_wdt_ops = {
>> +    .read  = imx2_wdt_read,
>> +    .write = imx2_wdt_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .valid = {
>> +        /*
>> +         * Our device would not work correctly if the guest was doing
>> +         * unaligned access. This might not be a limitation on the real
>> +         * device but in practice there is no reason for a guest to access
>> +         * this device unaligned.
>> +         */
>
> This sounds like it's perhaps a job for .impl.unaligned
> rather than .valid.unaligned ?
>

This was a snippet I copied from some already existing emulation
block, so I didn't pay too much attention. But yeah, now that you
suggested it, I think I should've used impl.valid as you suggest. Will
fix in v2.

>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +        .unaligned = false,
>> +    },
>> +};
>> +
>> +static void imx2_wdt_realize(DeviceState *dev, Error **errp)
>> +{
>> +    IMX2WdtState *s = IMX2_WDT(dev);
>> +
>> +    memory_region_init_io(&s->mmio, OBJECT(dev),
>> +                          &imx2_wdt_ops, s,
>> +                          TYPE_IMX2_WDT".mmio", SZ_64K);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
>> +}
>> +
>> +static void imx2_wdt_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = imx2_wdt_realize;
>> +
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +}
>> +
>> +static const TypeInfo imx2_wdt_info = {
>> +    .name          = TYPE_IMX2_WDT,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(IMX2WdtState),
>> +    .class_init    = imx2_wdt_class_init,
>> +};
>
> This device needs a reset function and vmstate description.
>

OK, will fix in v2.

Thanks
Andrey Smirnov
