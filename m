Received: from eggs.gnu.org ([2001:4830:134:3::10]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TqS-0000pj-4j
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TqQ-000503-RN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:43:20 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:55756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TqQ-0004zO-I2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:43:18 -0400
Received: by mail-wm0-x22f.google.com with SMTP id u138so8374196wmu.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-18-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-18-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:42:56 +0100
Message-ID: <CAFEAcA-wjuFzQuxOGz2UbjL6qSO7H75WzKHPVrqhT40QMaLLog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/17] Implement support for i.MX7 Sabre
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:51, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/arm/Makefile.objs   |   2 +-
>  hw/arm/mcimx7d-sabre.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/mcimx7d-sabre.c
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 33f6051ae3..fc4a963de8 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -19,5 +19,5 @@ obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>  obj-$(CONFIG_MPS2) += mps2.o
> -obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o
> +obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> new file mode 100644
> index 0000000000..34e3933db8
> --- /dev/null
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * MCIMX7D_SABRE Board System emulation.
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This code is licensed under the GPL, version 2 or later.
> + * See the file `COPYING' in the top level directory.
> + *
> + * It (partially) emulates a mcimx7d_sabre board, with a Freescale
> + * i.MX7 SoC
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/arm/fsl-imx7.h"
> +#include "hw/boards.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/device_tree.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/qtest.h"
> +#include "net/net.h"
> +
> +typedef struct {
> +    FslIMX7State soc;
> +    MemoryRegion ram;
> +} MCIMX7Sabre;
> +
> +static void mcimx7d_add_psci_node(const struct arm_boot_info *boot_info, void *fdt)
> +{
> +    const char comp[] = "arm,psci-0.2\0arm,psci";
> +
> +    qemu_fdt_add_subnode(fdt, "/psci");
> +    qemu_fdt_setprop(fdt, "/psci", "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_string(fdt, "/psci", "method", "smc");
> +}

You shouldn't need this -- we should just be able to work with whatever
the real hardware's device tree is. ("virt" is a special case because
we create our own device tree there.)

> +
> +static void mcimx7d_sabre_init(MachineState *machine)
> +{
> +    static struct arm_boot_info boot_info;
> +    MCIMX7Sabre *s = g_new0(MCIMX7Sabre, 1);
> +    Object *soc;
> +    int i;
> +
> +    if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
> +        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
> +                     machine->ram_size, FSL_IMX7_MMDC_SIZE);
> +        exit(1);
> +    }
> +
> +    boot_info = (struct arm_boot_info) {
> +        .loader_start = FSL_IMX7_MMDC_ADDR,
> +        .board_id = -1,
> +        .ram_size = machine->ram_size,
> +        .kernel_filename = machine->kernel_filename,
> +        .kernel_cmdline = machine->kernel_cmdline,
> +        .initrd_filename = machine->initrd_filename,
> +        .nb_cpus = smp_cpus,
> +        .modify_dtb = mcimx7d_add_psci_node,
> +    };
> +
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX7);
> +    soc = OBJECT(&s->soc);
> +    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal);
> +    object_property_set_bool(soc, true, "realized", &error_fatal);
> +
> +    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.ram",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                FSL_IMX7_MMDC_ADDR, &s->ram);
> +
> +    for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
> +        BusState *bus;
> +        DeviceState *carddev;
> +        DriveInfo *di;
> +        BlockBackend *blk;
> +
> +        di = drive_get_next(IF_SD);
> +        blk = di ? blk_by_legacy_dinfo(di) : NULL;
> +        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
> +        carddev = qdev_create(bus, TYPE_SD_CARD);
> +        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> +        object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
> +    }
> +
> +    if (!qtest_enabled()) {
> +        arm_load_kernel(&s->soc.cpu[0], &boot_info);
> +    }
> +}
> +
> +static void mcimx7d_sabre_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex A7)";
> +    mc->init = mcimx7d_sabre_init;
> +    mc->max_cpus = FSL_IMX7_NUM_CPUS;
> +    mc->ignore_memory_transaction_failures = true;

Please don't set this flag on new board models -- it is only
for legacy existing board models (where we don't know what
running guest code might be broken by turning bad accesses
into guest aborts. For a new board model, you should leave
the flag unset and instead stub out any devices that you
need to using create_unimplemented_device() so that your
guest code boots.

thanks
-- PMM
