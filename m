Received: from eggs.gnu.org ([2001:4830:134:3::10]:46134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Lb-00039y-7o
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87LX-0004SY-Vo
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:19:03 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:47570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87LX-0004S3-Qv
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:18:59 -0400
Received: by mail-qk0-x244.google.com with SMTP id m189so8965441qke.4
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:18:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-12-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ce56b1d1-72a8-5e7f-027e-6ddd02238072@amsat.org>
Date: Fri, 27 Oct 2017 13:18:51 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-12-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 11/13] sparc32_dma: introduce new
 SPARC32_DMA type container object
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
> Create a new SPARC32_DMA container object (including an appropriate container
> memory region) and add instances of the SPARC32_ESPDMA_DEVICE and
> SPARC32_LEDMA_DEVICE as child objects. The benefit is that most of the gpio
> wiring complexity between esp/espdma and lance/ledma is now hidden within the
> SPARC32_DMA realize function.
> 
> Since the sun4m IOMMU is already QOMified we can find a reference to
> it using object_resolve_path_type() allowing us to completely remove all external
> references to the iommu pointer.
> 
> Finally we rework sun4m's sparc32_dma_init() to invoke the new SPARC32_DMA object
> and wire up the remaining board memory regions/IRQs.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/dma/sparc32_dma.c           |   70 ++++++++++++++++++++++++++++++++++++++++
>  hw/sparc/sun4m.c               |   66 ++++++++++++++++++-------------------
>  include/hw/sparc/sparc32_dma.h |   12 +++++++
>  3 files changed, 114 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index d4cff74..582b7cc 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -30,6 +30,7 @@
>  #include "hw/sparc/sparc32_dma.h"
>  #include "hw/sparc/sun4m.h"
>  #include "hw/sysbus.h"
> +#include "qapi/error.h"
>  #include "trace.h"
>  
>  /*
> @@ -369,11 +370,80 @@ static const TypeInfo sparc32_ledma_device_info = {
>      .class_init    = sparc32_ledma_device_class_init,
>  };
>  
> +static void sparc32_dma_realize(DeviceState *dev, Error **errp)
> +{
> +    SPARC32DMAState *s = SPARC32_DMA(dev);
> +    DeviceState *espdma, *esp, *ledma, *lance;
> +    SysBusDevice *sbd;
> +    Object *iommu;
> +
> +    iommu = object_resolve_path_type("", TYPE_SUN4M_IOMMU, NULL);
> +    if (!iommu) {
> +        error_setg(errp, "unable to locate sun4m IOMMU device");
> +        return;
> +    }
> +
> +    espdma = qdev_create(NULL, TYPE_SPARC32_ESPDMA_DEVICE);
> +    object_property_set_link(OBJECT(espdma), iommu, "iommu", errp);
> +    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma), errp);
> +    qdev_init_nofail(espdma);
> +
> +    esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));

TYPE_ESP?

> +    sbd = SYS_BUS_DEVICE(esp);
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(espdma, 0));
> +    qdev_connect_gpio_out(espdma, 0, qdev_get_gpio_in(esp, 0));
> +    qdev_connect_gpio_out(espdma, 1, qdev_get_gpio_in(esp, 1));
> +
> +    sbd = SYS_BUS_DEVICE(espdma);
> +    memory_region_add_subregion(&s->dmamem, 0x0,
> +                                sysbus_mmio_get_region(sbd, 0));
> +
> +    ledma = qdev_create(NULL, TYPE_SPARC32_LEDMA_DEVICE);
> +    object_property_set_link(OBJECT(ledma), iommu, "iommu", errp);
> +    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma), errp);
> +    qdev_init_nofail(ledma);
> +
> +    lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));

TYPE_LANCE?

> +    sbd = SYS_BUS_DEVICE(lance);
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(ledma, 0));
> +    qdev_connect_gpio_out(ledma, 0, qdev_get_gpio_in(lance, 0));
> +
> +    sbd = SYS_BUS_DEVICE(ledma);
> +    memory_region_add_subregion(&s->dmamem, 0x10,
> +                                sysbus_mmio_get_region(sbd, 0));
> +}
> +
> +static void sparc32_dma_init(Object *obj)
> +{
> +    SPARC32DMAState *s = SPARC32_DMA(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init(&s->dmamem, OBJECT(s), "dma", DMA_SIZE + DMA_ETH_SIZE);
> +    sysbus_init_mmio(sbd, &s->dmamem);
> +}
> +
> +static void sparc32_dma_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = sparc32_dma_realize;
> +}
> +
> +static const TypeInfo sparc32_dma_info = {
> +    .name          = TYPE_SPARC32_DMA,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SPARC32DMAState),
> +    .instance_init = sparc32_dma_init,
> +    .class_init    = sparc32_dma_class_init,
> +};
> +
> +
>  static void sparc32_dma_register_types(void)
>  {
>      type_register_static(&sparc32_dma_device_info);
>      type_register_static(&sparc32_espdma_device_info);
>      type_register_static(&sparc32_ledma_device_info);
> +    type_register_static(&sparc32_dma_info);
>  }
>  
>  type_init(sparc32_dma_register_types)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ae486a4..5017ae5 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -307,18 +307,36 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>      return s;
>  }
>  
> -static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
> +static void *sparc32_dma_init(hwaddr dma_base,
> +                              hwaddr esp_base, qemu_irq espdma_irq,
> +                              hwaddr le_base, qemu_irq ledma_irq)
>  {
> -    DeviceState *dev;
> -    SysBusDevice *s;
> +    DeviceState *dma;
> +    ESPDMADeviceState *espdma;
> +    LEDMADeviceState *ledma;
> +    SysBusESPState *esp;
> +    SysBusPCNetState *lance;
>  
> -    dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");

TYPE_SPARC32_LEDMA_DEVICE, TYPE_SPARC32_ESPDMA_DEVICE

> -    object_property_set_link(OBJECT(dev), OBJECT(iommu), "iommu", &error_abort);
> -    qdev_init_nofail(dev);
> -    s = SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(s, 0, daddr);
> +    dma = qdev_create(NULL, TYPE_SPARC32_DMA);
> +    qdev_init_nofail(dma);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
>  
> -    return s;
> +    espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
> +                                   OBJECT(dma), "espdma"));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
> +
> +    esp = ESP_STATE(object_resolve_path_component(OBJECT(espdma), "esp"));

TYPE_ESP?

> +    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> +
> +    ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
> +                                 OBJECT(dma), "ledma"));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
> +
> +    lance = SYSBUS_PCNET(object_resolve_path_component(
> +                         OBJECT(ledma), "lance"));

TYPE_LANCE?

> +    sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
> +
> +    return dma;
>  }
>  
>  static DeviceState *slavio_intctl_init(hwaddr addr,
> @@ -798,9 +816,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      DeviceState *slavio_intctl;
>      const char *cpu_model = machine->cpu_model;
>      unsigned int i;
> -    void *iommu, *nvram;
> -    DeviceState *espdma, *esp, *ledma, *lance;
> -    SysBusDevice *sbd;
> +    void *nvram;
>      qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>      qemu_irq fdc_tc;
>      unsigned long kernel_size;
> @@ -848,8 +864,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          afx_init(hwdef->afx_base);
>      }
>  
> -    iommu = iommu_init(hwdef->iommu_base, hwdef->iommu_version,
> -                       slavio_irq[30]);
> +    iommu_init(hwdef->iommu_base, hwdef->iommu_version, slavio_irq[30]);
>  
>      if (hwdef->iommu_pad_base) {
>          /* On the real hardware (SS-5, LX) the MMU is not padded, but aliased.
> @@ -859,26 +874,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
>      }
>  
> -    espdma = sparc32_dma_init(hwdef->dma_base, iommu, 0);
> -    sbd = SYS_BUS_DEVICE(espdma);
> -    sysbus_connect_irq(sbd, 0, slavio_irq[18]);
> -
> -    esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
> -    sbd = SYS_BUS_DEVICE(esp);
> -    sysbus_mmio_map(sbd, 0, hwdef->esp_base);
> -    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(espdma, 0));
> -    qdev_connect_gpio_out(espdma, 0, qdev_get_gpio_in(esp, 0));
> -    qdev_connect_gpio_out(espdma, 1, qdev_get_gpio_in(esp, 1));
> -
> -    ledma = sparc32_dma_init(hwdef->dma_base + 16ULL, iommu, 1);
> -    sbd = SYS_BUS_DEVICE(ledma);
> -    sysbus_connect_irq(sbd, 0, slavio_irq[16]);
> -
> -    lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
> -    sbd = SYS_BUS_DEVICE(lance);
> -    sysbus_mmio_map(sbd, 0, hwdef->le_base);
> -    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(ledma, 0));
> -    qdev_connect_gpio_out(ledma, 0, qdev_get_gpio_in(lance, 0));
> +    sparc32_dma_init(hwdef->dma_base,
> +                     hwdef->esp_base, slavio_irq[18],
> +                     hwdef->le_base, slavio_irq[16]);
>  
>      if (graphic_depth != 8 && graphic_depth != 24) {
>          error_report("Unsupported depth: %d", graphic_depth);

OK until here.

> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index 5e39d81..5deeca6 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -44,6 +44,18 @@ typedef struct LEDMADeviceState {
>      SysBusPCNetState *lance;
>  } LEDMADeviceState;
>  
> +#define TYPE_SPARC32_DMA "sparc32-dma"
> +#define SPARC32_DMA(obj) OBJECT_CHECK(SPARC32DMAState, (obj), \
> +                                      TYPE_SPARC32_DMA)
> +
> +typedef struct SPARC32DMAState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion dmamem;
> +    ESPDMADeviceState *espdma;
> +    LEDMADeviceState *ledma;
> +} SPARC32DMAState;

This part is "include/hw/sparc/sun4m.h"

> +
>  /* sparc32_dma.c */
>  void ledma_memory_read(void *opaque, hwaddr addr,
>                         uint8_t *buf, int len, int do_bswap);
> 
