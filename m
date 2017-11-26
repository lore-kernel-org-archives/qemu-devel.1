Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzX1-00053J-OD
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWy-0005Xw-FI
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:47 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWy-0005Xq-Ao
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:44 -0500
Received: by mail-qt0-x243.google.com with SMTP id 33so27491921qtv.1
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 08:11:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1511703326-25325-8-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46f64169-4025-6543-d8f4-84458c976d47@amsat.org>
Date: Sun, 26 Nov 2017 12:17:40 -0300
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-8-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/8] sun4u_iommu: convert from
 IOMMU_DPRINTF to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/26/2017 10:35 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u_iommu.c |   17 +++--------------
>  hw/sparc64/trace-events  |    4 ++++
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
> index 612fec4..51fbc39 100644
> --- a/hw/sparc64/sun4u_iommu.c
> +++ b/hw/sparc64/sun4u_iommu.c
> @@ -30,16 +30,7 @@
>  #include "exec/address-spaces.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> -
> -/* debug IOMMU */
> -//#define DEBUG_IOMMU
> -
> -#ifdef DEBUG_IOMMU
> -#define IOMMU_DPRINTF(fmt, ...) \
> -do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define IOMMU_DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
>  
>  
>  #define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
> @@ -201,8 +192,7 @@ static void iommu_mem_write(void *opaque, hwaddr addr,
>  {
>      IOMMUState *is = opaque;
>  
> -    IOMMU_DPRINTF("IOMMU config write: 0x%" HWADDR_PRIx " val: %" PRIx64
> -                  " size: %d\n", addr, val, size);
> +    trace_sun4u_iommu_mem_write(addr, val, size);
>  
>      switch (addr) {
>      case IOMMU_CTRL:
> @@ -280,8 +270,7 @@ static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
>          break;
>      }
>  
> -    IOMMU_DPRINTF("IOMMU config read: 0x%" HWADDR_PRIx " val: %" PRIx64
> -                  " size: %d\n", addr, val, size);
> +    trace_sun4u_iommu_mem_read(addr, val, size);
>  
>      return val;
>  }
> diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
> index 04d80b7..052352f 100644
> --- a/hw/sparc64/trace-events
> +++ b/hw/sparc64/trace-events
> @@ -2,3 +2,7 @@
>  
>  # hw/sparc64/sun4u.c
>  ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
> +
> +# hw/sparc64/sun4u_iommu.c
> +sun4u_iommu_mem_read(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
> +sun4u_iommu_mem_write(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
> 
