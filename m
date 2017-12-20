Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRYBs-0000lZ-C1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRYBo-0000ox-C7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:4655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eRYBn-0000ml-Sg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:49:16 -0500
Date: Wed, 20 Dec 2017 14:32:42 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171220063242.GA7070@sky-dev>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
	<20171116085709.GA5072@sky-dev>
	<20171218061442.GW7753@umbus.fritz.box>
	<20171218091735.GA6002@sky-dev>
	<20171218112218.GB4786@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218112218.GB4786@umbus.fritz.box>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, alex.williamson@redhat.com, pbonzini@redhat.com

On Mon, Dec 18, 2017 at 10:22:18PM +1100, David Gibson wrote:
> On Mon, Dec 18, 2017 at 05:17:35PM +0800, Liu, Yi L wrote:
> > On Mon, Dec 18, 2017 at 05:14:42PM +1100, David Gibson wrote:
> > > On Thu, Nov 16, 2017 at 04:57:09PM +0800, Liu, Yi L wrote:
> > > > Hi David,
> > > > 
> > > > On Tue, Nov 14, 2017 at 11:59:34AM +1100, David Gibson wrote:
> > > > > On Mon, Nov 13, 2017 at 04:28:45PM +0800, Peter Xu wrote:
> > > > > > On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
> > > > > > > On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> > > > > > > > From: Peter Xu <peterx@redhat.com>
> > > > > > > > 
> > > > > > > > AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> > > > > > > > spaces to store arch-specific hooks.
> > > > > > > > 
> > > > > > > > The first hook I would like to introduce is iommu_get(). Return an
> > > > > > > > IOMMUObject behind the AddressSpace.
> > > > > > > > 
> > > > > > > > For systems that have IOMMUs, we will create a special address
> > > > > > > > space per device which is different from system default address
> > > > > > > > space for it (please refer to pci_device_iommu_address_space()).
> > > > > > > > Normally when that happens, there will be one specific IOMMU (or
> > > > > > > > say, translation unit) stands right behind that new address space.
> > > > > > > > 
> > > > > > > > This iommu_get() fetches that guy behind the address space. Here,
> > > > > > > > the guy is defined as IOMMUObject, which includes a notifier_list
> > > > > > > > so far, may extend in future. Along with IOMMUObject, a new iommu
> > > > > > > > notifier mechanism is introduced. It would be used for virt-svm.
> > > > > > > > Also IOMMUObject can further have a IOMMUObjectOps which is similar
> > > > > > > > to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> > > > > > > > on MemoryRegion.
> > > > > > > > 
> > > > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > > > > > 
> > > > > > > Hi, sorry I didn't reply to the earlier postings of this after our
> > > > > > > discussion in China.  I've been sick several times and very busy.
> > > > > > > 
> > > > > > > I still don't feel like there's an adequate explanation of exactly
> > > > > > > what an IOMMUObject represents.   Obviously it can represent more than
> > > > > > > a single translation window - since that's represented by the
> > > > > > > IOMMUMR.  But what exactly do all the MRs - or whatever else - that
> > > > > > > are represented by the IOMMUObject have in common, from a functional
> > > > > > > point of view.
> > > > > > > 
> > > > > > > Even understanding the SVM stuff better than I did, I don't really see
> > > > > > > why an AddressSpace is an obvious unit to have an IOMMUObject
> > > > > > > associated with it.
> > > > > > 
> > > > > > Here's what I thought about it: IOMMUObject was planned to be the
> > > > > > abstraction of the hardware translation unit, which is a higher level
> > > > > > of the translated address spaces.  Say, for each PCI device, it can
> > > > > > have its own translated address space.  However for multiple PCI
> > > > > > devices, they can be sharing the same translation unit that handles
> > > > > > the translation requests from different devices.  That's the case for
> > > > > > Intel platforms.  We introduced this IOMMUObject because sometimes we
> > > > > > want to do something with that translation unit rather than a specific
> > > > > > device, in which we need a general IOMMU device handle.
> > > > > 
> > > > > Ok, but what does "hardware translation unit" mean in practice.  The
> > > > > guest neither knows nor cares, which bits of IOMMU translation happen
> > > > > to be included in the same bundle of silicon.  It only cares what the
> > > > > behaviour is.  What behavioural characteristics does a single
> > > > > IOMMUObject have?
> > > > > 
> > > > > > IIRC one issue left over during last time's discussion was that there
> > > > > > could be more complicated IOMMU models. E.g., one device's DMA request
> > > > > > can be translated nestedly by two or multiple IOMMUs, and current
> > > > > > proposal cannot really handle that complicated hierachy.  I'm just
> > > > > > thinking whether we can start from a simple model (say, we don't allow
> > > > > > nested IOMMUs, and actually we don't even allow multiple IOMMUs so
> > > > > > far), then we can evolve from that point in the future.
> > > > > > 
> > > > > > Also, I thought there were something you mentioned that this approach
> > > > > > is not correct for Power systems, but I can't really remember the
> > > > > > details...  Anyways, I think this is not the only approach to solve
> > > > > > the problem, and I believe any new better idea would be greatly
> > > > > > welcomed as well. :)
> > > > > 
> > > > > So, some of my initial comments were based on a misunderstanding of
> > > > > what was proposed here - since discussing this with Yi at LinuxCon
> > > > > Beijing, I have a better idea of what's going on.
> > > > > 
> > > > > On POWER - or rather the "pseries" platform, which is paravirtualized.
> > > > > We can have multiple vIOMMU windows (usually 2) for a single virtual
> > > > 
> > > > On POWER, the DMA isolation is done by allocating different DMA window
> > > > to different isolation domains? And a single isolation domain may include
> > > > multiple dma windows? So with or withou IOMMU, there is only a single
> > > > DMA address shared by all the devices in the system? The isolation 
> > > > mechanism is as what described above?
> > > 
> > > No, the multiple windows are completely unrelated to how things are
> > > isolated.
> > 
> > I'm afraid I chose a wrong word by using "DMA window"..
> > Actually, when mentioning "DMA window", I mean address ranges in an iova
> > address space.
> 
> Yes, so did I.  My one window I mean one contiguous range of IOVA addresses.
> 
> > Anyhow, let me re-shape my understanding of POWER IOMMU and
> > make sure we are in the same page.
> > 
> > > 
> > > Just like on x86, each IOMMU domain has independent IOMMU mappings.
> > > The only difference is that IBM calls the domains "partitionable
> > > endpoints" (PEs) and they tend to be statically created at boot time,
> > > rather than runtime generated.
> > 
> > Does POWER IOMMU also have iova concept? Device can use an iova to
> > access memory, and IOMMU translates the iova to an address within the
> > system physical address?
> 
> Yes.  When I say the "PCI address space" I mean the IOVA space.
> 
> > > The windows are about what addresses in PCI space are translated by
> > > the IOMMU.  If the device generates a PCI cycle, only certain
> > > addresses will be mapped by the IOMMU to DMA - other addresses will
> > > correspond to other devices MMIOs, MSI vectors, maybe other things.
> > 
> > I guess the windows you mentioned here is the address ranges within the
> > system physical address space as you also mentioned MMIOs and etc.
> 
> No.  I mean ranges within the PCI space == IOVA space. It's simplest
> to understand with traditional PCI.  A cycle on the bus doesn't know
> whether the destination is a device or memory, it just has an address
> - a PCI memory address.  Part of that address range is mapped to
> system RAM, optionally with an IOMMU translating it.  Other parts of
> that address space are used for devices.
> 
> With PCI-E things get more complicated, but the conceptual model is
> the same.
> 
> > > The set of addresses translated by the IOMMU need not be contiguous.
> > 
> > I suppose you mean the output addresses of the IOMMU need not be
> > contiguous?
> 
> No.  I mean the input addresses of the IOMMU.
> 
> > > Or, there could be two IOMMUs on the bus, each accepting different
> > > address ranges.  These two situations are not distinguishable from the
> > > guest's point of view.
> > > 
> > > So for a typical PAPR setup, the device can access system RAM either
> > > via DMA in the range 0..1GiB (the "32-bit window") or in the range
> > > 2^59..2^59+<something> (the "64-bit window").  Typically the 32-bit
> > > window has mappings dynamically created by drivers, and the 64-bit
> > > window has all of system RAM mapped 1:1, but that's entirely up to the
> > > OS, it can map each window however it wants.
> > > 
> > > 32-bit devices (or "64 bit" devices which don't actually implement
> > > enough the address bits) will only be able to use the 32-bit window,
> > > of course.
> > > 
> > > MMIOs of other devices, the "magic" MSI-X addresses belonging to the
> > > host bridge and other things exist outside those ranges.  Those are
> > > just the ranges which are used to DMA to RAM.
> > > 
> > > Each PE (domain) can see a different version of what's in each
> > > window.
> > 
> > If I'm correct so far. PE actually defines a mapping between an address
> > range of an address space(aka. iova address space) and an address range
> > of the system physical address space.
> 
> No.  A PE means several things, but basically it is an isolation
> domain, like an Intel IOMMU domain.  Each PE has an independent set of
> IOMMU mappings which translate part of the PCI address space to system
> memory space.
> 
> > Then my question is: does each PE define a separate iova address sapce
> > which is flat from 0 - 2^AW -1, AW is address width? As a reference,
> > VT-d domain defines a flat address space for each domain.
> 
> Partly.  Each PE has an address space which all devices in the PE see.
> Only some of that address space is mapped to system memory though,
> other parts are occupied by devices, others are unmapped.
> 
> Only the parts mapped by the IOMMU vary between PEs - the other parts
> of the address space will be identical for all PEs on the host

