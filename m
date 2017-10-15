Received: from eggs.gnu.org ([2001:4830:134:3::10]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e3h7h-0002Wc-Uq
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 07:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e3h7e-00041h-9s
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 07:30:25 -0400
Date: Sun, 15 Oct 2017 13:30:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1710081718490.54240@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1710151239410.57072@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1707270007490.20438@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708192307590.44932@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708202246550.65843@zero.eik.bme.hu>
	<d4ffee34-8a82-95ea-bedc-ed37ae5fae67@ilande.co.uk>
	<alpine.BSF.2.21.1710081718490.54240@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] How to debug crash in TCG code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Sun, 8 Oct 2017, BALATON Zoltan wrote:
> I'm still trying to debug a crash that I don't understand why is
> happening and how to debug it further. Any hints are apreciated. I've 
> described the problem previously in
> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00249.html
> but I've dug deeper now, here's what I've found.

I've got a bit further with this but still could use some hints to find 
what is happening. Here are some more details I've found so far.

The memory map I have (see below) is a bit complex but the interesting 
part is that I have sii3112.bar5 as an mmio region with sii3112.bar0-4 as 
io region aliases into this. The crash is happening when the firmware is 
accessing one of these aliased io regions when

tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1

is called in accel/tcg/cputlb.c:616 which then calls

635	    section = address_space_translate_for_iotlb(cpu, asidx, paddr, &xlat, &sz);

this in turn calls address_space_translate_internal which calls

441	    section = address_space_lookup_region(d, addr, resolve_subpage);

that eventually gets the cached section at exec.c:411

411	    MemoryRegionSection *section = atomic_read(&d->mru_section);

When this is not a region covering the address as verifed by

415	    if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
416	        section_covers_addr(section, addr)) {
417	        update = false;
418	    } else {
419	        section = phys_page_find(d, addr);
420	        update = true;
421	    }

then the else branch is taken and phys_page_find is called and the correct 
region is found and set in line 427 atomic_set(&d->mru_section, section);
In this case the iotlb value in tlb_set_page_with_attrs at 
accel/tcg/cputlb.c:653

