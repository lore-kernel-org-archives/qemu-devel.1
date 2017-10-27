Received: from eggs.gnu.org ([2001:4830:134:3::10]:39126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Bk-0006xn-FW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Bg-0005x1-Dq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:08:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:50215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Bg-0005vz-0l
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:08:48 -0400
Received: by mail-qk0-x241.google.com with SMTP id o187so8945337qke.7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:08:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-9-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <72e929a8-3023-8a3f-ccee-c09d7ee6efdb@amsat.org>
Date: Fri, 27 Oct 2017 13:08:39 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-9-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 08/13] sparc32_dma: make esp device child
 of espdma device
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
> This makes it possible to reference the esp device from the espdma device as
> required, and by wiring up the device ourselves in sun4m.c we can drop use
> of the esp_init() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/dma/sparc32_dma.c           |   26 ++++++++++++++++++++++++++
>  hw/sparc/sun4m.c               |   19 ++++++++-----------
>  include/hw/sparc/sparc32_dma.h |    3 +++
>  3 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index c56a2ba..6009b94 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -298,11 +298,37 @@ static void sparc32_espdma_device_init(Object *obj)
>      s->is_ledma = 0;
>  }
>  
> +static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
> +{
> +    DeviceState *d;
> +    SysBusESPState *sysbus;
> +    ESPState *esp;
> +
> +    d = qdev_create(NULL, TYPE_ESP);
> +    object_property_add_child(OBJECT(dev), "esp", OBJECT(d), errp);

TYPE_ESP ?

> +    sysbus = ESP_STATE(d);
> +    esp = &sysbus->esp;
> +    esp->dma_memory_read = espdma_memory_read;
> +    esp->dma_memory_write = espdma_memory_write;
> +    esp->dma_opaque = SPARC32_DMA_DEVICE(dev);
> +    sysbus->it_shift = 2;
> +    esp->dma_enabled = 1;
> +    qdev_init_nofail(d);
> +}
> +
> +static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = sparc32_espdma_device_realize;
> +}
> +
>  static const TypeInfo sparc32_espdma_device_info = {
>      .name          = TYPE_SPARC32_ESPDMA_DEVICE,
>      .parent        = TYPE_SPARC32_DMA_DEVICE,
>      .instance_size = sizeof(ESPDMADeviceState),
>      .instance_init = sparc32_espdma_device_init,
> +    .class_init    = sparc32_espdma_device_class_init,
>  };
>  
>  static void sparc32_ledma_device_init(Object *obj)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 12d36b5..4626c85 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -819,10 +819,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      const char *cpu_model = machine->cpu_model;
>      unsigned int i;
>      void *iommu, *nvram;
> -    DeviceState *espdma, *ledma;
> +    DeviceState *espdma, *esp, *ledma;
>      SysBusDevice *sbd;
>      qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
> -    qemu_irq esp_reset, dma_enable;
>      qemu_irq fdc_tc;
>      unsigned long kernel_size;
>      DriveInfo *fd[MAX_FD];
> @@ -884,6 +883,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      sbd = SYS_BUS_DEVICE(espdma);
>      sysbus_connect_irq(sbd, 0, slavio_irq[18]);
>  
> +    esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
> +    sbd = SYS_BUS_DEVICE(esp);
> +    sysbus_mmio_map(sbd, 0, hwdef->esp_base);
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(espdma, 0));
> +    qdev_connect_gpio_out(espdma, 0, qdev_get_gpio_in(esp, 0));
> +    qdev_connect_gpio_out(espdma, 1, qdev_get_gpio_in(esp, 1));
> +
>      ledma = sparc32_dma_init(hwdef->dma_base + 16ULL, iommu, 1);
>      sbd = SYS_BUS_DEVICE(ledma);
>      sysbus_connect_irq(sbd, 0, slavio_irq[16]);
> @@ -970,15 +976,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      slavio_misc_init(hwdef->slavio_base, hwdef->aux1_base, hwdef->aux2_base,
>                       slavio_irq[30], fdc_tc);
>  
> -    esp_init(hwdef->esp_base, 2,
> -             espdma_memory_read, espdma_memory_write,
> -             espdma,
> -             qdev_get_gpio_in(espdma, 0),
> -             &esp_reset, &dma_enable);
> -
> -    qdev_connect_gpio_out(espdma, 0, esp_reset);
> -    qdev_connect_gpio_out(espdma, 1, dma_enable);
> -
>      if (hwdef->cs_base) {
>          sysbus_create_simple("SUNW,CS4231", hwdef->cs_base,
>                               slavio_irq[5]);
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index df7491d..365160f 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -2,6 +2,7 @@
>  #define SPARC32_DMA_H
>  
>  #include "hw/sysbus.h"
> +#include "hw/scsi/esp.h"

I'd keep this in "hw/sparc/sun4m_dma.h"

>  
>  #define DMA_REGS 4
>  
> @@ -28,6 +29,8 @@ struct DMADeviceState {
>  
>  typedef struct ESPDMADeviceState {
>      DMADeviceState parent_obj;
> +
> +    SysBusESPState *esp;
>  } ESPDMADeviceState;
>  
>  #define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
> 
