Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dViCg-0005Ii-D2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dViCd-0007mK-Au
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dViCd-0007ji-13
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B81261A14
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:47:01 +0000 (UTC)
Date: Thu, 13 Jul 2017 20:47:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713204619-mutt-send-email-mst@kernel.org>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499847223-8078-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] intel_iommu: let iotlb size tunable
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

On Wed, Jul 12, 2017 at 04:13:41PM +0800, Peter Xu wrote:
> We were having static IOTLB size as 1024. Let it be a tunable. We can
> also turns IOTLB off if we want, by specify the size as zero.
> 
> The tunable is named as "x-iotlb-size" since that should not really be
> something used by user yet, but mostly for debugging purpose now.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I'm somewhat vary of adding tunables just for developers to play with.
People will find and abuse them :)

> ---
>  hw/i386/intel_iommu.c          | 11 ++++++++++-
>  hw/i386/intel_iommu_internal.h |  1 -
>  include/hw/i386/intel_iommu.h  |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 392da45..9c36866 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -222,6 +222,10 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>      uint64_t key;
>      int level;
>  
> +    if (s->iotlb_size == 0) {
> +        return NULL;
> +    }
> +
>      for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
>          key = vtd_get_iotlb_key(vtd_get_iotlb_gfn(addr, level),
>                                  source_id, level);
> @@ -244,8 +248,12 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>      uint64_t *key = g_malloc(sizeof(*key));
>      uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
>  
> +    if (s->iotlb_size == 0) {
> +        return;
> +    }
> +
>      trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
> -    if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
> +    if (g_hash_table_size(s->iotlb) >= s->iotlb_size) {
>          trace_vtd_iotlb_reset("iotlb exceeds size limit");
>          vtd_reset_iotlb(s);
>      }
> @@ -2397,6 +2405,7 @@ static Property vtd_properties[] = {
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> +    DEFINE_PROP_UINT16("x-iotlb-size", IntelIOMMUState, iotlb_size, 1024),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 754cf8a..2d77249 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -116,7 +116,6 @@
>  /* The shift of source_id in the key of IOTLB hash table */
>  #define VTD_IOTLB_SID_SHIFT         36
>  #define VTD_IOTLB_LVL_SHIFT         52
> -#define VTD_IOTLB_MAX_SIZE          1024    /* Max size of the hash table */
>  
>  /* IOTLB_REG */
>  #define VTD_TLB_GLOBAL_FLUSH        (1ULL << 60) /* Global invalidation */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3e51876..a57f419 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -288,6 +288,7 @@ struct IntelIOMMUState {
>  
>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>      GHashTable *iotlb;              /* IOTLB */
> +    uint16_t iotlb_size;            /* IOTLB max cache entries */
>  
>      MemoryRegionIOMMUOps iommu_ops;
>      GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
> -- 
> 2.7.4