653	    iotlb = memory_region_section_get_iotlb(cpu, section, vaddr, paddr, xlat,

will be 20 and access works. In this case section is

$6 = {mr = 0x7f62d03744f0, fv = 0x7f62d035c6d0, offset_within_region = 0x0, size = 0x00000000000000000000000000000400,
   offset_within_address_space = 0xc08001000, readonly = 0x0}

But when the cached memory region in d->mru_section happens to be 
sii3112.bar5 the update=false branch is taken and the section is 
returned as is. In this case iotlb value will be 149 and the access 
results in the crash described below. Section in this case is

$13 = {mr = 0x55dedbd88210, fv = 0x7f62d035c6d0, offset_within_region = 0x80, size = 0x0000000000000000000000000000000c,
   offset_within_address_space = 0xc08001000, readonly = 0x0}

(note the different mr values and offset and size).

I don't yet understand why is it happening but seems to be related to 
aliased memory regions or maybe wrong mapping in the memory map. The code 
implementing these are in these patches:
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00246.html
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00245.html
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00247.html

Here is the memory layout in case someone can spot a problem in it. Any 
help is greatly appreciated.

(qemu) info mtree
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000001fffffff (prio 0, i/o): sdram-containers
       0000000000000000-000000001fffffff (prio 0, i/o): alias ppc4xx.sdram0 @ppc4xx.sdram 0000000000000000-000000001fffffff
     0000000400000000-000000040003ffff (prio 0, ram): ppc440.l2cache_ram
     00000004bffd0000-00000004bffd00ff (prio 0, i/o): ohci
     00000004bffd0400-00000004bffd13ff (prio 0, i/o): ehci
       00000004bffd0400-00000004bffd040f (prio 0, i/o): capabilities
       00000004bffd0410-00000004bffd0453 (prio 0, i/o): operational
       00000004bffd0454-00000004bffd046b (prio 0, i/o): ports
     00000004ef600300-00000004ef600307 (prio 0, i/o): serial
     00000004ef600700-00000004ef600711 (prio 0, i/o): ppc4xx-i2c
     00000004ef600800-00000004ef600811 (prio 0, i/o): ppc4xx-i2c
     00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash
     0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io 0000000000000000-000000000000ffff
     0000000c0ec00000-0000000c0ec800fe (prio 0, i/o): pci-container
       0000000c0ec00000-0000000c0ec00003 (prio 0, i/o): pci-conf-idx
       0000000c0ec00004-0000000c0ec00007 (prio 0, i/o): pci-conf-data
       0000000c0ec80000-0000000c0ec800fe (prio 0, i/o): pci.reg
     0000000c80000000-0000000c8fffffff (prio 0, i/o): alias PCI Outbound Window 0 @pci bus memory 0000000080000000-000000008fffffff
     0000000c90000000-0000000c9fffffff (prio 0, i/o): alias PCI Outbound Window 1 @pci bus memory 0000000090000000-000000009fffffff
     0000000d20000000-0000000d3fffffff (prio 0, i/o): pcie-mmcfg-mmio

address-space: I/O
   0000000000000000-000000000000ffff (prio 0, i/o): io
     0000000000001000-0000000000001007 (prio 1, i/o): alias sii3112.bar0 @sii3112.bar5 0000000000000080-0000000000000087
     0000000000001008-000000000000100b (prio 1, i/o): alias sii3112.bar1 @sii3112.bar5 0000000000000088-000000000000008b
     0000000000001010-0000000000001017 (prio 1, i/o): alias sii3112.bar2 @sii3112.bar5 00000000000000c0-00000000000000c7
     0000000000001018-000000000000101b (prio 1, i/o): alias sii3112.bar3 @sii3112.bar5 00000000000000c8-00000000000000cb
     0000000000001020-000000000000102f (prio 1, i/o): alias sii3112.bar4 @sii3112.bar5 0000000000000000-000000000000000f

address-space: cpu-memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000001fffffff (prio 0, i/o): sdram-containers
       0000000000000000-000000001fffffff (prio 0, i/o): alias ppc4xx.sdram0 @ppc4xx.sdram 0000000000000000-000000001fffffff
     0000000400000000-000000040003ffff (prio 0, ram): ppc440.l2cache_ram
     00000004bffd0000-00000004bffd00ff (prio 0, i/o): ohci
     00000004bffd0400-00000004bffd13ff (prio 0, i/o): ehci
       00000004bffd0400-00000004bffd040f (prio 0, i/o): capabilities
       00000004bffd0410-00000004bffd0453 (prio 0, i/o): operational
       00000004bffd0454-00000004bffd046b (prio 0, i/o): ports
     00000004ef600300-00000004ef600307 (prio 0, i/o): serial
     00000004ef600700-00000004ef600711 (prio 0, i/o): ppc4xx-i2c
     00000004ef600800-00000004ef600811 (prio 0, i/o): ppc4xx-i2c
     00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash
     0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io 0000000000000000-000000000000ffff
     0000000c0ec00000-0000000c0ec800fe (prio 0, i/o): pci-container
       0000000c0ec00000-0000000c0ec00003 (prio 0, i/o): pci-conf-idx
       0000000c0ec00004-0000000c0ec00007 (prio 0, i/o): pci-conf-data
       0000000c0ec80000-0000000c0ec800fe (prio 0, i/o): pci.reg
     0000000c80000000-0000000c8fffffff (prio 0, i/o): alias PCI Outbound Window 0 @pci bus memory 0000000080000000-000000008fffffff
     0000000c90000000-0000000c9fffffff (prio 0, i/o): alias PCI Outbound Window 1 @pci bus memory 0000000090000000-000000009fffffff
     0000000d20000000-0000000d3fffffff (prio 0, i/o): pcie-mmcfg-mmio

address-space:
   0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
     0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @bm-ppc440-pcix 0000000000000000-ffffffffffffffff

address-space: pci-bm
   0000000000000000-ffffffffffffffff (prio 0, i/o): bm-ppc440-pcix
     0000000000000000-ffffffffffffffff (prio 0, i/o): pci bus memory
       0000000080000000-00000000800001ff (prio 1, i/o): sii3112.bar5
       0000000084000000-0000000087ffffff (prio 1, ram): sm501.local
       0000000088000000-00000000881fffff (prio 1, i/o): sm501.mmio
         0000000088000000-000000008800006b (prio 0, i/o): sm501-system-config
         0000000088080000-0000000088080fff (prio 0, i/o): sm501-disp-ctrl
         0000000088100000-0000000088100053 (prio 0, i/o): sm501-2d-engine
     0000000000000000-000000001fffffff (prio -1, i/o): alias PCI Inbound Window 0 @system 0000000000000000-000000001fffffff

address-space:
   0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
     0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @bm-ppc440-pcix 0000000000000000-ffffffffffffffff

address-space:
   0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
     0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @bm-ppc440-pcix 0000000000000000-ffffffffffffffff

memory-region: ppc4xx.sdram
   0000000000000000-000000001fffffff (prio 0, ram): ppc4xx.sdram

memory-region: io
   0000000000000000-000000000000ffff (prio 0, i/o): io
     0000000000001000-0000000000001007 (prio 1, i/o): alias sii3112.bar0 @sii3112.bar5 0000000000000080-0000000000000087
     0000000000001008-000000000000100b (prio 1, i/o): alias sii3112.bar1 @sii3112.bar5 0000000000000088-000000000000008b
     0000000000001010-0000000000001017 (prio 1, i/o): alias sii3112.bar2 @sii3112.bar5 00000000000000c0-00000000000000c7
     0000000000001018-000000000000101b (prio 1, i/o): alias sii3112.bar3 @sii3112.bar5 00000000000000c8-00000000000000cb
     0000000000001020-000000000000102f (prio 1, i/o): alias sii3112.bar4 @sii3112.bar5 0000000000000000-000000000000000f

memory-region: pci bus memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): pci bus memory
     0000000080000000-00000000800001ff (prio 1, i/o): sii3112.bar5
     0000000084000000-0000000087ffffff (prio 1, ram): sm501.local
     0000000088000000-00000000881fffff (prio 1, i/o): sm501.mmio
       0000000088000000-000000008800006b (prio 0, i/o): sm501-system-config
       0000000088080000-0000000088080fff (prio 0, i/o): sm501-disp-ctrl
       0000000088100000-0000000088100053 (prio 0, i/o): sm501-2d-engine

