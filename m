Received: from eggs.gnu.org ([2001:4830:134:3::10]:37074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJdmb-0000SD-9I
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJdmW-0007pA-Cy
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:06:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJdmW-0007ow-4Q
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:05:56 -0500
Date: Wed, 21 Dec 2016 18:05:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161221100549.GG22006@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219233012.GF23176@umbus.fritz.box>
	<20161220041650.GA22006@pxdev.xzpeter.org>
	<20161221025337.GA13024@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161221025337.GA13024@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Wed, Dec 21, 2016 at 01:53:37PM +1100, David Gibson wrote:

[...]

> > Could you explain why here device address space has things to do with
> > PCI BARs? I thought BARs are for CPU address space only (so that CPU
> > can access PCI registers via MMIO manner), am I wrong?
> 
> In short, yes.  So, first think about vanilla PCI - most things are
> PCI-E these days, but the PCI addressing model which was designed for
> the old hardware is still mostly the same.
> 
> With plain PCI, you have a physical bus over which address and data
> cycles pass.  Those cycles don't distinguish between transfers from
> host to device or device to host.  Each address cycle just gives which
> address space: configuration, IO or memory, and an address.
> 
> Devices respond to addresses within their BARs, typically such cycles
> will come from the host, but they don't have to - a device is able to
> send cycles to another device (peer to peer DMA).  Meanwhile the host
> bridge will respond to addresses within certain DMA windows,
> propagating those access onwards to system memory.  How many DMA
> windows there are, their size, location and whether they're mapped
> directly or via an IOMMU depends on the model of host bridge.
> 
> On x86, traditionally, PCI addresses 0..<somewhere> were simply mapped
> directly to memory addresses 0..<somewhere>, identity mapping RAM into
> PCI space.  BARs would be assigned above <somewhere>, so they don't
> collide.  I suspect old enough machines will have <somewhere> == 2G,
> leaving 2G..4G for the BARs of 32-bit devices.  More modern x86
> bridges must have provisions for accessing memory above 4G, but I'm
> not entirely certain how that works.
> 
> PAPR traditionally also had a DMA window from 0..2G, however instead
> of being direct mapped to RAM, it is always translated via an IOMMU.
> More modern PAPR systems have that window by default, but allow the
> OS to remove it and configure up to 2 DMA windows of variable length
> and page size.  Various other platforms have various other DMA window
> arrangements.
> 
> With PCI-E, of course, upstream and downstream cycles are distinct,
> and peer to peer DMA isn't usually possible (unless a switch is
> configured specially to allow it by forwarding cycles from one
> downstream port to another).  But the address mndel remains logically
> the same: there is just one PCI memory space and both device BARs and
> host DMA windows live within it.  Firmware and/or the OS need to know
> the details of the platform's host bridge, and configure both the BARs
> and the DMA windows so that they don't collide.

Thanks for the thorough explanation. :)

So we should mask out all the MMIO regions (including BAR address
ranges) for PCI device address space, right? Since they should not be
able to access such addresses, but system ram?

> 
> > I think we should have a big enough IOMMU region size here. If device
> > writes to invalid addresses, IMHO we should trap it and report to
> > guest. If we have a smaller size than UINT64_MAX, how we can trap this
> > behavior and report for the whole address space (it should cover [0,
> > 2^64-1])?
> 
> That's not how the IOMMU works.  How it traps is dependent on the
> specific IOMMU model, but generally they'll only even look at cycles
> which lie within the IOMMU's DMA window.  On x86 I'm pretty sure that
> window will be large, but it won't be 2^64.  It's also likely to have
> a gap between 2..4GiB to allow room for the BARs of 32-bit devices.

But for x86 IOMMU region, I don't know anything like "DMA window" -
device has its own context entry, which will point to a whole page
table. In that sense I think at least all addresses from (0, 2^39-1)
should be legal addresses? And that range should depend on how many
address space bits the specific Intel IOMMU support, currently the
emulated VT-d one supports 39 bits.

An example would be: one with VT-d should be able to map the address
3G (0xc0000000, here it is an IOVA address) to any physical address
he/she wants, as long as he/she setup the page table correctly.

Hope I didn't miss anything important..

> 
> > > 
> > > > +        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> > > > +                                 "vtd_sys_alias", get_system_memory(),
> > > > +                                 0, memory_region_size(get_system_memory()));
> > > 
> > > I strongly suspect using memory_region_size(get_system_memory()) is
> > > also incorrect here.  System memory has size UINT64_MAX, but I'll bet
> > > you you can't actually access all of that via PCI space (again, it
> > > would collide with actual PCI BARs).  I also suspect you can't reach
> > > CPU MMIO regions via the PCI DMA space.
> > 
> > Hmm, sounds correct.
> > 
> > However if so we will have the same problem if without IOMMU? See
> > pci_device_iommu_address_space() - address_space_memory will be the
> > default if we have no IOMMU protection, and that will cover e.g. CPU
> > MMIO regions as well.
> 
> True.  That default is basically assuming that both the host bridge's
> DMA windows, and its outbound IO and memory windows are identity
> mapped between the system bus and the PCI address space.  I suspect
> that's rarely 100% true, but it's close enough to work on a fair few
> platforms.
> 
> But since you're building a more accurate model of the x86 host
> bridge's behaviour here, you might as well try to get it as accurate
> as possible.

Yes, but even if we can fix this problem, it should be for the
no-iommu case as well? If so, I think it might be more suitable for
another standalone patch.

Anyway, I noted this down. Thanks,

-- peterx
