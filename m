Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZYK3-0002k8-GH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZYJy-0004YP-G7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:30:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZYJy-0004Xa-7h
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:30:14 -0500
Date: Fri, 3 Feb 2017 15:30:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170203073007.GO5151@pxdev.xzpeter.org>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-4-git-send-email-peterx@redhat.com>
	<20170124093207.18444a86@t450s.home>
	<20170131033500.GL14879@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170131033500.GL14879@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v5 03/18] vfio: allow to notify unmap for
 very large region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Tue, Jan 31, 2017 at 02:35:00PM +1100, David Gibson wrote:
> On Tue, Jan 24, 2017 at 09:32:07AM -0700, Alex Williamson wrote:
> > On Tue, 24 Jan 2017 18:25:56 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> > 
> > > Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
> > > region. This can be leveraged by QEMU IOMMU implementation to cleanup
> > > existing page mappings for an entire iova address space (by notifying
> > > with an IOTLB with extremely huge addr_mask). However current
> > > vfio_iommu_map_notify() does not allow that. It make sure that all the
> > > translated address in IOTLB is falling into RAM range.
> > > 
> > > The check makes sense, but it should only be a sensible checker for
> > > mapping operations, and mean little for unmap operations.
> > > 
> > > This patch moves this check into map logic only, so that we'll get
> > > faster unmap handling (no need to translate again), and also we can then
> > > better support unmapping a very big region when it covers non-ram ranges
> > > or even not-existing ranges.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  hw/vfio/common.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index ce55dff..4d90844 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -354,11 +354,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > >          return;
> > >      }
> > >  
> > > -    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > > -        return;
> > > -    }
> > > -
> > >      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> > > +        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > > +            return;
> > > +        }
> > 
> > 
> > David, is SPAPR going to freak out if it sees unmaps to ranges that
> > extend beyond individual mappings, or perhaps include no mappings?
> > This effectively allows unmapping the entire address space of the iommu
> > in one pass, without validating or translating the backing.
> 
> Extending beyond an individual mapping will be fine.  However, if the
> unmap extends beyond the extent of IOVAs mapped by a single TCE table,
> then the unmap will fail (with ENXIO or EINVAL depending on whether
> there's a problem with origin or only size).
> 
> With holidays I've lost the context of this thread, so I can't easily
> find the whole patch series this relates to.  From your brief
> description above it sounds likes it should be ok - a range covering
> just the IOVA space (as long as that's actually correct for spapr tce)
> should be ok.

Thanks for the confirmation! Then I'll move ahead for the next spin.

Thanks,

-- peterx