Thx, this comment addressed me well. This is different from what we have
on VT-d.

> bridge.  However for POWER guests (not for hosts) there is exactly one
> PE for each virtual host bridge.
> 
> > > In fact, if I understand the "IO hole" correctly, the situation on x86
> > > isn't very different.  It has a window below the IO hole and a second
> > > window above the IO hole.  The addresses within the IO hole go to
> > > (32-bit) devices on the PCI bus, rather than being translated by the
> > 
> > If you mean the "IO hole" within the system physcial address space, I think
> > it's yes.
> 
> Well, really I mean the IO hole in PCI address space.  Because system
> address space and PCI memory space were traditionally identity mapped
> on x86 this is easy to confuse though.
> 
> > > IOMMU to RAM addresses.  Because the gap is smaller between the two
> > > windows, I think we get away without really modelling this detail in
> > > qemu though.
> > > 
> > > > > PCI host bridge.  Because of the paravirtualization, the mapping to
> > > > > hardware is fuzzy, but for passthrough devices they will both be
> > > > > implemented by the IOMMU built into the physical host bridge.  That
> > > > > isn't importat to the guest, though - all operations happen at the
> > > > > window level.
> > > > 
> > > > On VT-d, with IOMMU presented, each isolation domain has its own address
> > > > space. That's why we talked more on address space level. And iommu makes
> > > > the difference. That's the behavioural characteristics a single iommu
> > > > translation unit has. And thus an IOMMUObject going to have.
> > > 
> > > Right, that's the same on POWER.  But the IOMMU only translates *some*
> > > addresses within the address space, not all of them.  The rest will go
> > > to other PCI devices or be unmapped, but won't go to RAM.
> > > 
> > > That's why the IOMMU should really be associated with an MR (or
> > > several MRs), not an AddressSpace, it only translates some addresses.
> > 
> > If I'm correct so far, I do believe the major difference between VT-d and
> > POWER IOMMU is that VT-d isolation domain is a flat address space while
> > PE of POWER is something different(need your input here as I'm not sure about
> > it). Maybe it's like there is a flat address space, each PE takes some address
> > ranges and maps the address ranges to different system physcial address ranges.
> 
> No, it's really not that different.  In both cases (without virt-SVM)
> there's a system memory address space, and a PCI address space for
> each domain / PE.  There are one or more "outbound" windows in system
> memory space that map system memory cycles to PCI cycles (used by the
> CPU to access MMIO) and one or more "inbound" (DMA) windows in PCI
> memory space which map PCI cycles onto system memory cycles (used by
> devices to access system memory).
> 
> On old-style PCs, both inbound and outbound windows were (mostly)
> identity maps.  On POWER they are not.
> 
> > > > > The other thing that bothers me here is the way it's attached to an
> > > > > AddressSpace.
> > > > 
> > > > My consideration is iommu handles AddressSpaces. dma address space is also
> > > > an address space managed by iommu.
> > > 
> > > No, it's not.  It's a region (or several) within the overall PCI
> > > address space.  Other things in the addressspace, such as other
> > > device's BARs exist independent of the IOMMU.
> > > 
> > > It's not something that could really work with PCI-E, I think, but
> > > with a more traditional PCI bus there's no reason you couldn't have
> > > multiple IOMMUs listening on different regions of the PCI address
> > > space.
> > 
> > I think the point here is on POWER, the input addresses of IOMMUs are actaully
> > in the same address space?
> 
> I'm not sure what you mean, but I don't think so.  Each PE has its own
> IOMMU input address space.
> 
> > What IOMMU does is mapping the different ranges to
> > different system physcial address ranges. So it's as you mentioned, multiple
> > IOMMUs listen on different regions of a PCI address space.
> 
> No.  That could be the case in theory, but it's not the usual case.
> 
> Or rather it depends what you mean by "an IOMMU".  For PAPR guests,
> both IOVA 0..1GiB and 2^59..(somewhere) are mapped to system memory,
> but with separate page tables.  You could consider that two IOMMUs (we
> mostly treat it that way in qemu).  However, all the mapping is
> handled by the same host bridge with 2 sets of page tables per PE, so
> you could also call it one IOMMU.
> 
> This is what I'm getting at when I say that "one IOMMU" is not a
> clearly defined unit.
> 
> > While for VT-d, it's not the case. The input addresses of IOMMUs may not
> > in the same address sapce. As I mentioned, each IOMMU domain on VT-d is a
> > separate address space. So for VT-d, IOMMUs are actually listening to different
> > address spaces. That's the point why we want to have address space level
> > abstraction of IOMMU.
> > 
> > > 
> > > > That's why we believe it is fine to
> > > > associate dma address space with an IOMMUObject.
> > > 
> > > > >  IIUC how SVM works, the whole point is that the device
> > > > > no longer writes into a specific PCI address space.  Instead, it
> > > > > writes directly into a process address space.  So it seems to me more
> > > > > that SVM should operate at the PCI level, and disassociate the device
> > > > > from the normal PCI address space entirely, rather than hooking up
> > > > > something via that address space.

After thinking more, I agree that it is not suitable to hook up something for
1st level via the PCI address space. In the time 1st and 2nd level translation
is exposed to guest, a device would write to multiple address spaces. PCI address
space is only one of them. I think your reply in another email is a good start,
let me reply my thoughts under that email.

Regards,
Yi L

> > > > 
> > > > As Peter replied, we still need the PCI address space, it would be used
> > > > to build up the 2nd level page table which would be used in nested
> > > > translation.
> > > > 
> > > > Thanks,
> > > > Yi L
> > > > 
> > > > > 
> > > > 
> > > 
> > 
> > Regards,
> > Yi L
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