memory-region: sii3112.bar5
   0000000080000000-00000000800001ff (prio 1, i/o): sii3112.bar5

memory-region: bm-ppc440-pcix
   0000000000000000-ffffffffffffffff (prio 0, i/o): bm-ppc440-pcix
     0000000000000000-ffffffffffffffff (prio 0, i/o): pci bus memory
       0000000080000000-00000000800001ff (prio 1, i/o): sii3112.bar5
       0000000084000000-0000000087ffffff (prio 1, ram): sm501.local
       0000000088000000-00000000881fffff (prio 1, i/o): sm501.mmio
         0000000088000000-000000008800006b (prio 0, i/o): sm501-system-config
         0000000088080000-0000000088080fff (prio 0, i/o): sm501-disp-ctrl
         0000000088100000-0000000088100053 (prio 0, i/o): sm501-2d-engine
     0000000000000000-000000001fffffff (prio -1, i/o): alias PCI Inbound Window 0 @system 0000000000000000-000000001fffffff

memory-region: system
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000001fffffff (prio 0, i/o): sdram-containers
       0000000000000000-000000001fffffff (prio 0, i/o): alias ppc4xx.sdram0 @ppc4xx.sdram 0000000000000000-000000001fffffff
     0000000400000000-000000040003ffff (prio 0, ram): ppc440.l2cache_ram
     00000004bffd0000-00000004bffd00ff (prio 0, i/o): ohci
     00000004bffd0400-00000004bffd13ff (prio 0, i/o): ehci
       00000004bffd0400-00000004bffd040f (prio 0, i/o): capabilities
       00000004bffd0410-00000004bffd0453 (prio 0, i/o): operational
       00000004bffd0454-00000004bffd046b (prio 0, i/o): ports
     00000004ef600300-00000004ef600307 (prio 0, i/o): serial
     00000004ef600700-00000004ef600711 (prio 0, i/o): ppc4xx-i2c
     00000004ef600800-00000004ef600811 (prio 0, i/o): ppc4xx-i2c
     00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash
     0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io 0000000000000000-000000000000ffff
     0000000c0ec00000-0000000c0ec800fe (prio 0, i/o): pci-container
       0000000c0ec00000-0000000c0ec00003 (prio 0, i/o): pci-conf-idx
       0000000c0ec00004-0000000c0ec00007 (prio 0, i/o): pci-conf-data
       0000000c0ec80000-0000000c0ec800fe (prio 0, i/o): pci.reg
     0000000c80000000-0000000c8fffffff (prio 0, i/o): alias PCI Outbound Window 0 @pci bus memory 0000000080000000-000000008fffffff
     0000000c90000000-0000000c9fffffff (prio 0, i/o): alias PCI Outbound Window 1 @pci bus memory 0000000090000000-000000009fffffff
     0000000d20000000-0000000d3fffffff (prio 0, i/o): pcie-mmcfg-mmio


