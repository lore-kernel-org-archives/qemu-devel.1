Received: from eggs.gnu.org ([2001:4830:134:3::10]:37205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52hx-0005OM-17
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52ht-00042i-S0
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:45:25 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:52235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52ht-00042U-KB
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:45:21 -0400
Received: by mail-qk0-x243.google.com with SMTP id b15so8948235qkg.9
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 21:45:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-14-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb1d41bb-2685-696c-130a-43f65373b694@amsat.org>
Date: Thu, 19 Oct 2017 01:45:18 -0300
MIME-Version: 1.0
In-Reply-To: <1508006342-5304-14-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 13/13] sparc32_dma: add len to esp/le DMA
 memory tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/14/2017 03:39 PM, Mark Cave-Ayland wrote:
> This is surprisingly useful when trying to debug DMA issues.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c |    8 ++++----
>  hw/dma/trace-events  |    8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index bb7d70a..fbb072a 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -73,7 +73,7 @@ void ledma_memory_read(void *opaque, hwaddr addr,
>      int i;
>  
>      addr |= s->dmaregs[3];
> -    trace_ledma_memory_read(addr);
> +    trace_ledma_memory_read(addr, len);
>      if (do_bswap) {
>          sparc_iommu_memory_read(s->iommu, addr, buf, len);
>      } else {
> @@ -94,7 +94,7 @@ void ledma_memory_write(void *opaque, hwaddr addr,
>      uint16_t tmp_buf[32];
>  
>      addr |= s->dmaregs[3];
> -    trace_ledma_memory_write(addr);
> +    trace_ledma_memory_write(addr, len);
>      if (do_bswap) {
>          sparc_iommu_memory_write(s->iommu, addr, buf, len);
>      } else {
> @@ -139,7 +139,7 @@ void espdma_memory_read(void *opaque, uint8_t *buf, int len)
>  {
>      DMADeviceState *s = opaque;
>  
> -    trace_espdma_memory_read(s->dmaregs[1]);
> +    trace_espdma_memory_read(s->dmaregs[1], len);
>      sparc_iommu_memory_read(s->iommu, s->dmaregs[1], buf, len);
>      s->dmaregs[1] += len;
>  }
> @@ -148,7 +148,7 @@ void espdma_memory_write(void *opaque, uint8_t *buf, int len)
>  {
>      DMADeviceState *s = opaque;
>  
> -    trace_espdma_memory_write(s->dmaregs[1]);
> +    trace_espdma_memory_write(s->dmaregs[1], len);
>      sparc_iommu_memory_write(s->iommu, s->dmaregs[1], buf, len);
>      s->dmaregs[1] += len;
>  }
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 428469a..6b367f0 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -7,12 +7,12 @@ rc4030_read(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
>  rc4030_write(uint64_t addr, uint32_t val) "write reg[0x%"PRIx64"] = 0x%x"
>  
>  # hw/dma/sparc32_dma.c
> -ledma_memory_read(uint64_t addr) "DMA read addr 0x%"PRIx64
> -ledma_memory_write(uint64_t addr) "DMA write addr 0x%"PRIx64
> +ledma_memory_read(uint64_t addr, int len) "DMA read addr 0x%"PRIx64 " len %d"
> +ledma_memory_write(uint64_t addr, int len) "DMA write addr 0x%"PRIx64 " len %d"
>  sparc32_dma_set_irq_raise(void) "Raise IRQ"
>  sparc32_dma_set_irq_lower(void) "Lower IRQ"
> -espdma_memory_read(uint32_t addr) "DMA read addr 0x%08x"
> -espdma_memory_write(uint32_t addr) "DMA write addr 0x%08x"
> +espdma_memory_read(uint32_t addr, int len) "DMA read addr 0x%08x len %d"
> +espdma_memory_write(uint32_t addr, int len) "DMA write addr 0x%08x len %d"
>  sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg 0x%"PRIx64": 0x%08x"
>  sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg 0x%"PRIx64": 0x%08x -> 0x%08x"
>  sparc32_dma_enable_raise(void) "Raise DMA enable"
> 
