Received: from eggs.gnu.org ([2001:4830:134:3::10]:34290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eERwU-0005eF-RC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eERwR-0002pl-Lp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:31:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eERwR-0002n6-Au
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:31:15 -0500
Date: Tue, 14 Nov 2017 11:31:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171114033100.GA6821@xz-mi>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171114005934.GD32308@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Tue, Nov 14, 2017 at 11:59:34AM +1100, David Gibson wrote:
> On Mon, Nov 13, 2017 at 04:28:45PM +0800, Peter Xu wrote:
> > On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
> > > On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > 
> > > > AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> > > > spaces to store arch-specific hooks.
> > > > 
> > > > The first hook I would like to introduce is iommu_get(). Return an
> > > > IOMMUObject behind the AddressSpace.
> > > > 
> > > > For systems that have IOMMUs, we will create a special address
> > > > space per device which is different from system default address
> > > > space for it (please refer to pci_device_iommu_address_space()).
> > > > Normally when that happens, there will be one specific IOMMU (or
> > > > say, translation unit) stands right behind that new address space.
> > > > 
> > > > This iommu_get() fetches that guy behind the address space. Here,
> > > > the guy is defined as IOMMUObject, which includes a notifier_list
> > > > so far, may extend in future. Along with IOMMUObject, a new iommu
> > > > notifier mechanism is introduced. It would be used for virt-svm.
> > > > Also IOMMUObject can further have a IOMMUObjectOps which is similar
> > > > to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> > > > on MemoryRegion.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > 
> > > Hi, sorry I didn't reply to the earlier postings of this after our
> > > discussion in China.  I've been sick several times and very busy.
> > > 
> > > I still don't feel like there's an adequate explanation of exactly
> > > what an IOMMUObject represents.   Obviously it can represent more than
> > > a single translation window - since that's represented by the
> > > IOMMUMR.  But what exactly do all the MRs - or whatever else - that
> > > are represented by the IOMMUObject have in common, from a functional
> > > point of view.
> > > 
> > > Even understanding the SVM stuff better than I did, I don't really see
> > > why an AddressSpace is an obvious unit to have an IOMMUObject
> > > associated with it.
> > 
> > Here's what I thought about it: IOMMUObject was planned to be the
> > abstraction of the hardware translation unit, which is a higher level
> > of the translated address spaces.  Say, for each PCI device, it can
> > have its own translated address space.  However for multiple PCI
> > devices, they can be sharing the same translation unit that handles
> > the translation requests from different devices.  That's the case for
> > Intel platforms.  We introduced this IOMMUObject because sometimes we
> > want to do something with that translation unit rather than a specific
> > device, in which we need a general IOMMU device handle.
> 
> Ok, but what does "hardware translation unit" mean in practice.  The
> guest neither knows nor cares, which bits of IOMMU translation happen
> to be included in the same bundle of silicon.  It only cares what the
> behaviour is.  What behavioural characteristics does a single
> IOMMUObject have?

In VT-d (I believe the same to ARM SMMUs), IMHO the special thing is
that the translation windows (and device address spaces in QEMU) are
only talking about second level translations, but not first level,
while virt-svm needs to play with first level translations.  Until
now, AFAIU we don't really have a good interface for first level
translations at all (aka. the process address space).

> 
> > IIRC one issue left over during last time's discussion was that there
> > could be more complicated IOMMU models. E.g., one device's DMA request
> > can be translated nestedly by two or multiple IOMMUs, and current
> > proposal cannot really handle that complicated hierachy.  I'm just
> > thinking whether we can start from a simple model (say, we don't allow
> > nested IOMMUs, and actually we don't even allow multiple IOMMUs so
> > far), then we can evolve from that point in the future.
> > 
> > Also, I thought there were something you mentioned that this approach
> > is not correct for Power systems, but I can't really remember the
> > details...  Anyways, I think this is not the only approach to solve
> > the problem, and I believe any new better idea would be greatly
> > welcomed as well. :)
> 
> So, some of my initial comments were based on a misunderstanding of
> what was proposed here - since discussing this with Yi at LinuxCon
> Beijing, I have a better idea of what's going on.
> 
> On POWER - or rather the "pseries" platform, which is paravirtualized.
> We can have multiple vIOMMU windows (usually 2) for a single virtual
> PCI host bridge.  Because of the paravirtualization, the mapping to
> hardware is fuzzy, but for passthrough devices they will both be
> implemented by the IOMMU built into the physical host bridge.  That
> isn't importat to the guest, though - all operations happen at the
> window level.

Now I know that for Power it may not have anything like a "translation
unit" but everything is defined as "translation windows" in the
guests.  However the problem still exist for some other platforms.
Say, for Intel we have emulated VT-d; for ARM, we have vSMMU.  AFAIU
these platforms do have their translation units, and even for ARM it
should need such an interface (or any better interfaces, which are
always welcomed) for virt-svm to work.  Otherwise I don't know a way
to configure the first level translation tables.

Meanwhile, IMO this abstraction should not really affect pseries - it
should be only useful for those platforms who would like to use it.
For pseries, we can just ignore that new interface if we don't really
even have such a translation unit.

> 
> The other thing that bothers me here is the way it's attached to an
> AddressSpace.  IIUC how SVM works, the whole point is that the device
> no longer writes into a specific PCI address space.  Instead, it
> writes directly into a process address space.  So it seems to me more
> that SVM should operate at the PCI level, and disassociate the device
> from the normal PCI address space entirely, rather than hooking up
> something via that address space.

IMO the PCI address space is still used.  For virt-svm, host IOMMU
will be working in nested translation mode, so we should be having two
mappings working in parallel:

  1. DPDK process (in guest) address space mapping (GVA -> GPA)
  2. guest direct memory mappings (GPA -> HPA)

And here AFAIU the 2nd mapping is working exactly like general PCI
devices, the only difference is that the 2nd level mapping is always
static, just like when IOMMU passthrough is enabled for that device.

So, IMHO virt-SVM is not really in parallel with PCI subsystem.  For
the SVM in guest, it may be different, since it should only be using
first level translations.  However to implement virt-SVM, IMHO we not
only need existing PCI address space translation logic, we also need
an extra way to configure the first level mappings, as discussed.

Thanks,

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Peter Xu
