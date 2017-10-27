Received: from eggs.gnu.org ([2001:4830:134:3::10]:46639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Ms-0003pu-Pf
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Mp-0005fj-HJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:20:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:56123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Mo-0005eq-Uc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:20:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id v41so9037526qtv.12
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:20:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-13-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <912395a0-8696-0bd7-5dc9-65daa83d640c@amsat.org>
Date: Fri, 27 Oct 2017 13:20:15 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-13-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 12/13] sparc32_dma: remove is_ledma hack
 and replace with memory region alias
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
> This hack originated from before the memory region API was introduced, and
> increased the size of the ledma DMA device to capture incorrect accesses
> beyond the end of the ledma device. A full analysis can be found on Artyom's
> blog at http://tyom.blogspot.co.uk/2010/10/bug-in-all-solaris-versions-after-57.html.
> 
> With the memory API we can now simply alias the incorrect access onto its
> intended destination allowing us to remove the hack.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/dma/sparc32_dma.c           |   20 ++++++--------------
>  include/hw/sparc/sparc32_dma.h |    2 +-
>  2 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 582b7cc..f64787e 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -160,12 +160,6 @@ static uint64_t dma_mem_read(void *opaque, hwaddr addr,
>      DMADeviceState *s = opaque;
>      uint32_t saddr;
>  
> -    if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
> -        /* aliased to espdma, but we can't get there from here */
> -        /* buggy driver if using undocumented behavior, just return 0 */
> -        trace_sparc32_dma_mem_readl(addr, 0);
> -        return 0;
> -    }
>      saddr = (addr & DMA_MASK) >> 2;
>      trace_sparc32_dma_mem_readl(addr, s->dmaregs[saddr]);
>      return s->dmaregs[saddr];
> @@ -177,11 +171,6 @@ static void dma_mem_write(void *opaque, hwaddr addr,
>      DMADeviceState *s = opaque;
>      uint32_t saddr;
>  
> -    if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
> -        /* aliased to espdma, but we can't get there from here */
> -        trace_sparc32_dma_mem_writel(addr, 0, val);
> -        return;
> -    }
>      saddr = (addr & DMA_MASK) >> 2;
>      trace_sparc32_dma_mem_writel(addr, s->dmaregs[saddr], val);
>      switch (saddr) {
> @@ -296,7 +285,6 @@ static void sparc32_espdma_device_init(Object *obj)
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
>                            "espdma-mmio", DMA_SIZE);
> -    s->is_ledma = 0;
>  }
>  
>  static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
> @@ -337,8 +325,7 @@ static void sparc32_ledma_device_init(Object *obj)
>      DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
> -                          "ledma-mmio", DMA_ETH_SIZE);
> -    s->is_ledma = 1;
> +                          "ledma-mmio", DMA_SIZE);
>  }
>  
>  static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
> @@ -411,6 +398,11 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>      sbd = SYS_BUS_DEVICE(ledma);
>      memory_region_add_subregion(&s->dmamem, 0x10,
>                                  sysbus_mmio_get_region(sbd, 0));
> +
> +    /* Add ledma alias to handle SunOS 5.7 - Solaris 9 invalid access bug */
> +    memory_region_init_alias(&s->ledma_alias, OBJECT(dev), "ledma-alias",
> +                             sysbus_mmio_get_region(sbd, 0), 0x4, 0x4);
> +    memory_region_add_subregion(&s->dmamem, 0x20, &s->ledma_alias);
>  }
>  
>  static void sparc32_dma_init(Object *obj)
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index 5deeca6..ab42c54 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -21,7 +21,6 @@ struct DMADeviceState {
>      qemu_irq irq;
>      void *iommu;
>      qemu_irq gpio[2];
> -    uint32_t is_ledma;
>  };
>  
>  #define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
> @@ -52,6 +51,7 @@ typedef struct SPARC32DMAState {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion dmamem;
> +    MemoryRegion ledma_alias;
>      ESPDMADeviceState *espdma;
>      LEDMADeviceState *ledma;
>  } SPARC32DMAState;
> 

The same using "include/hw/sparc/sun4m.h":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
