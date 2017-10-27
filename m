Received: from eggs.gnu.org ([2001:4830:134:3::10]:59527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86q7-0002cH-5b
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86q4-0006hC-2b
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:46:31 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86q3-0006gl-U3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:46:28 -0400
Received: by mail-qk0-x244.google.com with SMTP id w134so8865905qkb.0
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:46:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-5-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a8ecf480-ef93-4549-e3c6-5e4b0d831c7b@amsat.org>
Date: Fri, 27 Oct 2017 12:46:19 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-5-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 04/13] sun4m: move DMA device wiring from
 sparc32_dma_init() to sun4m_hw_init()
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
> By using the sysbus interface it is possible to wire up the esp/le devices
> to the sun4m DMA controller directly during sun4m_hw_init() instead of
> passing qemu_irqs into the sparc32_dma_init() function.
> 
> This is an intermediate step to allow further reorganisation as more logic
> is moved into the relevant SPARC32 DMA devices; there will be a final
> refactoring of sparc32_dma_init() once this work is complete.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc/sun4m.c |   29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 88a9752..4f2ed4b 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -307,8 +307,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>      return s;
>  }
>  
> -static void *sparc32_dma_init(hwaddr daddr, qemu_irq parent_irq,
> -                              void *iommu, qemu_irq *dev_irq, int is_ledma)
> +static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -317,8 +316,6 @@ static void *sparc32_dma_init(hwaddr daddr, qemu_irq parent_irq,
>      qdev_prop_set_ptr(dev, "iommu_opaque", iommu);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
> -    sysbus_connect_irq(s, 0, parent_irq);
> -    *dev_irq = qdev_get_gpio_in(dev, 0);
>      sysbus_mmio_map(s, 0, daddr);
>  
>      return s;
> @@ -821,9 +818,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      DeviceState *slavio_intctl;
>      const char *cpu_model = machine->cpu_model;
>      unsigned int i;
> -    void *iommu, *espdma, *ledma, *nvram;
> -    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS],
> -        espdma_irq, ledma_irq;
> +    void *iommu, *nvram;
> +    DeviceState *espdma, *ledma;
> +    SysBusDevice *sbd;
> +    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>      qemu_irq esp_reset, dma_enable;
>      qemu_irq fdc_tc;
>      unsigned long kernel_size;
> @@ -882,11 +880,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
>      }
>  
> -    espdma = sparc32_dma_init(hwdef->dma_base, slavio_irq[18],
> -                              iommu, &espdma_irq, 0);
> +    espdma = sparc32_dma_init(hwdef->dma_base, iommu, 0);
> +    sbd = SYS_BUS_DEVICE(espdma);
> +    sysbus_connect_irq(sbd, 0, slavio_irq[18]);
>  
> -    ledma = sparc32_dma_init(hwdef->dma_base + 16ULL,
> -                             slavio_irq[16], iommu, &ledma_irq, 1);
> +    ledma = sparc32_dma_init(hwdef->dma_base + 16ULL, iommu, 1);
> +    sbd = SYS_BUS_DEVICE(ledma);
> +    sysbus_connect_irq(sbd, 0, slavio_irq[16]);
>  
>      if (graphic_depth != 8 && graphic_depth != 24) {
>          error_report("Unsupported depth: %d", graphic_depth);
> @@ -939,7 +939,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          empty_slot_init(hwdef->sx_base, 0x2000);
>      }
>  
> -    lance_init(&nd_table[0], hwdef->le_base, ledma, ledma_irq);
> +    lance_init(&nd_table[0], hwdef->le_base, ledma,
> +               qdev_get_gpio_in(ledma, 0));
>  
>      nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
>  
> @@ -971,7 +972,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>  
>      esp_init(hwdef->esp_base, 2,
>               espdma_memory_read, espdma_memory_write,
> -             espdma, espdma_irq, &esp_reset, &dma_enable);
> +             espdma,
> +             qdev_get_gpio_in(espdma, 0),
> +             &esp_reset, &dma_enable);
>  
>      qdev_connect_gpio_out(espdma, 0, esp_reset);
>      qdev_connect_gpio_out(espdma, 1, dma_enable);
> 
