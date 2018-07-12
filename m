Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcoY-00066G-JL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcoX-0004xk-J6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:43:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdcoX-0004xF-DK
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:43:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id l10-v6so9535290oii.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:43:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-21-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-21-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 15:43:04 +0100
Message-ID: <CAFEAcA-=nMs7NeVSkCzcs-Wp=nVr9kDrApoKHK7FT--vZQM82A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 20/20] arm/virt: Add support for GICv2
 virtualization extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Add support for GICv2 virtualization extensions by mapping the necessary
> I/O regions and connecting the maintenance IRQ lines.
>
> Declare those additions in the device tree and in the ACPI tables.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/arm/virt-acpi-build.c |  4 ++++
>  hw/arm/virt.c            | 50 +++++++++++++++++++++++++++++++++-------
>  include/hw/arm/virt.h    |  3 +++
>  3 files changed, 49 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6ea47e2588..3b74bf0372 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -659,6 +659,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          gicc->length = sizeof(*gicc);
>          if (vms->gic_version == 2) {
>              gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
> +            gicc->gich_base_address = cpu_to_le64(memmap[VIRT_GIC_HYP].base);
> +            gicc->gicv_base_address = cpu_to_le64(memmap[VIRT_GIC_VCPU].base);
>          }
>          gicc->cpu_interface_number = cpu_to_le32(i);
>          gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
> @@ -670,6 +672,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>          if (vms->virt && vms->gic_version == 3) {
>              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
> +        } else if (vms->virt && vms->gic_version == 2) {
> +            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV2_MAINT_IRQ));

The maintenance interrupt number is the same for GICv2 and v3, so
this seems a bit unnecessary -- we can just rename the constant to
ARCH_GIC_MAINT_IRQ and not condition it on the GIC version at all.

>          }
>      }
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 742f68afca..e45b9de3be 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -131,6 +131,8 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
>      [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
>      [VIRT_GIC_V2M] =            { 0x08020000, 0x00001000 },
> +    [VIRT_GIC_HYP] =            { 0x08030000, 0x00001000 },
> +    [VIRT_GIC_VCPU] =           { 0x08040000, 0x00001000 },

This is too small a size -- it doesn't include the GICV_DIR.
I would recommend making both of these sized 0x10000, ie a full
64K page. We don't want to have anything else in there for the
case where we're using 64K pages on a 64-bit guest CPU.

>      /* The space in between here is reserved for GICv3 CPU/vCPU/HYP */
>      [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
>      /* This redistributor space allows up to 2*64kB*123 CPUs */
> @@ -438,11 +440,26 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>          /* 'cortex-a15-gic' means 'GIC v2' */
>          qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
>                                  "arm,cortex-a15-gic");
> -        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> -                                      2, vms->memmap[VIRT_GIC_DIST].base,
> -                                      2, vms->memmap[VIRT_GIC_DIST].size,
> -                                      2, vms->memmap[VIRT_GIC_CPU].base,
> -                                      2, vms->memmap[VIRT_GIC_CPU].size);
> +        if (!vms->virt) {
> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
> +                                         2, vms->memmap[VIRT_GIC_CPU].base,
> +                                         2, vms->memmap[VIRT_GIC_CPU].size);
> +        } else {
> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
> +                                         2, vms->memmap[VIRT_GIC_CPU].base,
> +                                         2, vms->memmap[VIRT_GIC_CPU].size,
> +                                         2, vms->memmap[VIRT_GIC_HYP].base,
> +                                         2, vms->memmap[VIRT_GIC_HYP].size,
> +                                         2, vms->memmap[VIRT_GIC_VCPU].base,
> +                                         2, vms->memmap[VIRT_GIC_VCPU].size);
> +            qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
> +                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV2_MAINT_IRQ,
> +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);

You'll find this needs to be fixed up a bit when rebased on current master.

> +        }
>      }

thanks
-- PMM
