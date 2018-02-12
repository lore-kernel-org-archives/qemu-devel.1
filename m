Received: from eggs.gnu.org ([2001:4830:134:3::10]:52014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1elGdC-0002Dr-8B
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1elGd7-0005px-SV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:07:02 -0500
Date: Mon, 12 Feb 2018 09:06:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180212090653.42bdd2e2@w520.home>
In-Reply-To: <0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
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

On Mon, 12 Feb 2018 18:05:54 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 12/02/18 16:19, David Gibson wrote:
> > On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:  
> >> At the moment if vfio_memory_listener is registered in the system memory
> >> address space, it maps/unmaps every RAM memory region for DMA.
> >> It expects system page size aligned memory sections so vfio_dma_map
> >> would not fail and so far this has been the case. A mapping failure
> >> would be fatal. A side effect of such behavior is that some MMIO pages
> >> would not be mapped silently.
> >>
> >> However we are going to change MSIX BAR handling so we will end having
> >> non-aligned sections in vfio_memory_listener (more details is in
> >> the next patch) and vfio_dma_map will exit QEMU.
> >>
> >> In order to avoid fatal failures on what previously was not a failure and
> >> was just silently ignored, this checks the section alignment to
> >> the smallest supported IOMMU page size and prints an error if not aligned;
> >> it also prints an error if vfio_dma_map failed despite the page size check.
> >> Both errors are not fatal; only MMIO RAM regions are checked
> >> (aka "RAM device" regions).
> >>
> >> If the amount of errors printed is overwhelming, the MSIX relocation
> >> could be used to avoid excessive error output.
> >>
> >> This is unlikely to cause any behavioral change.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> > 
> > There are some relatively superficial problems noted below.
> > 
> > But more fundamentally, this feels like it's extending an existing
> > hack past the point of usefulness.
> > 
> > The explicit check for is_ram_device() here has always bothered me -
> > it's not like a real bus bridge magically knows whether a target
> > address maps to RAM or not.
> > 
> > What I think is really going on is that even for systems without an
> > IOMMU, it's not really true to say that the PCI address space maps
> > directly onto address_space_memory.  Instead, there's a large, but
> > much less than 2^64 sized, "upstream window" at address 0 on the PCI
> > bus, which is identity mapped to the system bus.  Details will vary
> > with the system, but in practice we expect nothing but RAM to be in
> > that window.  Addresses not within that window won't be mapped to the
> > system bus but will just be broadcast on the PCI bus and might be
> > picked up as a p2p transaction.  
> 
> Currently this p2p works only via the IOMMU, direct p2p is not possible as
> the guest needs to know physical MMIO addresses to make p2p work and it
> does not.

/me points to the Direct Translated P2P section of the ACS spec, though
it's as prone to spoofing by the device as ATS.  In any case, p2p
reflected from the IOMMU is still p2p and offloads the CPU even if
bandwidth suffers vs bare metal depending on if the data doubles back
over any links.  Thanks,

Alex
