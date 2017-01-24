Received: from eggs.gnu.org ([2001:4830:134:3::10]:57250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVrmV-0005gV-JV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 22:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVrmS-00075S-FW
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 22:28:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVrmS-00074p-84
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 22:28:24 -0500
Date: Tue, 24 Jan 2017 11:28:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124032818.GJ26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-3-git-send-email-peterx@redhat.com>
	<20170123114905.4936508d@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170123114905.4936508d@t450s.home>
Subject: Re: [Qemu-devel] [PATCH RFC v4 02/20] vfio: introduce
 vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Mon, Jan 23, 2017 at 11:49:05AM -0700, Alex Williamson wrote:
> On Fri, 20 Jan 2017 21:08:38 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > A cleanup for vfio_iommu_map_notify(). Should have no functional change,
> > just to make the function shorter and easier to understand.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/vfio/common.c | 58 +++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 38 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 174f351..ce55dff 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -294,25 +294,14 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
> >             section->offset_within_address_space & (1ULL << 63);
> >  }
> >  
> > -static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > +static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> > +                           bool *read_only)
> >  {
> > -    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> > -    VFIOContainer *container = giommu->container;
> > -    hwaddr iova = iotlb->iova + giommu->iommu_offset;
> >      MemoryRegion *mr;
> >      hwaddr xlat;
> >      hwaddr len = iotlb->addr_mask + 1;
> > -    void *vaddr;
> > -    int ret;
> > -
> > -    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
> > -                                iova, iova + iotlb->addr_mask);
> > -
> > -    if (iotlb->target_as != &address_space_memory) {
> > -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> > -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> > -        return;
> > -    }
> > +    bool ret = false;
> > +    bool writable = iotlb->perm & IOMMU_WO;
> >  
> >      /*
> >       * The IOMMU TLB entry we have just covers translation through
> > @@ -322,12 +311,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> >      rcu_read_lock();
> >      mr = address_space_translate(&address_space_memory,
> >                                   iotlb->translated_addr,
> > -                                 &xlat, &len, iotlb->perm & IOMMU_WO);
> > +                                 &xlat, &len, writable);
> >      if (!memory_region_is_ram(mr)) {
> >          error_report("iommu map to non memory area %"HWADDR_PRIx"",
> >                       xlat);
> >          goto out;
> >      }
> > +
> >      /*
> >       * Translation truncates length to the IOMMU page size,
> >       * check that it did not truncate too much.
> > @@ -337,11 +327,41 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> >          goto out;
> >      }
> >  
> > +    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> > +    *read_only = !writable || mr->readonly;
> > +    ret = true;
> > +
> > +out:
> > +    rcu_read_unlock();
> > +    return ret;
> > +}
> > +
> > +static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > +{
> > +    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> > +    VFIOContainer *container = giommu->container;
> > +    hwaddr iova = iotlb->iova + giommu->iommu_offset;
> > +    bool read_only;
> > +    void *vaddr;
> > +    int ret;
> > +
> > +    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
> > +                                iova, iova + iotlb->addr_mask);
> > +
> > +    if (iotlb->target_as != &address_space_memory) {
> > +        error_report("Wrong target AS \"%s\", only system memory is allowed",
> > +                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> > +        return;
> > +    }
> > +
> > +    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > +        return;
> > +    }
> > +
> >      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> > -        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> >          ret = vfio_dma_map(container, iova,
> >                             iotlb->addr_mask + 1, vaddr,
> > -                           !(iotlb->perm & IOMMU_WO) || mr->readonly);
> > +                           read_only);
> 
> Is it really valid to move the map ioctl out of the rcu read lock?
> We're making use of vaddr, which is directly a property of a
> MemoryRegion which may have now disappeared.  With the lock released,
> could an unmap race the map resulting in the wrong ordering?  As noted
> previously, there are some subtle changes here, we do the
> memory_region_get_ram_ptr() translation on both map and unmap (fixed in
> next patch) and then pull map out of the rcu lock.  I'm not sure the
> extra function is worthwhile or really has no functional change.
> Thanks,

Thanks for raising this question up.

IIUC this function can be triggered by three cases (this is for x86, I
suppose the rule should be same for all platforms):

- memory hot add/remove
- a PSI (page selective invalidation) for a newly mapped io page
- a domain switch (needs a iommu replay)

IMHO all these places are protected by the QBL (both 2nd/3rd cases
should be invoked in VT-d IOMMU MMIO write to queue invalidation
registers)? And I thought BQL should be regarded as a write lock even
stronger than RCU read lock?

If I understand it correctly above, looks like we should be safe here
as long as we are always with BQL? And, if so, do we really need RCU
read protection here?

Please kindly correct if I missed anything.

Thanks,

-- peterx
