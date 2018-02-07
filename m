Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejQg2-000092-BA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejQfw-0001cg-1u
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:26:22 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-5-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <202480a7-a417-f973-73a1-19c3a813f1f7@amsat.org>
Date: Wed, 7 Feb 2018 11:26:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180207042438.15422-5-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 04/14] i.MX: Add code to
 emulate i.MX2 watchdog IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi Andrey,

On 02/07/2018 01:24 AM, Andrey Smirnov wrote:
> Add enough code to emulate i.MX2 watchdog IP block so it would be
> possible to reboot the machine running Linux Guest.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/misc/Makefile.objs      |  1 +
>  hw/misc/imx2_wdt.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/misc/imx2_wdt.h | 33 +++++++++++++++++

I recommend you to setup scripts/git.orderfile to ease review.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  3 files changed, 123 insertions(+)
>  create mode 100644 hw/misc/imx2_wdt.c
>  create mode 100644 include/hw/misc/imx2_wdt.h
> 
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index a28e5e49b0..4b2b705a6c 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -34,6 +34,7 @@ obj-$(CONFIG_IMX) += imx25_ccm.o
>  obj-$(CONFIG_IMX) += imx6_ccm.o
>  obj-$(CONFIG_IMX) += imx6_src.o
>  obj-$(CONFIG_IMX) += imx7_ccm.o
> +obj-$(CONFIG_IMX) += imx2_wdt.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>  obj-$(CONFIG_MAINSTONE) += mst_fpga.o
> diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
> new file mode 100644
> index 0000000000..e47e442592
> --- /dev/null
> +++ b/hw/misc/imx2_wdt.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright (c) 2018, Impinj, Inc.
> + *
> + * i.MX2 Watchdog IP block
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "sysemu/watchdog.h"
> +
> +#include "hw/misc/imx2_wdt.h"
> +
> +#define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
> +#define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
> +
> +static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
> +                              unsigned int size)
> +{
> +    return 0;
> +}
> +
> +static void imx2_wdt_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned int size)
> +{
> +    if (addr == IMX2_WDT_WCR &&
> +        (value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
> +        watchdog_perform_action();
> +    }
> +}
> +
> +static const MemoryRegionOps imx2_wdt_ops = {
> +    .read  = imx2_wdt_read,
> +    .write = imx2_wdt_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        /*
> +         * Our device would not work correctly if the guest was doing
> +         * unaligned access. This might not be a limitation on the
> +         * real device but in practice there is no reason for a guest
> +         * to access this device unaligned.
> +         */
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void imx2_wdt_realize(DeviceState *dev, Error **errp)
> +{
> +    IMX2WdtState *s = IMX2_WDT(dev);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev),
> +                          &imx2_wdt_ops, s,
> +                          TYPE_IMX2_WDT".mmio",
> +                          IMX2_WDT_REG_NUM * sizeof(uint16_t));
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +}
> +
> +static void imx2_wdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = imx2_wdt_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo imx2_wdt_info = {
> +    .name          = TYPE_IMX2_WDT,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(IMX2WdtState),
> +    .class_init    = imx2_wdt_class_init,
> +};
> +
> +static WatchdogTimerModel model = {
> +    .wdt_name = "imx2-watchdog",
> +    .wdt_description = "i.MX2 Watchdog",
> +};
> +
> +static void imx2_wdt_register_type(void)
> +{
> +    watchdog_add_model(&model);
> +    type_register_static(&imx2_wdt_info);
> +}
> +type_init(imx2_wdt_register_type)
> diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/misc/imx2_wdt.h
> new file mode 100644
> index 0000000000..8afc99a10e
> --- /dev/null
> +++ b/include/hw/misc/imx2_wdt.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX2 Watchdog IP block
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef IMX2_WDT_H
> +#define IMX2_WDT_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_IMX2_WDT "imx2.wdt"
> +#define IMX2_WDT(obj) OBJECT_CHECK(IMX2WdtState, (obj), TYPE_IMX2_WDT)
> +
> +enum IMX2WdtRegisters {
> +    IMX2_WDT_WCR     = 0x0000,
> +    IMX2_WDT_REG_NUM = 0x0008 / sizeof(uint16_t) + 1,
> +};
> +
> +
> +typedef struct IMX2WdtState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +} IMX2WdtState;
> +
> +#endif /* IMX7_SNVS_H */
> 
