Received: from eggs.gnu.org ([209.51.188.92]:35522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hLVhv-0007Fu-0G
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hLVht-0007MW-BS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:34:14 -0400
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-6-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <74cfc52e-715b-31d6-1e6e-03987b5814d5@redhat.com>
Date: Tue, 30 Apr 2019 18:34:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190409102935.28292-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/8] hw/arm/virt: Enable device memory
 cold/hot plug with ACPI boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, xuwei5@hisilicon.com, lersek@redhat.com, ard.biesheuvel@linaro.org, linuxarm@huawei.com

Hi Shameer,

On 4/9/19 12:29 PM, Shameer Kolothum wrote:
> This initializes the GED device with base memory and irq, configures
> ged memory hotplug event and builds the corresponding aml code. GED
> irq routing to Guest is also enabled. With this, both hot and cold
> plug of device memory is enabled now for Guest with ACPI boot.
> 
> Memory cold plug support with Guest DT boot is not yet supported.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Individual history logs may be helpful to follow the changes (change in
MMIO reggion size, ...)
> ---
>  default-configs/arm-softmmu.mak |  2 ++
>  hw/arm/virt-acpi-build.c        |  9 ++++++
>  hw/arm/virt.c                   | 61 +++++++++++++++++++++++++++++++++++++++--
>  include/hw/arm/virt.h           |  4 +++
>  4 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 9f4b803..c9a9b34 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -163,3 +163,5 @@ CONFIG_LSI_SCSI_PCI=y
>  
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
> +CONFIG_ACPI_MEMORY_HOTPLUG=y
> +CONFIG_ACPI_HW_REDUCED=y
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bf9c0bc..1ad394b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -40,6 +40,8 @@
>  #include "hw/loader.h"
>  #include "hw/hw.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> @@ -727,6 +729,7 @@ static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      Aml *scope, *dsdt;
> +    MachineState *ms = MACHINE(vms);
>      const MemMapEntry *memmap = vms->memmap;
>      const int *irqmap = vms->irqmap;
>  
> @@ -753,6 +756,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      acpi_dsdt_add_power_button(scope);
>  
> +    build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(vms->acpi_dev),
> +                  irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY);
> +
> +    build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
> +                             AML_SYSTEM_MEMORY);
> +
>      aml_append(dsdt, scope);
>  
>      /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index da516b3..8179b3e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -63,6 +63,7 @@
>  #include "target/arm/internals.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/acpi/generic_event_device.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -133,6 +134,8 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
> +    [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_REG_LEN },>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -168,6 +171,7 @@ static const int a15irqmap[] = {
>      [VIRT_PCIE] = 3, /* ... to 6 */
>      [VIRT_GPIO] = 7,
>      [VIRT_SECURE_UART] = 8,
> +    [VIRT_ACPI_GED] = 9,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> @@ -183,6 +187,13 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("max"),
>  };
>  
> +static GedEvent ged_events[] = {
> +    {
> +        .selector = ACPI_GED_IRQ_SEL_MEM,
> +        .event    = GED_MEMORY_HOTPLUG,
> +    },
> +};
> +
>  static bool cpu_type_valid(const char *cpu)
>  {
>      int i;
> @@ -516,6 +527,26 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>      }
>  }
>  
> +static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
> +{
> +    DeviceState *dev;
> +
> +    dev = DEVICE(object_new(TYPE_ACPI_GED));
> +    qdev_prop_set_uint64(dev, "memhp-base",
> +                         vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    qdev_prop_set_ptr(dev, "gsi", vms->gsi);
> +    qdev_prop_set_uint64(dev, "ged-base", vms->memmap[VIRT_ACPI_GED].base);
> +    qdev_prop_set_uint32(dev, "ged-irq", vms->irqmap[VIRT_ACPI_GED]);
so as commented earlier I wonder why we can directly pass the right gsi.
> +    qdev_prop_set_ptr(dev, "ged-events", ged_events);
> +    qdev_prop_set_uint32(dev, "ged-events-size", ARRAY_SIZE(ged_events));
> +
> +    object_property_add_child(qdev_get_machine(), "acpi-ged",
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
> +
> +    return dev;
> +}
> +
>  static void create_its(VirtMachineState *vms, DeviceState *gicdev)
>  {
>      const char *itsclass = its_class_name();
> @@ -555,6 +586,12 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
>      fdt_add_v2m_gic_node(vms);
>  }
>  
> +static void virt_gsi_handler(void *opaque, int n, int level)
> +{
> +    qemu_irq *gic_irq = opaque;
> +    qemu_set_irq(gic_irq[n], level);
In https://patchwork.kernel.org/patch/10863285/, I asked why this gsi
routing was necessary. Please forgive me if I missed your answer but I
still don't get why it is necessary.
> +}
> +
>  static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>  {
>      /* We create a standalone GIC */
> @@ -670,6 +707,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>          pic[i] = qdev_get_gpio_in(gicdev, i);
>      }
>  
> +    vms->gsi = qemu_allocate_irqs(virt_gsi_handler, pic, NUM_IRQS);
> +
>      fdt_add_gic_node(vms);
>  
>      if (type == 3 && vms->its) {
> @@ -1418,7 +1457,7 @@ static void machvirt_init(MachineState *machine)
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *possible_cpus;
> -    qemu_irq pic[NUM_IRQS];
> +    qemu_irq *pic;
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *secure_sysmem = NULL;
>      int n, virt_max_cpus;
> @@ -1614,6 +1653,7 @@ static void machvirt_init(MachineState *machine)
>  
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
> +    pic = g_new0(qemu_irq, NUM_IRQS);
>      create_gic(vms, pic);
>  
>      fdt_add_pmu_nodes(vms);
> @@ -1644,6 +1684,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_platform_bus(vms, pic);
>  
> +    vms->acpi_dev = create_acpi_ged(vms);
> +
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -1811,21 +1853,34 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                   Error **errp)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        error_setg(errp, "memory cold/hot plug is not yet supported");
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> +
> +    if (is_nvdimm) {
> +        error_setg(errp, "nvdimm is not yet supported");
>          return;
>      }
>  
> +    if (!vms->acpi_dev) {
> +        error_setg(errp, "memory hotplug is not enabled: missing acpi device");
> +        return;
> +    }
> +
> +    hotplug_handler_pre_plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, errp);
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
>  
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> +    HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
>  
> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, NULL);
>  }
>  
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 507517c..9c6b0b1 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -77,6 +77,8 @@ enum {
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_PCDIMM_ACPI,
> +    VIRT_ACPI_GED,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> @@ -132,6 +134,8 @@ typedef struct {
>      uint32_t iommu_phandle;
>      int psci_conduit;
>      hwaddr highest_gpa;
> +    DeviceState *acpi_dev;
> +    qemu_irq *gsi;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
Thanks

Eric
> 
