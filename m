Received: from eggs.gnu.org ([2001:4830:134:3::10]:55577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0OU-0003iO-Mc
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0OQ-0002Qf-Lh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:43:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39537303-c634-b65e-ae60-fed755c82a87@amsat.org>
Date: Tue, 21 Aug 2018 03:43:50 -0300
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/22] hw/arm/mps2: Wire up
 dual-timer in mps2-an385 and mps2-an511
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

On 08/20/2018 11:10 AM, Peter Maydell wrote:
> The MPS2 FPGA images for the Cortex-M3 (mps2-an385 and mps2-511)
> both include a CMSDK dual-timer module. Wire this up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/mps2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 0a0ae867d9b..564624629d0 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -34,6 +34,7 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/char/cmsdk-apb-uart.h"
>  #include "hw/timer/cmsdk-apb-timer.h"
> +#include "hw/timer/cmsdk-apb-dualtimer.h"
>  #include "hw/misc/mps2-scc.h"
>  #include "hw/devices.h"
>  #include "net/net.h"
> @@ -64,6 +65,7 @@ typedef struct {
>      MemoryRegion blockram_m3;
>      MemoryRegion sram;
>      MPS2SCC scc;
> +    CMSDKAPBDualTimer dualtimer;
>  } MPS2MachineState;
>  
>  #define TYPE_MPS2_MACHINE "mps2"
> @@ -297,6 +299,15 @@ static void mps2_common_init(MachineState *machine)
>      cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
>      cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
>  
> +    sysbus_init_child_obj(OBJECT(mms), "dualtimer", &mms->dualtimer,
> +                          sizeof(mms->dualtimer), TYPE_CMSDK_APB_DUALTIMER);
> +    qdev_prop_set_uint32(DEVICE(&mms->dualtimer), "pclk-frq", SYSCLK_FRQ);
> +    object_property_set_bool(OBJECT(&mms->dualtimer), true, "realized",
> +                             &error_fatal);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
> +                       qdev_get_gpio_in(armv7m, 10));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
> +
>      object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
>      sccdev = DEVICE(&mms->scc);
>      qdev_set_parent_bus(sccdev, sysbus_get_default());
> 
