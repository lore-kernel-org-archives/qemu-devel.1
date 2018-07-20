Received: from eggs.gnu.org ([2001:4830:134:3::10]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgLb0-00030R-Fn
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgLav-0007cz-KI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:56:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgLav-0007cN-CZ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:56:37 -0400
Date: Fri, 20 Jul 2018 10:56:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720025630.GM4071@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180718064803.GA6197@xz-mi> <20180718103133.73dc74a1@t450s.home>
	<20180719054051.GE4071@xz-mi> <20180719090146.1f4303b6@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719090146.1f4303b6@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, Jul 19, 2018 at 09:01:46AM -0600, Alex Williamson wrote:
> On Thu, 19 Jul 2018 13:40:51 +0800
> Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Jul 18, 2018 at 10:31:33AM -0600, Alex Williamson wrote:
> > > On Wed, 18 Jul 2018 14:48:03 +0800
> > > Peter Xu <peterx@redhat.com> wrote:
> > > > I'm wondering what if want to do that somehow some day... Whether
> > > > it'll work if we just let vfio-pci devices to register some guest
> > > > memory invalidation hook (just like the iommu notifiers, but for guest
> > > > memory address space instead), then we map/unmap the IOMMU pages there
> > > > for vfio-pci device to make sure the inflated balloon pages are not
> > > > mapped and also make sure new pages are remapped with correct HPA
> > > > after deflated.  This is a pure question out of my curiosity, and for
> > > > sure it makes little sense if the answer of the first question above
> > > > is positive.  
> > > 
> > > This is why I mention the KVM MMU synchronization flag above.  KVM
> > > essentially had this same problem and fixed it with with MMU notifiers
> > > in the kernel.  They expose that KVM has the capability of handling
> > > such a scenario via a feature flag.  We can do the same with vfio.  In
> > > scenarios where we're able to fix this, we could expose a flag on the
> > > container indicating support for the same sort of thing.  
> > 
> > Sorry I didn't really caught that point when reply.  So that's why we
> > have had the mmu notifiers... Hmm, glad to know that.
> > 
> > But I would guess that if we want that notifier for vfio it should be
> > in QEMU rather than the kernel one since kernel vfio driver should not
> > have enough information on the GPA address space, hence it might not
> > be able to rebuild the mapping when a new page is mapped?  While QEMU
> > should be able to get both GPA and HVA easily when the balloon device
> > wants to deflate a page. [1]
> 
> This is where the vfio IOMMU backend comes into play.  vfio devices
> make use of MemoryListeners to register the HVA to GPA translations
> within the AddressSpace of a device.  When we're using an IOMMU, we pin
> those HVAs in order to make the HPA static and insert the GPA to HPA
> mappings into the IOMMU.  When we don't have an IOMMU, the IOMMU
> backend is storing those HVA to GPA translations so that the mediated
> device vendor driver can make pinning requests.  The vendor driver
> requests pinning of a given set of GPAs and the IOMMU backend pins the
> matching HVA to provide an HPA.
> 
> When a page is ballooned, it's zapped from the process address space,
> so we need to invalidate the HVA to HPA mapping.  When the page is
> restored, we still have the correct HVA, but we need a notifier to tell
> us to put it back into play, re-pinning and inserting the mapping into
> the IOMMU if we have one.
> 
> In order for QEMU to do this, this ballooned page would need to be
> reflected in the memory API.  This would be quite simple, inserting a
> MemoryRegion overlapping the RAM page which is ballooned out and
> removing it when the balloon is deflated.  But we run into the same
> problems with mapping granularity.  In order to accommodate this new
> overlap, the memory API would first remove the previous mapping, split
> or truncate the region, then reinsert the result.  Just like if we tried
> to do this in the IOMMU, it's not atomic with respect to device DMA.  In
> order to achieve this model, the memory API would need to operate
> entirely on page size regions.  Now imagine that every MiB of guest RAM
> requires 256 ioctls to map (assuming 4KiB pages), 256K per GiB.  Clearly
> we'd want to use a larger granularity for efficiency.  If we allow the
> user to specify the granularity, perhaps abstracting that granularity
> as the size of a DIMM, suddenly we've moved from memory ballooning to
> memory hotplug, where the latter does make use of the memory API and
> has none of these issues AIUI.

I see.  Indeed pc-dimm seems to be more suitable here.  And I think I
better understand the awkwardness that the page granularity problem
has brought - since we need this page granularity to happen even for
the QEMU memory API then we'll possibly have 4k-sized memory regions
to fill up all the RAM address space.  It sounds a hard mission.

> 
> > > There are a few complications to this support though.  First ballooning
> > > works at page size granularity, but IOMMU mapping can make use of
> > > arbitrary superpage sizes and the IOMMU API only guarantees unmap
> > > granularity equal to the original mapping.  Therefore we cannot unmap
> > > individual pages unless we require that all mappings through the IOMMU
> > > API are done with page granularity, precluding the use of superpages by
> > > the IOMMU and thereby inflicting higher IOTLB overhead.  Unlike a CPU,
> > > we can't invalidate the mappings and fault them back in or halt the
> > > processor to make the page table updates appear atomic.  The device is
> > > considered always running and interfering with that would likely lead
> > > to functional issues.  
> > 
> > Indeed.  Actually VT-d emulation bug was fixed just months ago where
> > the QEMU shadow page code for the device quickly unmapped the pages
> > and rebuilt the pages, but within the window we see DMA happened hence
> > DMA error on missing page entries.  I wish I have had learnt that
> > earlier from you!  Then the bug would be even more obvious to me.
> > 
> > And I would guess that if we want to do that in the future, the
> > easiest way as the first step would be that we just tell vfio to avoid
> > using huge pages when we see balloon devices.  It might be an
> > understandable cost at least to me to use both vfio-pci and the
> > balloon device.
> 
> There are a couple problem there though, first if we decide to use
> smaller pages for any case where we have a balloon device (a device
> that libvirt adds by default and requires manually editing the XML to
> remove), we introduce a performance regression for pretty much every
> existing VM as we restrict the IOMMU from making use of superpages and
> therefore depend far more on the IOTLB.  Second, QEMU doesn't have
> control of the mapping page size.  The vfio MAP_DMA ioctl simply takes
> a virtual address, IOVA (GPA) and size, the IOMMU gets to map this
> however it finds most efficient and the API requires unmapping with a
> minimum granularity matching the original mapping.  So again, the only
> way QEMU can get page size unmapping granularity is to perform only
> page sized mappings.  We could add a mapping flag to specify page size
> mapping and therefore page granularity unmapping, but that's a new
> contract (ie. API) between the user and vfio that comes with a
> performance penalty.  There is currently a vfio_iommu_type1 module
> option which disables IOMMU superpage support globally, but we don't
> have per instance control with the current APIs.

IIRC there were similar requests before to allow userspace to specify
page sizes to be used by vfio IOMMU backends but it didn't make it at
last.  But now I understand that this IOMMU page granularity problem
within the vfio IOMMU backend is a separate one to be settled
comparing to the one you mentioned in QEMU memory API.

(Though I also feel uncertain on whether libvirt should at least
 provide a simpler interface to allow the guest to disable the default
 balloon device...)

Thanks,

-- 
Peter Xu
