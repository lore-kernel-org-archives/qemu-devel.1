Received: from eggs.gnu.org ([2001:4830:134:3::10]:58162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fVLl5-0003J1-QV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fVLl4-0004Qc-IG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:53:39 -0400
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
	<1529072910-16156-6-git-send-email-eric.auger@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a4204e03-735d-28b9-7cc5-d51fd727b91f@redhat.com>
Date: Tue, 19 Jun 2018 20:53:30 +0200
MIME-Version: 1.0
In-Reply-To: <1529072910-16156-6-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/11] hw/arm/virt: GICv3 DT node with
 one or two redistributor regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, ard.biesheuvel@linaro.org
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com

Hi Eric,

sorry about the late followup. I have one question (mainly for Ard):

On 06/15/18 16:28, Eric Auger wrote:
> This patch allows the creation of a GICv3 node with 1 or 2
> redistributor regions depending on the number of smu_cpus.
> The second redistributor region is located just after the
> existing RAM region, at 256GB and contains up to up to 512 vcpus.
>
> Please refer to kernel documentation for further node details:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
> ---
> v1 (virt3.0) -> v2
> - Added Drew's R-b
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
> index 2885d18..d9f72eb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -148,6 +148,8 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +    /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> +    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
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
> +
>          if (vms->virt) {
>              qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
>                                     GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,

In edk2, we have the following code in
"ArmVirtPkg/Library/ArmVirtGicArchLib/ArmVirtGicArchLib.c":

  switch (GicRevision) {

  case 3:
    //
    // The GIC v3 DT binding describes a series of at least 3 physical (base
    // addresses, size) pairs: the distributor interface (GICD), at least one
    // redistributor region (GICR) containing dedicated redistributor
    // interfaces for all individual CPUs, and the CPU interface (GICC).
    // Under virtualization, we assume that the first redistributor region
    // listed covers the boot CPU. Also, our GICv3 driver only supports the
    // system register CPU interface, so we can safely ignore the MMIO version
    // which is listed after the sequence of redistributor interfaces.
    // This means we are only interested in the first two memory regions
    // supplied, and ignore everything else.
    //
    ASSERT (RegSize >= 32);

    // RegProp[0..1] == { GICD base, GICD size }
    DistBase = SwapBytes64 (Reg[0]);
    ASSERT (DistBase < MAX_UINTN);

    // RegProp[2..3] == { GICR base, GICR size }
    RedistBase = SwapBytes64 (Reg[2]);
    ASSERT (RedistBase < MAX_UINTN);

    PcdStatus = PcdSet64S (PcdGicDistributorBase, DistBase);
    ASSERT_RETURN_ERROR (PcdStatus);
    PcdStatus = PcdSet64S (PcdGicRedistributorsBase, RedistBase);
    ASSERT_RETURN_ERROR (PcdStatus);

    DEBUG ((EFI_D_INFO, "Found GIC v3 (re)distributor @ 0x%Lx (0x%Lx)\n",
      DistBase, RedistBase));

(I vaguely recall that I may have quoted this already, but I'm not
sure.)

My understanding is that this will continue working -- as long as we
don't want to boot up multiple CPUs in UEFI, anyway.

I think we have no plans for adding (well, for implementing)
EFI_PEI_MP_SERVICES_PPI or EFI_MP_SERVICES_PROTOCOL for ARM -- do you
agree, Ard?

(That PPI and PROTOCOL are totally unnecessary unless it is
architecturally required to configure various CPU features on each
(V)CPU *individually*, before leaving the firmware. Unfortunately, x86
has some CPU warts like that, and said PPI and PROTOCOL implementations
for x86 have given us a good dose of grief over time. I very much hope
the PPI and the PROTOCOL will never be needed on ARM!)


Eric, I reckon you tested this patch with the ArmVirtQemu firmware too,
covering both branches of the code, and with multiple VCPUs in both
cases. Can you please confirm?

Thanks
Laszlo
