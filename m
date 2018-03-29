Received: from eggs.gnu.org ([2001:4830:134:3::10]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f1UZd-0007tH-Il
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f1UZZ-0006Xv-3d
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1f1UZY-0006Xo-Rk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:14:21 -0400
References: <20180322081837.21460-1-aik@ozlabs.ru>
	<6975e05c-da7a-5a96-4fb5-1234694136d0@redhat.com>
	<102833aa-9046-f4d7-0a66-71e67b89c78f@ozlabs.ru>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a77f5133-318c-c144-7ce2-fb264da0b246@redhat.com>
Date: Thu, 29 Mar 2018 12:14:08 +0200
MIME-Version: 1.0
In-Reply-To: <102833aa-9046-f4d7-0a66-71e67b89c78f@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

Hi Alexey,
On 29/03/18 03:55, Alexey Kardashevskiy wrote:
> On 29/3/18 8:03 am, Auger Eric wrote:
>> Hi Alexey, Alex,
>> On 22/03/18 09:18, Alexey Kardashevskiy wrote:
>>> The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions") added
>>> an error message if a passed memory section address or size is not aligned
>>> to the minimal IOMMU page size. However although it checks
>>> offset_within_address_space for the alignment, offset_within_region is
>>> printed instead which makes it harder to find out what device caused
>>> the message so this replaces offset_within_region with
>>> offset_within_address_space.
>>>
>>> While we are here, this replaces '..' with 'size=' (as the second number
>>> is a size, not an end offset) and adds a memory region name.
>>>
>>> Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> The patch indeed fixes the reported format issues.
>>
>> However I have some other concerns with the info that is reported to the
>> end-user. See below.
>>
>> Assigning an e1000e device with a 64kB host, here are the traces I get:
>>
>> Region XXX is not aligned to 0x10000 and cannot be mapped for DMA
>>
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a4808 size=0xb7f8
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e0050 size=0x3fb0
>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e4808 size=0xb7f8
>>
>> It took me some time to understand what happens but here is now my
>> understanding:
>>
>> 1) When looking at vfio_pci_write_config() pdev->io_regions[bar].addr =
>> bar_addr in vfio_sub_page_bar_update_mapping() I see the following values:
>>
>> UNMAPPED -> 0x0 ->UNMAPPED -> 0x100a0000 -> UNMAPPED -> 0x100a0000 ->
>> UNMAPPED -> 0x100e0000
>>
>> vfio_sub_page_bar_update_mapping() create mrs with base bar at
>> 0x100a0000 and 0x100e0000 successively, hence the
>> vfio_listener_region_add on 0x100axxxx. Indeed, 0x0-0x50 msix-table mmio
>> region induces some memory section at 0x100a0050 and 0x100e50 successively.
>>
>> However this is confusing for the end-user who only has access to the
>> final mapping (0x100e0000) through lspi [1].
> 
> 
> The trace shows that at least at some point the BAR actually was
> 0x100a0000, I find this info rather useful than confusing as it might
> expose a bug of some sort, for example.
> 
> The user also has access to the MR name which is the host PCI address + BAR
> index, how is that confusing?

To me it is confusing since it does not match the final location of bar3
as output by lspci. I couldn't understanding how 0x100axxxx related to bar3.
> 
> 
>> 2) The changes in the size (0x3fb0 <-> 0xffb0) relate to the extension
>> of the 16kB bar to 64kB in vfio_sub_page_bar_update_mapping
>>> 3) Also it happens that I have a virtio-scsi-pci device that is put just
>> after the BAR3 at 0x100a4000 and 0x100e4000 successively. The device has
> 
> e1000e gets aligned to 64k but this one avoids the alignment for some reason?

