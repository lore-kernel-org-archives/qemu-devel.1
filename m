Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fYU5j-0004ma-Fz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fYU5g-000165-V7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:23:55 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fYU5g-00014d-96
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:23:52 -0400
Received: by mail-io0-x242.google.com with SMTP id l19-v6so4738735ioj.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 03:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8736x7w98z.fsf@linaro.org>
References: <1530094388-607-1-git-send-email-hongbo.zhang@linaro.org>
	<20180627123116.GB2424@work-vm>
	<CAHmQWvB2tPRXHOm08CQ+2R34gepULw8+pvKPa693coFbs-YvZg@mail.gmail.com>
	<8736x7w98z.fsf@linaro.org>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 28 Jun 2018 18:23:50 +0800
Message-ID: <CAHmQWvCwJFtwPD7Z+MHcmj_-Z-2k3OViBOi0gM_8NcqSA+jgYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm]  [PATCH] hw/arm: Add SBSA machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 June 2018 at 17:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Hongbo Zhang <hongbo.zhang@linaro.org> writes:
>
>> On 27 June 2018 at 20:31, Dr. David Alan Gilbert <dgilbert@redhat.com> w=
rote:
>>> * Hongbo Zhang (hongbo.zhang@linaro.org) wrote:
> <snip>
>> (Maybe we can change the kernel defconfig to e1000e, then we chose
>> e1000e here too)
>>
>>> then to my mind it makes sense to use virtio-net-pci rather than
>>> an e1000e.
>>>
>> Well, this is to emulate a 'true' hardware for firmware etc
>> development, primary purpose it to emulate hardware functions, not for
>> performance, so virtio is disabled, some firmware, boot loaders etc
>> may not work with virtio either, if people want virtio, they can use
>> the legacy 'virt' machine.
>
> I don't think pci based virtio is any different from "real" hardware in
> that sense. The bus supports device enumeration and detection via a
> standard mechanism, the actual endpoint is merely a driver detail.
>
Difference is from the perspective of hardware structure, in real Arm
hardware, AHCI and EHCI are system memory mapped, not PCIE devices.

