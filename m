Received: from eggs.gnu.org ([2001:4830:134:3::10]:56541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoRfP-0002xk-NJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoRfM-0002C8-I8
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:30:27 -0500
Date: Wed, 21 Feb 2018 11:30:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180221113012.2ee836fb@redhat.com>
In-Reply-To: <20180220180325.29818-20-peter.maydell@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-20-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/19] mps2-an505: New board model: MPS2
 with AN505 Cortex-M33 FPGA image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, 20 Feb 2018 18:03:25 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Define a new board model for the MPS2 with an AN505 FPGA image
> containing a Cortex-M33. Since the FPGA images for TrustZone
> cores (AN505, and the similar AN519 for Cortex-M23) have a
> significantly different layout of devices to the non-TrustZone
> images, we use a new source file rather than shoehorning them
> into the existing mps2.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/Makefile.objs |   1 +
>  hw/arm/mps2-tz.c     | 504 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 505 insertions(+)
>  create mode 100644 hw/arm/mps2-tz.c
> 
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 79cd30bb92..232258160a 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -19,5 +19,6 @@ obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>  obj-$(CONFIG_MPS2) += mps2.o
> +obj-$(CONFIG_MPS2) += mps2-tz.o
>  obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
>  obj-$(CONFIG_IOTKIT) += iotkit.o
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> new file mode 100644
> index 0000000000..ff414c649c
> --- /dev/null
> +++ b/hw/arm/mps2-tz.c
> @@ -0,0 +1,504 @@
> +/*
> + * ARM V2M MPS2 board emulation, trustzone aware FPGA images
> + *
> + * Copyright (c) 2017 Linaro Limited
> + * Written by Peter Maydell
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +/* The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
> + * FPGA but is otherwise the same as the 2). Since the CPU itself
> + * and most of the devices are in the FPGA, the details of the board
> + * as seen by the guest depend significantly on the FPGA image.
> + * This source file covers the following FPGA images, for TrustZone cores:
> + *  "mps2-an505" -- Cortex-M33 as documented in ARM Application Note AN505
> + *
> + * Links to the TRM for the board itself and to the various Application
> + * Notes which document the FPGA images can be found here:
> + * https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/mps2
> + *
> + * Board TRM:
> + * http://infocenter.arm.com/help/topic/com.arm.doc.100112_0200_06_en/versatile_express_cortex_m_prototyping_systems_v2m_mps2_and_v2m_mps2plus_technical_reference_100112_0200_06_en.pdf
> + * Application Note AN505:
> + * http://infocenter.arm.com/help/topic/com.arm.doc.dai0505b/index.html
> + *
> + * The AN505 defers to the Cortex-M33 processor ARMv8M IoT Kit FVP User Guide
> + * (ARM ECM0601256) for the details of some of the device layout:
> + *   http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/arm.h"
> +#include "hw/arm/armv7m.h"
> +#include "hw/or-irq.h"
> +#include "hw/boards.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/char/cmsdk-apb-uart.h"
> +#include "hw/timer/cmsdk-apb-timer.h"
> +#include "hw/misc/mps2-scc.h"
> +#include "hw/misc/mps2-fpgaio.h"
> +#include "hw/arm/iotkit.h"
> +#include "hw/devices.h"
> +#include "net/net.h"
> +#include "hw/core/split-irq.h"
> +
> +typedef enum MPS2TZFPGAType {
> +    FPGA_AN505,
> +} MPS2TZFPGAType;
> +
> +typedef struct {
> +    MachineClass parent;
> +    MPS2TZFPGAType fpga_type;
> +    const char *cpu_model;
I don't see it used in this patch, should it be removed?


> +    uint32_t scc_id;
> +} MPS2TZMachineClass;
> +
[...]
