Received: from eggs.gnu.org ([209.51.188.92]:39980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyePz-0000ZH-KT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyePv-0005Mv-IZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:13:15 -0500
References: <20190226135014.31854-1-eric.auger@redhat.com>
	<20190226135014.31854-8-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <971ecda5-f187-cc73-6d3e-8cb7c92af6b4@redhat.com>
Date: Tue, 26 Feb 2019 16:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190226135014.31854-8-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 07/18] hw/arm/virt: Dynamic memory map
 depending on RAM requirements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: pbonzini@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

Hi,

On 2/26/19 2:50 PM, Eric Auger wrote:
> Up to now the memory map has been static and the high IO region
> base has always been 256GiB.
> 
> This patch modifies the virt_set_memmap() function, which freezes
> the memory map, so that the high IO range base becomes floating,
> located after the initial RAM and the device memory.
> 
> The function computes
> - the base of the device memory,
> - the size of the device memory,
> - the high IO region base
> - the highest GPA used in the memory map.
> 
> Entries of the high IO region are assigned a base address. The
> device memory is initialized.
> 
> The highest GPA used in the memory map will be used at VM creation
> to choose the requested IPA size.
> 
> Setting all the existing highmem IO regions beyond the RAM
> allows to have a single contiguous RAM region (initial RAM and
> possible hotpluggable device memory). That way we do not need
> to do invasive changes in the EDK2 FW to support a dynamic
> RAM base.
> 
> Still the user cannot request an initial RAM size greater than 255GB.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v7 -> v8:
> - allocate ms->device_memory and removes vms->device_memory_base and
>   vms->device_memory_storage
> - remove (ms->maxram_size > ms->ram_size || ms->ram_slots > 0) and
>   (ms->ram_size > (ram_addr_t)LEGACY_RAMLIMIT_BYTES) checks
> - initialize the device memory
> - move the slots nb check and maxram_size alignment checks in this
>   patch
> ---
>  hw/arm/virt.c         | 52 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7297b69d93..172bb6c140 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "hw/acpi/acpi.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -107,8 +108,9 @@
>   * of a terabyte of RAM will be doing it on a host with more than a
>   * terabyte of physical address space.)
>   */
> -#define RAMLIMIT_GB 255
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
> +#define RAMBASE GiB
> +#define LEGACY_RAMLIMIT_GB 255
> +#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>  
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
> @@ -149,7 +151,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
> -    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +    [VIRT_MEM] =                { RAMBASE, LEGACY_RAMLIMIT_BYTES },
>  };
>  
>  /*
> @@ -1370,7 +1372,8 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>  
>  static void virt_set_memmap(VirtMachineState *vms)
>  {
> -    hwaddr base;
> +    MachineState *ms = MACHINE(vms);
> +    hwaddr base, device_memory_base, device_memory_size;
>      int i;
>  
>      vms->memmap = extended_memmap;
> @@ -1379,7 +1382,34 @@ static void virt_set_memmap(VirtMachineState *vms)
>          vms->memmap[i] = base_memmap[i];
>      }
>  
> -    vms->high_io_base = 256 * GiB; /* Top of the legacy initial RAM region */
> +    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
> +        error_report("unsupported number of memory slots: %"PRIu64,
> +                     ms->ram_slots);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (QEMU_ALIGN_UP(ms->maxram_size, GiB) != ms->maxram_size) {
> +        error_report("maximum memory size must be GiB aligned");
> +    }
> +
> +    /*
> +     * We compute the base of the high IO region depending on the
> +     * amount of initial and device memory. The device memory start/size
> +     * is aligned on 1GiB. We never put the high IO region below 256GiB
> +     * so that if maxram_size is < 255GiB we keep the legacy memory map.
> +     * The device region size assumes 1GiB page max alignment per slot.
> +     */
> +    device_memory_base = ROUND_UP(RAMBASE + ms->ram_size, GiB);
> +    device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
> +
> +    vms->high_io_base = device_memory_base + ROUND_UP(device_memory_size, GiB);
> +    if (vms->high_io_base < device_memory_base) {
> +        error_report("maxmem/slots too huge");
> +        exit(EXIT_FAILURE);
> +    }
> +    if (vms->high_io_base < 256 * GiB) {
> +        vms->high_io_base = 256 * GiB;
> +    }
>      base = vms->high_io_base;
>  
>      for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
> @@ -1390,6 +1420,13 @@ static void virt_set_memmap(VirtMachineState *vms)
>          vms->memmap[i].size = size;
>          base += size;
>      }
> +    vms->highest_gpa = base - 1;
> +    if (device_memory_size > 0) {
> +        ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
> +        ms->device_memory->base = device_memory_base;
> +        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
> +                           "device-memory", device_memory_size);
> +    }
>  }
>  
>  static void machvirt_init(MachineState *machine)
> @@ -1474,7 +1511,8 @@ static void machvirt_init(MachineState *machine)
>      vms->smp_cpus = smp_cpus;
>  
>      if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
> -        error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
> +        error_report("mach-virt: cannot model more than %dGB RAM",
> +                     LEGACY_RAMLIMIT_GB);
>          exit(1);
>      }
>  
> @@ -1568,6 +1606,8 @@ static void machvirt_init(MachineState *machine)
>      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
Argh, missing a
if (machine->device_memory) {}
> +    memory_region_add_subregion(sysmem, machine->device_memory->base,
> +                                &machine->device_memory->mr);
Respinning ...

Thanks

Eric
>  
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 3dc7a6c5d5..326a26b6d6 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -132,6 +132,7 @@ typedef struct {
>      uint32_t iommu_phandle;
>      int psci_conduit;
>      hwaddr high_io_base;
> +    hwaddr highest_gpa;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> 
