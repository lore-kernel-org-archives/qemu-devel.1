Received: from eggs.gnu.org ([2001:4830:134:3::10]:54760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eskp9-0003JM-TF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eskp6-000591-Oh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:46:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eskp6-00058a-K9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:46:16 -0500
Date: Mon, 5 Mar 2018 15:45:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180305074555.GA7584@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-5-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519900415-30314-5-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/12] vfio/pci: add notify framework
 based on IOMMUSVAContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Thu, Mar 01, 2018 at 06:33:27PM +0800, Liu, Yi L wrote:
> This patch introduces a notify framework for IOMMUSVAContext.sva_notifiers.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  hw/vfio/common.c              | 1 +
>  include/hw/vfio/vfio-common.h | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 06277d2..1cc96df 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1019,6 +1019,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->fd = fd;
>      QLIST_INIT(&container->giommu_mr_list);
>      QLIST_INIT(&container->hostwin_list);
> +    QLIST_INIT(&container->gsva_ctx_list);
>      if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
>          ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
>          bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 702a085..4c16b4c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -29,6 +29,7 @@
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> +#include "hw/core/pasid.h"
>  
>  #define ERR_PREFIX "vfio error: %s: "
>  #define WARN_PREFIX "vfio warning: %s: "
> @@ -88,6 +89,7 @@ typedef struct VFIOContainer {
>       * future
>       */
>      QLIST_HEAD(, VFIOGuestIOMMUMR) giommu_mr_list;
> +    QLIST_HEAD(, VFIOGuestIOMMUSVAContext) gsva_ctx_list;

IIUC vfio container is per-domain, so here we have a per-domain
context.  Does that mean that all the devices in the same IOMMU group
(or say, share the 2nd level page table) must share the same PASID
table (or say, the 1st level page table)?  Thanks,

>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>      QLIST_HEAD(, VFIOGroup) group_list;
>      QLIST_ENTRY(VFIOContainer) next;
> @@ -101,6 +103,13 @@ typedef struct VFIOGuestIOMMUMR {
>      QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
>  } VFIOGuestIOMMUMR;
>  
> +typedef struct VFIOGuestIOMMUSVAContext {
> +    VFIOContainer *container;
> +    IOMMUSVAContext *sva_ctx;
> +    IOMMUSVANotifier n;
> +    QLIST_ENTRY(VFIOGuestIOMMUSVAContext) gsva_ctx_next;
> +} VFIOGuestIOMMUSVAContext;
> +
>  typedef struct VFIOHostDMAWindow {
>      hwaddr min_iova;
>      hwaddr max_iova;
> -- 
> 1.9.1
> 

-- 
Peter Xu
