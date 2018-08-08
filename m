Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnKqc-0007BS-Gu
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnKqZ-0001E3-B2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:33:42 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-7-git-send-email-eric.auger@redhat.com>
	<20180718150519.697d815d@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <86f55cc7-ee12-ff3f-02cc-8d2c9a40d491@redhat.com>
Date: Wed, 8 Aug 2018 11:33:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180718150519.697d815d@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 06/15] hw/arm/virt: Allocate device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

Hi Igor,
On 07/18/2018 03:05 PM, Igor Mammedov wrote:
> On Tue,  3 Jul 2018 09:19:49 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> We define a new hotpluggable RAM region (aka. device memory).
>> Its base is 2TB GPA. This obviously requires 42b IPA support
>> in KVM/ARM, FW and guest kernel. At the moment the device
>> memory region is max 2TB.
>>
>> This is largely inspired of device memory initialization in
>> pc machine code.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>> ---
>>  hw/arm/virt.c         | 104 ++++++++++++++++++++++++++++++++++++--------------
>>  include/hw/arm/arm.h  |   2 +
>>  include/hw/arm/virt.h |   1 +
>>  3 files changed, 79 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 5a4d0bf..6fefb78 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -59,6 +59,7 @@
>>  #include "qapi/visitor.h"
>>  #include "standard-headers/linux/input.h"
>>  #include "hw/arm/smmuv3.h"
>> +#include "hw/acpi/acpi.h"
>>  
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>> @@ -94,34 +95,25 @@
>>  
>>  #define PLATFORM_BUS_NUM_IRQS 64
>>  
>> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
>> - * address space unallocated and free for future use between 256G and 512G.
>> - * If we need to provide more RAM to VMs in the future then we need to:
>> - *  * allocate a second bank of RAM starting at 2TB and working up
>> - *  * fix the DT and ACPI table generation code in QEMU to correctly
>> - *    report two split lumps of RAM to the guest
>> - *  * fix KVM in the host kernel to allow guests with >40 bit address spaces
>> - * (We don't want to fill all the way up to 512GB with RAM because
>> - * we might want it for non-RAM purposes later. Conversely it seems
>> - * reasonable to assume that anybody configuring a VM with a quarter
>> - * of a terabyte of RAM will be doing it on a host with more than a
>> - * terabyte of physical address space.)
>> - */
>> -#define RAMLIMIT_GB 255
>> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
>> +#define SZ_64K 0x10000
>> +#define SZ_1G (1024ULL * 1024 * 1024)
>>  
>>  /* Addresses and sizes of our components.
>> - * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
>> - * 128MB..256MB is used for miscellaneous device I/O.
>> - * 256MB..1GB is reserved for possible future PCI support (ie where the
>> - * PCI memory window will go if we add a PCI host controller).
>> - * 1GB and up is RAM (which may happily spill over into the
>> - * high memory region beyond 4GB).
>> - * This represents a compromise between how much RAM can be given to
>> - * a 32 bit VM and leaving space for expansion and in particular for PCI.
>> - * Note that devices should generally be placed at multiples of 0x10000,
>> + * 0..128MB is space for a flash device so we can run bootrom code such as UEFI,
>> + * 128MB..256MB is used for miscellaneous device I/O,
>> + * 256MB..1GB is used for PCI host controller,
>> + * 1GB..256GB is RAM (not hotpluggable),
>> + * 256GB..512GB: is left for device I/O (non RAM purpose),
>> + * 512GB..1TB: high mem PCI MMIO region,
>> + * 2TB..4TB is used for hot-pluggable DIMM (assumes 42b GPA is supported).
>> + *
>> + * Note that IO devices should generally be placed at multiples of 0x10000,
>>   * to accommodate guests using 64K pages.
>> + *
>> + * Conversely it seems reasonable to assume that anybody configuring a VM
>> + * with a quarter of a terabyte of RAM will be doing it on a host with more
>> + * than a terabyte of physical address space.)
>> + *
>>   */
>>  static const MemMapEntry a15memmap[] = {
>>      /* Space up to 0x8000000 is reserved for a boot ROM */
>> @@ -148,12 +140,13 @@ static const MemMapEntry a15memmap[] = {
>>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>> -    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
>> +    [VIRT_MEM] =                { SZ_1G , 255 * SZ_1G },
>>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
>>      [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
>>      [VIRT_PCIE_ECAM_HIGH] =     { 0x4010000000ULL, 0x10000000 },
>>      /* Second PCIe window, 512GB wide at the 512GB boundary */
>> -    [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
>> +    [VIRT_PCIE_MMIO_HIGH] =     { 512 * SZ_1G, 512 * SZ_1G },
>> +    [VIRT_HOTPLUG_MEM] =        { 2048 * SZ_1G, 2048 * SZ_1G },
>>  };
>>  
>>  static const int a15irqmap[] = {
>> @@ -1223,6 +1216,58 @@ static void create_secure_ram(VirtMachineState *vms,
>>      g_free(nodename);
>>  }
>>  
>> +static void create_device_memory(VirtMachineState *vms, MemoryRegion *sysmem)
>> +{
>> +    MachineState *ms = MACHINE(vms);
>> +    uint64_t device_memory_size;
>> +    uint64_t align = SZ_64K;
>> +
>> +    /* always allocate the device memory information */
>> +    ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
>> +
>> +    if (vms->max_vm_phys_shift < 42) {
>> +        /* device memory starts at 2TB whereas this VM supports less than
>> +         * 2TB GPA */
>> +        if (ms->maxram_size > ms->ram_size || ms->ram_slots) {
>> +            MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +
>> +            error_report("\"-memory 'slots|maxmem'\" is not supported by %s "
>> +                         "since KVM does not support more than 41b IPA",
>> +                         mc->name);
>> +            exit(EXIT_FAILURE);
>> +        }
>> +        return;
>> +    }
>> +
>> +    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
>> +        error_report("unsupported number of memory slots: %"PRIu64,
>> +                     ms->ram_slots);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>> +    if (QEMU_ALIGN_UP(ms->maxram_size, align) != ms->maxram_size) {
>> +        error_report("maximum memory size must be aligned to multiple of 0x%"
>> +                     PRIx64, align);
>> +            exit(EXIT_FAILURE);
>> +    }
>> +
>> +    ms->device_memory->base = vms->memmap[VIRT_HOTPLUG_MEM].base;
>> +    device_memory_size = ms->maxram_size - ms->ram_size;
>> +
>> +    if (device_memory_size > vms->memmap[VIRT_HOTPLUG_MEM].size) {
>> +        error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
>> +                         ms->maxram_size);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>> +    memory_region_init(&ms->device_memory->mr, OBJECT(vms),
>> +                       "device-memory", device_memory_size);
>> +    memory_region_add_subregion(sysmem, ms->device_memory->base,
>> +                                &ms->device_memory->mr);
> 
>> +    vms->bootinfo.device_memory_start = ms->device_memory->base;
>> +    vms->bootinfo.device_memory_size = device_memory_size;
> why do we need duplicate it in bootinfo?
> (I'd try avoid using bootinfo and use original source instead
> where it's needed)
agreed. Not needed.

Thanks

Eric
> 
> 
>> +}
>> +
>>  static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>>  {
>>      const VirtMachineState *board = container_of(binfo, VirtMachineState,
>> @@ -1430,7 +1475,8 @@ static void machvirt_init(MachineState *machine)
>>      vms->smp_cpus = smp_cpus;
>>  
>>      if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
>> -        error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
>> +        error_report("mach-virt: cannot model more than %dGB RAM",
>> +                     (int)(vms->memmap[VIRT_MEM].size / SZ_1G));
>>          exit(1);
>>      }
>>  
>> @@ -1525,6 +1571,8 @@ static void machvirt_init(MachineState *machine)
>>                                           machine->ram_size);
>>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
>>  
>> +    create_device_memory(vms, sysmem);
>> +
>>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>>  
>>      create_gic(vms, pic);
>> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
>> index ffed392..76269e6 100644
>> --- a/include/hw/arm/arm.h
>> +++ b/include/hw/arm/arm.h
>> @@ -116,6 +116,8 @@ struct arm_boot_info {
>>      bool secure_board_setup;
>>  
>>      arm_endianness endianness;
>> +    hwaddr device_memory_start;
>> +    hwaddr device_memory_size;
>>  };
>>  
>>  /**
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 91f6de2..173938d 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -78,6 +78,7 @@ enum {
>>      VIRT_GPIO,
>>      VIRT_SECURE_UART,
>>      VIRT_SECURE_MEM,
>> +    VIRT_HOTPLUG_MEM,
>>  };
>>  
>>  typedef enum VirtIOMMUType {
> 
