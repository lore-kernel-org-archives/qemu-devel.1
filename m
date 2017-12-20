Received: from eggs.gnu.org ([2001:4830:134:3::10]:52498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRSwd-000525-Hi
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRSwZ-0006GZ-Jd
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:13:15 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eRSwZ-0006Fn-6z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:13:11 -0500
Received: by mail-pg0-x244.google.com with SMTP id q20so11302813pgv.2
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:13:11 -0800 (PST)
References: <20171215062914.27927-1-aik@ozlabs.ru>
	<20171219045202.GK4786@umbus.fritz.box>
	<20171219102609.02f22c9d@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <14df94b1-7edc-5fa4-864c-eacafcfa438e@ozlabs.ru>
Date: Wed, 20 Dec 2017 12:13:04 +1100
MIME-Version: 1.0
In-Reply-To: <20171219102609.02f22c9d@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 20/12/17 04:26, Alex Williamson wrote:
> On Tue, 19 Dec 2017 15:52:02 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Fri, Dec 15, 2017 at 05:29:14PM +1100, Alexey Kardashevskiy wrote:
>>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
>>> which tells that a region with MSIX data can be mapped entirely, i.e.
>>> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
>>>
>>> With this change, all BARs are mapped in a single chunk and MSIX vectors
>>> are emulated on top unless the machine requests not to by defining and
>>> enabling a new "vfio-no-msix-emulation" property. At the moment only
>>> sPAPR machine does so - it prohibits MSIX emulation and does not allow
>>> enabling it as it does not define the "set" callback for the new property;
>>> the new property also does not appear in "-machine pseries,help".
>>>
>>> If the new capability is present, this puts MSIX IO memory region under
>>> mapped memory region. If the capability is not there, it falls back to
>>> the old behaviour with the sparse capability.
>>>
>>> In MSIX vectors section is not aligned to the page size, the KVM memory
>>> listener does not register it with the KVM as a memory slot and MSIX is
>>> emulated by QEMU as before.
>>>
>>> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
>>> for the new capability: https://www.spinics.net/lists/kvm/msg160282.html
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>
>>> This is mtree and flatview BEFORE this patch:
>>>
>>> "info mtree":
>>> memory-region: pci@800000020000000.mmio
>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>       000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>       000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>
>>> "info mtree -f":
>>> FlatView #0
>>>  AS "memory", root: system
>>>  AS "cpu-memory", root: system
>>>  Root memory region: system
>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>   0000210000000000-000021000000dfff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>   000021000000e600-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1 @000000000000e600
>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>
>>>
>>>
>>> This is AFTER this patch applied:
>>>
>>> "info mtree":
>>> memory-region: pci@800000020000000.mmio
>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table [disabled]
>>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>
>>>
>>> "info mtree -f":
>>> FlatView #2
>>>  AS "memory", root: system
>>>  AS "cpu-memory", root: system
>>>  Root memory region: system
>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>   0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>
>>>
>>>
>>> This is AFTER this patch applied AND spapr_get_msix_emulation() patched
>>> to enable emulation:
>>>
>>> "info mtree":
>>> memory-region: pci@800000020000000.mmio
>>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1
>>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR 3
>>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>>
>>> "info mtree -f":
>>> FlatView #1
>>>  AS "memory", root: system
>>>  AS "cpu-memory", root: system
>>>  Root memory region: system
>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>>   0000210000000000-000021000000dfff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0]
>>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>>   000021000000e600-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR 1 mmaps[0] @000000000000e600
>>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>> ---
>>>  include/hw/vfio/vfio-common.h |  1 +
>>>  linux-headers/linux/vfio.h    |  5 +++++
>>>  hw/ppc/spapr.c                |  8 ++++++++
>>>  hw/vfio/common.c              | 15 +++++++++++++++
>>>  hw/vfio/pci.c                 | 23 +++++++++++++++++++++--
>>>  5 files changed, 50 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index f3a2ac9..927d600 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>>>                           struct vfio_region_info **info);
>>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>>                               uint32_t subtype, struct vfio_region_info **info);
>>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
>>>  #endif
>>>  extern const MemoryListener vfio_prereg_listener;
>>>  
>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>>> index 4312e96..b45182e 100644
>>> --- a/linux-headers/linux/vfio.h
>>> +++ b/linux-headers/linux/vfio.h
>>> @@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>>>  
>>> +/*
>>> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
>>> + */
>>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>>> +
>>>  /**
>>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>>   *				    struct vfio_irq_info)
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 9de63f0..693394a 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2772,6 +2772,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
>>>      spapr->use_hotplug_event_source = value;
>>>  }
>>>  
>>> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
>>> +{
>>> +    return true;
>>> +}
>>> +
>>>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
>>>  {
>>>      sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
>>> @@ -2853,6 +2858,8 @@ static void spapr_machine_initfn(Object *obj)
>>>      object_property_set_description(obj, "vsmt",
>>>                                      "Virtual SMT: KVM behaves as if this were"
>>>                                      " the host's SMT mode", &error_abort);
>>> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
>>> +                             spapr_get_msix_emulation, NULL, NULL);  
>>
>> I prefer the approach where the property is in the PCI device, set by
>> the machine defaults mechanism, rather than the property being in the
>> machine and the device having to look it up.
>>
>> If Alex prefers the latter though, I'm ok with that way around.
> 
> I prefer anything that doesn't result in a user visible option.


The only way to have this is an interface implemented by a machine. I can
do that, call it "TYPE_MSIX_MMIO" or "TYPE_CONFIG_VFIO".


>>>  }
>>>  
>>>  static void spapr_machine_finalizefn(Object *obj)
>>> @@ -3742,6 +3749,7 @@ static const TypeInfo spapr_machine_info = {
>>>  /*
>>>   * pseries-2.11
>>>   */
>>> +
>>>  static void spapr_machine_2_11_instance_options(MachineState *machine)
>>>  {
>>>  }
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 1fb8a8e..da5f182 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1411,6 +1411,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>>      return -ENODEV;
>>>  }
>>>  
>>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)
>>> +{
>>> +    struct vfio_region_info *info = NULL;
>>> +    bool ret = false;
>>> +
>>> +    if (!vfio_get_region_info(vbasedev, region, &info)) {
>>> +        if (vfio_get_region_info_cap(info, cap_type)) {
>>> +            ret = true;
>>> +        }
>>> +        g_free(info);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>  /*
>>>   * Interfaces for IBM EEH (Enhanced Error Handling)
>>>   */
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index c977ee3..27a3706 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>>>      off_t start, end;
>>>      VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
>>>  
>>> +    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
>>> +                            vdev->msix->table_bar)) {
>>> +        return;
>>> +    }
>>> +
>>>      /*
>>>       * We expect to find a single mmap covering the whole BAR, anything else
>>>       * means it's either unsupported or already setup.
>>> @@ -1432,6 +1437,15 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>>>      vfio_pci_fixup_msix_region(vdev);
>>>  }
>>>  
>>> +static MemoryRegion *vfio_msix_parent(VFIORegion *region)
>>> +{
>>> +    if (region->nr_mmaps == 1 && region->mmaps[0].size == region->size) {
>>> +        return &region->mmaps[0].mem;
>>> +    }
>>> +
>>> +    return region->mem;
>>> +}
>>> +
>>>  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>>>  {
>>>      int ret;
>>> @@ -1440,9 +1454,9 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>>>      vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
>>>                                      sizeof(unsigned long));
>>>      ret = msix_init(&vdev->pdev, vdev->msix->entries,
>>> -                    vdev->bars[vdev->msix->table_bar].region.mem,
>>> +                    vfio_msix_parent(&vdev->bars[vdev->msix->table_bar].region),
>>>                      vdev->msix->table_bar, vdev->msix->table_offset,
>>> -                    vdev->bars[vdev->msix->pba_bar].region.mem,
>>> +                    vfio_msix_parent(&vdev->bars[vdev->msix->pba_bar].region),
>>>                      vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
>>>                      &err);
>>>      if (ret < 0) {
>>> @@ -1473,6 +1487,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>>>       */
>>>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
>>>  
>>> +    if (object_property_get_bool(OBJECT(qdev_get_machine()),
>>> +                                 "vfio-no-msix-emulation", NULL)) {
>>> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>>> +    }
>>> +  
>>
>> As Alex pointed out elsewhere, the need for the MSI-X emulation isn't
>> really VFIO specific.  It would make more sense to have the test
>> directly in msix_init(), and have it skip adding the msix region to
>> the BAR if the machine has said it's not necessary.
> 
> How much of the MSI-X capability do SPAPR guests make use of? 

Presence of the capability seems to be just enough.

I disabled the sanity test in msix_init(), hardcoded:
vdev->msix->table_offset = 0xff0000;
vdev->msix->pba_offset = 0xfff000;
in vfio_msix_setup() and got it up and running:

00:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
PCI-Express Fusion-MPT SAS-3 (rev 02)

Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
Expansion ROM at 2000c0000000 [disabled] [size=1M]

Capabilities: [c0] MSI-X: Enable+ Count=96 Masked-
        Vector table: BAR=1 offset=00ff0000
        PBA: BAR=1 offset=00fff000


> Asking
> msix_init() to manage an MSI-X capability that references MMIO regions
> on a BAR that aren't implemented is a bit incongruous.  Is there some
> way that the MSI-X capability can make it clear that MSI-X MMIO isn't
> implemented?  Offsets past the end of the BAR? 

This works.

> Reserved BIR values?

This does not - the only reserved value is 7 and it crashes as the device
does not implement BAR7 (ROM).


> You're basically asking msix_init() to create either an incomplete or
> invalid configuration.  Thanks,

I still like "vfio-no-msix-emulation" better.


-- 
Alexey