> However I think we should be aiming for an absolute minimum that you
> then configure on top off. I must admit I end up --nodefaults in my
> command line more than I would like.
>
>>
>>> Dave
>>>
>>>> This is the prototype, more features can be added in futrue.
>>>>
>>>> Purpose of this is to have a standard QEMU platform for Arm firmware
>>>> developement etc. where the legacy machines cannot meets requirements.
>>>>
>>>> Arm Trusted Firmware and UEFI porting to this are done seperately.
>>>>
>>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>>>> ---
>>>>  hw/arm/virt-acpi-build.c |  59 +++++++++++++-
>>>>  hw/arm/virt.c            | 196 ++++++++++++++++++++++++++++++++++++++=
++++++++-
>>>>  include/hw/arm/virt.h    |   3 +
>>>>  3 files changed, 254 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index 6ea47e2..60af414 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -84,6 +84,52 @@ static void acpi_dsdt_add_uart(Aml *scope, const Me=
mMapEntry *uart_memmap,
>>>>      aml_append(scope, dev);
>>>>  }
>>>>
>>>> +static void acpi_dsdt_add_ahci(Aml *scope, const MemMapEntry *ahci_me=
mmap,
>>>> +                                           uint32_t ahci_irq)
>>>> +{
>>>> +    Aml *dev =3D aml_device("AHC0");
>>>> +    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO001E")));
>>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>>>> +
>>>> +    Aml *crs =3D aml_resource_template();
>>>> +    aml_append(crs, aml_memory32_fixed(ahci_memmap->base,
>>>> +                                       ahci_memmap->size, AML_READ_WR=
ITE));
>>>> +    aml_append(crs,
>>>> +               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH=
,
>>>> +                             AML_EXCLUSIVE, &ahci_irq, 1));
>>>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>>>> +
>>>> +    Aml *pkg =3D aml_package(3);
>>>> +    aml_append(pkg, aml_int(0x1));
>>>> +    aml_append(pkg, aml_int(0x6));
>>>> +    aml_append(pkg, aml_int(0x1));
>>>> +
>>>> +    /* append the SATA class id */
>>>> +    aml_append(dev, aml_name_decl("_CLS", pkg));
>>>> +
>>>> +    aml_append(scope, dev);
>>>> +}
>>>> +
>>>> +static void acpi_dsdt_add_ehci(Aml *scope, const MemMapEntry *ehci_me=
mmap,
>>>> +                                           uint32_t ehci_irq)
>>>> +{
>>>> +    Aml *dev =3D aml_device("EHC0");
>>>> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0D20")));
>>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>>>> +
>>>> +    Aml *crs =3D aml_resource_template();
>>>> +    aml_append(crs, aml_memory32_fixed(ehci_memmap->base,
>>>> +                                       ehci_memmap->size, AML_READ_WR=
ITE));
>>>> +    aml_append(crs,
>>>> +               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH=
,
>>>> +                             AML_EXCLUSIVE, &ehci_irq, 1));
>>>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>>>> +
>>>> +    aml_append(scope, dev);
>>>> +}
>>>> +
>>>>  static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cf=
g_memmap)
>>>>  {
>>>>      Aml *dev =3D aml_device("FWCF");
>>>> @@ -768,14 +814,23 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r, VirtMachineState *vms)
>>>>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
>>>>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
>>>>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>>>> -    acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>>>> -                    (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TR=
ANSPORTS);
>>>> +    if (!vms->sbsa) {
>>>> +        acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>>>> +                   (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRA=
NSPORTS);
>>>> +    }
>>>>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BAS=
E),
>>>>                        vms->highmem, vms->highmem_ecam);
>>>>      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
>>>>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>>>>      acpi_dsdt_add_power_button(scope);
>>>>
>>>> +    if (vms->sbsa) {
>>>> +        acpi_dsdt_add_ahci(scope, &memmap[VIRT_AHCI],
>>>> +                           (irqmap[VIRT_AHCI] + ARM_SPI_BASE));
>>>> +        acpi_dsdt_add_ehci(scope, &memmap[VIRT_EHCI],
>>>> +                           (irqmap[VIRT_EHCI] + ARM_SPI_BASE));
>>>> +    }
>>>> +
>>>>      aml_append(dsdt, scope);
>>>>
>>>>      /* copy AML table into ACPI tables blob and patch header there */
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>> index 742f68a..491f23b 100644
>>>> --- a/hw/arm/virt.c
>>>> +++ b/hw/arm/virt.c
>>>> @@ -59,6 +59,10 @@
>>>>  #include "qapi/visitor.h"
>>>>  #include "standard-headers/linux/input.h"
>>>>  #include "hw/arm/smmuv3.h"
>>>> +#include "hw/ide/internal.h"
>>>> +#include "hw/ide/ahci_internal.h"
>>>> +#include "hw/usb.h"
>>>> +#include "qemu/cutils.h"
>>>>
>>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, =
\
>>>> @@ -94,6 +98,8 @@
>>>>
>>>>  #define PLATFORM_BUS_NUM_IRQS 64
>>>>
>>>> +#define SATA_NUM_PORTS 6
>>>> +
>>>>  /* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>>>>   * RAM can go up to the 256GB mark, leaving 256GB of the physical
>>>>   * address space unallocated and free for future use between 256G and=
 512G.
>>>> @@ -168,6 +174,47 @@ static const int a15irqmap[] =3D {
>>>>      [VIRT_PLATFORM_BUS] =3D 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS=
 -1 */
