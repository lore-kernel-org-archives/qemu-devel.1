Received: from eggs.gnu.org ([2001:4830:134:3::10]:38604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw57n-00088o-Fr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw57k-0001jQ-FD
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1cw57k-0001jC-8i
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:58:44 -0400
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-6-git-send-email-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d33a06b2-960d-9076-3b61-924c613fcc3a@redhat.com>
Date: Thu, 6 Apr 2017 12:58:30 +0200
MIME-Version: 1.0
In-Reply-To: <1491462524-1617-6-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 5/9] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>

Hi Peter,

On 06/04/2017 09:08, Peter Xu wrote:
> Originally we have one memory_region_iommu_replay() function, which is
> the default behavior to replay the translations of the whole IOMMU
> region. However, on some platform like x86, we may want our own replay
> logic for IOMMU regions. This patch add one more hook for IOMMUOps for
s/add/adds
> the callback, and it'll override the default if set.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  include/exec/memory.h | 2 ++
>  memory.c              | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 055b3a8..c0280b7 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
>      void (*notify_flag_changed)(MemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
> +    /* Set this up to provide customized IOMMU replay function */
> +    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
>  };
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> diff --git a/memory.c b/memory.c
> index ded4bf1..b782d5b 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1626,6 +1626,12 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
>  
> +    /* If the IOMMU has its own replay callback, override */
> +    if (mr->iommu_ops->replay) {
> +        mr->iommu_ops->replay(mr, n);
> +        return;
> +    }
> +
>      granularity = memory_region_iommu_get_min_page_size(mr);
>  
>      for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
> 
