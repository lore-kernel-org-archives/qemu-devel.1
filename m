Received: from eggs.gnu.org ([209.51.188.92]:36730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gxBTL-0000jV-2B
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gxBTJ-0007SC-Aj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:06:38 -0500
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-8-eric.auger@redhat.com>
	<20190222135721.25ddcaf7@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <447b96fa-16ab-ab18-1772-5e8f85000e53@redhat.com>
Date: Fri, 22 Feb 2019 15:06:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190222135721.25ddcaf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 07/17] hw/arm/virt: Dynamic memory map
 depending on RAM requirements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

Hi Igor,

On 2/22/19 1:57 PM, Igor Mammedov wrote:
> On Wed, 20 Feb 2019 23:39:53 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Up to now the memory map has been static and the high IO region
>> base has always been 256GiB.
>>
>> This patch modifies the virt_set_memmap() function, which freezes
>> the memory map, so that the high IO range base becomes floating,
>> located after the initial RAM and the device memory.
>>
>> The function computes
>> - the base of the device memory,
>> - the size of the device memory and
>> - the highest GPA used in the memory map.
>>
>> The two former will be used when defining the device memory region
>> while the latter will be used at VM creation to choose the requested
>> IPA size.
>>
>> Setting all the existing highmem IO regions beyond the RAM
>> allows to have a single contiguous RAM region (initial RAM and
>> possible hotpluggable device memory). That way we do not need
>> to do invasive changes in the EDK2 FW to support a dynamic
>> RAM base.
>>
>> Still the user cannot request an initial RAM size greater than 255GB.
>> Also we handle the case where maxmem or slots options are passed,
>> although no device memory is usable at the moment. In this case, we
>> just ignore those settings.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c         | 47 ++++++++++++++++++++++++++++++++++---------
>>  include/hw/arm/virt.h |  3 +++
>>  2 files changed, 41 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 12039a0367..9db602457b 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -107,8 +107,9 @@
>>   * of a terabyte of RAM will be doing it on a host with more than a
>>   * terabyte of physical address space.)
>>   */
>> -#define RAMLIMIT_GB 255
>> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
>> +#define RAMBASE GiB
>> +#define LEGACY_RAMLIMIT_GB 255
>> +#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>>  
>>  /* Addresses and sizes of our components.
>>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
>> @@ -149,7 +150,7 @@ static const MemMapEntry base_memmap[] = {
>>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>> -    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
>> +    [VIRT_MEM] =                { RAMBASE, LEGACY_RAMLIMIT_BYTES },
>>  };
>>  
>>  /*
>> @@ -1367,16 +1368,48 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>>  
>>  static void virt_set_memmap(VirtMachineState *vms)
>>  {
>> +    MachineState *ms = MACHINE(vms);
>>      hwaddr base;
>>      int i;
>>  
>> +    if (ms->maxram_size > ms->ram_size || ms->ram_slots > 0) {
>> +        error_report("mach-virt: does not support device memory: "
>> +                     "ignore maxmem and slots options");
>> +        ms->maxram_size = ms->ram_size;
>> +        ms->ram_slots = 0;
>> +    }
>> +    if (ms->ram_size > (ram_addr_t)LEGACY_RAMLIMIT_BYTES) {
>> +        error_report("mach-virt: cannot model more than %dGB RAM",
>> +                     LEGACY_RAMLIMIT_GB);
>> +        exit(1);
>> +    }
> I'd drop these checks and amend below code so that it would init device_memory
> logic when ram_slots > 0. It should simplify follow up patches by dropping
> all machine version specific parts.
I don't have sufficient knowledge of virtio-mem/virtio-pmem. Do they
also use slots?


> It shouldn't break old machines as layout stays the same but would allow to
> start old machine with pc-dimms which is fine from migration pov as target
> also should be able to start QEMU with the same options for migration to start.
> 
> 
>> +
>>      vms->memmap = extended_memmap;
>>  
>>      for (i = 0; i < ARRAY_SIZE(base_memmap); i++) {
>>          vms->memmap[i] = base_memmap[i];
>>      }
>>  
>> -    vms->high_io_base = 256 * GiB; /* Top of the legacy initial RAM region */
>> +    /*
>> +     * We compute the base of the high IO region depending on the
>> +     * amount of initial and device memory. The device memory start/size
>> +     * is aligned on 1GiB. We never put the high IO region below 256GiB
>> +     * so that if maxram_size is < 255GiB we keep the legacy memory map.
>> +     * The device region size assumes 1GiB page max alignment per slot.
>> +     */
>> +    vms->device_memory_base = ROUND_UP(RAMBASE + ms->ram_size, GiB);
>> +    vms->device_memory_size = ms->maxram_size - ms->ram_size +
>> +                              ms->ram_slots * GiB;
So does everyone agree on this device memory size computation? I would
like to make sure this is future proof. Do I need to add a machine
option like on x86 to enforce slot alignment or is it OK?

Thanks

Eric
>> +
>> +    vms->high_io_base = vms->device_memory_base +
>> +                        ROUND_UP(vms->device_memory_size, GiB);
>> +    if (vms->high_io_base < vms->device_memory_base) {
>> +        error_report("maxmem/slots too huge");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    if (vms->high_io_base < 256 * GiB) {
>> +        vms->high_io_base = 256 * GiB;
>> +    }
>>      base = vms->high_io_base;
>>  
>>      for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
>> @@ -1387,6 +1420,7 @@ static void virt_set_memmap(VirtMachineState *vms)
>>          vms->memmap[i].size = size;
>>          base += size;
>>      }
>> +    vms->highest_gpa = base - 1;
>>  }
>>  
>>  static void machvirt_init(MachineState *machine)
>> @@ -1470,11 +1504,6 @@ static void machvirt_init(MachineState *machine)
>>  
>>      vms->smp_cpus = smp_cpus;
>>  
>> -    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
>> -        error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
>> -        exit(1);
>> -    }
>> -
>>      if (vms->virt && kvm_enabled()) {
>>          error_report("mach-virt: KVM does not support providing "
>>                       "Virtualization extensions to the guest CPU");
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 3dc7a6c5d5..acad0400d8 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -132,6 +132,9 @@ typedef struct {
>>      uint32_t iommu_phandle;
>>      int psci_conduit;
>>      hwaddr high_io_base;
>> +    hwaddr highest_gpa;
>> +    hwaddr device_memory_base;
>> +    hwaddr device_memory_size;
>>  } VirtMachineState;
>>  
>>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> 
