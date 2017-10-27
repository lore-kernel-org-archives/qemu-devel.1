Received: from eggs.gnu.org ([2001:4830:134:3::10]:57587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86kc-00010D-JV
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86kZ-0007yc-Eg
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:40:50 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:48798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86kZ-0007yP-9M
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:40:47 -0400
Received: by mail-qk0-x243.google.com with SMTP id d67so8832892qkg.5
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:40:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c59fbb5-69a9-1c3b-1e94-8b99ef054da6@amsat.org>
Date: Fri, 27 Oct 2017 12:40:43 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 02/13] sparc32_dma: split esp and le into
 separate DMA devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> Due to slight differences in behaviour accessing the registers for the
> esp and le devices, create two separate SPARC32_DMA_DEVICE types and
> update the sun4m machine to use.
> 
> Note that by using different device types we already know the size of
> the register block and the value of is_ledma at init time, allowing us to
> drop the SPARC32_DMA_DEVICE realize function and the is_ledma device
> property.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c |   63 ++++++++++++++++++++++++++++++++++++++++----------
>  hw/sparc/sun4m.c     |    3 +--
>  2 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index a8d31c1..e4ff4a8 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -78,6 +78,22 @@ struct DMADeviceState {
>      uint32_t is_ledma;
>  };
>  
> +#define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
> +#define SPARC32_ESPDMA_DEVICE(obj) OBJECT_CHECK(ESPDMADeviceState, (obj), \
> +                                                TYPE_SPARC32_ESPDMA_DEVICE)
> +
> +typedef struct ESPDMADeviceState {
> +    DMADeviceState parent_obj;
> +} ESPDMADeviceState;
> +
> +#define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
> +#define SPARC32_LEDMA_DEVICE(obj) OBJECT_CHECK(LEDMADeviceState, (obj), \
> +                                               TYPE_SPARC32_LEDMA_DEVICE)
> +
> +typedef struct LEDMADeviceState {
> +    DMADeviceState parent_obj;
> +} LEDMADeviceState;
> +
>  enum {
>      GPIO_RESET = 0,
>      GPIO_DMA,
> @@ -285,19 +301,8 @@ static void sparc32_dma_device_init(Object *obj)
>      qdev_init_gpio_out(dev, s->gpio, 2);
>  }
>  
> -static void sparc32_dma_device_realize(DeviceState *dev, Error **errp)
> -{
> -    DMADeviceState *s = SPARC32_DMA_DEVICE(dev);
> -    int reg_size;
> -
> -    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
> -    memory_region_init_io(&s->iomem, OBJECT(dev), &dma_mem_ops, s,
> -                          "dma", reg_size);
> -}
> -
>  static Property sparc32_dma_device_properties[] = {
>      DEFINE_PROP_PTR("iommu_opaque", DMADeviceState, iommu),
> -    DEFINE_PROP_UINT32("is_ledma", DMADeviceState, is_ledma, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -308,7 +313,6 @@ static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>      dc->reset = sparc32_dma_device_reset;
>      dc->vmsd = &vmstate_sparc32_dma_device;
>      dc->props = sparc32_dma_device_properties;
> -    dc->realize = sparc32_dma_device_realize;
>      /* Reason: pointer property "iommu_opaque" */
>      dc->user_creatable = false;
>  }
> @@ -316,14 +320,49 @@ static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo sparc32_dma_device_info = {
>      .name          = TYPE_SPARC32_DMA_DEVICE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
> +    .abstract      = true,
>      .instance_size = sizeof(DMADeviceState),
>      .instance_init = sparc32_dma_device_init,
>      .class_init    = sparc32_dma_device_class_init,
>  };
>  
> +static void sparc32_espdma_device_init(Object *obj)
> +{
> +    DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
> +                          "espdma-mmio", DMA_SIZE);
> +    s->is_ledma = 0;
> +}
> +
> +static const TypeInfo sparc32_espdma_device_info = {
> +    .name          = TYPE_SPARC32_ESPDMA_DEVICE,
> +    .parent        = TYPE_SPARC32_DMA_DEVICE,
> +    .instance_size = sizeof(ESPDMADeviceState),
> +    .instance_init = sparc32_espdma_device_init,
> +};
> +
> +static void sparc32_ledma_device_init(Object *obj)
> +{
> +    DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
> +                          "ledma-mmio", DMA_ETH_SIZE);
> +    s->is_ledma = 1;
> +}
> +
> +static const TypeInfo sparc32_ledma_device_info = {
> +    .name          = TYPE_SPARC32_LEDMA_DEVICE,
> +    .parent        = TYPE_SPARC32_DMA_DEVICE,
> +    .instance_size = sizeof(LEDMADeviceState),
> +    .instance_init = sparc32_ledma_device_init,
> +};
> +
>  static void sparc32_dma_register_types(void)
>  {
>      type_register_static(&sparc32_dma_device_info);
> +    type_register_static(&sparc32_espdma_device_info);
> +    type_register_static(&sparc32_ledma_device_info);
>  }
>  
>  type_init(sparc32_dma_register_types)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 82c553c..88a9752 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -313,9 +313,8 @@ static void *sparc32_dma_init(hwaddr daddr, qemu_irq parent_irq,
>      DeviceState *dev;
>      SysBusDevice *s;
>  
> -    dev = qdev_create(NULL, "sparc32-dma-device");
> +    dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
>      qdev_prop_set_ptr(dev, "iommu_opaque", iommu);
> -    qdev_prop_set_uint32(dev, "is_ledma", is_ledma);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
>      sysbus_connect_irq(s, 0, parent_irq);
> 
