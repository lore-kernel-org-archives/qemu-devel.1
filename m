Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRYQA-0005hs-Vx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRYQ6-0007Uo-UT
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:04:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:21629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eRYQ6-0007TR-Ju
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:04:02 -0500
Date: Wed, 20 Dec 2017 14:47:30 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171220064730.GB7070@sky-dev>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218113531.GC4786@umbus.fritz.box>
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
Cc: Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com

On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > 
> > [...]
> > 
> > > I meant, in the current intel_iommu code, vtd_find_add_as() creates 1
> > > IOMMU MR and 1 AS per PCIe device, right?
> > 
> > I think this is the most tricky point - in QEMU IOMMU MR is not really
> > a 1:1 relationship to devices.  For Intel, it's true; for Power, it's
> > not.  On Power guests, one device's DMA address space can be splited
> > into different translation windows, while each window corresponds to
> > one IOMMU MR.
> 
> Right.
> 
> > So IMHO the real 1:1 mapping is between the device and its DMA address
> > space, rather than MRs.
> 
> That's not true either.  With both POWER and Intel, several devices
> can share a DMA address space: on POWER if they are in the same PE, on
> Intel if they are place in the same IOMMU domain.
> 
> On x86 and on POWER bare metal we generally try to make the minimum
> granularity for each PE/domain be a single function.  However, that
> may not be possible in the case of PCIe to PCI bridges, or
> multifunction devices where the functions aren't properly isolated
> from each other (e.g. function 0 debug registers which can affect
> other functions are quite common).
> 
> For POWER guests we only have one PE/domain per virtual host bridge.
> That's just a matter of implementation simplicity - if you want fine
> grained isolation you can just create more virtual host bridges.
> 
> > It's been a long time since when I drafted the patches.  I think at
> > least that should be a more general notifier mechanism comparing to
> > current IOMMUNotifier thing, which was bound to IOTLB notifies only.
> > AFAICT if we want to trap first-level translation changes, current
> > notifier is not even close to that interface - just see the definition
> > of IOMMUTLBEntry, it is tailored only for MAP/UNMAP of translation
> > addresses, not anything else.  And IMHO that's why it's tightly bound
> > to MemoryRegions, and that's the root problem.  The dynamic IOMMU MR
> > switching problem is related to this issue as well.
> 
> So, having read and thought a bunch more, I think I know where you
> need to start hooking this in.  The thing is the current qemu PCI DMA
> structure assumes that each device belongs to just a single PCI
> address space - that's what pci_device_iommu_address_space() returns.
> 
> For virt-SVM that's just not true.  IIUC, a virt-SVM capable device
> could simultaneously write to multiple process address spaces, since
> the process IDs actually go over the bus.

Correct.

> 
> So trying to hook notifiers at the AddressSpace OR MemoryRegion level
> just doesn't make sense - if we've picked a single addresss space for
> the device, we've already made a wrong step.

That's also why we want to have notifiers based on IOMMUObject(may be
not a suitable name, let me use it as the patch named).

> 
> Instead what you need I think is something like:
> pci_device_virtsvm_context().  virt-SVM capable devices would need to
> call that *before* calling pci_device_iommu_address_space ().  Well
> rather the virt-SVM capable DMA helpers would need to call that.
> 
> That would return a new VirtSVMContext (or something) object, which
> would roughly correspond to a single PASID table.  That's where the
> methods and notifiers for managing that would need to go.

Correct, pci_device_iommu_address_space() returns an AS and it is
a PCI address space. And if pci_device_virtsvm_context() is also
called in vfio_realize(), it may not return an AS since there may
be no 1st level translation page table bound.

So as you said, return a new VirtSVMContext, this VirtSVMContext can
hook some new notifiers. I think the IOMMUObject introduced in this patch
can meet the requirement. But it may be re-named.

So here it addressed the concern you raised before which is hook IOMMUObject
via a PCI address space. Regards to VirtSVMContext, it may be a replacement
of IOMMUObject. As it is related to PASID, I'm considering to name it as
IOMMUPasidContext or IOMMUPasidObject. So it would be an abstraction of all
the IOMMU PASID related operations.

Regards,
Yi L

> 
> > I am not sure current "get IOMMU object from address space" solution
> > would be best, maybe it's "too bigger a scope", I think it depends on
> > whether in the future we'll have some requirement in such a bigger
> > scope (say, something we want to trap from vIOMMU and deliver it to
> > host IOMMU which may not even be device-related?  I don't know).  Now
> > another alternative I am thinking is, whether we can provide a
> > per-device notifier, then it can be bound to PCIDevice rather than
> > MemoryRegions, then it will be in device scope.
> 
> I think that sounds like a version of what I've suggested above.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
