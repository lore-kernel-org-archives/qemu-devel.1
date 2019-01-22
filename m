Received: from eggs.gnu.org ([209.51.188.92]:56123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltoQ-0004vV-97
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltoK-0007EZ-9F
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:01:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gltoI-000766-E9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:01:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so26804789wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 03:01:17 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60356aab-3e21-bf0a-3829-d643e5e7fa56@redhat.com>
Date: Tue, 22 Jan 2019 12:01:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/23] hw/arm/iotkit: Refactor into
 abstract base class and subclass
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

On 1/21/19 7:51 PM, Peter Maydell wrote:
> The Arm SSE-200 Subsystem for Embedded is a revised and
> extended version of the older IoTKit SoC. Prepare for
> adding a model of it by refactoring the IoTKit code into
> an abstract base class which contains the functionality,
> driven by a class data block specific to each subclass.
> (This is the same approach used by the existing bcm283x
> SoC family implementation.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h | 22 +++++++++++++++++-----
>  hw/arm/iotkit.c         | 34 +++++++++++++++++++++++++++++-----
>  2 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
> index 9701738ec75..521d1f73757 100644
> --- a/include/hw/arm/iotkit.h
> +++ b/include/hw/arm/iotkit.h
> @@ -74,15 +74,15 @@
>  #include "hw/or-irq.h"
>  #include "hw/core/split-irq.h"
>  
> -#define TYPE_ARMSSE "iotkit"
> +#define TYPE_ARMSSE "arm-sse"
>  #define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
>  
>  /*
> - * For the moment TYPE_IOTKIT is a synonym for TYPE_ARMSSE (and the
> - * latter's underlying name is left as "iotkit"); in a later
> - * commit it will become a subclass of TYPE_ARMSSE.
> + * These type names are for specific IoTKit subsystems; other than
> + * instantiating them, code using these devices should always handle
> + * them via the ARMSSE base class, so they have no IOTKIT() etc macros.
>   */
> -#define TYPE_IOTKIT TYPE_ARMSSE
> +#define TYPE_IOTKIT "iotkit"
>  
>  /* We have an IRQ splitter and an OR gate input for each external PPC
>   * and the 2 internal PPCs
> @@ -143,4 +143,16 @@ typedef struct ARMSSE {
>      uint32_t mainclk_frq;
>  } ARMSSE;
>  
> +typedef struct ARMSSEInfo ARMSSEInfo;
> +
> +typedef struct ARMSSEClass {
> +    DeviceClass parent_class;
> +    const ARMSSEInfo *info;
> +} ARMSSEClass;
> +
> +#define ARMSSE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(ARMSSEClass, (klass), TYPE_ARMSSE)
> +#define ARMSSE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(ARMSSEClass, (obj), TYPE_ARMSSE)
> +
>  #endif
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index 9360053184e..d5b172933c3 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -18,6 +18,16 @@
>  #include "hw/arm/iotkit.h"
>  #include "hw/arm/arm.h"
>  
> +struct ARMSSEInfo {
> +    const char *name;
> +};
> +
> +static const ARMSSEInfo armsse_variants[] = {
> +    {
> +        .name = TYPE_IOTKIT,
> +    },
> +};
> +
>  /* Clock frequency in HZ of the 32KHz "slow clock" */
>  #define S32KCLK (32 * 1000)
>  
> @@ -732,29 +742,43 @@ static void iotkit_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(klass);
> +    ARMSSEClass *asc = ARMSSE_CLASS(klass);
>  
>      dc->realize = iotkit_realize;
>      dc->vmsd = &iotkit_vmstate;
>      dc->props = iotkit_properties;
>      dc->reset = iotkit_reset;
>      iic->check = iotkit_idau_check;
> +    asc->info = data;
>  }
>  
> -static const TypeInfo iotkit_info = {
> +static const TypeInfo armsse_info = {
>      .name = TYPE_ARMSSE,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(ARMSSE),
>      .instance_init = iotkit_init,
> -    .class_init = iotkit_class_init,
> +    .abstract = true,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_IDAU_INTERFACE },
>          { }
>      }
>  };
>  
> -static void iotkit_register_types(void)
> +static void armsse_register_types(void)
>  {
> -    type_register_static(&iotkit_info);
> +    int i;
> +
> +    type_register_static(&armsse_info);
> +
> +    for (i = 0; i < ARRAY_SIZE(armsse_variants); i++) {
> +        TypeInfo ti = {
> +            .name = armsse_variants[i].name,
> +            .parent = TYPE_ARMSSE,
> +            .class_init = iotkit_class_init,
> +            .class_data = (void *)&armsse_variants[i],
> +        };
> +        type_register(&ti);
> +    }
>  }
>  
> -type_init(iotkit_register_types);
> +type_init(armsse_register_types);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
