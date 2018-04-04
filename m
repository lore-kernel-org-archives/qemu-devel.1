Received: from eggs.gnu.org ([2001:4830:134:3::10]:49046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3rC3-0001n0-EM
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3rBz-0002Xi-9B
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:47:51 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3rBz-0002Wt-3k
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:47:47 -0400
Received: by mail-qt0-x241.google.com with SMTP id j3so24969564qtn.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 15:47:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1522873850-28733-1-git-send-email-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c594fd3f-c0d4-1c4f-cd13-9eaa5c5640ec@amsat.org>
Date: Wed, 4 Apr 2018 19:47:43 -0300
MIME-Version: 1.0
In-Reply-To: <1522873850-28733-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 2.12] vfio: Use a trace point when a
 RAM section cannot be DMA mapped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: aik@ozlabs.ru

On 04/04/2018 05:30 PM, Eric Auger wrote:
> The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions")
> added an error message if a passed memory section address or size
> is not aligned to the page size and thus cannot be DMA mapped.
> 
> This patch fixes the trace by printing the region name and the
> memory region section offset within the address space (instead of
> offset_within_region).
> 
> We also turn the error_report into a trace event. Indeed, In some
> cases, the traces can be confusing to non expert end-users and
> let think the use case does not work (whereas it
> works as before).
> 
> This is the case where a BAR is successively mapped at different
> GPAs and its sections are not compatible with dma map. The listener
> is called several times and traces are issued for each intermediate
> mapping.  The end-user cannot easily match those GPAs against the
> final GPA output by lscpi. So let's keep those information to
> informed users. In mid term, the plan is to advise the user about
> BAR relocation relevance.
> 
> Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> v1 -> v2:
> - use a trace point
> - add some details in the commit message
> ---
>  hw/vfio/common.c     | 11 +++++------
>  hw/vfio/trace-events |  1 +
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5e84716..07ffa0b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -548,12 +548,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>  
>          if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
> -            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
> -                         " is not aligned to 0x%"HWADDR_PRIx
> -                         " and cannot be mapped for DMA",
> -                         section->offset_within_region,
> -                         int128_getlo(section->size),
> -                         pgmask + 1);
> +            trace_vfio_listener_region_add_no_dma_map(
> +                memory_region_name(section->mr),
> +                section->offset_within_address_space,
> +                int128_getlo(section->size),
> +                pgmask + 1);
>              return;
>          }
>      }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 79f63a2..20109cb 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -90,6 +90,7 @@ vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "i
>  vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
> +vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>  vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>  vfio_disconnect_container(int fd) "close container->fd=%d"
> 
