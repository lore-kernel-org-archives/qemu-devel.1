Received: from eggs.gnu.org ([2001:4830:134:3::10]:44136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSCa-0001Sg-Ai
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSCZ-0003fw-3p
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:22:12 -0400
Date: Thu, 14 Jun 2018 15:21:53 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180614132153.lspgdpzjvmx5q65u@kamzik.brq.redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-6-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528879723-24675-6-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] hw/arm/virt: GICv3 DT node with one or
 two redistributor regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com, lersek@redhat.com

On Wed, Jun 13, 2018 at 10:48:39AM +0200, Eric Auger wrote:
> This patch allows the creation of a GICv3 node with 1 or 2
> redistributor regions depending on the number of smu_cpus.
> The second redistributor region is located just after the
> existing RAM region, at 256GB and contains up to up to 512 vcpus.
> 
> Please refer to kernel documentation for further node details:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - VIRT_GIC_REDIST2 is now 64MB large, ie. 512 redistributor capacity
> - virt_gicv3_redist_region_count does not test kvm_irqchip_in_kernel
>   anymore
> ---
>  hw/arm/virt.c         | 29 ++++++++++++++++++++++++-----
>  include/hw/arm/virt.h | 14 ++++++++++++++
>  2 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2885d18..5c02cc5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -148,6 +148,8 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +    /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> +    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000ULL },

No need for the ULL on the size. It messes up some alignment when the 2nd
ECAM region is added with patch 8/9.

>      /* Second PCIe window, 512GB wide at the 512GB boundary */
>      [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
>  };
> @@ -401,13 +403,30 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>      qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
>      qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
>      if (vms->gic_version == 3) {
> +        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
> +
>          qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
>                                  "arm,gic-v3");
> -        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> -                                     2, vms->memmap[VIRT_GIC_DIST].base,
> -                                     2, vms->memmap[VIRT_GIC_DIST].size,
> -                                     2, vms->memmap[VIRT_GIC_REDIST].base,
> -                                     2, vms->memmap[VIRT_GIC_REDIST].size);
> +
> +        qemu_fdt_setprop_cell(vms->fdt, "/intc",
> +                              "#redistributor-regions", nb_redist_regions);
> +
> +        if (nb_redist_regions == 1) {
> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
> +                                         2, vms->memmap[VIRT_GIC_REDIST].base,
> +                                         2, vms->memmap[VIRT_GIC_REDIST].size);
> +        } else {
> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
> +                                         2, vms->memmap[VIRT_GIC_REDIST].base,
> +                                         2, vms->memmap[VIRT_GIC_REDIST].size,
> +                                         2, vms->memmap[VIRT_GIC_REDIST2].base,
> +                                         2, vms->memmap[VIRT_GIC_REDIST2].size);
> +        }

You could handle a general number of redists by building an array and
calling qemu_fdt_setprop_sized_cells_from_array() directly. But, OTOH,
the memory map supports up to exactly two, so that's the current max
anyway.

> +
>          if (vms->virt) {
>              qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
>                                     GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4ac7ef6..308156f 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,8 @@
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
> +#include "sysemu/kvm.h"
> +#include "hw/intc/arm_gicv3_common.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -60,6 +62,7 @@ enum {
>      VIRT_GIC_V2M,
>      VIRT_GIC_ITS,
>      VIRT_GIC_REDIST,
> +    VIRT_GIC_REDIST2,
>      VIRT_SMMU,
>      VIRT_UART,
>      VIRT_MMIO,
> @@ -130,4 +133,15 @@ typedef struct {
>  
>  void virt_acpi_setup(VirtMachineState *vms);
>  
> +/* Return the number of used redistributor regions  */
> +static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
> +{
> +    uint32_t redist0_capacity =
> +                vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +
> +    assert(vms->gic_version == 3);
> +
> +    return vms->smp_cpus > redist0_capacity ? 2 : 1;

Another place that would need to be patched if we ever add a third region.

> +}
> +
>  #endif /* QEMU_ARM_VIRT_H */
> -- 
> 2.5.5
> 
> 

Besides feeling like we should write code that supports > 1 region,
vs. exactly 1 or 2 and the ULL nit, looks good to me

Reviewed-by: Andrew Jones <drjones@redhat.com>
