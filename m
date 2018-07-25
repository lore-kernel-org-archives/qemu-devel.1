Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiFIk-0001Ez-Mv
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiFIh-0006VI-Nf
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:37:42 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:55776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fiFIh-0006Tc-Ek
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:37:39 -0400
Received: by mail-it0-x241.google.com with SMTP id 16-v6so7523248itl.5
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 01:37:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B5824B5.5050904@huawei.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<5B5824B5.5050904@huawei.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 25 Jul 2018 16:37:38 +0800
Message-ID: <CAHmQWvD7QwRLBHL_Ky8TjwgWi9av=hKnbC1Yi3TVazAaDSi_FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 25 July 2018 at 15:20, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> Hi Hongbo,
>
Hi Shannon,

> On 2018/7/25 13:30, Hongbo Zhang wrote:
>> For the Aarch64, there is one machine 'virt', it is primarily meant to
>> run on KVM and execute virtualization workloads, but we need an
>> environment as faithful as possible to physical hardware, for supporting
>> firmware and OS development for pysical Aarch64 machines.
>>
>> This patch introduces new machine type 'Enterprise' with main features:
>>  - Based on 'virt' machine type.
>>  - Re-designed memory map.
>>  - EL2 and EL3 are enabled by default.
>>  - GIC version 3 by default.
>>  - AHCI controller attached to system bus, and then CDROM and hard disc
>>    can be added to it.
>>  - EHCI controller attached to system bus, with USB mouse and key board
>>    installed by default.
>>  - E1000E ethernet card on PCIE bus.
>>  - VGA display adaptor on PCIE bus.
>>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>>  - No virtio functions enabled, since this is to emulate real hardware.
>>  - No paravirtualized fw_cfg device either.
>>
> Does it support run on KVM or just TCG?
>
TCG is suggested to be used, but KVM isn't disabled now, it is up to
the user to use it or not.
(I would like to run some SBSA/SBBR test suite to see if there is some
difference later)

>> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>> Changes since v1:
>>  - rebase on v3.0.0-rc0
>>  - introduce another auxillary patch as 1/2, so this is 2/2
>>  - rename 'sbsa' to 'enterprise'
>>  - remove paravirualized fw_cfg
>>  - set gic_vertion to 3 instead of 2
>>  - edit commit message to describe purpose of this platform
>>
>>  hw/arm/virt-acpi-build.c |  59 +++++++++++++-
>>  hw/arm/virt.c            | 199 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/hw/arm/virt.h    |   3 +
>>  3 files changed, 255 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 6ea47e2..212832e 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -84,6 +84,52 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>>      aml_append(scope, dev);
>>  }
>>
>> +static void acpi_dsdt_add_ahci(Aml *scope, const MemMapEntry *ahci_memmap,
>> +                                           uint32_t ahci_irq)
>> +{
>> +    Aml *dev = aml_device("AHC0");
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO001E")));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>> +
>> +    Aml *crs = aml_resource_template();
>> +    aml_append(crs, aml_memory32_fixed(ahci_memmap->base,
>> +                                       ahci_memmap->size, AML_READ_WRITE));
>> +    aml_append(crs,
>> +               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>> +                             AML_EXCLUSIVE, &ahci_irq, 1));
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +
>> +    Aml *pkg = aml_package(3);
>> +    aml_append(pkg, aml_int(0x1));
>> +    aml_append(pkg, aml_int(0x6));
>> +    aml_append(pkg, aml_int(0x1));
>> +
>> +    /* append the SATA class id */
>> +    aml_append(dev, aml_name_decl("_CLS", pkg));
>> +
>> +    aml_append(scope, dev);
>> +}
>> +
>> +static void acpi_dsdt_add_ehci(Aml *scope, const MemMapEntry *ehci_memmap,
>> +                                           uint32_t ehci_irq)
>> +{
>> +    Aml *dev = aml_device("EHC0");
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0D20")));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>> +
>> +    Aml *crs = aml_resource_template();
>> +    aml_append(crs, aml_memory32_fixed(ehci_memmap->base,
>> +                                       ehci_memmap->size, AML_READ_WRITE));
>> +    aml_append(crs,
>> +               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>> +                             AML_EXCLUSIVE, &ehci_irq, 1));
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +
>> +    aml_append(scope, dev);
>> +}
>> +
>>  static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
>>  {
>>      Aml *dev = aml_device("FWCF");
>> @@ -768,14 +814,23 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
>>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
>>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> As you don't create the fw_cfg, no need to add it ACPI here.
>
Forgot this in this v2 patch, will move the if (!vms->enterprise) to include it.

>> -    acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>> -                    (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>> +    if (!vms->enterprise) {
>> +        acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>> +                   (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>> +    }
>>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
>>                        vms->highmem, vms->highmem_ecam);
>>      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
>>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>>      acpi_dsdt_add_power_button(scope);
>>
>> +    if (vms->enterprise) {
>> +        acpi_dsdt_add_ahci(scope, &memmap[VIRT_AHCI],
>> +                           (irqmap[VIRT_AHCI] + ARM_SPI_BASE));
>> +        acpi_dsdt_add_ehci(scope, &memmap[VIRT_EHCI],
>> +                           (irqmap[VIRT_EHCI] + ARM_SPI_BASE));
>> +    }
>> +
>>      aml_append(dsdt, scope);
>>
>>      /* copy AML table into ACPI tables blob and patch header there */
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 281ddcd..498b526 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -59,6 +59,10 @@
>>  #include "qapi/visitor.h"
>>  #include "standard-headers/linux/input.h"
>>  #include "hw/arm/smmuv3.h"
>> +#include "hw/ide/internal.h"
>> +#include "hw/ide/ahci_internal.h"
>> +#include "hw/usb.h"
>> +#include "qemu/units.h"
>>
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>> @@ -94,6 +98,8 @@
>>
>>  #define PLATFORM_BUS_NUM_IRQS 64
>>
>> +#define SATA_NUM_PORTS 6
>> +
>>  /* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>>   * RAM can go up to the 256GB mark, leaving 256GB of the physical
>>   * address space unallocated and free for future use between 256G and 512G.
>> @@ -168,6 +174,47 @@ static const int a15irqmap[] = {
>>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>>  };
>>
>> +static const MemMapEntry enterprise_memmap[] = {
>> +    /* Space up to 0x8000000 is reserved for a boot ROM */
>> +    [VIRT_FLASH] =              {          0, 0x08000000 },
>> +    [VIRT_CPUPERIPHS] =         { 0x08000000, 0x00020000 },
>> +    /* GIC distributor and CPU interfaces sit inside the CPU peripheral space */
>> +    [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
>> +    [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
>> +    [VIRT_GIC_V2M] =            { 0x08020000, 0x00001000 },
>> +    /* The space in between here is reserved for GICv3 CPU/vCPU/HYP */
>> +    [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
>> +    /* This redistributor space allows up to 2*64kB*123 CPUs */
>> +    [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
>> +    [VIRT_UART] =               { 0x09000000, 0x00001000 },
>> +    [VIRT_RTC] =                { 0x09010000, 0x00001000 },
>> +    [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
> no need to reserve mmio for fw_cfg.
>
Right, payed much attention to verify patch 1/2 and ignored here :(

>> +    [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>> +    [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>> +    [VIRT_AHCI] =               { 0x09050000, 0x00010000 },
>> +    [VIRT_EHCI] =               { 0x09060000, 0x00010000 },
> Between VIRT_EHCI and VIRT_PLATFORM_BUS, there are still some spaces,
> can we reuse it?
>
This derives from virt machine a15memmap, and I see even the a15memmap
has some blank spaces, so I just simply leave spaces as well.

> Also, is it necessary to create VIRT_PLATFORM_BUS?
>
Good catch, not necessary to keep it, I've tested that qemu works fine
without it.

>> +    [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>> +    [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
>> +    [VIRT_PCIE_MMIO] =          { 0x10000000, 0x7fff0000 },
>> +    [VIRT_PCIE_PIO] =           { 0x8fff0000, 0x00010000 },
>> +    [VIRT_PCIE_ECAM] =          { 0x90000000, 0x10000000 },
>> +    /* Second PCIe window, 508GB wide at the 4GB boundary */
>> +    [VIRT_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0x7F00000000ULL },
>> +    [VIRT_MEM] =                { 0x8000000000ULL, RAMLIMIT_BYTES },
>> +};
>> +
>> +static const int enterprise_irqmap[] = {
>> +    [VIRT_UART] = 1,
>> +    [VIRT_RTC] = 2,
>> +    [VIRT_PCIE] = 3, /* ... to 6 */
>> +    [VIRT_GPIO] = 7,
>> +    [VIRT_SECURE_UART] = 8,
>> +    [VIRT_AHCI] = 9,
>> +    [VIRT_EHCI] = 10,
>> +    [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>> +    [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>> +};
>> +
>>  static const char *valid_cpus[] = {
>>      ARM_CPU_TYPE_NAME("cortex-a15"),
>>      ARM_CPU_TYPE_NAME("cortex-a53"),
>> @@ -706,6 +753,72 @@ static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
>>      g_free(nodename);
>>  }
>>
>> +static void create_ahci(const VirtMachineState *vms, qemu_irq *pic)
>> +{
>> +    char *nodename;
>> +    hwaddr base = vms->memmap[VIRT_AHCI].base;
>> +    hwaddr size = vms->memmap[VIRT_AHCI].size;
>> +    int irq = vms->irqmap[VIRT_AHCI];
>> +    const char compat[] = "qemu,mach-virt-ahci\0generic-ahci";
>> +    DeviceState *dev;
>> +    DriveInfo *hd[SATA_NUM_PORTS];
>> +    SysbusAHCIState *sysahci;
>> +    AHCIState *ahci;
>> +    int i;
>> +
>> +    dev = qdev_create(NULL, "sysbus-ahci");
>> +    qdev_prop_set_uint32(dev, "num-ports", SATA_NUM_PORTS);
>> +    qdev_init_nofail(dev);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
>> +
>> +    sysahci = SYSBUS_AHCI(dev);
>> +    ahci = &sysahci->ahci;
>> +    ide_drive_get(hd, ARRAY_SIZE(hd));
>> +    for (i = 0; i < ahci->ports; i++) {
>> +        if (hd[i] == NULL) {
>> +            continue;
>> +        }
>> +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
>> +    }
>> +
>> +    nodename = g_strdup_printf("/sata@%" PRIx64, base);
>> +    qemu_fdt_add_subnode(vms->fdt, nodename);
>> +    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
>> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
>> +                                 2, base, 2, size);
>> +    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
>> +                           GIC_FDT_IRQ_TYPE_SPI, irq,
>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>> +    g_free(nodename);
>> +}
>> +
>> +static void create_ehci(const VirtMachineState *vms, qemu_irq *pic)
>> +{
>> +    char *nodename;
>> +    hwaddr base = vms->memmap[VIRT_EHCI].base;
>> +    hwaddr size = vms->memmap[VIRT_EHCI].size;
>> +    int irq = vms->irqmap[VIRT_EHCI];
>> +    const char compat[] = "qemu,mach-virt-ehci\0generic-ehci";
>> +    USBBus *usb_bus;
>> +
>> +    sysbus_create_simple("exynos4210-ehci-usb", base, pic[irq]);
>> +
>> +    usb_bus = usb_bus_find(-1);
>> +    usb_create_simple(usb_bus, "usb-kbd");
>> +    usb_create_simple(usb_bus, "usb-mouse");
>> +
>> +    nodename = g_strdup_printf("/ehci@%" PRIx64, base);
>> +    qemu_fdt_add_subnode(vms->fdt, nodename);
>> +    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
>> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
>> +                                 2, base, 2, size);
>> +    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
>> +                           GIC_FDT_IRQ_TYPE_SPI, irq,
>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>> +    g_free(nodename);
>> +}
>> +
>>  static DeviceState *gpio_key_dev;
>>  static void virt_powerdown_req(Notifier *n, void *opaque)
>>  {
>> @@ -1117,13 +1230,21 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
>>              NICInfo *nd = &nd_table[i];
>>
>>              if (!nd->model) {
>> -                nd->model = g_strdup("virtio");
>> +                if (vms->enterprise) {
>> +                    nd->model = g_strdup("e1000e");
>> +                } else {
>> +                    nd->model = g_strdup("virtio");
>> +                }
>>              }
>>
>>              pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>>          }
>>      }
>>
>> +    if (vms->enterprise) {
>> +        pci_create_simple(pci->bus, -1, "VGA");
>> +    }
>> +
>>      nodename = g_strdup_printf("/pcie@%" PRIx64, base);
>>      qemu_fdt_add_subnode(vms->fdt, nodename);
>>      qemu_fdt_setprop_string(vms->fdt, nodename,
>> @@ -1512,14 +1633,21 @@ static void machvirt_init(MachineState *machine)
>>
>>      create_gpio(vms, pic);
>>
>> +    if (vms->enterprise) {
>> +        create_ahci(vms, pic);
>> +        create_ehci(vms, pic);
>> +    }
>> +
>>      /* Create mmio transports, so the user can create virtio backends
>>       * (which will be automatically plugged in to the transports). If
>>       * no backend is created the transport will just sit harmlessly idle.
>>       */
>> -    create_virtio_devices(vms, pic);
>> +    if (!vms->enterprise) {
>> +        create_virtio_devices(vms, pic);
>>
>> -    vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
>> -    rom_set_fw(vms->fw_cfg);
>> +        vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
>> +        rom_set_fw(vms->fw_cfg);
>> +    }
>>
>>      create_platform_bus(vms, pic);
>>
>> @@ -1828,6 +1956,7 @@ static void virt_3_0_instance_init(Object *obj)
>>
>>      vms->memmap = a15memmap;
>>      vms->irqmap = a15irqmap;
>> +    vms->enterprise = false;
>>  }
>>
>>  static void virt_machine_3_0_options(MachineClass *mc)
>> @@ -1960,3 +2089,65 @@ static void virt_machine_2_6_options(MachineClass *mc)
>>      vmc->no_pmu = true;
>>  }
>>  DEFINE_VIRT_MACHINE(2, 6)
>> +
>> +static void enterprise_instance_init(Object *obj)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    vms->secure = true;
>> +    object_property_add_bool(obj, "secure", virt_get_secure,
>> +                             virt_set_secure, NULL);
>> +    object_property_set_description(obj, "secure",
>> +                                    "Set on/off to enable/disable the ARM "
>> +                                    "Security Extensions (TrustZone)",
>> +                                    NULL);
>> +
>> +    vms->virt = true;
>> +    object_property_add_bool(obj, "virtualization", virt_get_virt,
>> +                             virt_set_virt, NULL);
>> +    object_property_set_description(obj, "virtualization",
>> +                                    "Set on/off to enable/disable emulating a "
>> +                                    "guest CPU which implements the ARM "
>> +                                    "Virtualization Extensions",
>> +                                    NULL);
>> +
>> +    vms->highmem = true;
>> +
>> +    vms->gic_version = 3;
>> +    object_property_add_str(obj, "gic-version", virt_get_gic_version,
>> +                        virt_set_gic_version, NULL);
>> +    object_property_set_description(obj, "gic-version",
>> +                                    "Set GIC version. "
>> +                                    "Valid values are 2, 3, host, max", NULL);
>> +    vms->its = true;
>> +
>> +    vms->memmap = enterprise_memmap;
>> +    vms->irqmap = enterprise_irqmap;
>> +    vms->enterprise = true;
>> +}
>> +
>> +static void enterprise_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    mc->max_cpus = 246;
> Why 246?
>
This depends on the GIC redistributor space size.
I didn't change the size from previous a15memmap, each CPU core needs
64k memory size, and the total GIC redistributor can support 246 cores
at max, you can also see the comment in a15memmap source code.
(this only applies for GICv3, for the GICv2, max CPU number is much
less, and there is a problem of emulating MPIDR, I will send patch to
fix it if I have time )

>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
>> +    mc->block_default_type = IF_IDE;
>> +    mc->default_ram_size = 1 * GiB;
>> +    mc->default_cpus = 4;
>> +    mc->desc = "QEMU 'Enterprise' ARM Virtual Machine";
>> +}
>> +
>> +static const TypeInfo enterprise_info = {
>> +    .name          = MACHINE_TYPE_NAME("enterprise"),
>> +    .parent        = TYPE_VIRT_MACHINE,
>> +    .instance_init = enterprise_instance_init,
>> +    .class_init    = enterprise_class_init,
>> +};
>> +
>> +static void enterprise_machine_init(void)
>> +{
>> +    type_register_static(&enterprise_info);
>> +}
>> +
>> +type_init(enterprise_machine_init);
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 9a870cc..e65d478 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -78,6 +78,8 @@ enum {
>>      VIRT_GPIO,
>>      VIRT_SECURE_UART,
>>      VIRT_SECURE_MEM,
>> +    VIRT_AHCI,
>> +    VIRT_EHCI,
>>  };
>>
>>  typedef enum VirtIOMMUType {
>> @@ -124,6 +126,7 @@ typedef struct {
>>      uint32_t msi_phandle;
>>      uint32_t iommu_phandle;
>>      int psci_conduit;
>> +    bool enterprise;
>>  } VirtMachineState;
>>
>>  #define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
>>
>
> --
> Shannon
>
