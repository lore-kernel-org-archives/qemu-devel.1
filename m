Received: from eggs.gnu.org ([209.51.188.92]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwr4y-0003im-E0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwr4x-0005rd-3v
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:20:08 -0500
Date: Thu, 21 Feb 2019 17:19:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221171944.1cc65a33@redhat.com>
In-Reply-To: <20190220224003.4420-4-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 03/17] hw/arm/virt: Split the memory map
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

On Wed, 20 Feb 2019 23:39:49 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> In the prospect to introduce an extended memory map supporting more
> RAM, let's split the memory map array into two parts:
> 
> - the former a15memmap contains regions below and including the RAM

> - extended_memmap, only initialized with entries located after the RAM.
>   Only the size of the region is initialized there since their base
>   address will be dynamically computed, depending on the top of the
>   RAM (initial RAM at the moment), with same alignment as their size.
can't parse this part and pinpoint what is 'their', care to rephrase?


> This new split will allow to grow the RAM size without changing the
> description of the high regions.
> 
> The patch also moves the memory map setup
s/moves/makes/
s/$/dynamic and moves it/

> into machvirt_init().

> The rationale is the memory map will be soon affected by the

> kvm_type() call that happens after virt_instance_init() and
is dependency on kvm_type() still valid,
shouldn't split memmap work for TCG just fine as well?

> before machvirt_init().
> 
> The memory map is unchanged (the top of the initial RAM still is
> 256GiB). Then come the high IO regions with same layout as before.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> ---
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
>  hw/arm/virt.c         | 48 +++++++++++++++++++++++++++++++++++++------
>  include/hw/arm/virt.h | 14 +++++++++----
>  2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a1955e7764..12039a0367 100644
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
> @@ -149,11 +150,21 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +};
> +
> +/*
> + * Highmem IO Regions: This memory map is floating, located after the RAM.
> + * Each IO region offset will be dynamically computed, depending on the
s/IO region offset/MemMapEntry base (GPA)/
> + * top of the RAM, so that its base get the same alignment as the size,

> + * ie. a 512GiB region will be aligned on a 512GiB boundary. If there is
s/region/entry/

> + * less than 256GiB of RAM, the floating area starts at the 256GiB mark.
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
> @@ -1354,6 +1365,30 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>      return arm_cpu_mp_affinity(idx, clustersz);
>  }
>  
> +static void virt_set_memmap(VirtMachineState *vms)
> +{
> +    hwaddr base;
> +    int i;
> +
> +    vms->memmap = extended_memmap;
I probably don't see something but ...

> +
> +    for (i = 0; i < ARRAY_SIZE(base_memmap); i++) {
> +        vms->memmap[i] = base_memmap[i];

ARRAY_SIZE(base_memmap) > 3
ARRAY_SIZE(extended_memmap) == 3
as result shouldn't we observe OOB at vms->memmap[i] access
starting from i==3 ?

> +    }
> +
> +    vms->high_io_base = 256 * GiB; /* Top of the legacy initial RAM region */
> +    base = vms->high_io_base;
> +
> +    for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
not sure why VIRT_LOWMEMMAP_LAST is needed at all, one could just continue
with current 'i' value, provided extended_memmap wasn't corrupted by previous
loop.
And does this loop ever executes? VIRT_LOWMEMMAP_LAST > ARRAY_SIZE(extended_memmap)

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
> @@ -1368,6 +1403,8 @@ static void machvirt_init(MachineState *machine)
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>      bool aarch64 = true;
>  
> +    virt_set_memmap(vms);
> +
>      /* We can probe only here because during property set
>       * KVM is not available yet
>       */
> @@ -1843,7 +1880,6 @@ static void virt_instance_init(Object *obj)
>                                      "Valid values are none and smmuv3",
>                                      NULL);
>  
> -    vms->memmap = a15memmap;
>      vms->irqmap = a15irqmap;
>  }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a27086d524..3dc7a6c5d5 100644
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
> @@ -126,6 +131,7 @@ typedef struct {
>      uint32_t msi_phandle;
>      uint32_t iommu_phandle;
>      int psci_conduit;
> +    hwaddr high_io_base;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
