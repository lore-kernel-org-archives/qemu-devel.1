Received: from eggs.gnu.org ([2001:4830:134:3::10]:58524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRwet-0003CM-Ev
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRweq-0008OY-Bj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:56:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:45859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eRwep-0008Mk-U7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:56:52 -0500
Date: Thu, 21 Dec 2017 16:40:19 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171221084019.GA13501@sky-dev>
References: <1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
	<20171220064730.GB7070@sky-dev>
	<20171220111816.GG5981@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220111816.GG5981@umbus.fritz.box>
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

On Wed, Dec 20, 2017 at 10:18:16PM +1100, David Gibson wrote:
> On Wed, Dec 20, 2017 at 02:47:30PM +0800, Liu, Yi L wrote:
> > On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> > > On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > > > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > > > 
> > > > 
[...]
> > > So, having read and thought a bunch more, I think I know where you
> > > need to start hooking this in.  The thing is the current qemu PCI DMA
> > > structure assumes that each device belongs to just a single PCI
> > > address space - that's what pci_device_iommu_address_space() returns.
> > > 
> > > For virt-SVM that's just not true.  IIUC, a virt-SVM capable device
> > > could simultaneously write to multiple process address spaces, since
> > > the process IDs actually go over the bus.
> > 
> > Correct.
> > 
> > > So trying to hook notifiers at the AddressSpace OR MemoryRegion level
> > > just doesn't make sense - if we've picked a single addresss space for
> > > the device, we've already made a wrong step.
> > 
> > That's also why we want to have notifiers based on IOMMUObject(may be
> > not a suitable name, let me use it as the patch named).
> 
> Right, I think "IOMMUObject" is a misleading name.
> 
> > > Instead what you need I think is something like:
> > > pci_device_virtsvm_context().  virt-SVM capable devices would need to
> > > call that *before* calling pci_device_iommu_address_space ().  Well
> > > rather the virt-SVM capable DMA helpers would need to call that.
> > > 
> > > That would return a new VirtSVMContext (or something) object, which
> > > would roughly correspond to a single PASID table.  That's where the
> > > methods and notifiers for managing that would need to go.
> > 
> > Correct, pci_device_iommu_address_space() returns an AS and it is
> > a PCI address space. And if pci_device_virtsvm_context() is also
> > called in vfio_realize(), it may not return an AS since there may
> > be no 1st level translation page table bound.
> > 
> > So as you said, return a new VirtSVMContext, this VirtSVMContext can
> > hook some new notifiers. I think the IOMMUObject introduced in this patch
> > can meet the requirement. But it may be re-named.
> 
> Ok.
> 
> > So here it addressed the concern you raised before which is hook IOMMUObject
> > via a PCI address space. Regards to VirtSVMContext, it may be a replacement
> > of IOMMUObject. As it is related to PASID, I'm considering to name it as
> > IOMMUPasidContext or IOMMUPasidObject. So it would be an abstraction of all
> > the IOMMU PASID related operations.
> 
> I'm ok with calling it a "PASID context".
> 
> Thinking about this some more, here are some extra observations:
> 
>  * I think each device needs both a PASID context and an ordinary
>    address space.  The PASID context would be used for bus
>    transactions which include a process id, the address space for
>    those that don't.

Correct. Also virt-SVM still needs the PCI Address space. And the PCI
Address space == Guest physical Address space. For virt-SVM, requires
pt mode to ensure the nested translation.

> 
>  * Theoretically, the PASID context could be modelled as an array/map
>    of AddressSpace objects for each process ID.  However, creating all

I also thought about creating AddressSpace objects for each process ID.
But I don't think we need to do it. My reason as below:

In theory, it is correct to have AddressSpace object for each process
virtual address space in Qemu, and this is what we are doing for PCI
address space so far. However, this is necessary when we want to mirror
the mapping to host. Each time there is mapping changed within the PCI
address space, we need to mirror it to host.

While for virt-SVM, we don't need to mirror the changes within the guest
process address space. The nested translation capability in HW brings us
a convenience. In nested translation, HW can access a guest PASID table
with a GPA(this is what Intel and AMD does, not sure about ARM, maybe or
maybe not). For VT-d and AMD-IOMMU, even any change in guest PASID table,
it is not necessary to mirror it to host. Based on the statements above,
there is a candidate function to be included in PASIDContext. It could be
bind_guest_pasid_table(). And be used to set the guest PASID Table to host
translation structure when guest finds a device is has SVM capability.

>    those AddressSpace objects in advance might be too expensive.  I
>    can see a couple of options to avoid this:
> 
> 1) Have the PASID context class include a 'translate' method similar
> to the one in IOMMUMemoryRegionClass, but taking a process ID as well
> as an address.  This would avoid creating extra AddressSpace objects,
> but might require duplicating a bunch of the translation code that
> already exists for AddressSpace.

Translation code actually walks the guest CR3 table to get a GVA->GPA map.
But it is not really required so far due to HW capability.

> 
> 2) "Lazily" create AddressSpace objects.  The generic part of the
> PASID aware DMA helper functions would use a cache of AddressSpace's
> for particular process IDs, using the AddressSpace (and MemoryRegion
> within) to translate accesses for a particular process ID.  However,
> these AddressSpace and MemoryRegion objects would only be created when
> the device first accesses that address space.  In the common case,
> where a single device is just being used by a single process or a
> small number, this should keep the number of AddressSpace objects
> relatively small.  Obviously the cache would need to be invalidated,
> cleaning up the AddressSpace objects, when the PASID table is altered.

This "Lazily" mechanism is not required. But I agree with the last statement.
When PASID Table altered, the cache should be invalidated. Additionally, the
cache for the mappings(GVA) within the guest process address space should also
be invalidated when there is change. This also calls for a candidate function
in PASIDContext. It could be svm_invalidate_tlb(). And be used to invalidate
GVA cache and also PASID entry cache.

> 
>  * I realize that the expected case here is with KVM, where the guest
>    controls the first level translation, but the host controls the
>    second level translation.  However, we should also be able to model

Yeah, this is the case. And to be accurate, both the 1st level and 2nd level
translation here happens on HW IOMMU. The 1st level page table is actually
like "linked" from guest. And the 2nd level page table is created/conrolled
by Qemu(with MAP/UNMAP).

>    the case where the guest controls both levels for the sake of full
>    system emulation.  I think understanding this case will lead to a
>    better design even for the simpler case.

Not sure if I got your point accurately. Let me try to reply based on
what I got. If guest enables virt-IOVA(DMA isolaton in guest scope) and
virt-SVM. I think this is a case which guest controls both 1st and 2nd
level translation.

For virt-IOVA, we need to mirror all the guest IOVA mapping to host(aka.
shadow). Current MemoryRegion based notifiers(MAP/UNMAP) should be enough.
Peter has already upstreamed it.

> 
> Do you have a plan for what the virt-SVM aware DMA functions will look
> like?

I think there are two candidates so far. This should be enough for VT-d and
AMD-IOMMU. For ARM-SMMU, it may need extra function.
* bind_guest_pasid_table()
* svm_invalidate_tlb()

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
Yi L
