Received: from eggs.gnu.org ([2001:4830:134:3::10]:32842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e57AQ-0007Dp-DJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e57AM-0005CS-87
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:31:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1e57AL-0005Bx-UJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B81FFC0587DD
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:31:00 +0000 (UTC)
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
Date: Thu, 19 Oct 2017 12:30:49 +0300
MIME-Version: 1.0
In-Reply-To: <69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


Hi Laszlo,

On 18/10/2017 14:40, Laszlo Ersek wrote:
> Hi Marcel,
> 
> On 10/18/17 11:58, Marcel Apfelbaum wrote:
>> Currently there is no MMIO range over 4G
>> reserved for PCI hotplug. Since the 32bit PCI hole
>> depends on the number of cold-plugged PCI devices
>> and other factors, it is very possible is too small
>> to hotplug PCI devices with large BARs.
>>
>> Fix it by reserving all the address space after
>> RAM (and the reserved space for RAM hotplug),
>> but no more than 40bits. The later seems to be
>> QEMU's magic number for the Guest physical CPU addressable
>> bits and is safe with respect to migration.
>>
>> Note this is a regression since prev QEMU versions had
>> some range reserved for 64bit PCI hotplug.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>   hw/i386/pc.c              | 22 ++++++++++++++++++++++
>>   hw/pci-host/piix.c        | 10 ++++++++++
>>   hw/pci-host/q35.c         |  9 +++++++++
>>   include/hw/i386/pc.h      | 10 ++++++++++
>>   include/hw/pci-host/q35.h |  1 +
>>   5 files changed, 52 insertions(+)
> 
> - What are the symptoms of the problem?
> 

PCI devices with *relatively* large BARs can't be hot-plugged.
The reason is QEMU does not reserve MMIO range over 4G and
uses whatever remains on the 32bit PCI window.

If you coldplug enough PCI devices you will end up with
with a 64bit PCI window that covers only the cold-plugged PCI
devices, still no room for hotplug.

> - What QEMU commit regressed the previous functionality?
> 

  - commit 39848901818 pc: limit 64 bit hole to 2G by default
  shows us QEMU had the 64bit PCI hole, so it is a regression.

  - commit 2028fdf3791 piix: use 64 bit window programmed by guest
  leaves no room for PCI hotplug

> - How exactly is the regression (and this fix) exposed to the guest?
> 

The nuance is both above commits computed the actual MMIO
range used by cold-plugged devices, but as side effect
they influenced the remaining PCI window for hot-plugged devices.

What the guest sees is the CRS MMIO range over 4G.

> I'm confused because semi-recently I've done multiple successful
> hotplugs, with OVMF, Q35, PCIe root ports, and PCI Express devices
> having large (64-bit) MMIO BARs. The examples include ivshmem / Linux
> guest (based on your hints) and vfio-pci (XL710 NIC) / Windows Server
> 2016 guest.

Cool! These are actually great news!
Back to the issue in hand, a few things:
1. It works with Q35 only, but not with the I440FX machines.
2. The hints are used for the PCIe root ports, meaning for PCI bridges
    and addresses a slightly different issues: leave hotplug space
    for secondary buses, while this patch tackles hotplug
    space for root buses.

> 
> By default, OVMF marks a 32GB area as 64-bit MMIO aperture, for BAR
> allocation. This area is above the normal memory (plus reservation for
> hotplug memory, if any). It is also GB-aligned. The aperture size can be
> changed (currently) with an experimental -fw_cfg switch (the fw_cfg file
> is called "opt/ovmf/X-PciMmio64Mb", it states the size of the 64-bit
> MMIO aperture as a decimal number of megabytes).

I'll try to explain how I see the "picture":
CRS is created by QEMU and computed *after* the firmware finishes
the PCI BARs allocations. Then *QEMU* decides how big it will be the
64bit PCI hole, not the firmware - see the past commits.

So IMHO you don't need the opt/ovmf/X-PciMmio64Mb since the OVMF
is not deciding this value. It actually should not care at all.

> The OVMF logic is described in the message of the following commit:
> 
>    https://github.com/tianocore/edk2/commit/7e5b1b670c382
> 
> If the new resource reservation hints are used for PCI Express root
> ports, then the 64-bit reservations are satisfied (i.e., programmed into
> the root ports) from the above-mentioned 64-bit aperture. Then -- as I
> understand it -- QEMU will generate the ACPI payload honoring those
> reservations too. This means the OS will be aware, and will have room
> for accepting hotplug.
> 
> So... I'm not sure what the regression is, and how this patch fixes it.
> 

I hope it is more clear now.

> Is this about exposing a 64-bit MMIO aperture for hotplug purposes
> *without* the reservation hints?
> 

Again, the hints deal with secondary buses, this one with root buses.

> 
> Either way, if QEMU now starts (or starts *again* -- I don't know)
> dictating the base and size of the 64-bit MMIO aperture, then it
> shouldn't just be exposed to the OS, via ACPI; it should also be exposed
> to the firmware, via fw_cfg. The "etc/reserved-memory-end" file is
> exposed already, so that's good. Two more fw_cfg files look necessary,
> for exposing the 64-bit hole's base and size. The base should be equal
> to or larger than "etc/reserved-memory-end". The size should replace the
> current (experimental) "opt/ovmf/X-PciMmio64Mb" fw_cfg file.
> 

Well, the PCI hotplug window may be handled by QEMU since it does
not affect the firmware at all; it seems out of scope.
See the above patches, QEMU always decided the hotplug windows,
it does it for the memory and it has done it for the PCI hotplug window,
I don't see something we have to gain from exposing it to the firmware.

> 
> A separate note about sizing the 64-bit PCI hole. In OVMF, the end of
> the 64-bit PCI hole determines the highest guest-physical address that
> the DXE phase might want to access (so that a UEFI driver for a PCI
> device can read/write a 64-bit BAR placed there). In turn this dictates
> how the identity-mapping page tables are built for the DXE phase -- the
> higher the max expected guest-phys address, the more RAM is needed for
> the page tables.
> 
> Assuming QEMU exposes a fixed (1ULL << 40) value for the highest
> (exclusive) address, *and* OVMF is expected to follow QEMU's directions
> in the placement of the 64-bit PCI hole (via the new fw_cfg files), then
> OVMF will need the following RAM amount for building the page tables:
> 
> * with 1GB page support: 3 pages (12 KB)
> * without 1GB page support: 1027 pages (4108 KB)
> 
> This doesn't look overly bad -- but I don't think (1ULL << 40) is good
> enough. (1ULL << 40) corresponds to 1TB, and we want to have more *RAM*
> than that. The hotplug memory range comes on top, and then we should
> still have a 64-bit MMIO aperture.
> 
> Let's say we want to go up to 4TB (1ULL << 42). DXE page table memory
> needs in OVMF:
> 
> * with 1GB page support: 9 pages (36 KB)
> * without 1GB page support: 4105 pages (16420 KB)
> 
> I don't expect these memory needs to be a problem, but we should be
> aware of them.
> 

QEMU's default value for CPU phys addressable bits is 40, and is
used even is if you add -cpu host to command line and your
cpu works with 42 phys bits or more (funny thing, if you set
40 bits phys on command line you get a warning, but the default
is 40...)
The value is safe for migration, we don't want to limit migration
because of the PCI hotplug window, and in the same time we
want a usable window. It seemed like a good trade-off.

> 
> Also, how do you plan to integrate this feature with SeaBIOS?
> 

Simple, no need :) . It just works as it should.
SeaBIOS computes everything, *then* QEMU creates the CRs ranges
based on firmware input and other properties.
I think it works also with OVMF out of the box.


A last note, when pxb/pxb-pcies will became hot-pluggable
we need to leave some bits for them too. I wouldn't
really want to add fw_config files for them too, or
use a complicate fw_config, or rewrite
the logic for all firmware if we don't have to.

64bit PCI window starts from memory(+reserved) end
and finishes at 40bit. If you have 1T of RAM you
get nothing for PCI hotplug, seems fair.

When guests with more then 1T of RAM will become
frequent, I suppose the QEMU's default CPU addressable
bits will change and we will change it too.


Thanks,
Marcel

> Thanks
> Laszlo
> 
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 05985d4927..4df20d2b99 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1448,6 +1448,28 @@ void pc_memory_init(PCMachineState *pcms,
>>       pcms->ioapic_as = &address_space_memory;
>>   }
>>   
>> +uint64_t pc_pci_hole64_start(void)
>> +{
>> +    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +    uint64_t hole64_start = 0;
>> +
>> +    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
>> +        hole64_start = pcms->hotplug_memory.base;
>> +        if (!pcmc->broken_reserved_end) {
>> +            hole64_start += memory_region_size(&pcms->hotplug_memory.mr);
>> +        }
>> +    } else {
>> +        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
>> +    }
>> +
>> +    if (hole64_start > PCI_HOST_PCI_HOLE64_END) {
>> +        hole64_start = PCI_HOST_PCI_HOLE64_END;
>> +    }
>> +
>> +    return hole64_start;
>> +}
>> +
>>   qemu_irq pc_allocate_cpu_irq(void)
>>   {
>>       return qemu_allocate_irq(pic_irq_request, NULL, 0);
>> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>> index dec345fd24..317a232972 100644
>> --- a/hw/pci-host/piix.c
>> +++ b/hw/pci-host/piix.c
>> @@ -50,6 +50,7 @@ typedef struct I440FXState {
>>       PCIHostState parent_obj;
>>       Range pci_hole;
>>       uint64_t pci_hole64_size;
>> +    bool pci_hole64_fix;
>>       uint32_t short_root_bus;
>>   } I440FXState;
>>   
>> @@ -243,11 +244,15 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
>>                                                   void *opaque, Error **errp)
>>   {
>>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>> +    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
>>       Range w64;
>>       uint64_t value;
>>   
>>       pci_bus_get_w64_range(h->bus, &w64);
>>       value = range_is_empty(&w64) ? 0 : range_lob(&w64);
>> +    if (!value && s->pci_hole64_fix) {
>> +        value = pc_pci_hole64_start();
>> +    }
>>       visit_type_uint64(v, name, &value, errp);
>>   }
>>   
>> @@ -256,11 +261,15 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
>>                                                 Error **errp)
>>   {
>>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>> +    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
>>       Range w64;
>>       uint64_t value;
>>   
>>       pci_bus_get_w64_range(h->bus, &w64);
>>       value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
>> +    if (s->pci_hole64_fix && value < PCI_HOST_PCI_HOLE64_END) {
>> +        value = PCI_HOST_PCI_HOLE64_END;
>> +    }
>>       visit_type_uint64(v, name, &value, errp);
>>   }
>>   
>> @@ -857,6 +866,7 @@ static Property i440fx_props[] = {
>>       DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
>>                        pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
>>       DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
>> +    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> index 1ff648e80c..641213f177 100644
>> --- a/hw/pci-host/q35.c
>> +++ b/hw/pci-host/q35.c
>> @@ -104,11 +104,15 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
>>                                             Error **errp)
>>   {
>>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>> +    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>>       Range w64;
>>       uint64_t value;
>>   
>>       pci_bus_get_w64_range(h->bus, &w64);
>>       value = range_is_empty(&w64) ? 0 : range_lob(&w64);
>> +    if (!value && s->pci_hole64_fix) {
>> +        value = pc_pci_hole64_start();
>> +    }
>>       visit_type_uint64(v, name, &value, errp);
>>   }
>>   
>> @@ -117,11 +121,15 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>>                                           Error **errp)
>>   {
>>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>> +    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>>       Range w64;
>>       uint64_t value;
>>   
>>       pci_bus_get_w64_range(h->bus, &w64);
>>       value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
>> +    if (s->pci_hole64_fix && value < PCI_HOST_PCI_HOLE64_END) {
>> +        value = PCI_HOST_PCI_HOLE64_END;
>> +    }
>>       visit_type_uint64(v, name, &value, errp);
>>   }
>>   
>> @@ -143,6 +151,7 @@ static Property q35_host_props[] = {
>>                        mch.below_4g_mem_size, 0),
>>       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
>>                        mch.above_4g_mem_size, 0),
>> +    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 087d184ef5..2e98e8c943 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -239,6 +239,7 @@ void pc_guest_info_init(PCMachineState *pcms);
>>   #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
>>   #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
>>   #define DEFAULT_PCI_HOLE64_SIZE (~0x0ULL)
>> +#define PCI_HOST_PCI_HOLE64_END (0x1ULL << 40)
>>   
>>   
>>   void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
>> @@ -249,6 +250,7 @@ void pc_memory_init(PCMachineState *pcms,
>>                       MemoryRegion *system_memory,
>>                       MemoryRegion *rom_memory,
>>                       MemoryRegion **ram_memory);
>> +uint64_t pc_pci_hole64_start(void);
>>   qemu_irq pc_allocate_cpu_irq(void);
>>   DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
>>   void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
>> @@ -375,6 +377,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>>           .driver   = TYPE_X86_CPU,\
>>           .property = "x-hv-max-vps",\
>>           .value    = "0x40",\
>> +    },{\
>> +        .driver   = "i440FX-pcihost",\
>> +        .property = "x-pci-hole64-fix",\
>> +        .value    = "false",\
>> +    },{\
>> +        .driver   = "q35-pcihost",\
>> +        .property = "x-pci-hole64-fix",\
>> +        .value    = "false",\
>>       },
>>   
>>   #define PC_COMPAT_2_9 \
>> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
>> index 58983c00b3..8f4ddde393 100644
>> --- a/include/hw/pci-host/q35.h
>> +++ b/include/hw/pci-host/q35.h
>> @@ -68,6 +68,7 @@ typedef struct Q35PCIHost {
>>       PCIExpressHost parent_obj;
>>       /*< public >*/
>>   
>> +    bool pci_hole64_fix;
>>       MCHPCIState mch;
>>   } Q35PCIHost;
>>   
>>
> 
