Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1elzPQ-0007KY-Db
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1elzPM-0002gj-6e
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:55:48 -0500
Date: Wed, 14 Feb 2018 08:55:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180214085541.5491705f@w520.home>
In-Reply-To: <843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 14 Feb 2018 19:09:16 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 14/02/18 12:33, David Gibson wrote:
> > On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wrote:  
> >> On 13/02/18 16:41, David Gibson wrote:  
> >>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote:  
> >>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wrote:  
> >>>>> On 13/02/18 03:06, Alex Williamson wrote:  
> >>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>  
> >>>>>>> On 12/02/18 16:19, David Gibson wrote:  
> >>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:    
> >>>>>>>>> At the moment if vfio_memory_listener is registered in the system memory
> >>>>>>>>> address space, it maps/unmaps every RAM memory region for DMA.
> >>>>>>>>> It expects system page size aligned memory sections so vfio_dma_map
> >>>>>>>>> would not fail and so far this has been the case. A mapping failure
> >>>>>>>>> would be fatal. A side effect of such behavior is that some MMIO pages
> >>>>>>>>> would not be mapped silently.
> >>>>>>>>>
> >>>>>>>>> However we are going to change MSIX BAR handling so we will end having
> >>>>>>>>> non-aligned sections in vfio_memory_listener (more details is in
> >>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
> >>>>>>>>>
> >>>>>>>>> In order to avoid fatal failures on what previously was not a failure and
> >>>>>>>>> was just silently ignored, this checks the section alignment to
> >>>>>>>>> the smallest supported IOMMU page size and prints an error if not aligned;
> >>>>>>>>> it also prints an error if vfio_dma_map failed despite the page size check.
> >>>>>>>>> Both errors are not fatal; only MMIO RAM regions are checked
> >>>>>>>>> (aka "RAM device" regions).
> >>>>>>>>>
> >>>>>>>>> If the amount of errors printed is overwhelming, the MSIX relocation
> >>>>>>>>> could be used to avoid excessive error output.
> >>>>>>>>>
> >>>>>>>>> This is unlikely to cause any behavioral change.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>    
> >>>>>>>>
> >>>>>>>> There are some relatively superficial problems noted below.
> >>>>>>>>
> >>>>>>>> But more fundamentally, this feels like it's extending an existing
> >>>>>>>> hack past the point of usefulness.
> >>>>>>>>
> >>>>>>>> The explicit check for is_ram_device() here has always bothered me -
> >>>>>>>> it's not like a real bus bridge magically knows whether a target
> >>>>>>>> address maps to RAM or not.
> >>>>>>>>
> >>>>>>>> What I think is really going on is that even for systems without an
> >>>>>>>> IOMMU, it's not really true to say that the PCI address space maps
> >>>>>>>> directly onto address_space_memory.  Instead, there's a large, but
> >>>>>>>> much less than 2^64 sized, "upstream window" at address 0 on the PCI
> >>>>>>>> bus, which is identity mapped to the system bus.  Details will vary
> >>>>>>>> with the system, but in practice we expect nothing but RAM to be in
> >>>>>>>> that window.  Addresses not within that window won't be mapped to the
> >>>>>>>> system bus but will just be broadcast on the PCI bus and might be
> >>>>>>>> picked up as a p2p transaction.    
> >>>>>>>
> >>>>>>> Currently this p2p works only via the IOMMU, direct p2p is not possible as
> >>>>>>> the guest needs to know physical MMIO addresses to make p2p work and it
> >>>>>>> does not.  
> >>>>>>
> >>>>>> /me points to the Direct Translated P2P section of the ACS spec, though
> >>>>>> it's as prone to spoofing by the device as ATS.  In any case, p2p
> >>>>>> reflected from the IOMMU is still p2p and offloads the CPU even if
> >>>>>> bandwidth suffers vs bare metal depending on if the data doubles back
> >>>>>> over any links.  Thanks,  
> >>>>>
> >>>>> Sure, I was just saying that p2p via IOMMU won't be as simple as broadcast
> >>>>> on the PCI bus, IOMMU needs to be programmed in advance to make this work,
> >>>>> and current that broadcast won't work for the passed through devices.  
> >>>>
> >>>> Well, sure, p2p in a guest with passthrough devices clearly needs to
> >>>> be translated through the IOMMU (and p2p from a passthrough to an
> >>>> emulated device is essentially impossible).
> >>>>
> >>>> But.. what does that have to do with this code.  This is the memory
> >>>> area watcher, looking for memory regions being mapped directly into
> >>>> the PCI space.  NOT IOMMU regions, since those are handled separately
> >>>> by wiring up the IOMMU notifier.  This will only trigger if RAM-like,
> >>>> non-RAM regions are put into PCI space *not* behind an IOMMMU.  
> >>>
> >>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I guess
> >>> the point here is that this will map RAM-like devices into the host
> >>> IOMMU when there is no guest IOMMU, allowing p2p transactions between
> >>> passthrough devices (though not from passthrough to emulated devices).  
> >>
> >> Correct.
> >>  
> >>>
> >>> The conditions still seem kind of awkward to me, but I guess it makes
> >>> sense.  
> >>
> >> Is it the time to split this listener to RAM-listener and PCI bus listener?  
> > 
> > I'm not really sure what you mean by that.
> >   
> >> On x86 it listens on the "memory" AS, on spapr - on the
> >> "pci@800000020000000" AS, this will just create more confusion over time...  
> > 
> > Hm, it's still logically the same AS in each case - the PCI address
> > space.  It's just that in the x86 case that happens to be the same as
> > the memory AS (at least when there isn't a guest side IOMMU).  
> 
> Hm. Ok.
> 
> > I do wonder if that's really right even for x86 without IOMMU.  The
> > PCI address space is identity mapped to the "main" memory address
> > space there, but I'm not sure it's mapped th *all* of the main memory  
> 
> What should have been in the place of "th" above? :)
> 
> > address space, probably just certain ranges of it.  That's what I was
> > suggesting earlier in the thread.  
> 
> afaict vfio is trying to mmap every RAM MR == KVM memory slot, no ranges or
> anything like that. I am trying to figure out what is not correct with the
> patch. Thanks,

It is possible for x86 systems to have translation applied to MMIO vs
RAM such that the processor view and device view of MMIO are different,
putting them into separate address spaces, but this is not typical and
not available on the class of chipsets that QEMU emulates for PC.
Therefore I think it's correct that MMIO and RAM all live in one big
happy, flat address space as they do now (assuming the guest IOMMU is
not present or disabled).  Thanks,

Alex