Yes I will enquire about the allocation policy
> 
> 
>> its own msi-table and pba mmio regions[2]. As mmaps[0] is extended to
>> 64kB (with prio 0), we have those MMIO regions which result in new
>> memory sections, which cause vfio_listener_region_add calls. This
>> typically explains why we get a warning on 0x100e4808 (0xb7f8). By the
>> way I don't get why we don't have a trace for "0004:01:00.0 BAR 3
>> mmaps[0]" 0x100e4040 size=0x7c0, ie. mmaps[0] space between
>> virtio-scsi-pci msic-table and pba.
> 
> 
> "info mtree -f" might give a hint how MRs got resolved, could it end up
> being emulated (==skipped by the vfio listener)?

Actually that's what is strange as I can see it in info mtree -f output. See at the end of the mail.
> 
> 
>> So at the end of the day, my fear is all those info become really
>> frightening and confusing for the end-user and even not relevant
>> (0x100a0000 stuff). So I would rather simply remove the trace in 2.12
>> until we find a place where we could generate a clear hint for the
>> end-user, suggesting to relocate the msix bar.
>>
>> Thoughts?
> 
> Please post complete "lspci -v" output for both pci devices and "info mtree
> -f" (in addition to "info mtree", not instead).

see at the end
> 
> In general, the error_report() could be removed as we did not have any
> indication of not mapping before so we do not have to start now, I am just
> missing the point here - the message exposes potentially not-working P2P
> which is useful for people who care about that and do not know if actually
> might work. Rather than silencing it, I'd convert it into the trace point.

But typically output that
Region "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0 cannot be DMA mapped
is not strictly correct (by chance it was not re-allocated to something else, right?)

Thanks

Eric
> 
> Thanks,
> 
> 
>> Thanks
>>
>> Eric
>>
>>
>> [1] lspci
>>
>> Region 3: Memory at 104e0000 (32-bit, non-prefetchable) [size=16K]
>> Expansion ROM at 10480000 [disabled] [size=256K]
>> ../..
>> Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
>> Vector table: BAR=3 offset=00000000
>>               PBA: BAR=3 offset=00002000
>>
>> [2] info mtree (final)
>>
>> 100e0000-00000000100effff (prio 0, i/o): 0004:01:00.0 base BAR 3
>>  100e0000-00000000100e004f (prio 0, i/o): msix-table
>>  100e0000-00000000100effff (prio 0, i/o): 0004:01:00.0 BAR 3
>>   100e0000-00000000100effff (prio 0, ramd): 0004:01:00.0 BAR 3 mmaps[0]
>>       100e2000-00000000100e2007 (prio 0, i/o): msix-pba [disabled]
>> 100e4000-00000000100e4fff (prio 1, i/o): virtio-scsi-pci-msix
>>  00000000100e4000-00000000100e403f (prio 0, i/o): msix-table
>>  00000000100e4800-00000000100e4807 (prio 0, i/o): msix-pba
>>
>>
>>
>>
>>
>>
>>
>>> ---
>>>
>>> Message on slightly hacked QEMU (iommu pagesize=8K) looks now like this:
>>>
>>> qemu-system-x86_64: Region "0000:00:1a.0 BAR 0 mmaps[0]" 0xfebc0000 size=0x1000 is not aligned to 0x2000 and cannot be mapped for DMA
>>> ---
>>>  hw/vfio/common.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 5e84716..e2db596 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -548,10 +548,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>>          hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>>  
>>>          if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
>>> -            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
>>> +            error_report("Region \"%s\" 0x%"HWADDR_PRIx" size=0x%"HWADDR_PRIx
>>>                           " is not aligned to 0x%"HWADDR_PRIx
>>>                           " and cannot be mapped for DMA",
>>> -                         section->offset_within_region,
>>> +                         memory_region_name(section->mr),
>>> +                         section->offset_within_address_space,
>>>                           int128_getlo(section->size),
>>>                           pgmask + 1);
>>>              return;
>>>
> 
> 

