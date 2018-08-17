Received: from eggs.gnu.org ([2001:4830:134:3::10]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqoV6-0001cy-6O
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqoV1-0007MH-EE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:49:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9189f510-869e-c3d6-f925-24092c0f2c57@amsat.org>
Date: Fri, 17 Aug 2018 20:49:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 04/16] hw/arm/iotkit: Wire up
 the S32KTIMER
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

On 08/09/2018 10:01 AM, Peter Maydell wrote:
> The IoTKit has a CMSDK timer device that runs on the S32KCLK.
> Create this and wire it up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/iotkit.h | 2 +-
>  hw/arm/iotkit.c         | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
> index 776d0497087..0f5c5101708 100644
> --- a/include/hw/arm/iotkit.h
> +++ b/include/hw/arm/iotkit.h
> @@ -83,6 +83,7 @@ typedef struct IoTKit {
>      TZMPC mpc;
>      CMSDKAPBTIMER timer0;
>      CMSDKAPBTIMER timer1;
> +    CMSDKAPBTIMER s32ktimer;
>      qemu_or_irq ppc_irq_orgate;
>      SplitIRQ sec_resp_splitter;
>      SplitIRQ ppc_irq_splitter[NUM_PPCS];
> @@ -91,7 +92,6 @@ typedef struct IoTKit {
>      qemu_or_irq nmi_orgate;
>  
>      CMSDKAPBDualTimer dualtimer;
> -    UnimplementedDeviceState s32ktimer;
>  
>      CMSDKAPBWatchdog s32kwatchdog;
>      CMSDKAPBWatchdog nswatchdog;
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index 5cedfa03570..cb0ec456f39 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -141,6 +141,8 @@ static void iotkit_init(Object *obj)
>                            TYPE_CMSDK_APB_TIMER);
>      sysbus_init_child_obj(obj, "timer1", &s->timer1, sizeof(s->timer1),
>                            TYPE_CMSDK_APB_TIMER);
> +    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
> +                          TYPE_CMSDK_APB_TIMER);
>      sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
>                            TYPE_CMSDK_APB_DUALTIMER);
>      sysbus_init_child_obj(obj, "s32kwatchdog", &s->s32kwatchdog,
> @@ -166,8 +168,6 @@ static void iotkit_init(Object *obj)
>                                  TYPE_SPLIT_IRQ, &error_abort, NULL);
>          g_free(name);
>      }
> -    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
> -                          TYPE_UNIMPLEMENTED_DEVICE);
>  }
>  
>  static void iotkit_exp_irq(void *opaque, int n, int level)
> @@ -476,13 +476,14 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>      /* Devices behind APB PPC1:
>       *   0x4002f000: S32K timer
>       */
> -    qdev_prop_set_string(DEVICE(&s->s32ktimer), "name", "S32KTIMER");
> -    qdev_prop_set_uint64(DEVICE(&s->s32ktimer), "size", 0x1000);
> +    qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
>      object_property_set_bool(OBJECT(&s->s32ktimer), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->armv7m), 2));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
>      object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]", &err);
>      if (err) {
> 
