Received: from eggs.gnu.org ([2001:4830:134:3::10]:57400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eZQPQ-00062l-3w
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eZQPL-0002KS-Of
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:07:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1eZQPL-0002Gp-Bd
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:07:47 -0500
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171201112952.GC31366@sky-dev>
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-ID: <11a95513-73af-7a80-48bf-f78fa8740439@oracle.com>
Date: Wed, 10 Jan 2018 16:05:33 -0800
MIME-Version: 1.0
In-Reply-To: <20171201112952.GC31366@sky-dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, imammedo@redhat.com, peterx@redhat.com, konrad.wilk@oracle.com


Hi Yi L,

On 12/1/2017 3:29 AM, Liu, Yi L wrote:
> On Tue, Nov 14, 2017 at 06:13:50PM -0500, prasad.singamsetty@oracle.com wrote:
>> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>>
>> The current implementation of Intel IOMMU code only supports 39 bits
>> iova address width. This patch provides a new parameter (x-aw-bits)
>> for intel-iommu to extend its address width to 48 bits but keeping the
>> default the same (39 bits). The reason for not changing the default
>> is to avoid potential compatibility problems with live migration of
>> intel-iommu enabled QEMU guest. The only valid values for 'x-aw-bits'
>> parameter are 39 and 48.
>>
>> After enabling larger address width (48), we should be able to map
>> larger iova addresses in the guest. For example, a QEMU guest that
>> is configured with large memory ( >=1TB ). To check whether 48 bits
>> aw is enabled, we can grep in the guest dmesg output with line:
>> "DMAR: Host address width 48".
>>
>> Signed-off-by: Prasad Singamsetty <prasad.singamsety@oracle.com>
> 
> Prasad,
> 
> Have you tested the scenario with physical device assigned to a guest?

Sorry for the long delay in following up on this.

I did some testing with vfio-pci devices assigned to the guest.
This is done on the latest qemu code base (2.11.50).

Here are the test cases/results:

1. Booting VM with one or two vfio-pci (network) devices
    and multiple memory size configs (up to 256G). Assigned pci
    devices (network interfaces) worked fine and no issues
    in using these devices. This test is run for both address
    widths (39 and 48).
2. If the guest VM is configured to use 512G and address
    width is the default 39 bits then guest OS fails to
    boot due to DMA failures. The same is observed without
    applying the patch set. The guest OS ends up booting into
    dracut shell. This problem is not seen if we set the address
    width to 48 bits. So, the patch set addresses a latent bug
    with large memory config.

ISSUE - VM could take long time to boot with vfio-pci devices

Qemu process could take a long time to initialize the VM
when vfio-pci device is configured depending on the
memory size. For small memory sizes (less than 32G) it is
not noticeable (<30s). For larger memory sizes, the delay ranges
from several minutes and longer (2-40min). For more than 512G, qemu
process appears to hang but can be interrupted. This behavior
is observed without patch set applied also. The slowness is due
to VFIO_IOMMU_MAP_DMA ioctl taking long time to map the
system ram assigned to the guest. This is when qemu process
is initializing the vfio device where it maps all the assigned
ram memory regions. Here is the stack trace from gdb:

#0  vfio_dma_map (container=0x5555582709d0, iova=4294967296,
                   size=547608330240, vaddr=0x7f7fd3e00000,
                   readonly=false)
     at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:250
#1  0x000055555584f471 in vfio_listener_region_add(
                   listener=0x5555582709e0,
                   section=0x7fffffffc7f0)
     at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:521
#2  0x00005555557f08fc in listener_add_address_space (
                   listener=0x5555582709e0, as=0x55555813b790)
     at /home/psingams/qemu-upstream-v2/memory.c:2600
#3  0x00005555557f0bbe in memory_listener_register (
                   listener=0x5555582709e0, as=0x55555813b790)
     at /home/psingams/qemu-upstream-v2/memory.c:2643
#4  0x00005555558511ef in vfio_connect_container (group=0x555558270960,
                   as=0x55555813b790, errp=0x7fffffffdae8)
     at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:1130
****
(gdb) print/x size
$2 = 0x7f80000000

