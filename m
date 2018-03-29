Received: from eggs.gnu.org ([2001:4830:134:3::10]:59907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f1a1V-000756-E6
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f1a1R-0002tP-DK
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f1a1R-0002so-5G
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:03:29 -0400
Date: Thu, 29 Mar 2018 10:03:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180329100316.0812dbbe@t450s.home>
In-Reply-To: <2470338f-7824-d9c1-fb61-837d89764af2@redhat.com>
References: <20180322081837.21460-1-aik@ozlabs.ru>
	<6975e05c-da7a-5a96-4fb5-1234694136d0@redhat.com>
	<20180328161313.67c1a17c@w520.home>
	<2470338f-7824-d9c1-fb61-837d89764af2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio: Print address space address
 when cannot map MMIO for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On Thu, 29 Mar 2018 16:42:12 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 29/03/18 00:13, Alex Williamson wrote:
> > On Wed, 28 Mar 2018 23:03:23 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Alexey, Alex,
> >> On 22/03/18 09:18, Alexey Kardashevskiy wrote:  
> >>> The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions") added
> >>> an error message if a passed memory section address or size is not aligned
> >>> to the minimal IOMMU page size. However although it checks
> >>> offset_within_address_space for the alignment, offset_within_region is
> >>> printed instead which makes it harder to find out what device caused
> >>> the message so this replaces offset_within_region with
> >>> offset_within_address_space.
> >>>
> >>> While we are here, this replaces '..' with 'size=' (as the second number
> >>> is a size, not an end offset) and adds a memory region name.
> >>>
> >>> Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>    
> >> The patch indeed fixes the reported format issues.
> >>
> >> However I have some other concerns with the info that is reported to the
> >> end-user. See below.
> >>
> >> Assigning an e1000e device with a 64kB host, here are the traces I get:
> >>
> >> Region XXX is not aligned to 0x10000 and cannot be mapped for DMA
> >>
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a4808 size=0xb7f8
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e0050 size=0x3fb0
> >> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e4808 size=0xb7f8
> >>
> >> It took me some time to understand what happens but here is now my
> >> understanding:
> >>
> >> 1) When looking at vfio_pci_write_config() pdev->io_regions[bar].addr =
> >> bar_addr in vfio_sub_page_bar_update_mapping() I see the following values:
> >>
> >> UNMAPPED -> 0x0 ->UNMAPPED -> 0x100a0000 -> UNMAPPED -> 0x100a0000 ->
> >> UNMAPPED -> 0x100e0000
> >>
> >> vfio_sub_page_bar_update_mapping() create mrs with base bar at
> >> 0x100a0000 and 0x100e0000 successively, hence the
> >> vfio_listener_region_add on 0x100axxxx. Indeed, 0x0-0x50 msix-table mmio
> >> region induces some memory section at 0x100a0050 and 0x100e50 successively.
> >>
> >> However this is confusing for the end-user who only has access to the
> >> final mapping (0x100e0000) through lspi [1].
> >>
> >> 2) The changes in the size (0x3fb0 <-> 0xffb0) relate to the extension
> >> of the 16kB bar to 64kB in vfio_sub_page_bar_update_mapping
> >>
> >> 3) Also it happens that I have a virtio-scsi-pci device that is put just
> >> after the BAR3 at 0x100a4000 and 0x100e4000 successively. The device has
> >> its own msi-table and pba mmio regions[2]. As mmaps[0] is extended to
> >> 64kB (with prio 0), we have those MMIO regions which result in new
> >> memory sections, which cause vfio_listener_region_add calls. This
> >> typically explains why we get a warning on 0x100e4808 (0xb7f8). By the
> >> way I don't get why we don't have a trace for "0004:01:00.0 BAR 3
> >> mmaps[0]" 0x100e4040 size=0x7c0, ie. mmaps[0] space between
> >> virtio-scsi-pci msic-table and pba.
> >>
> >> So at the end of the day, my fear is all those info become really
> >> frightening and confusing for the end-user and even not relevant
> >> (0x100a0000 stuff). So I would rather simply remove the trace in 2.12
> >> until we find a place where we could generate a clear hint for the
> >> end-user, suggesting to relocate the msix bar.
> >>
> >> Thoughts?  
> > 
> > Yep, I think that's probably the right approach.  Everything works as
> > it should and nothing has worse access in 2.12 than it did in 2.11,
> > there's only the opportunity to make things better with msi-x
> > relocation and I don't think we want to error on the side of reporting
> > too many errors that users cannot understand in an attempt to advise
> > them of an unsupported option that might be better.  Let's remove the
> > error report for 2.12 and think about how we could make a concise
> > suggestion, once, while initializing the device.  Who's posting the
> > patch?  Thanks,
> > 
> > Alex
> > 
> > PS - Why isn't the firmware/kernel on aarch64 making an attempt to
> > align PCI resources on page boundaries?  
> 
> so according to Laszlo's input I understand virtio-scsi-pci region 1 is
> 4K and the spec only mandates a natural alignment.

Right, as I noted in the other thread, it's not a spec requirement,
more of a best practices feature.

>   Does
> > pci=realloc,resource_alignment=pci:ffffffff:ffffffff change it? (I'm
> > not sure if PCI_ANY_ID works for that option)  
> no, it does not.

Not entirely unexpected, and since you're dealing with a virtio-scsi
device it could certainly be your boot device, so firmware leaving it
unprogrammed (in order to allow the OS to program it with 64K
alignment) probably isn't an option either.

For this particular example, the firmware aligning BARs is a secondary
optimization.  Ignoring for a moment that this BAR is interrupted by an
MSI-X vector table emulation section, if BAR resources were 64K
aligned, then we could mmap the BAR through to a userspace driver in
the guest, just as the host firmware has allowed us to do for this L1
qemu instance.  However, since we do have the MSI-X vector table
splitting the BAR already, it wouldn't help us if the firmware had done
this optimization since we still need to relocate the MSI-X vector
table, and if we do that by extending this BAR, we "kill two birds".
However, trying to figure out how to do that automatically has many
perils, as we've seen, so the problem becomes how we can concisely
advise users when this might be an option to consider.  Perhaps we
should resurrect some of the code that attempted to do the "auto" part
of MSI-X relocation to simply advise when it might be useful.  Thanks,

Alex
