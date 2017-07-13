Received: from eggs.gnu.org ([2001:4830:134:3::10]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dViFM-0006wq-4M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dViFJ-0002o0-1f
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:49:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dViFI-0002mr-O3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A282783F44
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:49:47 +0000 (UTC)
Date: Thu, 13 Jul 2017 20:49:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713204803-mutt-send-email-mst@kernel.org>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499847223-8078-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] intel_iommu: implement mru list for
 iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Wed, Jul 12, 2017 at 04:13:43PM +0800, Peter Xu wrote:
> It is not wise to disgard all the IOTLB cache when cache size reaches
> max, but that's what we do now. A slightly better (but still simple) way
> to do this is, we just throw away the least recent used cache entry.

Not wise how? Slower? It seems simpler.

> This patch implemented MRU list algorithm for VT-d IOTLB. The main logic
> is to maintain a Most Recently Used list for the IOTLB entries. The hash
> table is still used for lookup, though a new list field is added to each
> IOTLB entry for a iotlb MRU list. For each active IOTLB entry, it's both
> in the hash table in s->iotlb, and also linked into the MRU list of
> s->iotlb_head. The hash helps in fast lookup, and the MRU list helps in
> knowing whether the cache is still hot.

Helps how? Faster?  What's missing here is a report of the performance
impact.

