Received: from eggs.gnu.org ([209.51.188.92]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkbX-0000H0-AF
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkbW-0005Ji-0Z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:01:43 -0500
Date: Fri, 1 Mar 2019 17:01:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301170128.29a28c21@redhat.com>
In-Reply-To: <20190301134709.4695-8-eric.auger@redhat.com>
References: <20190301134709.4695-1-eric.auger@redhat.com>
	<20190301134709.4695-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 07/10] hw/arm/virt: Dynamic memory map
 depending on RAM requirements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

On Fri,  1 Mar 2019 14:47:06 +0100
Eric Auger <eric.auger@redhat.com> wrote:

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v10 -> v11:
> - remove RAMBASE
> - s/256GiB/vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES
>   while checking if high io region base < 256GB
> - added a comment in base_memmap about the actual RAM size
> 
> v9 -> v10:
> - remove check of maxram_size 1GB alignment
> 
> v8 -> v9:
> - add if (machine->device_memory) check
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
> index 1c213eb3c9..624f417cd4 100644
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
> @@ -107,8 +108,8 @@
>   * of a terabyte of RAM will be doing it on a host with more than a
>   * terabyte of physical address space.)
>   */
> -#define RAMLIMIT_GB 255
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
> +#define LEGACY_RAMLIMIT_GB 255
> +#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>  
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
> @@ -149,7 +150,8 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
> -    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +    /* Actual RAM size depends on initial RAM and device memory settings */
> +    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
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
> @@ -1379,7 +1382,32 @@ static void virt_set_memmap(VirtMachineState *vms)
>          vms->memmap[i] = base_memmap[i];
>      }
>  
> -    base = 256 * GiB; /* Top of the legacy initial RAM region */
> +    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
> +        error_report("unsupported number of memory slots: %"PRIu64,
> +                     ms->ram_slots);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /*
> +     * We compute the base of the high IO region depending on the
> +     * amount of initial and device memory. The device memory start/size
> +     * is aligned on 1GiB. We never put the high IO region below 256GiB
> +     * so that if maxram_size is < 255GiB we keep the legacy memory map.
> +     * The device region size assumes 1GiB page max alignment per slot.
> +     */
> +    device_memory_base =
> +        ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
> +    device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
> +
> +    /* Base address of the high IO region */
> +    base = device_memory_base + ROUND_UP(device_memory_size, GiB);
> +    if (base < device_memory_base) {
> +        error_report("maxmem/slots too huge");
> +        exit(EXIT_FAILURE);
> +    }
> +    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
> +        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
> +    }
>  
>      for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
>          hwaddr size = extended_memmap[i].size;
> @@ -1389,6 +1417,13 @@ static void virt_set_memmap(VirtMachineState *vms)
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
> @@ -1475,7 +1510,8 @@ static void machvirt_init(MachineState *machine)
>      vms->smp_cpus = smp_cpus;
>  
>      if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
> -        error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
> +        error_report("mach-virt: cannot model more than %dGB RAM",
> +                     LEGACY_RAMLIMIT_GB);
>          exit(1);
>      }
>  
> @@ -1569,6 +1605,10 @@ static void machvirt_init(MachineState *machine)
>      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
> +    if (machine->device_memory) {
> +        memory_region_add_subregion(sysmem, machine->device_memory->base,
> +                                    &machine->device_memory->mr);
> +    }
>  
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index f3f7fae4ac..507517c603 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -131,6 +131,7 @@ typedef struct {
>      uint32_t msi_phandle;
>      uint32_t iommu_phandle;
>      int psci_conduit;
> +    hwaddr highest_gpa;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