(qemu) info mtree -f
info mtree -f
FlatView #0
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 AS "cpu-memory-1", root: system
 AS "cpu-memory-2", root: system
 AS "cpu-memory-3", root: system
 AS "vfio-pci", root: bus master container
 AS "virtio-scsi-pci", root: bus master container
 Root memory region: system
  0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
  0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
  0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
  0000000008080000-000000000808ffff (prio 0, i/o): control
  0000000008090000-000000000809ffff (prio 0, i/o): translation
  00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
  0000000009000000-0000000009000fff (prio 0, i/o): pl011
  0000000009010000-0000000009010fff (prio 0, i/o): pl031
  0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
  0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
  0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
  0000000009030000-0000000009030fff (prio 0, i/o): pl061
  000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
  000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
  000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
  000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
  000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
  000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
  000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
  000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
  000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
  000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
  000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
  000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
  000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
  000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
  000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
  000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
  000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
  000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
  000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
  000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
  000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
  000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
  000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
  000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
  000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
  000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
  000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
  000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
  000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
  000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
  000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
  000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
  0000000010000000-000000001007ffff (prio 0, ramd): 0004:01:00.0 BAR 1 mmaps[0]
  00000000100c0000-00000000100dffff (prio 0, ramd): 0004:01:00.0 BAR 0 mmaps[0]
  00000000100e0000-00000000100e004f (prio 0, i/o): msix-table
  00000000100e0050-00000000100e3fff (prio 0, ramd): 0004:01:00.0 BAR 3 mmaps[0] @0000000000000050
  00000000100e4000-00000000100e403f (prio 0, i/o): msix-table
  00000000100e4040-00000000100e47ff (prio 0, ramd): 0004:01:00.0 BAR 3 mmaps[0] @0000000000004040
  00000000100e4800-00000000100e4807 (prio 0, i/o): msix-pba
  00000000100e4808-00000000100effff (prio 0, ramd): 0004:01:00.0 BAR 3 mmaps[0] @0000000000004808
  000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
  000000003f000000-000000003fffffff (prio 0, i/o): pcie-mmcfg-mmio
  0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
  0000008000000000-0000008000000fff (prio 0, i/o): virtio-pci-common
  0000008000001000-0000008000001fff (prio 0, i/o): virtio-pci-isr
  0000008000002000-0000008000002fff (prio 0, i/o): virtio-pci-device
  0000008000003000-0000008000003fff (prio 0, i/o): virtio-pci-notify

FlatView #1
 AS "I/O", root: io
 Root memory region: io
  0000000000000000-000000000000ffff (prio 0, i/o): io

FlatView #2
 AS "gpex-root", root: bus master container
 Root memory region: (none)
  No rendered FlatView

(qemu)
(qemu)

(qemu) info mtree
info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff

address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io

address-space: cpu-memory-0
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff

address-space: cpu-memory-1
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff

address-space: cpu-memory-2
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff

address-space: cpu-memory-3
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff

address-space: gpex-root
  0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
    0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @system 0000000000000000-ffffffffffffffff [disabled]

address-space: vfio-pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
    0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @system 0000000000000000-ffffffffffffffff

address-space: virtio-scsi-pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
    0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @system 0000000000000000-ffffffffffffffff

memory-region: gpex_mmio
  0000000000000000-ffffffffffffffff (prio 0, i/o): gpex_mmio
    0000000010000000-000000001007ffff (prio 1, i/o): 0004:01:00.0 base BAR 1
      0000000010000000-000000001007ffff (prio 0, i/o): 0004:01:00.0 BAR 1
        0000000010000000-000000001007ffff (prio 0, ramd): 0004:01:00.0 BAR 1 mmaps[0]
    00000000100c0000-00000000100dffff (prio 1, i/o): 0004:01:00.0 base BAR 0
      00000000100c0000-00000000100dffff (prio 0, i/o): 0004:01:00.0 BAR 0
        00000000100c0000-00000000100dffff (prio 0, ramd): 0004:01:00.0 BAR 0 mmaps[0]
    00000000100e0000-00000000100effff (prio 0, i/o): 0004:01:00.0 base BAR 3
      00000000100e0000-00000000100e004f (prio 0, i/o): msix-table
      00000000100e0000-00000000100effff (prio 0, i/o): 0004:01:00.0 BAR 3
        00000000100e0000-00000000100effff (prio 0, ramd): 0004:01:00.0 BAR 3 mmaps[0]
      00000000100e2000-00000000100e2007 (prio 0, i/o): msix-pba [disabled]
    00000000100e4000-00000000100e4fff (prio 1, i/o): virtio-scsi-pci-msix
      00000000100e4000-00000000100e403f (prio 0, i/o): msix-table
      00000000100e4800-00000000100e4807 (prio 0, i/o): msix-pba
    0000008000000000-0000008000003fff (prio 1, i/o): virtio-pci
      0000008000000000-0000008000000fff (prio 0, i/o): virtio-pci-common
      0000008000001000-0000008000001fff (prio 0, i/o): virtio-pci-isr
      0000008000002000-0000008000002fff (prio 0, i/o): virtio-pci-device
      0000008000003000-0000008000003fff (prio 0, i/o): virtio-pci-notify

