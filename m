Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTFM-0002nk-Qg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTFL-0003ow-UI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:03:48 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPTFL-0003oZ-Qr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:03:47 -0500
Received: by mail-ua0-x229.google.com with SMTP id i68so300070146uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 04:03:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5b9a682feb30a4c22b068d698d65063c299d24cf.1482265908.git.alistair.francis@xilinx.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
	<5b9a682feb30a4c22b068d698d65063c299d24cf.1482265908.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 12:03:25 +0000
Message-ID: <CAFEAcA-oiVXMCfEJOgybD8b_OcL2qwsVxNKazAzXka=DuFj_Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 3/3] xlnx-zynqmp: Connect the ARM
 Generic Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alistair Francis <alistair23@gmail.com>

On 20 December 2016 at 22:42, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 0d86ba3..f3891ae 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -38,6 +38,8 @@
>  #define SATA_ADDR           0xFD0C0000
>  #define SATA_NUM_PORTS      2
>
> +#define ARM_GEN_TIMER_ADDR  0xFF260000
> +
>  #define DP_ADDR             0xfd4a0000
>  #define DP_IRQ              113
>
> @@ -172,6 +174,10 @@ static void xlnx_zynqmp_init(Object *obj)
>          qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
>      }
>
> +    object_initialize(&s->arm_gen_timer, sizeof(s->arm_gen_timer),
> +                      TYPE_ARM_GEN_TIMER);
> +    qdev_set_parent_bus(DEVICE(&s->arm_gen_timer), sysbus_get_default());
> +
>      object_initialize(&s->dp, sizeof(s->dp), TYPE_XLNX_DP);
>      qdev_set_parent_bus(DEVICE(&s->dp), sysbus_get_default());
>
> @@ -405,6 +411,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          g_free(bus_name);
>      }
>
> +    object_property_set_bool(OBJECT(&s->arm_gen_timer), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->arm_gen_timer), 0, ARM_GEN_TIMER_ADDR);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->arm_gen_timer), 1, ARM_GEN_TIMER_ADDR - 0x10000);

Having a #define for a base address and then also using
thing - 0x10000 is a bit odd. I'd use two #defines, I think.
(Also avoids the overlong line.)

If we take the "board responsible for only mapping the secure-only
regs into the secure address space" approach this code will need to
change accordingly.

> +
>      object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index c2931bf..8deabb4 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -26,6 +26,7 @@
>  #include "hw/ide/ahci.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/ssi/xilinx_spips.h"
> +#include "hw/timer/arm_generic_timer.h"
>  #include "hw/dma/xlnx_dpdma.h"
>  #include "hw/display/xlnx_dp.h"
>
> @@ -83,6 +84,7 @@ typedef struct XlnxZynqMPState {
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> +    ARMGenTimer arm_gen_timer;
>      XlnxDPState dp;
>      XlnxDPDMAState dpdma;

thanks
-- PMM
