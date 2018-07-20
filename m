Received: from eggs.gnu.org ([2001:4830:134:3::10]:44384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fgOcC-0007TK-HF
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fgOc9-0005Ug-CF
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:10:08 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fgOc8-0005UL-Uu
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:10:05 -0400
Received: by mail-pl0-x243.google.com with SMTP id w8-v6so4709182ply.8
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 23:10:04 -0700 (PDT)
References: <20180620091013.2224-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8155ce8b-2c48-00b0-9311-46e2fcd4bab3@ozlabs.ru>
Date: Fri, 20 Jul 2018 16:09:58 +1000
MIME-Version: 1.0
In-Reply-To: <20180620091013.2224-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] vfio/spapr: Allow backing bigger
 guest IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>



On 20/6/18 7:10 pm, Alexey Kardashevskiy wrote:
> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
> pages and POWER8 CPU supports the exact same set of page size so
> so far things worked fine.
> 
> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
> the last two - 2M and 1G - are not even allowed in the paravirt interface
> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
> back guest's 16MB IOMMU pages with 2MB pages on the host.
> 
> This stores the supported host IOMMU page sizes in VFIOContainer and uses
> this later when creating a new DMA window. This uses the system page size
> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
> the IOMMU pagesize.
> 
> This changes the type of @pagesize to uint64_t as this is what
> memory_region_iommu_get_min_page_size() returns and clz64() takes.
> 
> There should be no behavioral changes on platforms other than pseries.
> The guest will keep using the IOMMU page size selected by the PHB pagesize
> property as this only changes the underlying hardware TCE table
> granularity.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Ping?

> ---
> Changes:
> v2:
> * fixed biggest but smaller page size calculation
> * limit IOMMU pagesize to the system pagesize
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              |  3 +++
>  hw/vfio/spapr.c               | 21 ++++++++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a903692..c20524d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,7 @@ typedef struct VFIOContainer {
>      unsigned iommu_type;
>      int error;
>      bool initialized;
> +    unsigned long pgsizes;
>      /*
>       * This assumes the host IOMMU can support only a single
>       * contiguous IOVA window.  We may need to generalize that in
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fb396cf..40f0356 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1108,6 +1108,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>              info.iova_pgsizes = 4096;
>          }
>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
> +        container->pgsizes = info.iova_pgsizes;
>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
>          struct vfio_iommu_spapr_tce_info info;
> @@ -1172,6 +1173,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          }
>  
>          if (v2) {
> +            container->pgsizes = info.ddw.pgsizes;
>              /*
>               * There is a default window in just created container.
>               * To make region_add/del simpler, we better remove this
> @@ -1186,6 +1188,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>              }
>          } else {
>              /* The default table uses 4K pages */
> +            container->pgsizes = 0x1000;
>              vfio_host_win_add(container, info.dma32_window_start,
>                                info.dma32_window_start +
>                                info.dma32_window_size - 1,
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 259397c..becf71a 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -15,6 +15,7 @@
>  
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/hw.h"
> +#include "exec/ram_addr.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  
> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  {
>      int ret;
>      IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -    unsigned pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
> +    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>      unsigned entries, pages;
>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
> +    long systempagesize = qemu_getrampagesize();
> +
> +    /*
> +     * The host might not support the guest supported IOMMU page size,
> +     * so we will use smaller physical IOMMU pages to back them.
> +     */
> +    if (pagesize > systempagesize) {
> +        pagesize = systempagesize;
> +    }
> +    pagesize = 1ULL << (63 - clz64(container->pgsizes &
> +                                   (pagesize | (pagesize - 1))));
> +    if (!pagesize) {
> +        error_report("Host doesn't support page size 0x%"PRIx64
> +                     ", the supported mask is 0x%lx",
> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> +                     container->pgsizes);
> +        return -EINVAL;
> +    }
>  
>      /*
>       * FIXME: For VFIO iommu types which have KVM acceleration to
> 

-- 
Alexey
