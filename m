Received: from eggs.gnu.org ([2001:4830:134:3::10]:34229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0f3W-0007Bt-Sk
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0f3T-0003S9-NO
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:09:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d0f3T-0003Rh-EM
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:09:15 -0400
Date: Wed, 19 Apr 2017 10:08:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170419020857.GG22226@pxdev.xzpeter.org>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
	<1491562755-23867-2-git-send-email-peterx@redhat.com>
	<20170410043922.GI27571@umbus>
	<20170410070950.GK3981@pxdev.xzpeter.org>
	<20170411015654.GU27571@umbus>
	<20170418095637.GE22226@pxdev.xzpeter.org>
	<20170418115511.GA12450@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418115511.GA12450@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v9 1/9] memory: add section range info for
 IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Apr 18, 2017 at 09:55:11PM +1000, David Gibson wrote:
> On Tue, Apr 18, 2017 at 05:56:37PM +0800, Peter Xu wrote:
> > On Tue, Apr 11, 2017 at 11:56:54AM +1000, David Gibson wrote:
> > > On Mon, Apr 10, 2017 at 03:09:50PM +0800, Peter Xu wrote:
> > > > On Mon, Apr 10, 2017 at 02:39:22PM +1000, David Gibson wrote:
> > > > > On Fri, Apr 07, 2017 at 06:59:07PM +0800, Peter Xu wrote:
> > > > > > In this patch, IOMMUNotifier.{start|end} are introduced to store section
> > > > > > information for a specific notifier. When notification occurs, we not
> > > > > > only check the notification type (MAP|UNMAP), but also check whether the
> > > > > > notified iova range overlaps with the range of specific IOMMU notifier,
> > > > > > and skip those notifiers if not in the listened range.
> > > > > > 
> > > > > > When removing an region, we need to make sure we removed the correct
> > > > > > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> > > > > > 
> > > > > > This patch is solving the problem that vfio-pci devices receive
> > > > > > duplicated UNMAP notification on x86 platform when vIOMMU is there. The
> > > > > > issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
> > > > > > splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
> > > > > > this (splitted IOMMU region) is only happening on x86.
> > > > > > 
> > > > > > This patch also helps vhost to leverage the new interface as well, so
> > > > > > that vhost won't get duplicated cache flushes. In that sense, it's an
> > > > > > slight performance improvement.
> > > > > > 
> > > > > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >  hw/vfio/common.c      | 12 +++++++++---
> > > > > >  hw/virtio/vhost.c     | 10 ++++++++--
> > > > > >  include/exec/memory.h | 19 ++++++++++++++++++-
> > > > > >  memory.c              |  9 +++++++++
> > > > > >  4 files changed, 44 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > > > > index f3ba9b9..6b33b9f 100644
> > > > > > --- a/hw/vfio/common.c
> > > > > > +++ b/hw/vfio/common.c
> > > > > > @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
> > > > > >          giommu->iommu_offset = section->offset_within_address_space -
> > > > > >                                 section->offset_within_region;
> > > > > >          giommu->container = container;
> > > > > > -        giommu->n.notify = vfio_iommu_map_notify;
> > > > > > -        giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
> > > > > > +        llend = int128_add(int128_make64(section->offset_within_region),
> > > > > > +                           section->size);
> > > > > > +        llend = int128_sub(llend, int128_one());
> > > > > > +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > > > > > +                            IOMMU_NOTIFIER_ALL,
> > > > > > +                            section->offset_within_region,
> > > > > > +                            int128_get64(llend));
> > > > > 
> > > > > Seems to me it would make sense to put the fiddling around to convert
> > > > > the MemoryRegionSection into the necessary values would make sense to
> > > > > go inside iommu_notifier_init().
> > > > 
> > > > But will we always get one MemoryRegionSection if we are not in any of
> > > > the region_{add|del} callback? E.g., what if we want to init an IOMMU
> > > > notifier that covers just the whole IOMMU region range?
> > > 
> > > I suppose so.  It's just the only likely users of the interface I can
> > > see will be always doing this from region_{add,del}.
> > > 
> > > > Considering above, I would still slightly prefer current interface.
> > > 
> > > Ok, well my opinion on the matter isn't terribly strong.
> > 
> > Hi, David,
> > 
> > Sorry to respond late (so that context might be lost). Just want to
> > make sure that you are okay with current patch and interface, right?
> > 
> > I think Marcel is going to merge it if np, and I would like to have
> > your confirmation on this before the merge. Thanks!
> 
> Yes, that's fine.

I see that Edurado has already queued the patches. Thanks for the
confirmation!

-- 
Peter Xu
