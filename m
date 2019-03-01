Received: from eggs.gnu.org ([209.51.188.92]:53180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkVs-0003s2-7V
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkVq-0000JG-A9
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:55:52 -0500
Date: Fri, 1 Mar 2019 16:55:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301165533.7abf7817@redhat.com>
In-Reply-To: <20190301134709.4695-4-eric.auger@redhat.com>
References: <20190301134709.4695-1-eric.auger@redhat.com>
	<20190301134709.4695-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 03/10] hw/arm/virt: Split the memory
 map description
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

On Fri,  1 Mar 2019 14:47:02 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> In the prospect to introduce an extended memory map supporting more
> RAM, let's split the memory map array into two parts:
> 
> - the former a15memmap, renamed base_memmap, contains regions below
>   and including the RAM. MemMapEntries initialized in this array
>   have a static size and base address.
> - extended_memmap, only initialized with entries located after the
>   RAM. MemMapEntries initialized in this array only get their size
>   initialized. Their base address is dynamically computed depending
>   on the the top of the RAM, with same alignment as their size.
> 
> Eventually base_memmap entries are copied into the extended_memmap
> array. Using two separate arrays however clarifies which entries
> are statically allocated and those which are dynamically allocated.
> 
> This new split will allow to grow the RAM size without changing the
> description of the high IO entries.
> 
> We introduce a new virt_set_memmap() helper function which
> "freezes" the memory map. We call it in machvirt_init as
> memory attributes of the machine are not yet set when
> virt_instance_init() gets called.
> 
> The memory map is unchanged (the top of the initial RAM still is
> 256GiB). Then come the high IO regions with same layout as before.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
with nits fixed or not:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v10 -> v11:
> - remove vms->high_io_base
> - initialize vms->memmamp to NULL in the instance_init
> 
> v8 -> v9:
> - restore virt_set_memmap call in machvirt_init as otherwise it does
>   not work in TCG mode
> 
> v7 -> v8:
> - removed Peter's R-b due to the changes induced by Igor's comments
> - call set_memmap back in virt_instance_init
> - add comments about sizing of extended_memmap
> - s/region/entries as suggested by Igor
> - rewording of the commit message
> 
> v6 -> v7:
> - s/a15memmap/base_memmap
> - slight rewording of the commit message
> - add "if there is less than 256GiB of RAM then the floating area
>   starts at the 256GiB mark" in the comment associated to the floating
>   memory map
> - Added Peter's R-b
> 
> v5 -> v6
> - removal of many macros in units.h
> - introduce the virt_set_memmap helper
> - new computation for offsets of high IO regions
> - add comments
> ---
>  hw/arm/virt.c         | 51 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/arm/virt.h | 13 +++++++----
>  2 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 892bae4f3a..1c213eb3c9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -29,6 +29,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/arm.h"
> @@ -121,7 +122,7 @@
>   * Note that devices should generally be placed at multiples of 0x10000,
>   * to accommodate guests using 64K pages.
>   */
> -static const MemMapEntry a15memmap[] = {
> +static const MemMapEntry base_memmap[] = {
>      /* Space up to 0x8000000 is reserved for a boot ROM */
>      [VIRT_FLASH] =              {          0, 0x08000000 },
>      [VIRT_CPUPERIPHS] =         { 0x08000000, 0x00020000 },
> @@ -149,11 +150,24 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, 
 },
> +};
> +
> +/*
> + * Highmem IO Regions: This memory map is floating, located after the RAM.
> + * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
> + * top of the RAM, so that its base get the same alignment as the size,
> + * ie. a 512GiB entry will be aligned on a 512GiB boundary. If there is
> + * less than 256GiB of RAM, the floating area starts at the 256GiB mark.
> + * Note the extended_memmap is sized so that it eventually also includes the
> + * base_memmap entries (VIRT_HIGH_GIC_REDIST2 index is greater than the last
> + * index of base_memmap).
> + */
> +static MemMapEntry extended_memmap[] = {
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> -    [VIRT_HIGH_GIC_REDIST2] =   { 0x4000000000ULL, 0x4000000 },
> -    [VIRT_HIGH_PCIE_ECAM] =     { 0x4010000000ULL, 0x10000000 },
> -    /* Second PCIe window, 512GB wide at the 512GB boundary */
> -    [VIRT_HIGH_PCIE_MMIO] =     { 0x8000000000ULL, 0x8000000000ULL },
> +    [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> +    [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> +    /* Second PCIe window */
> +    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
>  };
>  
>  static const int a15irqmap[] = {
> @@ -1354,6 +1368,29 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>      return arm_cpu_mp_affinity(idx, clustersz);
>  }
>  
> +static void virt_set_memmap(VirtMachineState *vms)
> +{
> +    hwaddr base;
> +    int i;
> +
> +    vms->memmap = extended_memmap;
> +
> +    for (i = 0; i < ARRAY_SIZE(base_memmap); i++) {
> +        vms->memmap[i] = base_memmap[i];
> +    }
> +
> +    base = 256 * GiB; /* Top of the legacy initial RAM region */
nit:
 like you suggested, maybe use here [VIRT_MEM] + RAMLIMIT_BYTES

> +
> +    for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
> +        hwaddr size = extended_memmap[i].size;
> +
> +        base = ROUND_UP(base, size);
> +        vms->memmap[i].base = base;
> +        vms->memmap[i].size = size;
> +        base += size;
> +    }
> +}
> +
>  static void machvirt_init(MachineState *machine)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(machine);
> @@ -1368,6 +1405,8 @@ static void machvirt_init(MachineState *machine)
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>      bool aarch64 = true;
>  
> +    virt_set_memmap(vms);
> +
>      /* We can probe only here because during property set
>       * KVM is not available yet
>       */
> @@ -1845,7 +1884,7 @@ static void virt_instance_init(Object *obj)
>                                      "Valid values are none and smmuv3",
>                                      NULL);
>  
> -    vms->memmap = a15memmap;
> +    vms->memmap = NULL;
nit:
 it's sufficient to just remove this line as objects a guarantied to be 0 initialized

>      vms->irqmap = a15irqmap;
>  }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a27086d524..f3f7fae4ac 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -64,7 +64,6 @@ enum {
>      VIRT_GIC_VCPU,
>      VIRT_GIC_ITS,
>      VIRT_GIC_REDIST,
> -    VIRT_HIGH_GIC_REDIST2,
>      VIRT_SMMU,
>      VIRT_UART,
>      VIRT_MMIO,
> @@ -74,12 +73,18 @@ enum {
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
>      VIRT_PCIE_ECAM,
> -    VIRT_HIGH_PCIE_ECAM,
>      VIRT_PLATFORM_BUS,
> -    VIRT_HIGH_PCIE_MMIO,
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_LOWMEMMAP_LAST,
> +};
> +
> +/* indices of IO regions located after the RAM */
> +enum {
> +    VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
> +    VIRT_HIGH_PCIE_ECAM,
> +    VIRT_HIGH_PCIE_MMIO,
>  };
>  
>  typedef enum VirtIOMMUType {
> @@ -116,7 +121,7 @@ typedef struct {
>      int32_t gic_version;
>      VirtIOMMUType iommu;
>      struct arm_boot_info bootinfo;
> -    const MemMapEntry *memmap;
> +    MemMapEntry *memmap;
>      const int *irqmap;
>      int smp_cpus;
>      void *fdt;
