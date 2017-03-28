Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1csvER-0007VB-30
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1csvEO-0005bZ-0P
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:48:35 -0400
Date: Tue, 28 Mar 2017 11:48:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170328114829.25656146@t450s.home>
In-Reply-To: <20170328090530.20052-2-aik@ozlabs.ru>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 28 Mar 2017 20:05:28 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/exec/memory.h | 2 ++
>  hw/ppc/spapr_iommu.c  | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e39256ad03..925c10b35b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -174,6 +174,8 @@ struct MemoryRegionIOMMUOps {
>      void (*notify_flag_changed)(MemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
> +    /* Returns a kernel fd for IOMMU */
> +    int (*get_fd)(MemoryRegion *iommu);

What if we used this as a prototype:

int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);

And then we defined:

typedef enum {
    SPAPR_IOMMU_TABLE_FD = 0,
} IOMMUFdType;

Such that you're actually asking the IOMMUOps for a specific type of FD
and it either has it or not, so the caller doesn't need to assume what
it is they get back.

Furthermore, add:

int memory_region_iommu_get_fd(IOMMUFdType type, MemoryRegion *mr)
{
    assert(memory_region_is_iommu(mr));

    if (mr->iommu_ops && mr->iommu_ops->get_fd) {
        return mr->iommu_ops->get_fd(type, mr);
    }

    return -1;
}

>  };
>

This should be two patches, patch 1 above, patch 2 below
  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 9e30e148d6..b61c8f053e 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -170,6 +170,13 @@ static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
>      }
>  }
>  
> +static int spapr_tce_get_fd(MemoryRegion *iommu)
> +{
> +    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
> +
> +    return tcet->fd;


This would then be:

    return type == SPAPR_IOMMU_TABLE_FD ? tcet->fd : -1;

> +}
> +
>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
> @@ -251,6 +258,7 @@ static MemoryRegionIOMMUOps spapr_iommu_ops = {
>      .translate = spapr_tce_translate_iommu,
>      .get_min_page_size = spapr_tce_get_min_page_size,
>      .notify_flag_changed = spapr_tce_notify_flag_changed,
> +    .get_fd = spapr_tce_get_fd,
>  };
>  
>  static int spapr_tce_table_realize(DeviceState *dev)
