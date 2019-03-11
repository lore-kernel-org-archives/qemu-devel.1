Received: from eggs.gnu.org ([209.51.188.92]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3SCb-0003Ko-1r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3SCZ-0003wI-VN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:11:17 -0400
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-11-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f3386b54-ec43-c133-9545-c58ad917a71b@redhat.com>
Date: Mon, 11 Mar 2019 22:11:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] hw/arm/virt: Add GED device
 configuration and build aml
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Hi Shameer,

On 3/8/19 12:42 PM, Shameer Kolothum wrote:
> This initializes the GED device with base memory and irq.
> It also configures ged memory hotplug event and builds the
> corresponding aml code.
> 
> But ged irq routing to Guest is not enabled and thus hotplug
> is not yet supported.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/virt-acpi-build.c        | 13 +++++++++++++
>  hw/arm/virt-acpi.c              |  4 ++++
>  hw/arm/virt.c                   | 22 ++++++++++++++++++++++
>  include/hw/arm/virt.h           |  4 ++++
>  5 files changed, 44 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index b3bac25..7c442fd 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -168,3 +168,4 @@ CONFIG_MUSICPAL=y
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
>  CONFIG_ACPI_MEMORY_HOTPLUG=y
> +CONFIG_ACPI_HW_REDUCED=y
requires a KConfig entry now
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6cb7263..86f25ad 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -50,6 +50,18 @@
>  #define ARM_SPI_BASE 32
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>  
> +static void acpi_dsdt_add_ged(Aml *scope, VirtMachineState *vms)
> +{
> +    int irq =  vms->irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE;
> +
> +    if (!vms->ged_events || !vms->ged_events_size) {
> +        return;
> +    }
> +
> +    build_ged_aml(scope, "\\_SB."GED_DEVICE, irq, vms->ged_events,
> +                  vms->ged_events_size, AML_SYSTEM_MEMORY);
> +}
> +
>  static void acpi_dsdt_add_memory_hotplug(Aml *scope, MachineState *ms)
>  {
>      uint32_t nr_mem = ms->ram_slots;
> @@ -758,6 +770,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       */
>      scope = aml_scope("\\_SB");
>      acpi_dsdt_add_memory_hotplug(scope, MACHINE(vms));
> +    acpi_dsdt_add_ged(scope, vms);
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> diff --git a/hw/arm/virt-acpi.c b/hw/arm/virt-acpi.c
> index 18ebe94..3b55c63 100644
> --- a/hw/arm/virt-acpi.c
> +++ b/hw/arm/virt-acpi.c
> @@ -31,6 +31,7 @@
>  typedef struct VirtAcpiState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
> +    GEDState ged_state;
>  } VirtAcpiState;
>  
>  #define TYPE_VIRT_ACPI "virt-acpi"
> @@ -76,12 +77,15 @@ static void virt_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
>      const MemMapEntry *memmap = vms->memmap;
> +    const int *irqmap = vms->irqmap;
>      VirtAcpiState *s = VIRT_ACPI(dev);
>  
>      if (s->memhp_state.is_enabled) {
>          acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
>                                   &s->memhp_state,
>                                   memmap[VIRT_PCDIMM_ACPI].base);
> +        acpi_ged_init(get_system_memory(), OBJECT(dev), &s->ged_state,
> +                      memmap[VIRT_ACPI_GED].base, irqmap[VIRT_ACPI_GED]);
>      }
>  }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9427f4f..352dbb1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -134,6 +134,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, 0x00010000 },
> +    [VIRT_ACPI_GED] =           { 0x09080000, 0x00010000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -169,6 +170,7 @@ static const int a15irqmap[] = {
>      [VIRT_PCIE] = 3, /* ... to 6 */
>      [VIRT_GPIO] = 7,
>      [VIRT_SECURE_UART] = 8,
> +    [VIRT_ACPI_GED] = 9,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> @@ -184,6 +186,25 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("max"),
>  };
>  
> +static void virt_acpi_ged_conf(VirtMachineState *vms)
> +{
> +    uint8_t events_size;
> +
> +    /* GED events */
> +    GedEvent events[] = {
> +        {
> +            .selector = ACPI_GED_IRQ_SEL_MEM,
> +            .event    = GED_MEMORY_HOTPLUG,
> +        },
> +    };
> +
> +    events_size = ARRAY_SIZE(events);
> +
> +    vms->ged_events = g_malloc0(events_size * sizeof(GedEvent));
> +    memcpy(vms->ged_events, events, events_size * sizeof(GedEvent));
> +    vms->ged_events_size = events_size;
> +}
can't you do the virt_acpi_ged_conf's job directly in virt_acpi_init
avoid this memcpy by using a pointer to a static const GedEvent
ged_events[]?
> +
>  static bool cpu_type_valid(const char *cpu)
>  {
>      int i;
> @@ -1650,6 +1671,7 @@ static void machvirt_init(MachineState *machine)
>      create_platform_bus(vms, pic);
>  
>      vms->acpi = virt_acpi_init();
> +    virt_acpi_ged_conf(vms);

>  
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index e46a051..49fda81 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -37,6 +37,7 @@
>  #include "hw/arm/arm.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
> +#include "hw/acpi/ged.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -78,6 +79,7 @@ enum {
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
>      VIRT_PCDIMM_ACPI,
> +    VIRT_ACPI_GED,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> @@ -134,6 +136,8 @@ typedef struct {
>      int psci_conduit;
>      hwaddr highest_gpa;
>      DeviceState *acpi;
> +    GedEvent *ged_events;
> +    uint32_t ged_events_size;
I guess we can avoid that one by using a const GedEvent *ged_events and
using ARRAY_SIZE?

Thanks

Eric
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> 
