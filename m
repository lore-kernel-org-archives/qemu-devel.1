Received: from eggs.gnu.org ([209.51.188.92]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwq0F-0005Se-RN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwq0C-0003fy-D6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:11:10 -0500
Date: Thu, 21 Feb 2019 16:05:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221160534.183636e0@redhat.com>
In-Reply-To: <20190220224003.4420-3-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 02/17] hw/arm/virt: Rename highmem IO
 regions
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

On Wed, 20 Feb 2019 23:39:48 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> In preparation for a split of the memory map into a static
> part and a dynamic part floating after the RAM, let's rename the
> regions located after the RAM
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

with indent and checkpatch warnings fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v7: added Peter's R-b
> v6: creation
> ---
>  hw/arm/virt-acpi-build.c |  8 ++++----
>  hw/arm/virt.c            | 21 +++++++++++----------
>  include/hw/arm/virt.h    |  8 ++++----
>  3 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 04b62c714d..829d2f0035 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -229,8 +229,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>                       size_pio));
>  
>      if (use_highmem) {
> -        hwaddr base_mmio_high = memmap[VIRT_PCIE_MMIO_HIGH].base;
> -        hwaddr size_mmio_high = memmap[VIRT_PCIE_MMIO_HIGH].size;
> +        hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
> +        hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
>  
>          aml_append(rbuf,
>              aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> @@ -663,8 +663,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              gicr = acpi_data_push(table_data, sizeof(*gicr));
>              gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
>              gicr->length = sizeof(*gicr);
> -            gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST2].base);
> -            gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST2].size);
> +            gicr->base_address = cpu_to_le64(memmap[VIRT_HIGH_GIC_REDIST2].base);
> +            gicr->range_length = cpu_to_le32(memmap[VIRT_HIGH_GIC_REDIST2].size);
>          }
>  
>          if (its_class_name() && !vmc->no_its) {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 99c2b6e60d..a1955e7764 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -150,10 +150,10 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> -    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
> -    [VIRT_PCIE_ECAM_HIGH] =     { 0x4010000000ULL, 0x10000000 },
> +    [VIRT_HIGH_GIC_REDIST2] =   { 0x4000000000ULL, 0x4000000 },
> +    [VIRT_HIGH_PCIE_ECAM] =     { 0x4010000000ULL, 0x10000000 },
>      /* Second PCIe window, 512GB wide at the 512GB boundary */
> -    [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
> +    [VIRT_HIGH_PCIE_MMIO] =     { 0x8000000000ULL, 0x8000000000ULL },
>  };
>  
>  static const int a15irqmap[] = {
> @@ -435,8 +435,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>                                           2, vms->memmap[VIRT_GIC_DIST].size,
>                                           2, vms->memmap[VIRT_GIC_REDIST].base,
>                                           2, vms->memmap[VIRT_GIC_REDIST].size,
> -                                         2, vms->memmap[VIRT_GIC_REDIST2].base,
> -                                         2, vms->memmap[VIRT_GIC_REDIST2].size);
> +                                         2, vms->memmap[VIRT_HIGH_GIC_REDIST2].base,
> +                                         2, vms->memmap[VIRT_HIGH_GIC_REDIST2].size);
>          }
>  
>          if (vms->virt) {
> @@ -584,7 +584,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>  
>          if (nb_redist_regions == 2) {
>              uint32_t redist1_capacity =
> -                        vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
> +                    vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
is indent correct here (it didn't look correct to begin with).

Strangle checkpatch didn't complain about it, but since I've run it
does complain about a bunch of "line over 80 characters" on this patch

>  
>              qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
>                  MIN(smp_cpus - redist0_count, redist1_capacity));
> @@ -601,7 +601,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>      if (type == 3) {
>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
>          if (nb_redist_regions == 2) {
> -            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
> +            sysbus_mmio_map(gicbusdev, 2,
> +                            vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
>          }
>      } else {
>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
> @@ -1088,8 +1089,8 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
>  {
>      hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
> -    hwaddr base_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].base;
> -    hwaddr size_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
> +    hwaddr base_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].base;
> +    hwaddr size_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].size;
>      hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
>      hwaddr base_ecam, size_ecam;
> @@ -1418,7 +1419,7 @@ static void machvirt_init(MachineState *machine)
>       */
>      if (vms->gic_version == 3) {
>          virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
> -        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
> +        virt_max_cpus += vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
>      } else {
>          virt_max_cpus = GIC_NCPU;
>      }
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4cc57a7ef6..a27086d524 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -64,7 +64,7 @@ enum {
>      VIRT_GIC_VCPU,
>      VIRT_GIC_ITS,
>      VIRT_GIC_REDIST,
> -    VIRT_GIC_REDIST2,
> +    VIRT_HIGH_GIC_REDIST2,
>      VIRT_SMMU,
>      VIRT_UART,
>      VIRT_MMIO,
> @@ -74,9 +74,9 @@ enum {
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
>      VIRT_PCIE_ECAM,
> -    VIRT_PCIE_ECAM_HIGH,
> +    VIRT_HIGH_PCIE_ECAM,
>      VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_MMIO_HIGH,
> +    VIRT_HIGH_PCIE_MMIO,
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> @@ -128,7 +128,7 @@ typedef struct {
>      int psci_conduit;
>  } VirtMachineState;
>  
> -#define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
> +#define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
>  
>  #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
>  #define VIRT_MACHINE(obj) \
