Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ebiv5-0004tP-NE
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ebiv1-0007uK-HW
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:18:03 -0500
References: <20171215062914.27927-1-aik@ozlabs.ru>
	<3af66f82-a8d6-4e7d-4d89-09cae2333198@redhat.com>
	<20180105082916.480132af@t450s.home>
	<51ac953b-da09-94ed-41a4-ae75ca045c5e@ozlabs.ru>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <889be92f-6f01-dc53-1bf1-00a5539e5e54@redhat.com>
Date: Wed, 17 Jan 2018 09:17:50 +0100
MIME-Version: 1.0
In-Reply-To: <51ac953b-da09-94ed-41a4-ae75ca045c5e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] RFC: vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Alexey,

On 16/01/18 06:17, Alexey Kardashevskiy wrote:
> On 06/01/18 02:29, Alex Williamson wrote:
>> On Fri, 5 Jan 2018 10:48:07 +0100
>> Auger Eric <eric.auger@redhat.com> wrote:
>>
>>> Hi Alexey,
>>>
>>> On 15/12/17 07:29, Alexey Kardashevskiy wrote:
>>>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
>>>> which tells that a region with MSIX data can be mapped entirely, i.e.
>>>> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
>>>>
>>>> With this change, all BARs are mapped in a single chunk and MSIX vectors
>>>> are emulated on top unless the machine requests not to by defining and
>>>> enabling a new "vfio-no-msix-emulation" property. At the moment only
>>>> sPAPR machine does so - it prohibits MSIX emulation and does not allow
>>>> enabling it as it does not define the "set" callback for the new property;
>>>> the new property also does not appear in "-machine pseries,help".
>>>>
>>>> If the new capability is present, this puts MSIX IO memory region under
>>>> mapped memory region. If the capability is not there, it falls back to
>>>> the old behaviour with the sparse capability.
>>>>
>>>> In MSIX vectors section is not aligned to the page size, the KVM memory
>>>> listener does not register it with the KVM as a memory slot and MSIX is
>>>> emulated by QEMU as before.
>>>>
>>>> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
>>>> for the new capability: https://www.spinics.net/lists/kvm/msg160282.html
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>
>>>> This is mtree and flatview BEFORE this patch:
>>>>
>>>> "info mtree":
>>>> memory-region: pci@800000020000000.mmio
>>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>>       000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>>       000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>>
>>>> "info mtree -f":
>>>> FlatView #0
>>>>  AS "memory", root: system
>>>>  AS "cpu-memory", root: system
>>>>  Root memory region: system
>>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>>   0000210000000000-000021000000dfff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>>   000021000000e600-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1 @000000000000e600
>>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>>
>>>>
>>>>
>>>> This is AFTER this patch applied:
>>>>
>>>> "info mtree":
>>>> memory-region: pci@800000020000000.mmio
>>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table [disabled]
>>>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>>
>>>>
>>>> "info mtree -f":
>>>> FlatView #2
>>>>  AS "memory", root: system
>>>>  AS "cpu-memory", root: system
>>>>  Root memory region: system
>>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>>   0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>>
>>>>
>>>>
>>>> This is AFTER this patch applied AND spapr_get_msix_emulation() patched
>>>> to enable emulation:
>>>>
>>>> "info mtree":
>>>> memory-region: pci@800000020000000.mmio
>>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>>
>>>> "info mtree -f":
>>>> FlatView #1
>>>>  AS "memory", root: system
>>>>  AS "cpu-memory", root: system
>>>>  Root memory region: system
>>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>>   0000210000000000-000021000000dfff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>>   000021000000e600-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0] @000000000000e600
>>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>> ---
>>>>  include/hw/vfio/vfio-common.h |  1 +
>>>>  linux-headers/linux/vfio.h    |  5 +++++
>>>>  hw/ppc/spapr.c                |  8 ++++++++
>>>>  hw/vfio/common.c              | 15 +++++++++++++++
>>>>  hw/vfio/pci.c                 | 23 +++++++++++++++++++++--
>>>>  5 files changed, 50 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index f3a2ac9..927d600 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>>>>                           struct vfio_region_info **info);
>>>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>>>                               uint32_t subtype, struct vfio_region_info **info);
>>>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
>>>>  #endif
>>>>  extern const MemoryListener vfio_prereg_listener;
>>>>  
>>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>>>> index 4312e96..b45182e 100644
>>>> --- a/linux-headers/linux/vfio.h
>>>> +++ b/linux-headers/linux/vfio.h
>>>> @@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
>>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>>>>  
>>>> +/*
>>>> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
>>>> + */
>>>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>>> +
>>>>  /**
>>>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>>>   *				    struct vfio_irq_info)
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 9de63f0..693394a 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -2772,6 +2772,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
>>>>      spapr->use_hotplug_event_source = value;
>>>>  }
>>>>  
>>>> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
>>>> +{
>>>> +    return true;
>>>> +}
>>>> +
>>>>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
>>>>  {
>>>>      sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
>>>> @@ -2853,6 +2858,8 @@ static void spapr_machine_initfn(Object *obj)
>>>>      object_property_set_description(obj, "vsmt",
>>>>                                      "Virtual SMT: KVM behaves as if this were"
>>>>                                      " the host's SMT mode", &error_abort);
>>>> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
>>>> +                             spapr_get_msix_emulation, NULL, NULL);
>>>>  }
>>>>  
>>>>  static void spapr_machine_finalizefn(Object *obj)
>>>> @@ -3742,6 +3749,7 @@ static const TypeInfo spapr_machine_info = {
>>>>  /*
>>>>   * pseries-2.11
>>>>   */
>>>> +
>>>>  static void spapr_machine_2_11_instance_options(MachineState *machine)
>>>>  {
>>>>  }
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 1fb8a8e..da5f182 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -1411,6 +1411,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>>>      return -ENODEV;
>>>>  }
>>>>  
>>>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)
>>>> +{
>>>> +    struct vfio_region_info *info = NULL;
>>>> +    bool ret = false;
>>>> +
>>>> +    if (!vfio_get_region_info(vbasedev, region, &info)) {
>>>> +        if (vfio_get_region_info_cap(info, cap_type)) {
>>>> +            ret = true;
>>>> +        }
>>>> +        g_free(info);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Interfaces for IBM EEH (Enhanced Error Handling)
>>>>   */
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index c977ee3..27a3706 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>>>>      off_t start, end;
>>>>      VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
>>>>  
>>>> +    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
>>>> +                            vdev->msix->table_bar)) {
>>>> +        return;
>>>> +    }  
>>>
>>> I am testing this patch on ARM with a Mellanox CX-4 card. Single bar0 +
>>> msix table at 0x2000, using 64kB pages.
>>>
>>> 0000000000000000-0000000001ffffff (prio 1, i/o): 0000:01:00.0 BAR 0
>>>  0000000000000000-0000000001ffffff (prio 0, ramd): 0000:01:00.0 BAR 0
>>> mmaps[0]
>>>   0000000000002000-00000000000023ff (prio 0, i/o): msix-table
>>>   0000000000003000-0000000000003007 (prio 0, i/o): msix-pba [disabled]
>>>
>>>
>>> My kernel includes your "vfio-pci: Allow mapping MSIX BAR" so we bypass
>>> vfio_pci_fixup_msix_region. But as the mmaps[0] is not fixed up the
>>> vfio_listener_region_add_ram gets called on the first 8kB which cannot
>>> be mapped with 64kB page, leading to a qemu abort.
>>>
>>> 29520@1515145231.232161:vfio_listener_region_add_ram region_add [ram]
>>> 0x8000000000 - 0x8000001fff [0xffffa8820000]
>>> qemu-system-aarch64: VFIO_MAP_DMA: -22
>>> qemu-system-aarch64: vfio_dma_map(0x1e265f60, 0x8000000000, 0x2000,
>>> 0xffffa8820000) = -22 (Invalid argument)
>>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>>
>>> In my case don't we still need the fixup logic?
>>
>> Ah, I didn't realize you had Alexey's QEMU patch when you asked about
>> this.  I'd say no, the fixup shouldn't be needed, but apparently we
>> can't remove it until we figure out this bug and who should be filtering
>> out sub-page size listener events.  Thanks,
> 
> 
> This should do it:
> 
> @@ -303,11 +303,19 @@ static bool
> vfio_listener_skipped_section(MemoryRegionSection *section)
>              * Sizing an enabled 64-bit BAR can cause spurious mappings to
>              * addresses in the upper part of the 64-bit address space.  These
>              * are never accessed by the CPU and beyond the address width of
>              * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
>              */
> -           section->offset_within_address_space & (1ULL << 63);
> +           section->offset_within_address_space & (1ULL << 63) ||
> +           /*
> +            * Non-system-page aligned RAM regions have no chance to be
> +            * DMA mapped so skip them too.
> +            */
> +           (memory_region_is_ram(section->mr) &&
> +            ((section->offset_within_region & qemu_real_host_page_mask) ||
> +             (int128_getlo(section->size) & qemu_real_host_page_mask))
> +           );
>  }
This should indeed avoid the vfio_dma_map error. I can't test it at the
moment since I don't have access to this HW anymore but as soon as I
recover it, I will let you know.

Thanks

Eric
> 
> 
> Do we VFIO DMA map on every RAM MR just because it is not necessary to have
> more complicated logic to detect whether it is MMIO? Or there is something
> bigger?
> 
> As for now, it is possible to have non-aligned RAM MR, the KVM's listener
> just does not register it with the KVM if unaligned.
> 
> 
> 