This is before guest OS gets to boot. The host is running 4.15.0-rc6
kernel with qemu version 2.11.50.

I am not sure if this is a known issue and someone is already
working on fixing the implementation of VFIO_IOMMU_MAP_DMA ioctl.

This issue is not related to this patch set and need to be
investigated separately.

Please let me know if there are other comments on this patch set.

Regards,
--Prasad

> 
> Regards,
> Yi L
>> ---
>>   hw/i386/acpi-build.c           |   3 +-
>>   hw/i386/intel_iommu.c          | 101 ++++++++++++++++++++++++-----------------
>>   hw/i386/intel_iommu_internal.h |   9 ++--
>>   include/hw/i386/intel_iommu.h  |   1 +
>>   4 files changed, 65 insertions(+), 49 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 73519ab3ac..537957c89a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2460,6 +2460,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>>       AcpiDmarDeviceScope *scope = NULL;
>>       /* Root complex IOAPIC use one path[0] only */
>>       size_t ioapic_scope_size = sizeof(*scope) + sizeof(scope->path[0]);
>> +    IntelIOMMUState *intel_iommu = INTEL_IOMMU_DEVICE(iommu);
>>   
>>       assert(iommu);
>>       if (iommu->intr_supported) {
>> @@ -2467,7 +2468,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>>       }
>>   
>>       dmar = acpi_data_push(table_data, sizeof(*dmar));
>> -    dmar->host_address_width = VTD_HOST_ADDRESS_WIDTH - 1;
>> +    dmar->host_address_width = intel_iommu->aw_bits - 1;
>>       dmar->flags = dmar_flags;
>>   
>>       /* DMAR Remapping Hardware Unit Definition structure */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 53b3bf244d..c2380fdfdc 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -521,9 +521,9 @@ static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
>>       return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
>>   }
>>   
>> -static inline uint64_t vtd_get_slpte_addr(uint64_t slpte)
>> +static inline uint64_t vtd_get_slpte_addr(uint64_t slpte, uint8_t aw)
>>   {
>> -    return slpte & VTD_SL_PT_BASE_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
>> +    return slpte & VTD_SL_PT_BASE_ADDR_MASK(aw);
>>   }
>>   
>>   /* Whether the pte indicates the address of the page frame */
>> @@ -608,20 +608,21 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
>>       return true;
>>   }
>>   
>> -static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
>> +static inline uint64_t vtd_iova_limit(VTDContextEntry *ce, uint8_t aw)
>>   {
>>       uint32_t ce_agaw = vtd_ce_get_agaw(ce);
>> -    return 1ULL << MIN(ce_agaw, VTD_MGAW);
>> +    return 1ULL << MIN(ce_agaw, aw);
>>   }
>>   
>>   /* Return true if IOVA passes range check, otherwise false. */
>> -static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce)
>> +static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce,
>> +                                        uint8_t aw)
>>   {
>>       /*
>>        * Check if @iova is above 2^X-1, where X is the minimum of MGAW
>>        * in CAP_REG and AW in context-entry.
>>        */
>> -    return !(iova & ~(vtd_iova_limit(ce) - 1));
>> +    return !(iova & ~(vtd_iova_limit(ce, aw) - 1));
>>   }
>>   
>>   /*
>> @@ -669,7 +670,7 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
>>    */
>>   static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
>>                                uint64_t *slptep, uint32_t *slpte_level,
>> -                             bool *reads, bool *writes)
>> +                             bool *reads, bool *writes, uint8_t aw_bits)
>>   {
>>       dma_addr_t addr = vtd_ce_get_slpt_base(ce);
>>       uint32_t level = vtd_ce_get_level(ce);
>> @@ -677,7 +678,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
>>       uint64_t slpte;
>>       uint64_t access_right_check;
>>   
>> -    if (!vtd_iova_range_check(iova, ce)) {
>> +    if (!vtd_iova_range_check(iova, ce, aw_bits)) {
>>           trace_vtd_err_dmar_iova_overflow(iova);
>>           return -VTD_FR_ADDR_BEYOND_MGAW;
>>       }
>> @@ -714,7 +715,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
>>               *slpte_level = level;
>>               return 0;
>>           }
>> -        addr = vtd_get_slpte_addr(slpte);
>> +        addr = vtd_get_slpte_addr(slpte, aw_bits);
>>           level--;
>>       }
>>   }
>> @@ -732,11 +733,12 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
>>    * @read: whether parent level has read permission
>>    * @write: whether parent level has write permission
>>    * @notify_unmap: whether we should notify invalid entries
>> + * @aw: maximum address width
>>    */
>>   static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>>                                  uint64_t end, vtd_page_walk_hook hook_fn,
>> -                               void *private, uint32_t level,
>> -                               bool read, bool write, bool notify_unmap)
>> +                               void *private, uint32_t level, bool read,
>> +                               bool write, bool notify_unmap, uint8_t aw)
>>   {
>>       bool read_cur, write_cur, entry_valid;
>>       uint32_t offset;
>> @@ -783,7 +785,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>>               entry.target_as = &address_space_memory;
>>               entry.iova = iova & subpage_mask;
>>               /* NOTE: this is only meaningful if entry_valid == true */
>> -            entry.translated_addr = vtd_get_slpte_addr(slpte);
>> +            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
>>               entry.addr_mask = ~subpage_mask;
>>               entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
>>               if (!entry_valid && !notify_unmap) {
>> @@ -803,10 +805,10 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>>                   trace_vtd_page_walk_skip_perm(iova, iova_next);
>>                   goto next;
>>               }
>> -            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte), iova,
>> +            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw), iova,
>>                                         MIN(iova_next, end), hook_fn, private,
>>                                         level - 1, read_cur, write_cur,
>> -                                      notify_unmap);
>> +                                      notify_unmap, aw);
>>               if (ret < 0) {
>>                   return ret;
>>               }
>> @@ -827,25 +829,26 @@ next:
>>    * @end: IOVA range end address (start <= addr < end)
>>    * @hook_fn: the hook that to be called for each detected area
>>    * @private: private data for the hook function
>> + * @aw: maximum address width
>>    */
>>   static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
>>                            vtd_page_walk_hook hook_fn, void *private,
>> -                         bool notify_unmap)
>> +                         bool notify_unmap, uint8_t aw)
>>   {
>>       dma_addr_t addr = vtd_ce_get_slpt_base(ce);
>>       uint32_t level = vtd_ce_get_level(ce);
>>   
>> -    if (!vtd_iova_range_check(start, ce)) {
>> +    if (!vtd_iova_range_check(start, ce, aw)) {
>>           return -VTD_FR_ADDR_BEYOND_MGAW;
>>       }
>>   
>> -    if (!vtd_iova_range_check(end, ce)) {
>> +    if (!vtd_iova_range_check(end, ce, aw)) {
>>           /* Fix end so that it reaches the maximum */
>> -        end = vtd_iova_limit(ce);
>> +        end = vtd_iova_limit(ce, aw);
>>       }
>>   
>>       return vtd_page_walk_level(addr, start, end, hook_fn, private,
>> -                               level, true, true, notify_unmap);
>> +                               level, true, true, notify_unmap, aw);
>>   }
>>   
>>   /* Map a device to its corresponding domain (context-entry) */
>> @@ -867,7 +870,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>           return -VTD_FR_ROOT_ENTRY_P;
>>       }
>>   
>> -    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD(VTD_HOST_ADDRESS_WIDTH))) {
>> +    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD(s->aw_bits))) {
>>           trace_vtd_re_invalid(re.rsvd, re.val);
>>           return -VTD_FR_ROOT_ENTRY_RSVD;
>>       }
>> @@ -884,7 +887,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>       }
>>   
>>       if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
>> -               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(VTD_HOST_ADDRESS_WIDTH))) {
>> +               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
>>           trace_vtd_ce_invalid(ce->hi, ce->lo);
>>           return -VTD_FR_CONTEXT_ENTRY_RSVD;
>>       }
>> @@ -1166,7 +1169,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>       }
>>   
>>       ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
>> -                               &reads, &writes);
>> +                               &reads, &writes, s->aw_bits);
>>       if (ret_fr) {
>>           ret_fr = -ret_fr;
>>           if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
>> @@ -1183,7 +1186,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>                        access_flags, level);
>>   out:
>>       entry->iova = addr & page_mask;
>> -    entry->translated_addr = vtd_get_slpte_addr(slpte) & page_mask;
>> +    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
>>       entry->addr_mask = ~page_mask;
>>       entry->perm = access_flags;
>>       return true;
>> @@ -1200,7 +1203,7 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
>>   {
>>       s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
>>       s->root_extended = s->root & VTD_RTADDR_RTT;
>> -    s->root &= VTD_RTADDR_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
>> +    s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
>>   
>>       trace_vtd_reg_dmar_root(s->root, s->root_extended);
>>   }
>> @@ -1216,7 +1219,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
>>       uint64_t value = 0;
>>       value = vtd_get_quad_raw(s, DMAR_IRTA_REG);
>>       s->intr_size = 1UL << ((value & VTD_IRTA_SIZE_MASK) + 1);
>> -    s->intr_root = value & VTD_IRTA_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
>> +    s->intr_root = value & VTD_IRTA_ADDR_MASK(s->aw_bits);
>>       s->intr_eime = value & VTD_IRTA_EIME;
>>   
>>       /* Notify global invalidation */
>> @@ -1392,7 +1395,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>>           if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
>>               vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
>>                             vtd_page_invalidate_notify_hook,
>> -                          (void *)&vtd_as->iommu, true);
>> +                          (void *)&vtd_as->iommu, true, s->aw_bits);
>>           }
>>       }
>>   }
>> @@ -1472,7 +1475,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
>>       trace_vtd_inv_qi_enable(en);
>>   
>>       if (en) {
>> -        s->iq = iqa_val & VTD_IQA_IQA_MASK(VTD_HOST_ADDRESS_WIDTH);
>> +        s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
>>           /* 2^(x+8) entries */
>>           s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
>>           s->qi_enabled = true;
>> @@ -2403,6 +2406,8 @@ static Property vtd_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
>>                               ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>> +    DEFINE_PROP_UINT8("x-aw-bits", IntelIOMMUState, aw_bits,
>> +                      VTD_HOST_ADDRESS_WIDTH),
>>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> @@ -2758,6 +2763,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>       hwaddr size;
>>       hwaddr start = n->start;
>>       hwaddr end = n->end;
>> +    IntelIOMMUState *s = as->iommu_state;
>>   
>>       /*
>>        * Note: all the codes in this function has a assumption that IOVA
>> @@ -2765,12 +2771,12 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>        * VT-d spec), otherwise we need to consider overflow of 64 bits.
>>        */
>>   
>> -    if (end > VTD_ADDRESS_SIZE(VTD_HOST_ADDRESS_WIDTH)) {
>> +    if (end > VTD_ADDRESS_SIZE(s->aw_bits)) {
>>           /*
>>            * Don't need to unmap regions that is bigger than the whole
>>            * VT-d supported address space size
>>            */
>> -        end = VTD_ADDRESS_SIZE(VTD_HOST_ADDRESS_WIDTH);
>> +        end = VTD_ADDRESS_SIZE(s->aw_bits);
>>       }
>>   
>>       assert(start <= end);
>> @@ -2782,9 +2788,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>            * suite the minimum available mask.
>>            */
>>           int n = 64 - clz64(size);
>> -        if (n > VTD_MGAW) {
>> +        if (n > s->aw_bits) {
>>               /* should not happen, but in case it happens, limit it */
>> -            n = VTD_MGAW;
>> +            n = s->aw_bits;
>>           }
>>           size = 1ULL << n;
>>       }
>> @@ -2844,7 +2850,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>>                                     PCI_FUNC(vtd_as->devfn),
>>                                     VTD_CONTEXT_ENTRY_DID(ce.hi),
>>                                     ce.hi, ce.lo);
>> -        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false);
>> +        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
>> +                      s->aw_bits);
>>       } else {
>>           trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
>>                                       PCI_FUNC(vtd_as->devfn));
>> @@ -2859,7 +2866,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>>   static void vtd_init(IntelIOMMUState *s)
>>   {
>>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>> -    uint8_t aw_bits = VTD_HOST_ADDRESS_WIDTH;
>>   
>>       memset(s->csr, 0, DMAR_REG_SIZE);
>>       memset(s->wmask, 0, DMAR_REG_SIZE);
>> @@ -2878,21 +2884,24 @@ static void vtd_init(IntelIOMMUState *s)
>>       s->next_frcd_reg = 0;
>>       s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>>                VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
>> -             VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(VTD_HOST_ADDRESS_WIDTH);
>> +             VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
>> +    if (s->aw_bits == VTD_HOST_AW_48BIT) {
>> +        s->cap |= VTD_CAP_SAGAW_48bit;
>> +    }
>>       s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
>>   
>>       /*
>>        * Rsvd field masks for spte
>>        */
>>       vtd_paging_entry_rsvd_field[0] = ~0ULL;
>> -    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(aw_bits);
>> -    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(aw_bits);
>> +    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
>> +    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
>>   
>>       if (x86_iommu->intr_supported) {
>>           s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
>> @@ -3029,6 +3038,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>           }
>>       }
>>   
>> +    /* Currently only address widths supported are 39 and 48 bits */
>> +    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
>> +        (s->aw_bits != VTD_HOST_AW_48BIT)) {
>> +        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
>> +                   VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
>> +        return false;
>> +    }
>> +
>>       return true;
>>   }
>>   
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 77e4a9833a..d084099ed9 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -131,7 +131,7 @@
>>   #define VTD_TLB_DID(val)            (((val) >> 32) & VTD_DOMAIN_ID_MASK)
>>   
>>   /* IVA_REG */
>> -#define VTD_IVA_ADDR(val)       ((val) & ~0xfffULL & ((1ULL << VTD_MGAW) - 1))
>> +#define VTD_IVA_ADDR(val)       ((val) & ~0xfffULL)
>>   #define VTD_IVA_AM(val)         ((val) & 0x3fULL)
>>   
>>   /* GCMD_REG */
>> @@ -197,7 +197,6 @@
>>   #define VTD_DOMAIN_ID_SHIFT         16  /* 16-bit domain id for 64K domains */
>>   #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
>>   #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
>> -#define VTD_MGAW                    39  /* Maximum Guest Address Width */
>>   #define VTD_ADDRESS_SIZE(aw)        (1ULL << (aw))
>>   #define VTD_CAP_MGAW(aw)            ((((aw) - 1) & 0x3fULL) << 16)
>>   #define VTD_MAMV                    18ULL
>> @@ -213,7 +212,6 @@
>>   #define VTD_CAP_SAGAW_39bit         (0x2ULL << VTD_CAP_SAGAW_SHIFT)
>>    /* 48-bit AGAW, 4-level page-table */
>>   #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
>> -#define VTD_CAP_SAGAW               VTD_CAP_SAGAW_39bit
>>   
>>   /* IQT_REG */
>>   #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
>> @@ -252,7 +250,7 @@
>>   #define VTD_FRCD_SID_MASK       0xffffULL
>>   #define VTD_FRCD_SID(val)       ((val) & VTD_FRCD_SID_MASK)
>>   /* For the low 64-bit of 128-bit */
>> -#define VTD_FRCD_FI(val)        ((val) & (((1ULL << VTD_MGAW) - 1) ^ 0xfffULL))
>> +#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>>   
>>   /* DMA Remapping Fault Conditions */
>>   typedef enum VTDFaultReason {
>> @@ -360,8 +358,7 @@ typedef union VTDInvDesc VTDInvDesc;
>>   #define VTD_INV_DESC_IOTLB_DOMAIN       (2ULL << 4)
>>   #define VTD_INV_DESC_IOTLB_PAGE         (3ULL << 4)
>>   #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>> -#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL & \
>> -                                         ((1ULL << VTD_MGAW) - 1))
>> +#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
>>   #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>>   #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index 372b06df45..45ec8919b6 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -304,6 +304,7 @@ struct IntelIOMMUState {
>>       bool intr_eime;                 /* Extended interrupt mode enabled */
>>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>>       bool buggy_eim;                 /* Force buggy EIM unless eim=off */
>> +    uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
>>   };
>>   
>>   /* Find the VTD Address space associated with the given bus pointer,
>> -- 
>> 2.14.0-rc1
>>
>>
