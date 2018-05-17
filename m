Received: from eggs.gnu.org ([2001:4830:134:3::10]:33077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJJxj-0000Di-2a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJJxh-0000Ai-TK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:32:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJJxh-0000Aa-N6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:32:57 -0400
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-7-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <99079f7d-c447-d615-83c0-bb943557258d@redhat.com>
Date: Thu, 17 May 2018 16:32:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180504030811.28111-7-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/10] intel-iommu: pass in address
 space when page walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

Hi Peter,

On 05/04/2018 05:08 AM, Peter Xu wrote:
> We pass in the VTDAddressSpace to replace the aw bits when doing page
> walk.  The VTDAddressSpace contains the aw bits information, meanwhile
> we'll need to do something more in the follow up patches regarding to
> the address spaces.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/i386/intel_iommu.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b2b2a0a441..83769f2b8c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -753,13 +753,13 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
>   * @hook_fn: hook func to be called when detected page
>   * @private: private data to be passed into hook func
>   * @notify_unmap: whether we should notify invalid entries
> - * @aw: maximum address width
> + * @as: VT-d address space of the device
>   */
>  typedef struct {
> +    VTDAddressSpace *as;
>      vtd_page_walk_hook hook_fn;
>      void *private;
>      bool notify_unmap;
> -    uint8_t aw;
>  } vtd_page_walk_info;
>  
>  static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> @@ -796,6 +796,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>      uint64_t iova = start;
>      uint64_t iova_next;
>      int ret = 0;
> +    uint8_t aw = info->as->iommu_state->aw_bits;
>  
>      trace_vtd_page_walk_level(addr, level, start, end);
>  
> @@ -836,7 +837,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>  
>          if (vtd_is_last_slpte(slpte, level)) {
>              /* NOTE: this is only meaningful if entry_valid == true */
> -            entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
> +            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
>              if (!entry_valid && !info->notify_unmap) {
>                  trace_vtd_page_walk_skip_perm(iova, iova_next);
>                  goto next;
> @@ -862,7 +863,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>                  }
>                  goto next;
>              }
> -            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
> +            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw),
>                                        iova, MIN(iova_next, end), level - 1,
>                                        read_cur, write_cur, info);
>              if (ret < 0) {
> @@ -885,19 +886,20 @@ next:
>   * @end: IOVA range end address (start <= addr < end)
>   * @hook_fn: the hook that to be called for each detected area
>   * @private: private data for the hook function
> - * @aw: maximum address width
> + * @as: the VT-d address space of the device
>   */
>  static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
>                           vtd_page_walk_hook hook_fn, void *private,
> -                         bool notify_unmap, uint8_t aw)
> +                         bool notify_unmap, VTDAddressSpace *as)
>  {
>      dma_addr_t addr = vtd_ce_get_slpt_base(ce);
>      uint32_t level = vtd_ce_get_level(ce);
> +    uint8_t aw = as->iommu_state->aw_bits;
>      vtd_page_walk_info info = {
>          .hook_fn = hook_fn,
>          .private = private,
>          .notify_unmap = notify_unmap,
> -        .aw = aw,
> +        .as = as,
>      };
>  
>      if (!vtd_iova_range_check(start, ce, aw)) {
> @@ -1470,7 +1472,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>                   */
>                  vtd_page_walk(&ce, addr, addr + size,
>                                vtd_page_invalidate_notify_hook,
> -                              (void *)&vtd_as->iommu, true, s->aw_bits);
> +                              (void *)&vtd_as->iommu, true, vtd_as);
>              } else {
>                  /*
>                   * For UNMAP-only notifiers, we don't need to walk the
> @@ -2941,7 +2943,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>          if (vtd_as_notify_mappings(vtd_as)) {
>              /* This is required only for MAP typed notifiers */
>              vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
> -                          s->aw_bits);
> +                          vtd_as);
>          }
>      } else {
>          trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> 
