Received: from eggs.gnu.org ([2001:4830:134:3::10]:56381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eAVfG-0002ta-L9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eAVfF-0007ic-L7
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eAVfF-0007iA-Bu
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 761BE7E421
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 06:41:11 +0000 (UTC)
Date: Fri, 3 Nov 2017 14:41:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171103064104.GA4424@pxdev.xzpeter.org>
References: <20171102180310.24760-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171102180310.24760-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ioapic/tracing: Remove last DPRINTFs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com

On Thu, Nov 02, 2017 at 06:03:10PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Remove the last few DPRINTFs from hw/intc/ioapic.c and turn
> them into tracing.  In one case it's a new trace, in the others
> it's just adding a parameter to the existing traces.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  hw/intc/ioapic.c     | 17 +++--------------
>  hw/intc/trace-events |  5 +++--
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 37c4386ae3..36139a4db6 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -35,15 +35,6 @@
>  #include "hw/i386/x86-iommu.h"
>  #include "trace.h"
>  
> -//#define DEBUG_IOAPIC
> -
> -#ifdef DEBUG_IOAPIC
> -#define DPRINTF(fmt, ...)                                       \
> -    do { printf("ioapic: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif
> -
>  #define APIC_DELIVERY_MODE_SHIFT 8
>  #define APIC_POLARITY_SHIFT 14
>  #define APIC_TRIG_MODE_SHIFT 15
> @@ -157,7 +148,7 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
>       * to GSI 2.  GSI maps to ioapic 1-1.  This is not
>       * the cleanest way of doing it but it should work. */
>  
> -    DPRINTF("%s: %s vec %x\n", __func__, level ? "raise" : "lower", vector);
> +    trace_ioapic_set_irq(vector, level);
>      if (vector == 0) {
>          vector = 2;
>      }
> @@ -290,11 +281,10 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
>                  }
>              }
>          }
> -        DPRINTF("read: %08x = %08x\n", s->ioregsel, val);
>          break;
>      }
>  
> -    trace_ioapic_mem_read(addr, size, val);
> +    trace_ioapic_mem_read(addr, s->ioregsel, size, val);
>  
>      return val;
>  }
> @@ -335,7 +325,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>      int index;
>  
>      addr &= 0xff;
> -    trace_ioapic_mem_write(addr, size, val);
> +    trace_ioapic_mem_write(addr, s->ioregsel, size, val);
>  
>      switch (addr) {
>      case IOAPIC_IOREGSEL:
> @@ -345,7 +335,6 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>          if (size != 4) {
>              break;
>          }
> -        DPRINTF("write: %08x = %08" PRIx64 "\n", s->ioregsel, val);
>          switch (s->ioregsel) {
>          case IOAPIC_REG_ID:
>              s->id = (val >> IOAPIC_ID_SHIFT) & IOAPIC_ID_MASK;
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index b86f242b0f..b298fac7c6 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -18,8 +18,9 @@ apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
>  ioapic_set_remote_irr(int n) "set remote irr for pin %d"
>  ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
>  ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
> -ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
> -ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
> +ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
> +ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
> +ioapic_set_irq(int vector, int level) "vector: %d level: %d"
>  
>  # hw/intc/slavio_intctl.c
>  slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = 0x%x"
> -- 
> 2.14.3
> 

-- 
Peter Xu
