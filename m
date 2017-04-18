Received: from eggs.gnu.org ([2001:4830:134:3::10]:45949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Wy5-0003gV-AM
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Wy2-0007aP-4H
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0Wy1-0007a4-SF
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:31:06 -0400
Date: Tue, 18 Apr 2017 14:30:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170418173054.GC7078@thinpad.lan.raisama.net>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
	<1491562755-23867-2-git-send-email-peterx@redhat.com>
	<20170410043922.GI27571@umbus>
	<20170410070950.GK3981@pxdev.xzpeter.org>
	<dc26790e-8200-bbde-a7c3-70852f625424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc26790e-8200-bbde-a7c3-70852f625424@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Apr 18, 2017 at 06:20:11PM +0300, Marcel Apfelbaum wrote:
> On 04/10/2017 10:09 AM, Peter Xu wrote:
> > On Mon, Apr 10, 2017 at 02:39:22PM +1000, David Gibson wrote:
> > > On Fri, Apr 07, 2017 at 06:59:07PM +0800, Peter Xu wrote:
> > > > In this patch, IOMMUNotifier.{start|end} are introduced to store section
> > > > information for a specific notifier. When notification occurs, we not
> > > > only check the notification type (MAP|UNMAP), but also check whether the
> > > > notified iova range overlaps with the range of specific IOMMU notifier,
> > > > and skip those notifiers if not in the listened range.
> > > > 
> > > > When removing an region, we need to make sure we removed the correct
> > > > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> > > > 
> > > > This patch is solving the problem that vfio-pci devices receive
> > > > duplicated UNMAP notification on x86 platform when vIOMMU is there. The
> > > > issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
> > > > splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
> > > > this (splitted IOMMU region) is only happening on x86.
> > > > 
> > > > This patch also helps vhost to leverage the new interface as well, so
> > > > that vhost won't get duplicated cache flushes. In that sense, it's an
> > > > slight performance improvement.
> > > > 
> > > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  hw/vfio/common.c      | 12 +++++++++---
> > > >  hw/virtio/vhost.c     | 10 ++++++++--
> > > >  include/exec/memory.h | 19 ++++++++++++++++++-
> > > >  memory.c              |  9 +++++++++
> > > >  4 files changed, 44 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > > index f3ba9b9..6b33b9f 100644
> > > > --- a/hw/vfio/common.c
> > > > +++ b/hw/vfio/common.c
> > > > @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
> > > >          giommu->iommu_offset = section->offset_within_address_space -
> > > >                                 section->offset_within_region;
> > > >          giommu->container = container;
> > > > -        giommu->n.notify = vfio_iommu_map_notify;
> > > > -        giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
> > > > +        llend = int128_add(int128_make64(section->offset_within_region),
> > > > +                           section->size);
> > > > +        llend = int128_sub(llend, int128_one());
> > > > +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > > > +                            IOMMU_NOTIFIER_ALL,
> > > > +                            section->offset_within_region,
> > > > +                            int128_get64(llend));
> > > 
> > > Seems to me it would make sense to put the fiddling around to convert
> > > the MemoryRegionSection into the necessary values would make sense to
> > > go inside iommu_notifier_init().
> > 
> > But will we always get one MemoryRegionSection if we are not in any of
> > the region_{add|del} callback? E.g., what if we want to init an IOMMU
> > notifier that covers just the whole IOMMU region range?
> > 
> > Considering above, I would still slightly prefer current interface.
> > 
> > > 
> > > >          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> > > > 
> > > >          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> > > > @@ -550,7 +555,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
> > > >          VFIOGuestIOMMU *giommu;
> > > > 
> > > >          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> > > > -            if (giommu->iommu == section->mr) {
> > > > +            if (giommu->iommu == section->mr &&
> > > > +                giommu->n.start == section->offset_within_region) {
> > > 
> > > This test should be sufficient, but I'd be a bit more comfortable if
> > > there was a test and assert() that the end matches as well.  I also
> > > wonder if remove-matching-notifier helper would be useful here.
> > > Although vhost doesn't appear to ever remove, so maybe it's premature.
> > 
> > Oh... vhost does remove it, but I just forgot to touch it up :( ...
> > Thanks for pointing out.
> > 
> > Marcel, if this is the only comment, would you mind squash below
> > change into current patch? Thanks,
> 
> Hi Peter,
> I asked Eduardo to merge the series through this machine tree
> since I don't have a tree yet.
> He already squashed the change, thanks Eduardo!
> Marcel

The series is queued at:

git://github.com/ehabkost/qemu-hacks.git machine-next

(Including the vhost_iommu_region_del() fixup below).

v2.9.0-rc5 was tagged today, v2.9.0 is expected to be tagged in 2
days. I plan to submit a pull request as soon as it is tagged.

-- 
Eduardo
