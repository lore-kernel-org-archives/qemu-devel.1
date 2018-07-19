Received: from eggs.gnu.org ([2001:4830:134:3::10]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg1gT-0001bc-Rl
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg1gQ-0006f7-Ox
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:41:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fg1gQ-0006ew-Jh
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:40:58 -0400
Date: Thu, 19 Jul 2018 13:40:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180719054051.GE4071@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180718064803.GA6197@xz-mi> <20180718103133.73dc74a1@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718103133.73dc74a1@t450s.home>
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

On Wed, Jul 18, 2018 at 10:31:33AM -0600, Alex Williamson wrote:
> On Wed, 18 Jul 2018 14:48:03 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:
> > > Directly assigned vfio devices have never been compatible with
> > > ballooning.  Zapping MADV_DONTNEED pages happens completely
> > > independent of vfio page pinning and IOMMU mapping, leaving us with
> > > inconsistent GPA to HPA mapping between vCPUs and assigned devices
> > > when the balloon deflates.  Mediated devices can theoretically do
> > > better, if we make the assumption that the mdev vendor driver is fully
> > > synchronized to the actual working set of the guest driver.  In that
> > > case the guest balloon driver should never be able to allocate an mdev
> > > pinned page for balloon inflation.  Unfortunately, QEMU can't know the
> > > workings of the vendor driver pinning, and doesn't actually know the
> > > difference between mdev devices and directly assigned devices.  Until
> > > we can sort out how the vfio IOMMU backend can tell us if ballooning
> > > is safe, the best approach is to disabling ballooning any time a vfio
> > > devices is attached.
> > > 
> > > To do that, simply make the balloon inhibitor a counter rather than a
> > > boolean, fixup a case where KVM can then simply use the inhibit
> > > interface, and inhibit ballooning any time a vfio device is attached.
> > > I'm expecting we'll expose some sort of flag similar to
> > > KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
> > > this.  An addition we could consider here would be yet another device
> > > option for vfio, such as x-disable-balloon-inhibit, in case there are
> > > mdev devices that behave in a manner compatible with ballooning.
> > > 
> > > Please let me know if this looks like a good idea.  Thanks,  
> > 
> > IMHO patches 1-2 are good cleanup as standalone patches...
> > 
> > I totally have no idea on whether people would like to use vfio-pci
> > and the balloon device at the same time.  After all vfio-pci are
> > majorly for performance players, then I would vaguely guess that they
> > don't really care thin provisioning of memory at all, hence the usage
> > scenario might not exist much.  Is that the major reason that we'd
> > just like to disable it (which makes sense to me)?
> 
> Well, the major reason for disabling it is that it currently doesn't
> work and when the balloon is deflated, the device and vCPU are talking
> to different host pages for the same GPA for previously ballooned
> pages.  Regardless of the amenability of device assignment to various
> usage scenarios, that's a bad thing.  I guess most device assignment
> users have either realized this doesn't work and avoid it, or perhaps
> they have VMs tuned more for performance than density and (again) don't
> use ballooning.

Makes sense to me.

>  
> > I'm wondering what if want to do that somehow some day... Whether
> > it'll work if we just let vfio-pci devices to register some guest
> > memory invalidation hook (just like the iommu notifiers, but for guest
> > memory address space instead), then we map/unmap the IOMMU pages there
> > for vfio-pci device to make sure the inflated balloon pages are not
> > mapped and also make sure new pages are remapped with correct HPA
> > after deflated.  This is a pure question out of my curiosity, and for
> > sure it makes little sense if the answer of the first question above
> > is positive.
> 
> This is why I mention the KVM MMU synchronization flag above.  KVM
> essentially had this same problem and fixed it with with MMU notifiers
> in the kernel.  They expose that KVM has the capability of handling
> such a scenario via a feature flag.  We can do the same with vfio.  In
> scenarios where we're able to fix this, we could expose a flag on the
> container indicating support for the same sort of thing.

Sorry I didn't really caught that point when reply.  So that's why we
have had the mmu notifiers... Hmm, glad to know that.

But I would guess that if we want that notifier for vfio it should be
in QEMU rather than the kernel one since kernel vfio driver should not
have enough information on the GPA address space, hence it might not
be able to rebuild the mapping when a new page is mapped?  While QEMU
should be able to get both GPA and HVA easily when the balloon device
wants to deflate a page. [1]

> 
> There are a few complications to this support though.  First ballooning
> works at page size granularity, but IOMMU mapping can make use of
> arbitrary superpage sizes and the IOMMU API only guarantees unmap
> granularity equal to the original mapping.  Therefore we cannot unmap
> individual pages unless we require that all mappings through the IOMMU
> API are done with page granularity, precluding the use of superpages by
> the IOMMU and thereby inflicting higher IOTLB overhead.  Unlike a CPU,
> we can't invalidate the mappings and fault them back in or halt the
> processor to make the page table updates appear atomic.  The device is
> considered always running and interfering with that would likely lead
> to functional issues.

Indeed.  Actually VT-d emulation bug was fixed just months ago where
the QEMU shadow page code for the device quickly unmapped the pages
and rebuilt the pages, but within the window we see DMA happened hence
DMA error on missing page entries.  I wish I have had learnt that
earlier from you!  Then the bug would be even more obvious to me.

And I would guess that if we want to do that in the future, the
easiest way as the first step would be that we just tell vfio to avoid
using huge pages when we see balloon devices.  It might be an
understandable cost at least to me to use both vfio-pci and the
balloon device.

> 
> Second MMU notifiers seem to provide invalidation, pte change notices,
> and page aging interfaces, so if a page is consumed by the balloon
> inflating, we can invalidate it (modulo the issues in the previous
> paragraph), but how do we re-populate the mapping through the IOMMU
> when the page is released as the balloon is deflated?  KVM seems to do
> this by handling the page fault, but we don't really have that option
> for devices.  If we try to solve this only for mdev devices, we can
> request invalidation down the vendor driver with page granularity and
> we could assume a vendor driver that's well synchronized with the
> working set of the device would re-request a page if it was previously
> invalidated and becomes part of the working set.  But if we have that
> assumption, then we could also assume that such a vendor driver would
> never have a ballooning victim page in its working set and therefore we
> don't need to do anything.  Unfortunately without an audit, we can't
> really know the behavior of the vendor driver.  vfio-ccw might be an
> exception here since this entire class of devices doesn't really
> perform DMA and page pinning is done on a per transaction basis, aiui.

Could we just provide the MMU notifier in QEMU instead of kernel, as I
mentioned at [1] (no matter what we call it...)?  Basically when we
deflate the balloon we trigger that notifier, then we pass another new
VFIO_IOMMU_DMA_MAP down to vfio with correct GPA/HVA.  Would that
work?

> 
> The vIOMMU is yet another consideration as it can effectively define
> the working set for a device via the device AddressSpace.  If a
> ballooned request does not fall within the AddressSpace of any assigned
> device, it would be safe to balloon the page.  So long as we're not
> running in IOMMU passthrough mode, these should be distinctly separate
> sets, active DMA pages should not be ballooning targets.  However, I
> believe the current state of vIOMMU with assigned devices is that it's
> functional, but not in any way performant for this scenario.  We see
> massive performance degradation when trying to use vIOMMU for anything
> other than mostly static mappings, such as when using passthrough mode
> or using userspace drivers or nested guests with relatively static
> mappings.  So I don't know that it's a worthwhile return on investment
> if we were to test whether a balloon victim page falls within a
> device's AddressSpace as a further level of granularity.  Thanks,

Yeah, vIOMMU will be another story.  Maybe that could be the last
thing to consider.  AFAIU the only user of that (both vIOMMU and
vfio-pci) are NFV, and I don't think they need balloon at all, so
maybe we can just keep it disabled there.

Thanks for the details (as always)!  FWIW I'd agree this is the only
correct thing to do at least for me as a first step, no matter what's
our possible next move is.

Regards,

-- 
Peter Xu
