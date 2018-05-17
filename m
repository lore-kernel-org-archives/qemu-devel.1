Received: from eggs.gnu.org ([2001:4830:134:3::10]:33086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJJxl-0000Es-RL
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJJxf-0000A5-L2
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:33:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJJxf-00009k-FU
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:32:55 -0400
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-4-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <17cd0a63-47db-ca21-be34-6c131c839690@redhat.com>
Date: Thu, 17 May 2018 16:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180504030811.28111-4-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/10] intel-iommu: add iommu lock
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
> Add a per-iommu big lock to protect IOMMU status.  Currently the only
> thing to be protected is the IOTLB/context cache, since that can be
> accessed even without BQL, e.g., in IO dataplane.

As discussed together, Peter challenged per device mutex in
"Re: [PATCH v11 15/17] hw/arm/smmuv3: Cache/invalidate config data"
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02403.html
but at that time I fail to justify the use :-(

> 
> Note that we don't need to protect device page tables since that's fully
> controlled by the guest kernel.  However there is still possibility that
> malicious drivers will program the device to not obey the rule.  In that
> case QEMU can't really do anything useful, instead the guest itself will
> be responsible for all uncertainties.
> 
> Reported-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/i386/intel_iommu.h |  6 +++++
>  hw/i386/intel_iommu.c         | 43 +++++++++++++++++++++++++++++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 220697253f..ee517704e7 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -300,6 +300,12 @@ struct IntelIOMMUState {
>      OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>      bool buggy_eim;                 /* Force buggy EIM unless eim=off */
>      uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> +
> +    /*
> +     * Protects IOMMU states in general.  Currently it protects the
> +     * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
> +     */
> +    QemuMutex iommu_lock;
>  };
>  
>  /* Find the VTD Address space associated with the given bus pointer,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5987b48d43..112971638d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -128,6 +128,16 @@ static uint64_t vtd_set_clear_mask_quad(IntelIOMMUState *s, hwaddr addr,
>      return new_val;
>  }
>  
> +static inline void vtd_iommu_lock(IntelIOMMUState *s)
> +{
> +    qemu_mutex_lock(&s->iommu_lock);
> +}
> +
> +static inline void vtd_iommu_unlock(IntelIOMMUState *s)
> +{
> +    qemu_mutex_unlock(&s->iommu_lock);
> +}
> +
>  /* GHashTable functions */
>  static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
>  {
> @@ -172,7 +182,7 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
>  }
>  
>  /* Reset all the gen of VTDAddressSpace to zero and set the gen of
> - * IntelIOMMUState to 1.
> + * IntelIOMMUState to 1.  Must be with IOMMU lock held.
s/Must be/ Must be called ?
not done in vtd_init()
>   */
>  static void vtd_reset_context_cache(IntelIOMMUState *s)
>  {
> @@ -197,12 +207,19 @@ static void vtd_reset_context_cache(IntelIOMMUState *s)
>      s->context_cache_gen = 1;
>  }
>  
> -static void vtd_reset_iotlb(IntelIOMMUState *s)
> +static void vtd_reset_iotlb_locked(IntelIOMMUState *s)
add the above comment and keep the original name?
>  {
>      assert(s->iotlb);
>      g_hash_table_remove_all(s->iotlb);
>  }
>  
> +static void vtd_reset_iotlb(IntelIOMMUState *s)
> +{
> +    vtd_iommu_lock(s);
> +    vtd_reset_iotlb_locked(s);
> +    vtd_iommu_unlock(s);
> +}
> +
>  static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
>                                    uint32_t level)
>  {
> @@ -215,6 +232,7 @@ static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
>      return (addr & vtd_slpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
>  }
>  
> +/* Must be with IOMMU lock held */
>  static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>                                         hwaddr addr)
>  {
> @@ -235,6 +253,7 @@ out:
>      return entry;
>  }
>  
> +/* Must be with IOMMU lock held */
>  static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>                               uint16_t domain_id, hwaddr addr, uint64_t slpte,
>                               uint8_t access_flags, uint32_t level)
> @@ -246,7 +265,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>      trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
>      if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
>          trace_vtd_iotlb_reset("iotlb exceeds size limit");
> -        vtd_reset_iotlb(s);
> +        vtd_reset_iotlb_locked(s);
>      }
>  
>      entry->gfn = gfn;
> @@ -1106,7 +1125,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>      IntelIOMMUState *s = vtd_as->iommu_state;
>      VTDContextEntry ce;
>      uint8_t bus_num = pci_bus_num(bus);
> -    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +    VTDContextCacheEntry *cc_entry;
>      uint64_t slpte, page_mask;
>      uint32_t level;
>      uint16_t source_id = vtd_make_source_id(bus_num, devfn);
> @@ -1123,6 +1142,10 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       */
>      assert(!vtd_is_interrupt_addr(addr));
>  
> +    vtd_iommu_lock(s);
> +
> +    cc_entry = &vtd_as->context_cache_entry;
> +
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {
> @@ -1182,7 +1205,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>           * IOMMU region can be swapped back.
>           */
>          vtd_pt_enable_fast_path(s, source_id);
> -
> +        vtd_iommu_unlock(s);
>          return true;
>      }
>  
> @@ -1203,6 +1226,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>      vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
>                       access_flags, level);
>  out:
> +    vtd_iommu_unlock(s);
>      entry->iova = addr & page_mask;
>      entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
>      entry->addr_mask = ~page_mask;
> @@ -1210,6 +1234,7 @@ out:
>      return true;
>  
>  error:
> +    vtd_iommu_unlock(s);
>      entry->iova = 0;
>      entry->translated_addr = 0;
>      entry->addr_mask = 0;
> @@ -1258,10 +1283,13 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
>  static void vtd_context_global_invalidate(IntelIOMMUState *s)
>  {
>      trace_vtd_inv_desc_cc_global();
> +    /* Protects context cache */
> +    vtd_iommu_lock(s);
>      s->context_cache_gen++;
>      if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
>          vtd_reset_context_cache(s);
>      }
> +    vtd_iommu_unlock(s);
>      vtd_switch_address_space_all(s);
>      /*
>       * From VT-d spec 6.5.2.1, a global context entry invalidation
> @@ -1377,8 +1405,10 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>  
>      trace_vtd_inv_desc_iotlb_domain(domain_id);
>  
> +    vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
>                                  &domain_id);
> +    vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> @@ -1426,7 +1456,9 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>      info.domain_id = domain_id;
>      info.addr = addr;
>      info.mask = ~((1 << am) - 1);
> +    vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
> +    vtd_iommu_unlock(s);
>      vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>  }
>  
> @@ -3072,6 +3104,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      }
>  
>      QLIST_INIT(&s->notifiers_list);
> +    qemu_mutex_init(&s->iommu_lock);
>      memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
>      memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
>                            "intel_iommu", DMAR_REG_SIZE);
> 
Don't you need to take the lock in vtd_context_device_invalidate() which
manipulates the vtd_as->context_cache_entry.context_cache_gen?

Thanks

Eric
