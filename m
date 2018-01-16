Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebIvY-00023h-9T
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebIvV-00075a-46
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:32:48 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-12-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
Date: Tue, 16 Jan 2018 01:32:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-12-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/14] ARM: Add basic code to emulate
 A7MPCore DAP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi Andrey,

On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
> Add minimal code to emulate A7MPCore DAP block needed to boot Linux
> guest.

I was not aware the DAP is accessed by upstream Linux...

You sure this isn't rather part of some bootloader built-in self-test?

> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/arm/Makefile.objs       |   2 +-
>  hw/arm/coresight.c         | 120 +++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/coresight.h |  24 +++++++++
>  3 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/coresight.c
>  create mode 100644 include/hw/arm/coresight.h
> 
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 2794e086d6..692216e0cf 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o
> +obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o coresight.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-y += integratorcp.o mainstone.o musicpal.o nseries.o
>  obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o
> diff --git a/hw/arm/coresight.c b/hw/arm/coresight.c
> new file mode 100644
> index 0000000000..d0a8c1b005
> --- /dev/null
> +++ b/hw/arm/coresight.c
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * CoreSight block emulation code
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/coresight.h"
> +#include "qemu/log.h"
> +
> +static uint64_t coresight_read(void *opaque, hwaddr offset,
> +                               unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void coresight_write(void *opaque, hwaddr offset,
> +                            uint64_t value, unsigned size)
> +{
> +}

I assume you had to add this to bypass the memory_transaction_failures
check.

> +
> +static const struct MemoryRegionOps coresight_ops = {
> +    .read = coresight_read,
> +    .write = coresight_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        /*
> +         * Our device would not work correctly if the guest was doing
> +         * unaligned access. This might not be a limitation on the real
> +         * device but in practice there is no reason for a guest to access
> +         * this device unaligned.
> +         */
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void a7mpcore_dap_init(Object *obj)
> +{
> +    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
> +    A7MPCoreDAPState *s = A7MPCORE_DAP(obj);
> +
> +    memory_region_init(&s->container, obj, "a7mpcore-dap-container", 0x100000);

You can just use add this in fsl_imx7_realize():

  create_unimplemented_device("a7mpcore-dap-container",
                              FSL_IMX7_A7MPCORE_DAP_ADDR,
                              0x100000);

to register a background region for the DAP (see "hw/misc/unimp.h")

as a bonus, running with "-d unimp" you can trace the DAP access.

So this model and those files are not necessary.

> +    sysbus_init_mmio(sd, &s->container);
> +
> +    memory_region_init_io(&s->ca7_atb_funnel,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".ca7-atb-funnel",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x41000, &s->ca7_atb_funnel);
> +
> +    memory_region_init_io(&s->cpu0_etm,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".cpu0-etm",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x7C000, &s->cpu0_etm);
> +
> +    memory_region_init_io(&s->atb_funnel,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".atb-funnel",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x83000, &s->atb_funnel);
> +
> +    memory_region_init_io(&s->tmc_etb,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".tmc-etb",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x84000, &s->tmc_etb);
> +
> +    memory_region_init_io(&s->tmc_etr,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".tmc-etr",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x86000, &s->tmc_etr);
> +
> +    memory_region_init_io(&s->tpiu,
> +                          obj,
> +                          &coresight_ops,
> +                          s,
> +                          TYPE_A7MPCORE_DAP ".tpiu",
> +                          0x1000);
> +    memory_region_add_subregion(&s->container, 0x87000, &s->tpiu);
> +}
> +
> +static void a7mpcore_dap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "A7MPCore DAP Module";
> +}
> +
> +static const TypeInfo a7mpcore_dap_info = {
> +    .name          = TYPE_A7MPCORE_DAP,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(A7MPCoreDAPState),
> +    .instance_init = a7mpcore_dap_init,
> +    .class_init    = a7mpcore_dap_class_init,
> +};
> +
> +static void coresight_register_type(void)
> +{
> +    type_register_static(&a7mpcore_dap_info);
> +}
> +type_init(coresight_register_type)
> diff --git a/include/hw/arm/coresight.h b/include/hw/arm/coresight.h
> new file mode 100644
> index 0000000000..d1480e825b
> --- /dev/null
> +++ b/include/hw/arm/coresight.h
> @@ -0,0 +1,24 @@
> +#ifndef CORESIGHT_H
> +#define CORESIGHT_H
> +
> +#include "hw/sysbus.h"
> +
> +typedef struct A7MPCoreDAPState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion container;
> +
> +    MemoryRegion ca7_atb_funnel;
> +    MemoryRegion cpu0_etm;
> +    MemoryRegion atb_funnel;
> +    MemoryRegion tmc_etb;
> +    MemoryRegion tmc_etr;
> +    MemoryRegion tpiu;
> +
> +} A7MPCoreDAPState;
> +
> +#define TYPE_A7MPCORE_DAP "a7mpcore-dap"
> +#define A7MPCORE_DAP(obj) OBJECT_CHECK(A7MPCoreDAPState, (obj), TYPE_A7MPCORE_DAP)
> +
> +#endif /* CORESIGHT_H */
> 
