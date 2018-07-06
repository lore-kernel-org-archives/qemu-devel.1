Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fbMzX-0006FA-Dr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fbMzV-0006cB-Cr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:25:27 -0400
From: Jan Kiszka <jan.kiszka@web.de>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-21-luc.michel@greensocs.com>
	<d8062fb6-8eef-eff3-fa92-9f9f791ee669@web.de>
	<a199e550-4576-3a03-a7c1-8c21bb502cf5@web.de>
Message-ID: <fea850ca-d0cf-75ba-e906-55b11726f354@web.de>
Date: Fri, 6 Jul 2018 11:25:05 +0200
MIME-Version: 1.0
In-Reply-To: <a199e550-4576-3a03-a7c1-8c21bb502cf5@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com

On 2018-07-05 10:00, Jan Kiszka wrote:
> On 2018-07-05 08:51, Jan Kiszka wrote:
>> On 2018-06-29 15:29, Luc Michel wrote:
>>> Add support for GICv2 virtualization extensions by mapping the necessary
>>> I/O regions and connecting the maintenance IRQ lines.
>>>
>>> Declare those additions in the device tree and in the ACPI tables.
>>>
>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>> ---
>>>  hw/arm/virt-acpi-build.c |  4 ++++
>>>  hw/arm/virt.c            | 50 +++++++++++++++++++++++++++++++++-------
>>>  include/hw/arm/virt.h    |  3 +++
>>>  3 files changed, 49 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index 6ea47e2588..3b74bf0372 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -659,6 +659,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>          gicc->length = sizeof(*gicc);
>>>          if (vms->gic_version == 2) {
>>>              gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
>>> +            gicc->gich_base_address = cpu_to_le64(memmap[VIRT_GIC_HYP].base);
>>> +            gicc->gicv_base_address = cpu_to_le64(memmap[VIRT_GIC_VCPU].base);
>>>          }
>>>          gicc->cpu_interface_number = cpu_to_le32(i);
>>>          gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
>>> @@ -670,6 +672,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>          }
>>>          if (vms->virt && vms->gic_version == 3) {
>>>              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
>>> +        } else if (vms->virt && vms->gic_version == 2) {
>>> +            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV2_MAINT_IRQ));
>>>          }
>>>      }
>>>  
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 742f68afca..e45b9de3be 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -131,6 +131,8 @@ static const MemMapEntry a15memmap[] = {
>>>      [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
>>>      [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
>>>      [VIRT_GIC_V2M] =            { 0x08020000, 0x00001000 },
>>> +    [VIRT_GIC_HYP] =            { 0x08030000, 0x00001000 },
>>> +    [VIRT_GIC_VCPU] =           { 0x08040000, 0x00001000 },
>>>      /* The space in between here is reserved for GICv3 CPU/vCPU/HYP */
>>>      [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
>>>      /* This redistributor space allows up to 2*64kB*123 CPUs */
>>> @@ -438,11 +440,26 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>>>          /* 'cortex-a15-gic' means 'GIC v2' */
>>>          qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
>>>                                  "arm,cortex-a15-gic");
>>> -        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
>>> -                                      2, vms->memmap[VIRT_GIC_DIST].base,
>>> -                                      2, vms->memmap[VIRT_GIC_DIST].size,
>>> -                                      2, vms->memmap[VIRT_GIC_CPU].base,
>>> -                                      2, vms->memmap[VIRT_GIC_CPU].size);
>>> +        if (!vms->virt) {
>>> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
>>> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
>>> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
>>> +                                         2, vms->memmap[VIRT_GIC_CPU].base,
>>> +                                         2, vms->memmap[VIRT_GIC_CPU].size);
>>> +        } else {
>>> +            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
>>> +                                         2, vms->memmap[VIRT_GIC_DIST].base,
>>> +                                         2, vms->memmap[VIRT_GIC_DIST].size,
>>> +                                         2, vms->memmap[VIRT_GIC_CPU].base,
>>> +                                         2, vms->memmap[VIRT_GIC_CPU].size,
>>> +                                         2, vms->memmap[VIRT_GIC_HYP].base,
>>> +                                         2, vms->memmap[VIRT_GIC_HYP].size,
>>> +                                         2, vms->memmap[VIRT_GIC_VCPU].base,
>>> +                                         2, vms->memmap[VIRT_GIC_VCPU].size);
>>> +            qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
>>> +                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV2_MAINT_IRQ,
>>> +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>>> +        }
>>>      }
>>>  
>>>      qemu_fdt_setprop_cell(vms->fdt, "/intc", "phandle", vms->gic_phandle);
>>> @@ -563,6 +580,11 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>>              qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
>>>                  MIN(smp_cpus - redist0_count, redist1_capacity));
>>>          }
>>> +    } else {
>>> +        if (!kvm_irqchip_in_kernel()) {
>>> +            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
>>> +                              vms->virt);
>>> +        }
>>>      }
>>>      qdev_init_nofail(gicdev);
>>>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>>> @@ -574,6 +596,10 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>>          }
>>>      } else {
>>>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
>>> +        if (vms->virt) {
>>> +            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_HYP].base);
>>> +            sysbus_mmio_map(gicbusdev, 3, vms->memmap[VIRT_GIC_VCPU].base);
>>> +        }
>>>      }
>>>  
>>>      /* Wire the outputs from each CPU's generic timer and the GICv3
>>> @@ -600,9 +626,17 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>>                                                     ppibase + timer_irq[irq]));
>>>          }
>>>  
>>> -        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
>>> -                                    qdev_get_gpio_in(gicdev, ppibase
>>> -                                                     + ARCH_GICV3_MAINT_IRQ));
>>> +        if (type == 3) {
>>> +            qemu_irq irq = qdev_get_gpio_in(gicdev,
>>> +                                            ppibase + ARCH_GICV3_MAINT_IRQ);
>>> +            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
>>> +                                        0, irq);
>>> +        } else if (vms->virt) {
>>> +            qemu_irq irq = qdev_get_gpio_in(gicdev,
>>> +                                            ppibase + ARCH_GICV2_MAINT_IRQ);
>>> +            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
>>> +        }
>>> +
>>>          qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
>>>                                      qdev_get_gpio_in(gicdev, ppibase
>>>                                                       + VIRTUAL_PMU_IRQ));
>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>> index 9a870ccb6a..9e2f33f2d1 100644
>>> --- a/include/hw/arm/virt.h
>>> +++ b/include/hw/arm/virt.h
>>> @@ -42,6 +42,7 @@
>>>  #define NUM_VIRTIO_TRANSPORTS 32
>>>  #define NUM_SMMU_IRQS          4
>>>  
>>> +#define ARCH_GICV2_MAINT_IRQ  9
>>>  #define ARCH_GICV3_MAINT_IRQ  9
>>>  
>>>  #define ARCH_TIMER_VIRT_IRQ   11
>>> @@ -60,6 +61,8 @@ enum {
>>>      VIRT_GIC_DIST,
>>>      VIRT_GIC_CPU,
>>>      VIRT_GIC_V2M,
>>> +    VIRT_GIC_HYP,
>>> +    VIRT_GIC_VCPU,
>>>      VIRT_GIC_ITS,
>>>      VIRT_GIC_REDIST,
>>>      VIRT_GIC_REDIST2,
>>>
>>
>> This one apparently requires rebasing over master. Did this manually.
>>
>> But now I'm running into troubles with reading back GICD ITARGETSR.
>> Maybe we are emulating an "early implementation" here?
>>
>> [from the related Jailhouse code [1]]
>> /*
>>  * Get the CPU interface ID for this cpu. It can be discovered by
>>  * reading the banked value of the PPI and IPI TARGET registers
>>  * Patch 2bb3135 in Linux explains why the probe may need to scans the
>>  * first 8 registers: some early implementation returned 0 for the first
>>  * ITARGETSR registers.
>>  * Since those didn't have virtualization extensions, we can safely
>>  * ignore that case.
>>  */
>>
>> But maybe I'm just off with the configuration, checking...
>>
> 
> As suspected, it's a bug in QEMU, this resolves it, and I can run Linux
> as root cell and a bare metal non-root cell:
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 7d24348d96..199f953ddb 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -965,7 +965,11 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
>              if (irq >= 29 && irq <= 31) {
>                  res = cm;
>              } else {
> -                res = GIC_DIST_TARGET(irq);
> +                if (irq < GIC_INTERNAL) {
> +                    res = 1 << gic_get_current_cpu(s);
> +                } else {
> +                    res = GIC_DIST_TARGET(irq);
> +                }
>              }
>          }
>      } else if (offset < 0xf00) {
> 
> Didn't test Linux as non-root cell (secondary guest) yet, but that
> should work as well. I'm seeing issues in an error shutdown path, but
> that might be the same on real hw, needs cross-checking.

The shutdown issue actually turned out to be a Jailhouse bug. Fixed now
as well, and we run smoothly in GICv2 mode over QEMU, also with the
secondary Linux guest!

Jan
