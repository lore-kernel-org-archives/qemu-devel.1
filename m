Received: from eggs.gnu.org ([2001:4830:134:3::10]:34637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQwOk-0000CS-Qg
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQwOj-0007Jd-KN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:28:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eQwOj-0007Ip-B2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:28:05 -0500
Date: Mon, 18 Dec 2017 07:28:00 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171218072800.58456558@w520.home>
In-Reply-To: <c472c115-3cfb-7ce0-62f3-13a026ccf02d@ozlabs.ru>
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050253.13478.49457.stgit@gimli.home>
	<f76b5d78-0107-cca8-5e72-ab9944c8a90b@ozlabs.ru>
	<20171218062822.625b7469@w520.home>
	<c472c115-3cfb-7ce0-62f3-13a026ccf02d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 5/5] vfio/pci: Allow relocating
 MSI-X MMIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com

On Tue, 19 Dec 2017 00:55:32 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 19/12/17 00:28, Alex Williamson wrote:
> > On Mon, 18 Dec 2017 20:04:23 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> On 18/12/17 16:02, Alex Williamson wrote:  
> >>> With recently proposed kernel side vfio-pci changes, the MSI-X vector
> >>> table area can be mmap'd from userspace, allowing direct access to
> >>> non-MSI-X registers within the host page size of this area.  However,
> >>> we only get that direct access if QEMU isn't also emulating MSI-X
> >>> within that same page.  For x86/64 host, the system page size is 4K
> >>> and the PCI spec recommends a minimum of 4K to 8K alignment to
> >>> separate MSI-X from non-MSI-X registers, therefore only devices which
> >>> don't honor this recommendation would see any improvement from this
> >>> option.  The real targets for this feature are hosts where the page
> >>> size exceeds the PCI spec recommended alignment, such as ARM64 systems
> >>> with 64K pages.
> >>>
> >>> This new x-msix-relocation option accepts the following options:
> >>>
> >>>   off: Disable MSI-X relocation, use native device config (default)
> >>>   auto: Automaically relocate MSI-X MMIO to another BAR or offset
> >>>        based on minimum additional MMIO requirement
> >>>   bar0..bar5: Specify the target BAR, which will either be extended
> >>>        if the BAR exists or added if the BAR slot is available.    
> >>
> >>
> >> While I am digesting the patchset, here are some test results.  
> > 
> > Thanks for testing!
> >   
> >> This is the device:
> >>
> >> 00:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
> >> PCI-Express Fusion-MPT SAS-3 (rev 02)  
> > 
> > BAR1:
> >   
> >> Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]  
> > 
> > BAR3:
> >   
> >> Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
> >>
> >> Capabilities: [c0] MSI-X: Enable+ Count=96 Masked-
> >>         Vector table: BAR=1 offset=0000e000
> >>         PBA: BAR=1 offset=0000f000
> >>
> >>
> >> Test #1: x-msix-relocation = "off":
> >>
> >> FlatView #1
> >>  AS "memory", root: system
> >>  AS "cpu-memory", root: system
> >>  Root memory region: system
> >>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>   0000210000000000-000021000000dfff (prio 0, i/o): 0001:03:00.0 BAR 1
> >>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
> >>   000021000000e600-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
> >> @000000000000e600
> >>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
> >>
> >> Ok, works.
> >>
> >>
> >> Test #2: x-msix-relocation = "auto":
> >>
> >> FlatView #2
> >>  AS "memory", root: system
> >>  AS "cpu-memory", root: system
> >>  Root memory region: system
> >>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>   0000200080000000-00002000800005ff (prio 0, i/o): msix-table
> >>   0000200080000600-000020008000ffff (prio 1, i/o): 0001:03:00.0 base BAR 0
> >> @0000000000000600
> >>   0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
> >>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
> >>
> >>
> >> The guest fails probing because the first 64bit BAR is broken.
> >>
> >> lspci:
> >>
> >> Region 0: Memory at 200080000000 (32-bit, prefetchable) [size=64K]
> >> Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
> >> Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
> >>
> >> Capabilities: [c0] MSI-X: Enable- Count=96 Masked-
> >>         Vector table: BAR=0 offset=00000000
> >>         PBA: BAR=0 offset=00000600  
> > 
> > Why do you suppose it's broken?  The added BAR0 is 32bit, it cannot be
> > 64bit since BAR1 is implemented.  I don't see anything fundamentally
> > different between this and the working BAR5 test below.  
> 
> 
> BAR1 (0x14..0x17) uses BAR0 (0x10..0x13) as upper 32bits when it is 64bit
> BAR, no?

AIUI, if BAR1 is 64bit, it consumes 0x14-0x17 for the lower 32bis and
0x18-1b for the upper 32bits, ie. it consumes BAR1 + BAR2.  Likewise
the 64bit BAR3 also consumes BAR4.  See for instance the 82576
datasheet:

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82576eb-gigabit-ethernet-controller-datasheet.pdf

9.4.11.2 shows the BAR configuration in 64bit mode, 64bit BAR0 consumes
BAR0 (lower) + BAR1 (upper), 64bit BAR2 consumes BAR2 (lower) + BAR3
(upper), and the MSI-X BAR becomes 64bit at BAR4, consuming BAR4
(lower) + BAR5 (upper).  lspci would show this as Region 0, 2, 4.  The
layout of your SAS card does seem poorly thought out that they've
essentially precluded a 3rd 64bit BAR by starting with BAR1, but
perhaps it's for compatibility with an equally poorly designed 32bit
version of the device.  Thanks,

Alex
