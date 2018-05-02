Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDncM-0002JD-He
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDncL-00017h-8p
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:00:06 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:45236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fDncH-00014s-6h
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:00:05 -0400
Received: by mail-io0-x242.google.com with SMTP id c9-v6so10235024iob.12
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 02:00:01 -0700 (PDT)
References: <20180502044557.21035-1-aik@ozlabs.ru>
	<20180502063706.GD3517@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <43ff86df-7368-3857-1443-2cbde839039b@ozlabs.ru>
Date: Wed, 2 May 2018 18:59:53 +1000
MIME-Version: 1.0
In-Reply-To: <20180502063706.GD3517@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow backing bigger
 guest IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 2/5/18 4:37 pm, David Gibson wrote:
> On Wed, May 02, 2018 at 02:45:57PM +1000, Alexey Kardashevskiy wrote:
>> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
>> pages and POWER8 CPU supports the exact same set of page size so
>> so far things worked fine.
>>
>> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
>> the last two - 2M and 1G - are not even allowed in the paravirt interface
>> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
>> back guest's 16MB IOMMU pages with 2MB pages on the host.
>>
>> This stores the supported host IOMMU page sizes in VFIOContainer and uses
>> this later when creating a new DMA window.
>>
>> There should be no behavioral changes on platforms other than pseries.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> What will happen if you try to use this on an older kernel without
> your mismatching pagesize changes?

I tried 1GB huge pages and "-global spapr-pci-host-bridge.pgsz=0x1011000"
or 0x41011000.

With or without this change and kernel change, the P9 host says:

pci 0001:01     : [PE# fd] Disabling 64-bit DMA bypass

pci 0001:01     : [PE# fd] Removing DMA window #0

pci 0001:01     : [PE# fd] Setting up window#0 0..3fffffff pg=1000

pci 0001:01     : [PE# fd] Setting up window#1
800000000000000..800001fffffffff pg=1000000
pci 0001:01     : [PE# fd] Failed to configure TCE table, err -1

pci 0001:01     : [PE# fd] Removing DMA window #1


Which is a failure from opal_pci_map_pe_dma_window().

QEMU calls hw_error:

xhci_hcd 0000:00:00.0: xHCI Host Controller
xhci_hcd 0000:00:00.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:00.0: node is /pci@800000020000000/usb@0
5700@1525248659.671888:spapr_iommu_ddw_query buid=0x800000020000000
addr=0x0, 1 windows available, max window size=0x800000
00, mask=0x7
xhci_hcd 0000:00:00.0: ibm,query-pe-dma-windows(2026) 0 8000000 20000000
returned 0
5700@1525248659.672138:spapr_iommu_new_table liobn=0x80000001
table=0x7fffb9080000 fd=26
qemu-system-ppc64: Failed to create a window, ret = -1 (Operation not
permitted)
qemu: hardware error: vfio: DMA mapping failed, unable to continue
CPU #0:
NIP 000000000daf0010   LR 000000000000c11c CTR c00000000fe80000 XER
0000000020040000 CPU#0
MSR 0000000002001000 HID0 0000000000000000  HF 8000000000000000 iidx 3 didx 3
TB 00000000 00000000 DECR 00000000
GPR00 8000000002001031 c00000007e503230 c0000000013a1f00 000000000000f000
GPR04 00000000014007d0 000000000daf0000 0000000002001000 8000000002001033
GPR08 0000000000000000 8000000000002933 000000000000000c 000000000daf0000
GPR12 0000000000008000 c00000000fe80000 c00000000000def8 0000000008000000
GPR16 0000000000000000 0000000020000000 000000000000001f 0000000000000000
GPR20 c00000007e034440 0000000000000018 c000000009164900 c00000007fffab78
GPR24 c0000000012e6768 c000000001529394 0000000000000001 0000000000000005
GPR28 0000000000002027 c0000000014007b0 c00000007e50351c 0000000000000004




aaand I found a bug below...


> 
>> ---
>>  include/hw/vfio/vfio-common.h |  1 +
>>  hw/vfio/common.c              |  3 +++
>>  hw/vfio/spapr.c               | 15 ++++++++++++++-
>>  3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index d936014..dd8d0d3 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -83,6 +83,7 @@ typedef struct VFIOContainer {
>>      unsigned iommu_type;
>>      int error;
>>      bool initialized;
>> +    unsigned long pgsizes;
>>      /*
>>       * This assumes the host IOMMU can support only a single
>>       * contiguous IOVA window.  We may need to generalize that in
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 07ffa0b..15ddef2 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1103,6 +1103,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>              info.iova_pgsizes = 4096;
>>          }
>>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
>> +        container->pgsizes = info.iova_pgsizes;
>>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
>>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
>>          struct vfio_iommu_spapr_tce_info info;
>> @@ -1167,6 +1168,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>          }
>>  
>>          if (v2) {
>> +            container->pgsizes = info.ddw.pgsizes;
>>              /*
>>               * There is a default window in just created container.
>>               * To make region_add/del simpler, we better remove this
>> @@ -1181,6 +1183,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>              }
>>          } else {
>>              /* The default table uses 4K pages */
>> +            container->pgsizes = 0x1000;
>>              vfio_host_win_add(container, info.dma32_window_start,
>>                                info.dma32_window_start +
>>                                info.dma32_window_size - 1,
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 259397c..9637ed5 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -144,11 +144,24 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>  {
>>      int ret;
>>      IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>> -    unsigned pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>> +    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>>      unsigned entries, pages;
>>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
>>  
>>      /*
>> +     * The host might not support the guest supported IOMMU page size,
>> +     * so we will use smaller physical IOMMU pages to back them.
>> +     */
>> +    pagesize = 1ULL << ctz64(container->pgsizes & (pagesize | (pagesize - 1)));



... and here is a bug - must be:

pagesize = 1ULL << (63 - clz64(container->pgsizes &
                               (pagesize | (pagesize - 1))));


With the original version, it picked 4K page size, created a huge window
with 4K pages but KVM VFIO device did not attach to LIOBN because of page
size mismatch (guest sees 16M, vfio sees 4K) so actual TCE table remained
empty and EEH happened (and recovered later after killing QEMU).




>> +    if (!pagesize) {
>> +        error_report("Host doesn't support page size 0x%"PRIx64
>> +                     ", the supported mask is 0x%lx",
>> +                     memory_region_iommu_get_min_page_size(iommu_mr),
>> +                     container->pgsizes);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>>       * FIXME: For VFIO iommu types which have KVM acceleration to
>>       * avoid bouncing all map/unmaps through qemu this way, this
>>       * would be the right place to wire that up (tell the KVM
> 


-- 
Alexey