> I'm running with -accel tcg,thread=single -singlestep so it does not seem to 
> be a multi threading problem. The seg fault happens when U-Boot running on 
> the emulated embedded PPC SoC accesses a PCI device but after several 
> successful iteration of the same access so it seems to be some internal 
> inconsistency that arrises while QEMU is running, not something generally 
> broken. It is also dependent on code run by the client or QEMU, so e.g. it 
> disappears when I enable -d in_asm or use a different U-Boot version. I'm not 
> sure what exactly causes the bug to happen or disappear but I can reproduce 
> it reliably with certain images at the same place. It always happens during 
> io_readx or io_writex. Here's the info I could get with a debugger with some 
> additional debug and trace messages enabled:
>
> Here's the PCI device detected by U-Boot and BARs mapped:
> The device is implemended here:
> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00246.html
>
> 4744@1507472117.454656:pci_cfg_read sii3112 01:0 @0xe -> 0x0
> tlb_set_page_with_attrs: vaddr=0ffb0800 paddr=0x000000000ffb0800 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff73c00 paddr=0x000000000ff73c00 prot=7 idx=1
> 4744@1507472117.454676:pci_cfg_read sii3112 01:0 @0x0 -> 0x1095
> 4744@1507472117.454766:pci_cfg_read sii3112 01:0 @0x2 -> 0x3112
> 4744@1507472117.454775:pci_cfg_read sii3112 01:0 @0xa -> 0x104
> tlb_set_page_with_attrs: vaddr=0ff74000 paddr=0x000000000ff74000 prot=7 idx=1
> 4744@1507472117.454794:pci_cfg_read sii3112 01:0 @0xa -> 0x104
> 4744@1507472117.454905:pci_cfg_read sii3112 01:0 @0x4 -> 0x0
> 4744@1507472117.454916:pci_cfg_write sii3112 01:0 @0x10 <- 0xffffffff
> 4744@1507472117.454927:pci_cfg_read sii3112 01:0 @0x10 -> 0xfffffff9
> 4744@1507472117.456524:pci_cfg_write sii3112 01:0 @0x10 <- 0x1000
> tlb_set_page_with_attrs: vaddr=0ff74800 paddr=0x000000000ff74800 prot=7 idx=1
> 4744@1507472117.456823:pci_cfg_write sii3112 01:0 @0x14 <- 0xffffffff
> 4744@1507472117.456833:pci_cfg_read sii3112 01:0 @0x14 -> 0xfffffffd
> 4744@1507472117.456844:pci_cfg_write sii3112 01:0 @0x14 <- 0x1008
> 4744@1507472117.456852:pci_cfg_write sii3112 01:0 @0x18 <- 0xffffffff
> 4744@1507472117.456859:pci_cfg_read sii3112 01:0 @0x18 -> 0xfffffff9
> 4744@1507472117.456869:pci_cfg_write sii3112 01:0 @0x18 <- 0x1010
> 4744@1507472117.456878:pci_cfg_write sii3112 01:0 @0x1c <- 0xffffffff
> 4744@1507472117.456885:pci_cfg_read sii3112 01:0 @0x1c -> 0xfffffffd
> 4744@1507472117.456895:pci_cfg_write sii3112 01:0 @0x1c <- 0x1018
> 4744@1507472117.456903:pci_cfg_write sii3112 01:0 @0x20 <- 0xffffffff
> 4744@1507472117.456911:pci_cfg_read sii3112 01:0 @0x20 -> 0xfffffff1
> 4744@1507472117.456920:pci_cfg_write sii3112 01:0 @0x20 <- 0x1020
> 4744@1507472117.456929:pci_cfg_write sii3112 01:0 @0x24 <- 0xffffffff
> 4744@1507472117.456936:pci_cfg_read sii3112 01:0 @0x24 -> 0xfffffe00
> 4744@1507472117.457173:pci_cfg_write sii3112 01:0 @0x24 <- 0x80000000
> 4744@1507472117.457208:pci_cfg_write sii3112 01:0 @0x4 <- 0x7
> 4744@1507472117.457213:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 0,0x1000+0x8
> tlb_flush_nocheck: (count: 23)
> 4744@1507472117.457488:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 1,0x1008+0x4
> tlb_flush_nocheck: (count: 24)
> 4744@1507472117.457769:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 2,0x1010+0x8
> tlb_flush_nocheck: (count: 25)
> 4744@1507472117.458048:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 3,0x1018+0x4
> tlb_flush_nocheck: (count: 26)
> 4744@1507472117.458324:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 4,0x1020+0x10
> tlb_flush_nocheck: (count: 27)
> 4744@1507472117.458604:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 
> 5,0x80000000+0x200
>
> (BAR0-4 are alias memory regions to BAR5 so all access should go to BAR5 at 
> the end even if U-Boot accesses it through BAR0-4)
> Here U-Boot starts using the device:
>
> tlb_set_page_with_attrs: vaddr=dec00000 paddr=0x0000000c0ec00000 prot=3 idx=1
> 4744@1507472121.253966:pci_cfg_read ppc4xx-host-bridge 00:0 @0xe -> 0x0
> 4744@1507472121.253982:pci_cfg_read ppc4xx-host-bridge 00:0 @0x0 -> 0x1014
> 4744@1507472121.253992:pci_cfg_read ppc4xx-host-bridge 00:0 @0x2 -> 0x27f
> 4744@1507472121.254005:pci_cfg_read sii3112 01:0 @0xe -> 0x0
> 4744@1507472121.254015:pci_cfg_read sii3112 01:0 @0x0 -> 0x1095
> 4744@1507472121.254024:pci_cfg_read sii3112 01:0 @0x2 -> 0x3112
> tlb_set_page_with_attrs: vaddr=00000800 paddr=0x0000000000000800 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff6f000 paddr=0x000000000ff6f000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff74000 paddr=0x000000000ff74000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff73c00 paddr=0x000000000ff73c00 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ffb0c00 paddr=0x000000000ffb0c00 prot=7 idx=1
> 4744@1507472121.254748:pci_cfg_write sii3112 01:0 @0x4 <- 0x7
> 4744@1507472121.254846:pci_cfg_read sii3112 01:0 @0x8 -> 0x1040001
> 4744@1507472121.255085:pci_cfg_write sii3112 01:0 @0xc <- 0x1
> 4744@1507472121.255228:pci_cfg_read sii3112 01:0 @0x10 -> 0x1001
> 4744@1507472121.255417:pci_cfg_read sii3112 01:0 @0x18 -> 0x1011
> tlb_set_page_with_attrs: vaddr=0ffa3800 paddr=0x000000000ffa3800 prot=7 idx=1
>
> And can talk to the device emulation:
>
> tlb_set_page_with_attrs: vaddr=0ff89000 paddr=0x000000000ff89000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
> 4744@1507472121.402003:sii3112_write bmdma: write (size 1) 0x86 : 0xe0
>
> Address 0x86 in BAR5 is accessed via vaddr d8001006 which is an alias via 
> BAR0
>
> tlb_set_page_with_attrs: vaddr=0ff8a400 paddr=0x000000000ff8a400 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ffa3400 paddr=0x000000000ffa3400 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ffc7800 paddr=0x000000000ffc7800 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
> 4744@1507472121.513050:sii3112_set_irq channel 0 level 0
> 4744@1507472121.513057:sii3112_read bmdma: read (size 1) 0x87 : 0x50
> tlb_set_page_with_attrs: vaddr=0ff6f000 paddr=0x000000000ff6f000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0df6d000 paddr=0x000000000df6d000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ffc0800 paddr=0x000000000ffc0800 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff87800 paddr=0x000000000ff87800 prot=7 idx=1
> 4744@1507472121.613784:sii3112_write bmdma: write (size 1) 0xc6 : 0xe0
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
> 4744@1507472121.724016:sii3112_set_irq channel 1 level 0
> 4744@1507472121.724020:sii3112_read bmdma: read (size 1) 0xc7 : 0x00
> tlb_set_page_with_attrs: vaddr=0ff8a400 paddr=0x000000000ff8a400 prot=7 idx=1
>
> Accessing the device seems to work, it identifies the connected ATAPI CD 
> emulation and can read from it, until it hits null pointer:
>
> tlb_set_page_with_attrs: vaddr=0ff89800 paddr=0x000000000ff89800 prot=7 idx=1
> 4744@1507472121.949834:sii3112_read bmdma: read (size 1) 0x82 : 0x02
> 4744@1507472121.950222:sii3112_read bmdma: read (size 2) 0x80 : 0x8005
> 4744@1507472121.950283:sii3112_read bmdma: read (size 2) 0x80 : 0x2100
> 4744@1507472121.950289:sii3112_read bmdma: read (size 2) 0x80 : 0x1f
> 4744@1507472121.950292:sii3112_read bmdma: read (size 2) 0x80 : 0x00
> 4744@1507472121.950295:sii3112_read bmdma: read (size 2) 0x80 : 0x4551
> 4744@1507472121.950298:sii3112_read bmdma: read (size 2) 0x80 : 0x554d
> 4744@1507472121.950301:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
> 4744@1507472121.950306:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
> 4744@1507472121.950309:sii3112_read bmdma: read (size 2) 0x80 : 0x4551
> 4744@1507472121.950312:sii3112_read bmdma: read (size 2) 0x80 : 0x554d
> 4744@1507472121.950316:sii3112_read bmdma: read (size 2) 0x80 : 0x4420
> 4744@1507472121.950319:sii3112_read bmdma: read (size 2) 0x80 : 0x4456
> 4744@1507472121.950323:sii3112_read bmdma: read (size 2) 0x80 : 0x522d
> 4744@1507472121.950326:sii3112_read bmdma: read (size 2) 0x80 : 0x4d4f
> 4744@1507472121.950330:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
> 4744@1507472121.950333:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
> 4744@1507472121.950338:sii3112_read bmdma: read (size 2) 0x80 : 0x2e32
> 4744@1507472121.950342:sii3112_set_irq channel 0 level 1
> 4744@1507472121.950346:sii3112_set_irq channel 0 level 1
> 4744@1507472121.950348:sii3112_read bmdma: read (size 2) 0x80 : 0x2b35
> 4744@1507472121.955573:sii3112_set_irq channel 0 level 0
> 4744@1507472121.955590:sii3112_read bmdma: read (size 1) 0x87 : 0x50
> tlb_set_page_with_attrs: vaddr=0ff89c00 paddr=0x000000000ff89c00 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff8a000 paddr=0x000000000ff8a000 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=0ff89400 paddr=0x000000000ff89400 prot=7 idx=1
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
> 4744@1507472121.957147:sii3112_write bmdma: write (size 1) 0x86 : 0xe0
> 4744@1507472121.957158:sii3112_set_irq channel 0 level 0
> 4744@1507472121.957161:sii3112_read bmdma: read (size 1) 0x87 : 0x50
> 4744@1507472121.957168:sii3112_write bmdma: write (size 1) 0x81 : 0x00
> 4744@1507472121.957172:sii3112_write bmdma: write (size 1) 0x82 : 0x00
> 4744@1507472121.957177:sii3112_write bmdma: write (size 1) 0x83 : 0x00
> 4744@1507472121.957181:sii3112_write bmdma: write (size 1) 0x84 : 0x00
> 4744@1507472121.957188:sii3112_write bmdma: write (size 1) 0x85 : 0x00
> 4744@1507472121.957198:sii3112_write bmdma: write (size 1) 0x86 : 0xe0
> 4744@1507472121.957204:sii3112_write bmdma: write (size 1) 0x87 : 0xa0
> 4744@1507472121.957278:sii3112_set_irq channel 0 level 0
> 4744@1507472121.957283:sii3112_read bmdma: read (size 1) 0x87 : 0x58
> 4744@1507472121.957289:sii3112_write bmdma: write (size 2) 0x80 : 0x1b
> 4744@1507472121.957294:sii3112_write bmdma: write (size 2) 0x80 : 0x00
> 4744@1507472121.957298:sii3112_write bmdma: write (size 2) 0x80 : 0x03
> 4744@1507472121.957302:sii3112_write bmdma: write (size 2) 0x80 : 0x00
> 4744@1507472121.957306:sii3112_write bmdma: write (size 2) 0x80 : 0x00
> 4744@1507472121.957309:sii3112_write bmdma: write (size 2) 0x80 : 0x00
> 4744@1507472121.957315:sii3112_set_irq channel 0 level 1
> 4744@1507472121.962334:sii3112_set_irq channel 0 level 0
> 4744@1507472121.962340:sii3112_read bmdma: read (size 1) 0x87 : 0x50
> 4744@1507472121.962346:sii3112_read bmdma: read (size 1) 0x85 : 0x00
> 4744@1507472121.962351:sii3112_read bmdma: read (size 1) 0x84 : 0x00
> 4744@1507472121.967372:sii3112_set_irq channel 0 level 0
> 4744@1507472121.967378:sii3112_read bmdma: read (size 1) 0x87 : 0x50
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffe87f7700 (LWP 4761)]
> 0x00005555557f4bc4 in io_writex (env=0x7fffe88002a0, 
> iotlbentry=0x7fffe8811d60, mmu_idx=1, val=224, addr=3623882758, 
> retaddr=140737099010411,
>    size=1) at accel/tcg/cputlb.c:803
>    803    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
> (gdb) bt
> #0  0x00005555557f4bc4 in io_writex (env=0x7fffe88002a0, 
> iotlbentry=0x7fffe8811d60, mmu_idx=1, val=224, addr=3623882758, 
> retaddr=140737099010411,
>    size=1) at accel/tcg/cputlb.c:803
> #1  0x00005555557f5673 in io_writeb (env=0x7fffe88002a0, mmu_idx=1, index=4, 
> val=224 '\340', addr=3623882758, retaddr=140737099010411)
>    at accel/tcg/softmmu_template.h:265
> #2  0x00005555557f57ff in helper_ret_stb_mmu (env=0x7fffe88002a0, 
> addr=3623882758, val=224 '\340', oi=1, retaddr=140737099010411)
>    at accel/tcg/softmmu_template.h:300
> #3  0x00007fffe8cb116b in code_gen_buffer ()
> #4  0x00005555557fdaf1 in cpu_tb_exec (cpu=0x7fffe87f8010, itb=0x7fffe8cb0780 
> <code_gen_buffer+3753814>)
>    at accel/tcg/cpu-exec.c:166
> #5  0x00005555557fe936 in cpu_loop_exec_tb (cpu=0x7fffe87f8010, 
> tb=0x7fffe8cb0780 <code_gen_buffer+3753814>, last_tb=0x7fffe87f6af8,
>    tb_exit=0x7fffe87f6af4) at accel/tcg/cpu-exec.c:613
> #6  0x00005555557fec29 in cpu_exec (cpu=0x7fffe87f8010) at 
> accel/tcg/cpu-exec.c:711
> #7  0x00005555557c7a05 in tcg_cpu_exec (cpu=0x7fffe87f8010) at 
> qemu/cpus.c:1270
> #8  0x00005555557c7c3c in qemu_tcg_rr_cpu_thread_fn (arg=0x7fffe87f8010) at 
> qemu/cpus.c:1365
> #9  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
> #10 0x00007ffff42d062d in clone () from /lib64/libc.so.6
> (gdb) p mr
> $1 = (MemoryRegion *) 0x0
> (gdb) p/x addr
> $2 = 0xd8001006
> (gdb) p *iotlbentry
> $3 = {addr = 18446744070085669013, attrs = {unspecified = 1, secure = 0, user 
> = 0, requester_id = 0}}
> (gdb) p/x iotlbentry->addr
> $4 = 0xffffffff27fff095
> (gdb) up
> #1  0x00005555557f5673 in io_writeb (env=0x7fffe88002a0, mmu_idx=1, index=4, 
> val=224 '\340', addr=3623882758, retaddr=140737099010411)
>    at accel/tcg/softmmu_template.h:265
> 265    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 
> DATA_SIZE);
> (gdb) up
> #2  0x00005555557f57ff in helper_ret_stb_mmu (env=0x7fffe88002a0, 
> addr=3623882758, val=224 '\340', oi=1, retaddr=140737099010411)
>    at accel/tcg/softmmu_template.h:300
> 300        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
> (gdb) l 260
> 255# endif
> 256#endif
> 257
> 258static inline void glue(io_write, SUFFIX)(CPUArchState *env,
> 259                                          size_t mmu_idx, size_t index,
> 260                                          DATA_TYPE val,
> 261                                          target_ulong addr,
> 262                                          uintptr_t retaddr)
> 263{
> 264    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
> 265    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 
> DATA_SIZE);
> 266}
> 267
> 268void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE 
> val,
> 269                       TCGMemOpIdx oi, uintptr_t retaddr)
> 270{
> 271    unsigned mmu_idx = get_mmuidx(oi);
> 272    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> 273    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
> 274    unsigned a_bits = get_alignment_bits(get_memop(oi));
> 275    uintptr_t haddr;
> 276
> 277    if (addr & ((1 << a_bits) - 1)) {
> 278        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
> 279                             mmu_idx, retaddr);
> 280    }
> 281
> 282    /* If the TLB entry is for a different page, reload and try again.  */
> 283    if ((addr & TARGET_PAGE_MASK)
> 284        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
> 285        if (!VICTIM_TLB_HIT(addr_write, addr)) {
> 286            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, 
> retaddr);
> 287        }
> 288        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
> 289    }
> 290
> 291    /* Handle an IO access.  */
> 292    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
> 293        if ((addr & (DATA_SIZE - 1)) != 0) {
> 294            goto do_unaligned_access;
> 295        }
> 296
> 297        /* ??? Note that the io helpers always read data in the target
> 298           byte ordering.  We should push the LE/BE request down into io. 
> */
> 299        val = TGT_LE(val);
> 300        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
> 301        return;
> 302    }
> 303
> 304    /* Handle slow unaligned access (it spans two pages or IO).  */
> (gdb) p/x tlb_addr
> $5 = 0xd8001080
> (gdb) p/x env->tlb_table[mmu_idx][index]
> $6 = {{{addr_read = 0xd8001080, addr_write = 0xd8001080, addr_code = 
> 0xffffffff, addend = 0xffffffff27fff000}, dummy = {0x80, 0x10, 0x0, 0xd8,
>      0x80, 0x10, 0x0, 0xd8, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 
> 0x0, 0xf0, 0xff, 0x27, 0xff <repeats 12 times>}}}
>
> So as far as I understand the mmu_idx and index variables passed down to 
> io_write are from env->tlb_table but are used on the env->iotlb array to get 
> iotlbentry which seems to be invalid in this case (while apparently normally 
> these are in sync and this works because several successful accesses precede 
> this one causing the crash). Does anyone know if this is correct and how are 
> these arrays can get out of sync causing this crash or what should be checked 
> to find the problem here?
>
> Thank you,
> BALATON Zoltan
>
>