> After we have such a MRU list, replacing all the iterators of IOTLB
> entries by using list iterations rather than hash table iterations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c          | 75 +++++++++++++++++++++++++-----------------
>  hw/i386/intel_iommu_internal.h |  8 -----
>  hw/i386/trace-events           |  1 -
>  include/hw/i386/intel_iommu.h  |  6 +++-
>  4 files changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e17340c..6320dea 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,9 @@
>  #include "kvm_i386.h"
>  #include "trace.h"
>  
> +#define FOREACH_IOTLB_SAFE(entry, s, entry_n) \
> +    QTAILQ_FOREACH_SAFE(entry, &(s)->iotlb_head, link, entry_n)
> +
>  static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                              uint64_t wmask, uint64_t w1cmask)
>  {
> @@ -139,14 +142,6 @@ static guint vtd_uint64_hash(gconstpointer v)
>      return (guint)*(const uint64_t *)v;
>  }
>  
> -static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
> -                                          gpointer user_data)
> -{
> -    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> -    uint16_t domain_id = *(uint16_t *)user_data;
> -    return entry->domain_id == domain_id;
> -}
> -
>  /* The shift of an addr for a certain level of paging structure */
>  static inline uint32_t vtd_slpt_level_shift(uint32_t level)
>  {
> @@ -159,18 +154,6 @@ static inline uint64_t vtd_slpt_level_page_mask(uint32_t level)
>      return ~((1ULL << vtd_slpt_level_shift(level)) - 1);
>  }
>  
> -static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
> -                                        gpointer user_data)
> -{
> -    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> -    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> -    uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
> -    uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
> -    return (entry->domain_id == info->domain_id) &&
> -            (((entry->gfn & info->mask) == gfn) ||
> -             (entry->gfn == gfn_tlb));
> -}
> -
>  /* Reset all the gen of VTDAddressSpace to zero and set the gen of
>   * IntelIOMMUState to 1.
>   */
> @@ -201,6 +184,7 @@ static void vtd_reset_iotlb(IntelIOMMUState *s)
>  {
>      assert(s->iotlb);
>      g_hash_table_remove_all(s->iotlb);
> +    QTAILQ_INIT(&s->iotlb_head);
>  }
>  
>  static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
> @@ -231,6 +215,9 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>                                  source_id, level);
>          entry = g_hash_table_lookup(s->iotlb, &key);
>          if (entry) {
> +            /* Move the entry to the head of MRU list */
> +            QTAILQ_REMOVE(&s->iotlb_head, entry, link);
> +            QTAILQ_INSERT_HEAD(&s->iotlb_head, entry, link);
>              goto out;
>          }
>      }
> @@ -239,11 +226,23 @@ out:
>      return entry;
>  }
>  
> +static void vtd_iotlb_remove_entry(IntelIOMMUState *s, VTDIOTLBEntry *entry)
> +{
> +    uint64_t key = entry->key;
> +
> +    /*
> +     * To remove an entry, we need to both remove it from the MRU
> +     * list, and also from the hash table.
> +     */
> +    QTAILQ_REMOVE(&s->iotlb_head, entry, link);
> +    g_hash_table_remove(s->iotlb, &key);
> +}
> +
>  static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>                               uint16_t domain_id, hwaddr addr, uint64_t slpte,
>                               uint8_t access_flags, uint32_t level)
>  {
> -    VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
> +    VTDIOTLBEntry *entry = g_new0(VTDIOTLBEntry, 1), *last;
>      uint64_t *key = g_malloc(sizeof(*key));
>      uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
>  
> @@ -253,8 +252,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>  
>      trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
>      if (g_hash_table_size(s->iotlb) >= s->iotlb_size) {
> -        trace_vtd_iotlb_reset("iotlb exceeds size limit");
> -        vtd_reset_iotlb(s);
> +        /* Remove the Least Recently Used cache */
> +        last = QTAILQ_LAST(&s->iotlb_head, VTDIOTLBEntryHead);
> +        vtd_iotlb_remove_entry(s, last);
>      }
>  
>      entry->gfn = gfn;
> @@ -263,7 +263,11 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>      entry->access_flags = access_flags;
>      entry->mask = vtd_slpt_level_page_mask(level);
>      *key = vtd_get_iotlb_key(gfn, source_id, level);
> +    entry->key = *key;
>      g_hash_table_replace(s->iotlb, key, entry);
> +
> +    /* Update MRU list */
> +    QTAILQ_INSERT_HEAD(&s->iotlb_head, entry, link);
>  }
>  
>  /* Given the reg addr of both the message data and address, generate an
> @@ -1354,11 +1358,15 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      IntelIOMMUNotifierNode *node;
>      VTDContextEntry ce;
>      VTDAddressSpace *vtd_as;
> +    VTDIOTLBEntry *entry, *entry_n;
>  
>      trace_vtd_inv_desc_iotlb_domain(domain_id);
>  
> -    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
> -                                &domain_id);
> +    FOREACH_IOTLB_SAFE(entry, s, entry_n) {
> +        if (entry->domain_id == domain_id) {
> +            vtd_iotlb_remove_entry(s, entry);
> +        }
> +    }
>  
>      QLIST_FOREACH(node, &s->notifiers_list, next) {
>          vtd_as = node->vtd_as;
> @@ -1400,15 +1408,22 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>                                        hwaddr addr, uint8_t am)
>  {
> -    VTDIOTLBPageInvInfo info;
> +    VTDIOTLBEntry *entry, *entry_n;
> +    uint64_t gfn, mask;
>  
>      trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
>  
>      assert(am <= VTD_MAMV);
> -    info.domain_id = domain_id;
> -    info.addr = addr;
> -    info.mask = ~((1 << am) - 1);
> -    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
> +
> +    mask = ~((1 << am) - 1);
> +    gfn = (addr >> VTD_PAGE_SHIFT) & mask;
> +
> +    FOREACH_IOTLB_SAFE(entry, s, entry_n) {
> +        if (entry->domain_id == domain_id && (entry->gfn & mask) == gfn) {
> +            vtd_iotlb_remove_entry(s, entry);
> +        }
> +    }
> +
>      vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>  }
>  
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2d77249..76efc66 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -372,14 +372,6 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>  
> -/* Information about page-selective IOTLB invalidate */
> -struct VTDIOTLBPageInvInfo {
> -    uint16_t domain_id;
> -    uint64_t addr;
> -    uint8_t mask;
> -};
> -typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
> -
>  /* Pagesize of VTD paging structures, including root and context tables */
>  #define VTD_PAGE_SHIFT              12
>  #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 42d8a7e..b552815 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -34,7 +34,6 @@ vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain)
>  vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
>  vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
>  vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
> -vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
>  vtd_fault_disabled(void) "Fault processing disabled for context entry"
>  vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
>  vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 1b51c9f..d2caab3 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -98,9 +98,11 @@ struct VTDBus {
>  
>  struct VTDIOTLBEntry {
>      uint64_t gfn;
> -    uint16_t domain_id;
>      uint64_t slpte;
>      uint64_t mask;
> +    uint64_t key;
> +    QTAILQ_ENTRY(VTDIOTLBEntry) link;
> +    uint16_t domain_id;
>      uint8_t access_flags;
>  };
>  
> @@ -288,6 +290,8 @@ struct IntelIOMMUState {
>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>      GHashTable *iotlb;              /* IOTLB */
>      uint16_t iotlb_size;            /* IOTLB max cache entries */
> +    /* Head of IOTLB MRU list */
> +    QTAILQ_HEAD(VTDIOTLBEntryHead, VTDIOTLBEntry) iotlb_head;
>  
>      MemoryRegionIOMMUOps iommu_ops;
>      GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
> -- 
> 2.7.4
