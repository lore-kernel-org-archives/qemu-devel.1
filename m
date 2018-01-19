Received: from eggs.gnu.org ([2001:4830:134:3::10]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecRaj-0003ON-L0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecRah-00073l-1d
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:00:01 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:40828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ecRag-000737-O5
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:59:58 -0500
Received: by mail-it0-x242.google.com with SMTP id 196so1152115iti.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 23:59:58 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180118034732.10439-1-aik@ozlabs.ru>
	<d36e66a5-8616-0cfe-033c-c2214cd1ba62@ozlabs.ru>
Message-ID: <2dfc15e8-95ab-c33b-4abe-01ec30c94fd9@ozlabs.ru>
Date: Fri, 19 Jan 2018 18:59:51 +1100
MIME-Version: 1.0
In-Reply-To: <d36e66a5-8616-0cfe-033c-c2214cd1ba62@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_pci: Alias MMIO windows to PHB
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On 18/01/18 16:33, Alexey Kardashevskiy wrote:
> On 18/01/18 14:47, Alexey Kardashevskiy wrote:
>> At the moment the sPAPR PHB MMIO space does not have an address space
>> object as it does not really need one - guest accesses it via virtual
>> addresses (and we provide mappings to the CPU space), the device drivers
>> in QEMU access MMIO directly (as they own MRs). The only case when
>> a driver in QEMU might need an address space (AS) is DMA so we provide one
>> with only IOMMUs on it.
>>
>> So PHB AS looks like:
>> address-space: pci@800000020000000
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.iommu-root
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001
>>       0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000
>>       0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
>>     0000040000000000-000004000000ffff (prio 0, i/o): msi
>>
>> with no mention of any PCI device, and so does the flatview:
>>
>>  FlatView #2
>>   AS "pci@800000020000000", root: pci@800000020000000.iommu-root
>>   AS "nec-usb-xhci", root: bus master container
>>   Root memory region: pci@800000020000000.iommu-root
>>    0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
>>
>> This adds 2 more aliases (for MMIO32 and MMIO64 windows) on PHB AS so
>> whatever appears on the bus can be seen in "info mtree [-f]".
>>
>> Here are the chunks from "diff" for a QEMU with an emulater XHCI adapter:
>>
>>  address-space: pci@800000020000000
>>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.iommu-root
>>      0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001
>>        0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001
>>      0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000
>>        0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
>> +    0000000080000000-00000000ffffffff (prio 0, i/o): alias pci@800000020000000.mmio32-alias-pci @pci@800000020000000.mmio3
>> +2-alias 0000000000000000-000000007fffffff
>>      0000040000000000-000004000000ffff (prio 0, i/o): msi
>> +    0000210000000000-000021ffffffffff (prio 0, i/o): alias pci@800000020000000.mmio64-alias-pci @pci@800000020000000.mmio6
>> +4-alias 0000000000000000-000000ffffffffff
>>
>>
>>  FlatView #2
>>   AS "pci@800000020000000", root: pci@800000020000000.iommu-root
>>   AS "nec-usb-xhci", root: bus master container
>>   Root memory region: pci@800000020000000.iommu-root
>>    0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
>> +  0000000080000000-000000008000003f (prio 0, i/o): capabilities
>> +  0000000080000040-000000008000043f (prio 0, i/o): operational
>> +  0000000080000440-000000008000044f (prio 0, i/o): usb3 port #1
>> +  0000000080000450-000000008000045f (prio 0, i/o): usb3 port #2
>> +  0000000080000460-000000008000046f (prio 0, i/o): usb3 port #3
>> +  0000000080000470-000000008000047f (prio 0, i/o): usb3 port #4
>> +  0000000080000480-000000008000048f (prio 0, i/o): usb2 port #1
>> +  0000000080000490-000000008000049f (prio 0, i/o): usb2 port #2
>> +  00000000800004a0-00000000800004af (prio 0, i/o): usb2 port #3
>> +  00000000800004b0-00000000800004bf (prio 0, i/o): usb2 port #4
>> +  0000000080001000-000000008000121f (prio 0, i/o): runtime
>> +  0000000080002000-000000008000281f (prio 0, i/o): doorbell
>> +  0000000080003000-00000000800030ff (prio 0, i/o): msix-table
>> +  0000000080003800-0000000080003807 (prio 0, i/o): msix-pba
>>    0000040000000000-000004000000ffff (prio 0, i/o): msi
>>    0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001



Things are actually worse, with this applied + VFIO, an MMIO/RAM MR
"0001:01:00.3 BAR 0 mmaps[0]" appears on "pci@800000020000000":

FlatView #2
 AS "pci@800000020000000", root: pci@800000020000000.iommu-root
 AS "vfio-pci", root: bus master container
 Root memory region: pci@800000020000000.iommu-root
  0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
  0000040000000000-000004000000ffff (prio 0, i/o): msi
  0000210000000000-0000210000001fff (prio 0, i/o): 0001:01:00.3 BAR 0
  0000210000002000-00002100000020bf (prio 0, i/o): msix-table
  00002100000020c0-000021000000ffff (prio 0, i/o): 0001:01:00.3 BAR 0
@00000000000020c0
  0000210000010000-0000210001ffffff (prio 0, ramd): 0001:01:00.3 BAR 0 mmaps[0]
  0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001


vfio_listener_region_add() tries creating a window as it does only check
the container type (was sufficient so far). So I am putting this on hold
but I still wonder if the while idea makes sense. Thanks.


Alex, I did not cc: you as I believed it is a spapr business but turns out
this affects how we proceed with vfio_listener_skipped_section() and
vfio_listener_region_add() as not hw_error-ing on vfio_dma_map() if
memory_region_is_ram_device() won't be enough on spapr.






>>
>> The major point for this is to help debugging overlapped regions.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Should not we do this in the common code really?
> 
> 
> By this I meant not literally map memory space from pci_register_root_bus()
> (as it is 64bit wide, subregions are the windows) but still do something to
> see devices on a PCI AS. Now PHB does not have an AS on my x86 setup.
> 
> 
> and ...
> 
> 
> 
>> Does this look useful at all? I was quite confused when I realized that
>> I do not see an AS with DMA windows and MMIO while they co-exist
>> on a bus.
>>
>>
>> ---
>>  include/hw/pci-host/spapr.h |  1 +
>>  hw/ppc/spapr_pci.c          | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 0fae4fc..4550192 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -57,6 +57,7 @@ struct sPAPRPHBState {
>>      uint64_t mem64_win_pciaddr;
>>      hwaddr io_win_addr, io_win_size;
>>      MemoryRegion mem32window, mem64window, iowindow, msiwindow;
>> +    MemoryRegion mem32windowpci, mem64windowpci;
>>  
>>      uint32_t dma_liobn[SPAPR_PCI_DMA_MAX_WINDOWS];
>>      hwaddr dma_win_addr, dma_win_size;
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 37f18b3..d142f74 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1642,6 +1642,18 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>      address_space_init(&sphb->iommu_as, &sphb->iommu_root,
>>                         sphb->dtbusname);
>>  
>> +    /* Map memory space onto the PHB address space */
>> +    namebuf = g_strdup_printf("%s.mmio32-alias-pci", sphb->dtbusname);
>> +    memory_region_init_alias(&sphb->mem32windowpci, OBJECT(sphb), namebuf,
>> +                             &sphb->mem32window, 0, sphb->mem_win_size);
>> +    memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MEM_WIN_BUS_OFFSET,
>> +                                &sphb->mem32windowpci);
>> +    namebuf = g_strdup_printf("%s.mmio64-alias-pci", sphb->dtbusname);
>> +    memory_region_init_alias(&sphb->mem64windowpci, OBJECT(sphb), namebuf,
>> +                             &sphb->mem64window, 0, sphb->mem64_win_size);
>> +    memory_region_add_subregion(&sphb->iommu_root, sphb->mem64_win_pciaddr,
>> +                                &sphb->mem64windowpci);
> 
> 
> ... I just noticed - this leaks @namebuf memory, I'll fix it in v2 if no
> other comment arrive.
> 
> 
>> +
>>      /*
>>       * As MSI/MSIX interrupts trigger by writing at MSI/MSIX vectors,
>>       * we need to allocate some memory to catch those writes coming
>>
> 
> 


-- 
Alexey