memory-region: pcie-mmcfg-mmio
  0000000000000000-000000001fffffff (prio 0, i/o): pcie-mmcfg-mmio

memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-000000000811ffff (prio 0, i/o): gicv3_redist
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
    000000000a000200-000000000a0003ff (prio 0, i/o): virtio-mmio
    000000000a000400-000000000a0005ff (prio 0, i/o): virtio-mmio
    000000000a000600-000000000a0007ff (prio 0, i/o): virtio-mmio
    000000000a000800-000000000a0009ff (prio 0, i/o): virtio-mmio
    000000000a000a00-000000000a000bff (prio 0, i/o): virtio-mmio
    000000000a000c00-000000000a000dff (prio 0, i/o): virtio-mmio
    000000000a000e00-000000000a000fff (prio 0, i/o): virtio-mmio
    000000000a001000-000000000a0011ff (prio 0, i/o): virtio-mmio
    000000000a001200-000000000a0013ff (prio 0, i/o): virtio-mmio
    000000000a001400-000000000a0015ff (prio 0, i/o): virtio-mmio
    000000000a001600-000000000a0017ff (prio 0, i/o): virtio-mmio
    000000000a001800-000000000a0019ff (prio 0, i/o): virtio-mmio
    000000000a001a00-000000000a001bff (prio 0, i/o): virtio-mmio
    000000000a001c00-000000000a001dff (prio 0, i/o): virtio-mmio
    000000000a001e00-000000000a001fff (prio 0, i/o): virtio-mmio
    000000000a002000-000000000a0021ff (prio 0, i/o): virtio-mmio
    000000000a002200-000000000a0023ff (prio 0, i/o): virtio-mmio
    000000000a002400-000000000a0025ff (prio 0, i/o): virtio-mmio
    000000000a002600-000000000a0027ff (prio 0, i/o): virtio-mmio
    000000000a002800-000000000a0029ff (prio 0, i/o): virtio-mmio
    000000000a002a00-000000000a002bff (prio 0, i/o): virtio-mmio
    000000000a002c00-000000000a002dff (prio 0, i/o): virtio-mmio
    000000000a002e00-000000000a002fff (prio 0, i/o): virtio-mmio
    000000000a003000-000000000a0031ff (prio 0, i/o): virtio-mmio
    000000000a003200-000000000a0033ff (prio 0, i/o): virtio-mmio
    000000000a003400-000000000a0035ff (prio 0, i/o): virtio-mmio
    000000000a003600-000000000a0037ff (prio 0, i/o): virtio-mmio
    000000000a003800-000000000a0039ff (prio 0, i/o): virtio-mmio
    000000000a003a00-000000000a003bff (prio 0, i/o): virtio-mmio
    000000000a003c00-000000000a003dff (prio 0, i/o): virtio-mmio
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpex_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff103f (prio 1, i/o): virtio-pci
    000000003f000000-000000003fffffff (prio 0, i/o): alias pcie-ecam @pcie-mmcfg-mmio 0000000000000000-0000000000ffffff
    0000000040000000-000000023fffffff (prio 0, ram): mach-virt.ram
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio 0000008000000000-000000ffffffffff
