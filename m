Received: from eggs.gnu.org ([2001:4830:134:3::10]:56370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0SE-0007MD-K2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs0S9-0004RE-Ha
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:47:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2e864a0-d4de-c238-b0ba-87b50e507b0f@amsat.org>
Date: Tue, 21 Aug 2018 03:47:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/22] hw/misc/iotkit: Wire up the sysctl
 and sysinfo register blocks
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

On 08/20/2018 11:11 AM, Peter Maydell wrote:
> Wire up the system control element's register banks
> (sysctl and sysinfo).
> 
> This is the last of the previously completely unimplemented
> components in the IoTKit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/iotkit.h |  6 +++++-
>  hw/arm/iotkit.c         | 26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
> index 0f5c5101708..426dc326a0d 100644
> --- a/include/hw/arm/iotkit.h
> +++ b/include/hw/arm/iotkit.h
> @@ -58,7 +58,8 @@
>  #include "hw/timer/cmsdk-apb-timer.h"
>  #include "hw/timer/cmsdk-apb-dualtimer.h"
>  #include "hw/watchdog/cmsdk-apb-watchdog.h"
> -#include "hw/misc/unimp.h"
> +#include "hw/misc/iotkit-sysctl.h"
> +#include "hw/misc/iotkit-sysinfo.h"
>  #include "hw/or-irq.h"
>  #include "hw/core/split-irq.h"
>  
> @@ -97,6 +98,9 @@ typedef struct IoTKit {
>      CMSDKAPBWatchdog nswatchdog;
>      CMSDKAPBWatchdog swatchdog;
>  
> +    IoTKitSysCtl sysctl;
> +    IoTKitSysCtl sysinfo;
> +
>      MemoryRegion container;
>      MemoryRegion alias1;
>      MemoryRegion alias2;
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index cb0ec456f39..f8276b5425c 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -16,7 +16,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/registerfields.h"
>  #include "hw/arm/iotkit.h"
> -#include "hw/misc/unimp.h"
>  #include "hw/arm/arm.h"
>  
>  /* Clock frequency in HZ of the 32KHz "slow clock" */
> @@ -151,6 +150,10 @@ static void iotkit_init(Object *obj)
>                            sizeof(s->nswatchdog), TYPE_CMSDK_APB_WATCHDOG);
>      sysbus_init_child_obj(obj, "swatchdog", &s->swatchdog,
>                            sizeof(s->swatchdog), TYPE_CMSDK_APB_WATCHDOG);
> +    sysbus_init_child_obj(obj, "iotkit-sysctl", &s->sysctl,
> +                          sizeof(s->sysctl), TYPE_IOTKIT_SYSCTL);
> +    sysbus_init_child_obj(obj, "iotkit-sysinfo", &s->sysinfo,
> +                          sizeof(s->sysinfo), TYPE_IOTKIT_SYSINFO);
>      object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
>                              sizeof(s->nmi_orgate), TYPE_OR_IRQ,
>                              &error_abort, NULL);
> @@ -516,13 +519,20 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>                            qdev_get_gpio_in_named(dev_apb_ppc1,
>                                                   "cfg_sec_resp", 0));
>  
> -    /* Using create_unimplemented_device() maps the stub into the
> -     * system address space rather than into our container, but the
> -     * overall effect to the guest is the same.
> -     */
> -    create_unimplemented_device("SYSINFO", 0x40020000, 0x1000);
> -
> -    create_unimplemented_device("SYSCONTROL", 0x50021000, 0x1000);
> +    object_property_set_bool(OBJECT(&s->sysinfo), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    /* System information registers */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, 0x40020000);
> +    /* System control registers */
> +    object_property_set_bool(OBJECT(&s->sysctl), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x50021000);
>  
>      /* This OR gate wires together outputs from the secure watchdogs to NMI */
>      object_property_set_int(OBJECT(&s->nmi_orgate), 2, "num-lines", &err);
> 
