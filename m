Received: from eggs.gnu.org ([2001:4830:134:3::10]:60386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslNx-0005mN-11
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslNs-00046S-HA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:22:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:62752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eslNs-00044n-8R
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:22:12 -0500
Date: Mon, 5 Mar 2018 16:05:20 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305080520.GA2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-5-git-send-email-yi.l.liu@linux.intel.com>
	<20180305074555.GA7584@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305074555.GA7584@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com, eric.auger.pro@gmail.com, david@gibson.dropbear.id.au

On Mon, Mar 05, 2018 at 03:45:55PM +0800, Peter Xu wrote:
> On Thu, Mar 01, 2018 at 06:33:27PM +0800, Liu, Yi L wrote:
> > This patch introduces a notify framework for IOMMUSVAContext.sva_notifiers.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  hw/vfio/common.c              | 1 +
> >  include/hw/vfio/vfio-common.h | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 06277d2..1cc96df 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1019,6 +1019,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> >      container->fd = fd;
> >      QLIST_INIT(&container->giommu_mr_list);
> >      QLIST_INIT(&container->hostwin_list);
> > +    QLIST_INIT(&container->gsva_ctx_list);
> >      if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
> >          ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> >          bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > index 702a085..4c16b4c 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -29,6 +29,7 @@
> >  #ifdef CONFIG_LINUX
> >  #include <linux/vfio.h>
> >  #endif
> > +#include "hw/core/pasid.h"
> >  
> >  #define ERR_PREFIX "vfio error: %s: "
> >  #define WARN_PREFIX "vfio warning: %s: "
> > @@ -88,6 +89,7 @@ typedef struct VFIOContainer {
> >       * future
> >       */
> >      QLIST_HEAD(, VFIOGuestIOMMUMR) giommu_mr_list;
> > +    QLIST_HEAD(, VFIOGuestIOMMUSVAContext) gsva_ctx_list;
> 
> IIUC vfio container is per-domain, so here we have a per-domain
> context.  Does that mean that all the devices in the same IOMMU group
> (or say, share the 2nd level page table) must share the same PASID
> table (or say, the 1st level page table)?  Thanks,

Correct. We are also discussing it in another thread which is
on the bind granularity. Basically, SVA may only works for the
case in which only a single device in an iommu group. This is
based on the fact that there is no special handling to the PASID
TLP Prefix in PCI-E spec.

https://patchwork.kernel.org/patch/10213877/

Thanks,
Yi Liu
