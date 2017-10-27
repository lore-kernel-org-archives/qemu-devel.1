Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87El-0008R4-BY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Eh-0002NH-3K
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:11:59 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Eg-0002M7-RV
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:11:54 -0400
Received: by mail-qt0-x242.google.com with SMTP id j58so9057141qtj.0
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:11:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-11-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0a61c56-8510-ad13-7b97-70da40bbd381@amsat.org>
Date: Fri, 27 Oct 2017 13:11:46 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-11-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 10/13] sparc32_dma: make lance device
 child of ledma device
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
> This makes it possible to reference the lance device from the ledma device as
> required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/dma/sparc32_dma.c           |   22 ++++++++++++++++++++++
>  hw/sparc/sun4m.c               |   31 +++++++------------------------
>  include/hw/sparc/sparc32_dma.h |    3 +++
>  3 files changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 6009b94..d4cff74 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -340,11 +340,33 @@ static void sparc32_ledma_device_init(Object *obj)
>      s->is_ledma = 1;
>  }
>  
> +static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
> +{
> +    DeviceState *d;
> +    NICInfo *nd = &nd_table[0];
> +
> +    qemu_check_nic_model(nd, TYPE_LANCE);

It works but it is not the same idea (Type != Model) so I'd rather use
"lance" here.

> +
> +    d = qdev_create(NULL, TYPE_LANCE);
> +    object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);

And use TYPE_LANCE here :)

> +    qdev_set_nic_properties(d, nd);
> +    qdev_prop_set_ptr(d, "dma", dev);
> +    qdev_init_nofail(d);
> +}
> +
> +static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = sparc32_ledma_device_realize;
> +}
> +
>  static const TypeInfo sparc32_ledma_device_info = {
>      .name          = TYPE_SPARC32_LEDMA_DEVICE,
>      .parent        = TYPE_SPARC32_DMA_DEVICE,
>      .instance_size = sizeof(LEDMADeviceState),
>      .instance_init = sparc32_ledma_device_init,
> +    .class_init    = sparc32_ledma_device_class_init,
>  };
>  
>  static void sparc32_dma_register_types(void)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 4626c85..ae486a4 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -321,26 +321,6 @@ static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
>      return s;
>  }
>  
> -static void lance_init(NICInfo *nd, hwaddr leaddr,
> -                       void *dma_opaque, qemu_irq irq)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    qemu_irq reset;
> -
> -    qemu_check_nic_model(&nd_table[0], "lance");
> -
> -    dev = qdev_create(NULL, "lance");
> -    qdev_set_nic_properties(dev, nd);
> -    qdev_prop_set_ptr(dev, "dma", dma_opaque);
> -    qdev_init_nofail(dev);
> -    s = SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(s, 0, leaddr);
> -    sysbus_connect_irq(s, 0, irq);
> -    reset = qdev_get_gpio_in(dev, 0);
> -    qdev_connect_gpio_out(dma_opaque, 0, reset);
> -}
> -
>  static DeviceState *slavio_intctl_init(hwaddr addr,
>                                         hwaddr addrg,
>                                         qemu_irq **parent_irq)
> @@ -819,7 +799,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      const char *cpu_model = machine->cpu_model;
>      unsigned int i;
>      void *iommu, *nvram;
> -    DeviceState *espdma, *esp, *ledma;
> +    DeviceState *espdma, *esp, *ledma, *lance;
>      SysBusDevice *sbd;
>      qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>      qemu_irq fdc_tc;
> @@ -894,6 +874,12 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      sbd = SYS_BUS_DEVICE(ledma);
>      sysbus_connect_irq(sbd, 0, slavio_irq[16]);
>  
> +    lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));

TYPE_LANCE here (or not)

> +    sbd = SYS_BUS_DEVICE(lance);
> +    sysbus_mmio_map(sbd, 0, hwdef->le_base);
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(ledma, 0));
> +    qdev_connect_gpio_out(ledma, 0, qdev_get_gpio_in(lance, 0));
> +
>      if (graphic_depth != 8 && graphic_depth != 24) {
>          error_report("Unsupported depth: %d", graphic_depth);
>          exit (1);
> @@ -945,9 +931,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          empty_slot_init(hwdef->sx_base, 0x2000);
>      }
>  
> -    lance_init(&nd_table[0], hwdef->le_base, ledma,
> -               qdev_get_gpio_in(ledma, 0));
> -
>      nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
>  
>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);

OK until here.

> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index 365160f..5e39d81 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -3,6 +3,7 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/scsi/esp.h"
> +#include "hw/net/lance.h"

Same comment as patch 9, use "hw/sparc/sun4m_dma.h"?
>  
>  #define DMA_REGS 4
>  
> @@ -39,6 +40,8 @@ typedef struct ESPDMADeviceState {
>  
>  typedef struct LEDMADeviceState {
>      DMADeviceState parent_obj;
> +
> +    SysBusPCNetState *lance;
>  } LEDMADeviceState;
>  
>  /* sparc32_dma.c */
> 
