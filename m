Received: from eggs.gnu.org ([2001:4830:134:3::10]:37841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e877Y-0004QF-HJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e877U-0008OC-JG
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:04:32 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e877U-0008NL-D7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:04:28 -0400
Received: by mail-qt0-x243.google.com with SMTP id 8so9024515qtv.1
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:04:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2a3f31d3-7e03-105b-97fc-439fea6fca3a@amsat.org>
Date: Fri, 27 Oct 2017 13:04:19 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 03/13] sparc32_dma: move type
 declarations from sparc32_dma.c to sparc32_dma.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org

Hi Mark,

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/dma/sparc32_dma.c           |   34 ----------------------------------
>  include/hw/sparc/sparc32_dma.h |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index e4ff4a8..ae8fa06 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -40,7 +40,6 @@
>   * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/DMA2.txt
>   */
>  
> -#define DMA_REGS 4
>  #define DMA_SIZE (4 * sizeof(uint32_t))

Since you move this out, can you replace with:

   #define DMA_SIZE (DMA_REGS * sizeof(uint32_t))

>  /* We need the mask, because one instance of the device is not page
>     aligned (ledma, start address 0x0010) */
> @@ -61,39 +60,6 @@
>  /* XXX SCSI and ethernet should have different read-only bit masks */
>  #define DMA_CSR_RO_MASK 0xfe000007
>  
> -#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
> -#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
> -                                             TYPE_SPARC32_DMA_DEVICE)
> -
> -typedef struct DMADeviceState DMADeviceState;
> -
> -struct DMADeviceState {
> -    SysBusDevice parent_obj;
> -
> -    MemoryRegion iomem;
> -    uint32_t dmaregs[DMA_REGS];
> -    qemu_irq irq;
> -    void *iommu;
> -    qemu_irq gpio[2];

OK to move until here to sparc32_dma.h

However I don't like having now network/scsi fields mixed in
sparc32_dma.h which is supposed to be device agnostic IMHO.

So I'd rather keep this part here

(from here ...

> -    uint32_t is_ledma;
> -};
> -
> -#define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
> -#define SPARC32_ESPDMA_DEVICE(obj) OBJECT_CHECK(ESPDMADeviceState, (obj), \
> -                                                TYPE_SPARC32_ESPDMA_DEVICE)
> -
> -typedef struct ESPDMADeviceState {
> -    DMADeviceState parent_obj;
> -} ESPDMADeviceState;
> -
> -#define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
> -#define SPARC32_LEDMA_DEVICE(obj) OBJECT_CHECK(LEDMADeviceState, (obj), \
> -                                               TYPE_SPARC32_LEDMA_DEVICE)
> -
> -typedef struct LEDMADeviceState {
> -    DMADeviceState parent_obj;
> -} LEDMADeviceState;

... until here)

Or move it to hw/sparc/sun4m.c (or maybe clever in "hw/sparc/sun4m_dma.h").

> -
>  enum {
>      GPIO_RESET = 0,
>      GPIO_DMA,
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index 9497b13..df7491d 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -1,6 +1,43 @@
>  #ifndef SPARC32_DMA_H
>  #define SPARC32_DMA_H
>  
> +#include "hw/sysbus.h"
> +
> +#define DMA_REGS 4
> +
> +#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
> +#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
> +                                             TYPE_SPARC32_DMA_DEVICE)
> +
> +typedef struct DMADeviceState DMADeviceState;
> +
> +struct DMADeviceState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    uint32_t dmaregs[DMA_REGS];
> +    qemu_irq irq;
> +    void *iommu;
> +    qemu_irq gpio[2];

};

[no ...

> +    uint32_t is_ledma;
> +};
> +
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

... no]

>  /* sparc32_dma.c */
>  void ledma_memory_read(void *opaque, hwaddr addr,
>                         uint8_t *buf, int len, int do_bswap);
> 

What do you think?

Regards,

Phil.
