Received: from eggs.gnu.org ([2001:4830:134:3::10]:37700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUuh9-0006hR-S0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUuh6-0001Ih-NO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:55:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fdb48dbe-b3c4-6641-b329-aeafb17a663c@amsat.org>
Date: Tue, 11 Jul 2017 09:55:08 -0300
MIME-Version: 1.0
In-Reply-To: <1499771839-32518-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 7/7] hw/arm/mps2: Add SCC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/11/2017 08:17 AM, Peter Maydell wrote:
> Add the SCC to the MPS2 board models.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/arm/mps2.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index b1a0df9..3dd61fe 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -34,6 +34,7 @@
>   #include "hw/misc/unimp.h"
>   #include "hw/char/cmsdk-apb-uart.h"
>   #include "hw/timer/cmsdk-apb-timer.h"
> +#include "hw/misc/mps2-scc.h"
>   
>   typedef enum MPS2FPGAType {
>       FPGA_AN385,
> @@ -44,6 +45,7 @@ typedef struct {
>       MachineClass parent;
>       MPS2FPGAType fpga_type;
>       const char *cpu_model;
> +    uint32_t scc_id;
>   } MPS2MachineClass;
>   
>   typedef struct {
> @@ -60,6 +62,7 @@ typedef struct {
>       MemoryRegion blockram_m2;
>       MemoryRegion blockram_m3;
>       MemoryRegion sram;
> +    MPS2SCC scc;
>   } MPS2MachineState;
>   
>   #define TYPE_MPS2_MACHINE "mps2"
> @@ -114,7 +117,7 @@ static void mps2_common_init(MachineState *machine)
>   
>       MemoryRegion *system_memory = get_system_memory();
>   
> -    DeviceState *armv7m;
> +    DeviceState *armv7m, *sccdev;
>   
>       /* The FPGA images have an odd combination of different RAMs,
>        * because in hardware they are different implementations and
> @@ -298,6 +301,16 @@ static void mps2_common_init(MachineState *machine)
>       cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
>       cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
>   
> +    object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
> +    sccdev = DEVICE(&mms->scc);
> +    qdev_set_parent_bus(armv7m, sysbus_get_default());
> +    qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
> +    qdev_prop_set_uint32(sccdev, "scc-aid", 0x02000008);
> +    qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
> +    object_property_set_bool(OBJECT(&mms->scc), true, "realized",
> +                             &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
> +
>       system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>   
>       armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> @@ -320,6 +333,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
>       mc->desc = "ARM MPS2 with AN385 FPGA image for Cortex-M3";
>       mmc->fpga_type = FPGA_AN385;
>       mmc->cpu_model = "cortex-m3";
> +    mmc->scc_id = 0x41040000 | (385 << 4);
>   }
>   
>   static void mps2_an511_class_init(ObjectClass *oc, void *data)
> @@ -330,6 +344,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
>       mc->desc = "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3";
>       mmc->fpga_type = FPGA_AN511;
>       mmc->cpu_model = "cortex-m3";
> +    mmc->scc_id = 0x4104000 | (511 << 4);
>   }
>   
>   static const TypeInfo mps2_info = {
> 
