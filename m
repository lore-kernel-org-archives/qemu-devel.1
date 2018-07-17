Received: from eggs.gnu.org ([2001:4830:134:3::10]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRTp-0001nL-EN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRTf-0002tB-VT
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:01:33 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffRTf-0002sd-Os
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:01:23 -0400
Received: by mail-oi0-x243.google.com with SMTP id y207-v6so2572968oie.13
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:01:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ab43f647a637a7c63401dacc8b4edcd55aafcf7.1530395710.git.jcd@tribudubois.net>
References: <cover.1530395710.git.jcd@tribudubois.net>
	<1ab43f647a637a7c63401dacc8b4edcd55aafcf7.1530395710.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 16:01:02 +0100
Message-ID: <CAFEAcA8shGhPL6VSQCt7xhZRunuRrEs3Lh6g45nhWU2dZKUFRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] i.MX6UL: Add Freescale i.MX6 UltraLite
 14x14 EVK Board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 30 June 2018 at 22:58, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> Tested by booting linux 4.18 (built using imx_v6_v7_defconfig) on the
> emulated board.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>  hw/arm/Makefile.objs  |  2 +-
>  hw/arm/mcimx6ul-evk.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/mcimx6ul-evk.c
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index e419ad040b..2902f47b4c 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -36,4 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
>  obj-$(CONFIG_IOTKIT) += iotkit.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>  obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
> -obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o
> +obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
> diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
> new file mode 100644
> index 0000000000..7d1b3c97df
> --- /dev/null
> +++ b/hw/arm/mcimx6ul-evk.c
> @@ -0,0 +1,86 @@
> +/*
> + * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
> + *
> + * MCIMX6UL_EVK Board System emulation.
> + *
> + * This code is licensed under the GPL, version 2 or later.
> + * See the file `COPYING' in the top level directory.
> + *
> + * It (partially) emulates a mcimx6ul_evk board, with a Freescale
> + * i.MX6ul SoC
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/arm/fsl-imx6ul.h"
> +#include "hw/boards.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/qtest.h"
> +
> +typedef struct {
> +    FslIMX6ULState soc;
> +    MemoryRegion ram;
> +} MCIMX6ULEVK;
> +
> +static void mcimx6ul_evk_init(MachineState *machine)
> +{
> +    static struct arm_boot_info boot_info;
> +    MCIMX6ULEVK *s = g_new0(MCIMX6ULEVK, 1);
> +    Object *soc;
> +    int i;
> +
> +    if (machine->ram_size > FSL_IMX6UL_MMDC_SIZE) {
> +        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
> +                     machine->ram_size, FSL_IMX6UL_MMDC_SIZE);
> +        exit(1);
> +    }
> +
> +    boot_info = (struct arm_boot_info) {
> +        .loader_start = FSL_IMX6UL_MMDC_ADDR,
> +        .board_id = -1,
> +        .ram_size = machine->ram_size,
> +        .kernel_filename = machine->kernel_filename,
> +        .kernel_cmdline = machine->kernel_cmdline,
> +        .initrd_filename = machine->initrd_filename,
> +        .nb_cpus = smp_cpus,
> +    };
> +
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX6UL);
> +    soc = OBJECT(&s->soc);
> +    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal);

This should use object_initialize_child() rather than
object_initialize() + object_property_add_child().

> +    object_property_set_bool(soc, true, "realized", &error_fatal);

Otherwise this patch looks good.

thanks
-- PMM