>>>>  };
>>>>
>>>> +static const MemMapEntry sbsa_memmap[] =3D {
>>>> +    /* Space up to 0x8000000 is reserved for a boot ROM */
>>>> +    [VIRT_FLASH] =3D              {          0, 0x08000000 },
>>>> +    [VIRT_CPUPERIPHS] =3D         { 0x08000000, 0x00020000 },
>>>> +    /* GIC distributor and CPU interfaces sit inside the CPU peripher=
al space */
>>>> +    [VIRT_GIC_DIST] =3D           { 0x08000000, 0x00010000 },
>>>> +    [VIRT_GIC_CPU] =3D            { 0x08010000, 0x00010000 },
>>>> +    [VIRT_GIC_V2M] =3D            { 0x08020000, 0x00001000 },
>>>> +    /* The space in between here is reserved for GICv3 CPU/vCPU/HYP *=
/
>>>> +    [VIRT_GIC_ITS] =3D            { 0x08080000, 0x00020000 },
>>>> +    /* This redistributor space allows up to 2*64kB*123 CPUs */
>>>> +    [VIRT_GIC_REDIST] =3D         { 0x080A0000, 0x00F60000 },
>>>> +    [VIRT_UART] =3D               { 0x09000000, 0x00001000 },
>>>> +    [VIRT_RTC] =3D                { 0x09010000, 0x00001000 },
>>>> +    [VIRT_FW_CFG] =3D             { 0x09020000, 0x00000018 },
>>>> +    [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
>>>> +    [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
>>>> +    [VIRT_AHCI] =3D               { 0x09050000, 0x00010000 },
>>>> +    [VIRT_EHCI] =3D               { 0x09060000, 0x00010000 },
>>>> +    [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
>>>> +    [VIRT_SECURE_MEM] =3D         { 0x0e000000, 0x01000000 },
>>>> +    [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x7fff0000 },
>>>> +    [VIRT_PCIE_PIO] =3D           { 0x8fff0000, 0x00010000 },
>>>> +    [VIRT_PCIE_ECAM] =3D          { 0x90000000, 0x10000000 },
>>>> +    /* Second PCIe window, 508GB wide at the 4GB boundary */
>>>> +    [VIRT_PCIE_MMIO_HIGH] =3D     { 0x100000000ULL, 0x7F00000000ULL }=
,
>>>> +    [VIRT_MEM] =3D                { 0x8000000000ULL, RAMLIMIT_BYTES }=
,
>>>> +};
>>>> +
>>>> +static const int sbsa_irqmap[] =3D {
>>>> +    [VIRT_UART] =3D 1,
>>>> +    [VIRT_RTC] =3D 2,
>>>> +    [VIRT_PCIE] =3D 3, /* ... to 6 */
>>>> +    [VIRT_GPIO] =3D 7,
>>>> +    [VIRT_SECURE_UART] =3D 8,
>>>> +    [VIRT_AHCI] =3D 9,
>>>> +    [VIRT_EHCI] =3D 10,
>>>> +    [VIRT_GIC_V2M] =3D 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>>>> +    [VIRT_PLATFORM_BUS] =3D 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS=
 -1 */
>>>> +};
>>>> +
>>>>  static const char *valid_cpus[] =3D {
>>>>      ARM_CPU_TYPE_NAME("cortex-a15"),
>>>>      ARM_CPU_TYPE_NAME("cortex-a53"),
>>>> @@ -696,6 +743,72 @@ static void create_rtc(const VirtMachineState *vm=
s, qemu_irq *pic)
>>>>      g_free(nodename);
>>>>  }
>>>>
>>>> +static void create_ahci(const VirtMachineState *vms, qemu_irq *pic)
>>>> +{
>>>> +    char *nodename;
>>>> +    hwaddr base =3D vms->memmap[VIRT_AHCI].base;
>>>> +    hwaddr size =3D vms->memmap[VIRT_AHCI].size;
>>>> +    int irq =3D vms->irqmap[VIRT_AHCI];
>>>> +    const char compat[] =3D "qemu,mach-virt-ahci\0generic-ahci";
>>>> +    DeviceState *dev;
>>>> +    DriveInfo *hd[SATA_NUM_PORTS];
>>>> +    SysbusAHCIState *sysahci;
>>>> +    AHCIState *ahci;
>>>> +    int i;
>>>> +
>>>> +    dev =3D qdev_create(NULL, "sysbus-ahci");
>>>> +    qdev_prop_set_uint32(dev, "num-ports", SATA_NUM_PORTS);
>>>> +    qdev_init_nofail(dev);
>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
>>>> +
>>>> +    sysahci =3D SYSBUS_AHCI(dev);
>>>> +    ahci =3D &sysahci->ahci;
>>>> +    ide_drive_get(hd, ARRAY_SIZE(hd));
>>>> +    for (i =3D 0; i < ahci->ports; i++) {
>>>> +        if (hd[i] =3D=3D NULL) {
>>>> +            continue;
>>>> +        }
>>>> +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
>>>> +    }
>>>> +
>>>> +    nodename =3D g_strdup_printf("/sata@%" PRIx64, base);
>>>> +    qemu_fdt_add_subnode(vms->fdt, nodename);
>>>> +    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof=
(compat));
>>>> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
>>>> +                                 2, base, 2, size);
>>>> +    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
>>>> +                           GIC_FDT_IRQ_TYPE_SPI, irq,
>>>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>>>> +    g_free(nodename);
>>>> +}
>>>> +
>>>> +static void create_ehci(const VirtMachineState *vms, qemu_irq *pic)
>>>> +{
>>>> +    char *nodename;
>>>> +    hwaddr base =3D vms->memmap[VIRT_EHCI].base;
>>>> +    hwaddr size =3D vms->memmap[VIRT_EHCI].size;
>>>> +    int irq =3D vms->irqmap[VIRT_EHCI];
>>>> +    const char compat[] =3D "qemu,mach-virt-ehci\0generic-ehci";
>>>> +    USBBus *usb_bus;
>>>> +
>>>> +    sysbus_create_simple("exynos4210-ehci-usb", base, pic[irq]);
>>>> +
>>>> +    usb_bus =3D usb_bus_find(-1);
>>>> +    usb_create_simple(usb_bus, "usb-kbd");
>>>> +    usb_create_simple(usb_bus, "usb-mouse");
>>>> +
>>>> +    nodename =3D g_strdup_printf("/ehci@%" PRIx64, base);
>>>> +    qemu_fdt_add_subnode(vms->fdt, nodename);
>>>> +    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof=
(compat));
>>>> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
>>>> +                                 2, base, 2, size);
>>>> +    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
>>>> +                           GIC_FDT_IRQ_TYPE_SPI, irq,
>>>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>>>> +    g_free(nodename);
>>>> +}
>>>> +
>>>>  static DeviceState *gpio_key_dev;
>>>>  static void virt_powerdown_req(Notifier *n, void *opaque)
>>>>  {
>>>> @@ -1107,13 +1220,21 @@ static void create_pcie(VirtMachineState *vms,=
 qemu_irq *pic)
>>>>              NICInfo *nd =3D &nd_table[i];
>>>>
>>>>              if (!nd->model) {
>>>> -                nd->model =3D g_strdup("virtio");
>>>> +                if (vms->sbsa) {
>>>> +                    nd->model =3D g_strdup("e1000");
>>>> +                } else {
>>>> +                    nd->model =3D g_strdup("virtio");
>>>> +                }
>>>>              }
>>>>
>>>>              pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>>>>          }
>>>>      }
>>>>
>>>> +    if (vms->sbsa) {
>>>> +        pci_create_simple(pci->bus, -1, "VGA");
>>>> +    }
>>>> +
>>>>      nodename =3D g_strdup_printf("/pcie@%" PRIx64, base);
>>>>      qemu_fdt_add_subnode(vms->fdt, nodename);
>>>>      qemu_fdt_setprop_string(vms->fdt, nodename,
>>>> @@ -1502,11 +1623,18 @@ static void machvirt_init(MachineState *machin=
e)
>>>>
>>>>      create_gpio(vms, pic);
>>>>
>>>> +    if (vms->sbsa) {
>>>> +        create_ahci(vms, pic);
>>>> +        create_ehci(vms, pic);
>>>> +    }
>>>> +
>>>>      /* Create mmio transports, so the user can create virtio backends
>>>>       * (which will be automatically plugged in to the transports). If
>>>>       * no backend is created the transport will just sit harmlessly i=
dle.
>>>>       */
>>>> -    create_virtio_devices(vms, pic);
>>>> +    if (!vms->sbsa) {
>>>> +        create_virtio_devices(vms, pic);
>>>> +    }
>>>>
>>>>      vms->fw_cfg =3D create_fw_cfg(vms, &address_space_memory);
>>>>      rom_set_fw(vms->fw_cfg);
>>>> @@ -1818,6 +1946,7 @@ static void virt_3_0_instance_init(Object *obj)
>>>>
>>>>      vms->memmap =3D a15memmap;
>>>>      vms->irqmap =3D a15irqmap;
>>>> +    vms->sbsa =3D false;
>>>>  }
>>>>
>>>>  static void virt_machine_3_0_options(MachineClass *mc)
>>>> @@ -1950,3 +2079,66 @@ static void virt_machine_2_6_options(MachineCla=
ss *mc)
>>>>      vmc->no_pmu =3D true;
>>>>  }
>>>>  DEFINE_VIRT_MACHINE(2, 6)
>>>> +
>>>> +static void sbsa_instance_init(Object *obj)
>>>> +{
>>>> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>>>> +
>>>> +    vms->secure =3D true;
>>>> +    object_property_add_bool(obj, "secure", virt_get_secure,
>>>> +                             virt_set_secure, NULL);
>>>> +    object_property_set_description(obj, "secure",
>>>> +                                    "Set on/off to enable/disable the=
 ARM "
>>>> +                                    "Security Extensions (TrustZone)"=
,
>>>> +                                    NULL);
>>>> +
>>>> +    vms->virt =3D true;
>>>> +    object_property_add_bool(obj, "virtualization", virt_get_virt,
>>>> +                             virt_set_virt, NULL);
>>>> +    object_property_set_description(obj, "virtualization",
>>>> +                                    "Set on/off to enable/disable emu=
lating a "
>>>> +                                    "guest CPU which implements the A=
RM "
>>>> +                                    "Virtualization Extensions",
>>>> +                                    NULL);
>>>> +
>>>> +    vms->highmem =3D true;
>>>> +
>>>> +    /* This can be changed to GICv3 when firmware is ready*/
>>>> +    vms->gic_version =3D 2;
>>>> +    object_property_add_str(obj, "gic-version", virt_get_gic_version,
>>>> +                        virt_set_gic_version, NULL);
>>>> +    object_property_set_description(obj, "gic-version",
>>>> +                                    "Set GIC version. "
>>>> +                                    "Valid values are 2, 3, host, max=
", NULL);
>>>> +    vms->its =3D true;
>>>> +
>>>> +    vms->memmap =3D sbsa_memmap;
>>>> +    vms->irqmap =3D sbsa_irqmap;
>>>> +    vms->sbsa =3D true;
>>>> +}
>>>> +
>>>> +static void sbsa_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>>> +
>>>> +    mc->max_cpus =3D 246;
>>>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a57");
>>>> +    mc->block_default_type =3D IF_IDE;
>>>> +    mc->default_ram_size =3D 1 * G_BYTE;
>>>> +    mc->default_cpus =3D 4;
>>>> +    mc->desc =3D "QEMU 'SBSA' ARM Virtual Machine";
>>>> +}
>>>> +
>>>> +static const TypeInfo sbsa_info =3D {
>>>> +    .name          =3D MACHINE_TYPE_NAME("sbsa"),
>>>> +    .parent        =3D TYPE_VIRT_MACHINE,
>>>> +    .instance_init =3D sbsa_instance_init,
>>>> +    .class_init    =3D sbsa_class_init,
>>>> +};
>>>> +
>>>> +static void sbsa_machine_init(void)
>>>> +{
>>>> +    type_register_static(&sbsa_info);
>>>> +}
>>>> +
>>>> +type_init(sbsa_machine_init);
>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>> index 9a870cc..619473e 100644
>>>> --- a/include/hw/arm/virt.h
>>>> +++ b/include/hw/arm/virt.h
>>>> @@ -78,6 +78,8 @@ enum {
>>>>      VIRT_GPIO,
>>>>      VIRT_SECURE_UART,
>>>>      VIRT_SECURE_MEM,
>>>> +    VIRT_AHCI,
>>>> +    VIRT_EHCI,
>>>>  };
>>>>
>>>>  typedef enum VirtIOMMUType {
>>>> @@ -124,6 +126,7 @@ typedef struct {
>>>>      uint32_t msi_phandle;
>>>>      uint32_t iommu_phandle;
>>>>      int psci_conduit;
>>>> +    bool sbsa;
>>>>  } VirtMachineState;
>>>>
>>>>  #define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_EC=
AM)
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
> --
> Alex Benn=C3=A9e
