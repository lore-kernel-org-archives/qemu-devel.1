Received: from eggs.gnu.org ([2001:4830:134:3::10]:55131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erSqX-0004Pv-Lr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erSqW-0006qg-Kz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:22:25 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erSqW-0006qC-EM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:22:24 -0500
Received: by mail-wr0-x243.google.com with SMTP id u49so7560002wrc.10
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 10:22:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1519856998.git.alistair.francis@xilinx.com>
	<a665ee99473159fb703f78281b52f6943100cecb.1519856998.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6dbed91b-4625-ad2e-0373-88122eff7cdd@amsat.org>
Date: Thu, 1 Mar 2018 15:22:21 -0300
MIME-Version: 1.0
In-Reply-To: <a665ee99473159fb703f78281b52f6943100cecb.1519856998.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] xlnx-zynqmp-pmu: Connect the PMU
 IOMOD PIT devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com

On 02/28/2018 07:32 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  hw/microblaze/xlnx-zynqmp-pmu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 999a5657cf..35a2314ffb 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -26,6 +26,7 @@
>  
>  #include "hw/intc/xlnx-zynqmp-ipi.h"
>  #include "hw/intc/xlnx-pmu-iomod-intc.h"
> +#include "hw/timer/xlnx-pmu-iomod-pit.h"
>  
>  /* Define the PMU device */
>  
> @@ -40,6 +41,7 @@
>  #define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
>  
>  #define XLNX_ZYNQMP_PMU_NUM_IPIS    4
> +#define XLNX_ZYNQMP_PMU_NUM_PITS    4
>  
>  static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
>      0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
> @@ -48,6 +50,13 @@ static const uint64_t ipi_irq[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
>      19, 20, 21, 22,
>  };
>  
> +static const uint64_t pit_addr[XLNX_ZYNQMP_PMU_NUM_PITS] = {
> +    0xFFD40040, 0xFFD40050, 0xFFD40060, 0xFFD40070,
> +};
> +static const uint64_t pit_irq[XLNX_ZYNQMP_PMU_NUM_PITS] = {
> +    3, 4, 5, 6,
> +};
> +
>  typedef struct XlnxZynqMPPMUSoCState {
>      /*< private >*/
>      DeviceState parent_obj;
> @@ -147,7 +156,9 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>      MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
>      MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
>      XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
> +    XlnxPMUPIT *pit[XLNX_ZYNQMP_PMU_NUM_PITS];
>      qemu_irq irq[32];
> +    qemu_irq tmp_irq;
>      int i;
>  
>      /* Create the ROM */
> @@ -186,6 +197,30 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>          sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
>      }
>  
> +    /* Create and connect the IOMOD PIT devices */
> +    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_PITS; i++) {
> +        pit[i] = g_new0(XlnxPMUPIT, 1);
> +        object_initialize(pit[i], sizeof(XlnxPMUPIT), TYPE_XLNX_ZYNQMP_IOMODULE_PIT);
> +        qdev_set_parent_bus(DEVICE(pit[i]), sysbus_get_default());
> +    }
> +
> +    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_PITS; i++) {
> +        object_property_set_bool(OBJECT(pit[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(pit[i]), 0, pit_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(pit[i]), 0, irq[pit_irq[i]]);
> +    }
> +
> +    /* PIT1 hits into PIT0 */
> +    tmp_irq = qdev_get_gpio_in_named(DEVICE(pit[0]), "ps_hit_in", 0);
> +    qdev_connect_gpio_out_named(DEVICE(pit[1]), "ps_hit_out", 0, tmp_irq);
> +
> +    /* PIT3 hits into PIT2 */
> +    tmp_irq = qdev_get_gpio_in_named(DEVICE(pit[2]), "ps_hit_in", 0);
> +    qdev_connect_gpio_out_named(DEVICE(pit[3]), "ps_hit_out", 0, tmp_irq);
> +
> +    /* TODO: PIT0 and PIT2 "ps_config" GPIO goes to The GPO1 device. */
> +
>      /* Load the kernel */
>      microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
>                             machine->ram_size,
> 
