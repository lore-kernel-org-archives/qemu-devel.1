Received: from eggs.gnu.org ([209.51.188.92]:45253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3L2i-0004x9-N1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3L2h-0002K7-Ji
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:32:36 -0400
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-7-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3c656ef1-a58e-6461-254e-140976b01d4e@redhat.com>
Date: Mon, 11 Mar 2019 14:32:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] hw/arm/virt: Add ACPI support for
 device memory cold-plug
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
> This adds support to build the aml code so that Guest can see the
s/Guest/the guest
> cold-plugged device memory.

Isn't the colplug part only related to acpi_dsdt_add_memory_hotplug()? I
understand the patch also adds some hotplug infra?

Can't you just keerp the dsdt additions here, move the virt-acpi changes
in the original patch and move the virt-acpi instantiation in a
subsequent patch?

Thanks

Eric
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/virt-acpi-build.c        |  9 +++++++++
>  hw/arm/virt-acpi.c              | 23 +++++++++++++++++++++++
>  hw/arm/virt.c                   | 11 +++++++++++
>  include/hw/arm/virt.h           |  2 ++
>  5 files changed, 46 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index fbc4564..b3bac25 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -167,3 +167,4 @@ CONFIG_HIGHBANK=y
>  CONFIG_MUSICPAL=y
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
> +CONFIG_ACPI_MEMORY_HOTPLUG=y
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d7e2e48..87d66da 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -40,6 +40,7 @@
>  #include "hw/loader.h"
>  #include "hw/hw.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/memory_hotplug.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> @@ -49,6 +50,13 @@
>  #define ARM_SPI_BASE 32
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>  
> +static void acpi_dsdt_add_memory_hotplug(Aml *scope, MachineState *ms)
> +{
> +    uint32_t nr_mem = ms->ram_slots;
> +
> +    build_memory_hotplug_aml(scope, nr_mem, "\\_SB", NULL, AML_SYSTEM_MEMORY);
> +}
> +
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>  {
>      uint16_t i;
> @@ -740,6 +748,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       * the RTC ACPI device at all when using UEFI.
>       */
>      scope = aml_scope("\\_SB");
> +    acpi_dsdt_add_memory_hotplug(scope, MACHINE(vms));
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> diff --git a/hw/arm/virt-acpi.c b/hw/arm/virt-acpi.c
> index df8a02b..18ebe94 100644
> --- a/hw/arm/virt-acpi.c
> +++ b/hw/arm/virt-acpi.c
> @@ -26,9 +26,11 @@
>  #include "hw/arm/virt.h"
>  
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/memory_hotplug.h"
>  
>  typedef struct VirtAcpiState {
>      SysBusDevice parent_obj;
> +    MemHotplugState memhp_state;
>  } VirtAcpiState;
>  
>  #define TYPE_VIRT_ACPI "virt-acpi"
> @@ -44,6 +46,16 @@ static const VMStateDescription vmstate_acpi = {
>  static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
>                                  DeviceState *dev, Error **errp)
>  {
> +    VirtAcpiState *s = VIRT_ACPI(hotplug_dev);
> +
> +    if (s->memhp_state.is_enabled &&
> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state,
> +                                dev, errp);
> +    } else {
> +        error_setg(errp, "virt: device plug request for unsupported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
>  }
>  
>  static void virt_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> @@ -62,6 +74,15 @@ static void virt_send_ged(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static void virt_device_realize(DeviceState *dev, Error **errp)
>  {
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    const MemMapEntry *memmap = vms->memmap;
> +    VirtAcpiState *s = VIRT_ACPI(dev);
> +
> +    if (s->memhp_state.is_enabled) {
> +        acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
> +                                 &s->memhp_state,
> +                                 memmap[VIRT_PCDIMM_ACPI].base);
> +    }
>  }
>  
>  DeviceState *virt_acpi_init(void)
> @@ -70,6 +91,8 @@ DeviceState *virt_acpi_init(void)
>  }
>  
>  static Property virt_acpi_properties[] = {
> +    DEFINE_PROP_BOOL("memory-hotplug-support", VirtAcpiState,
> +                     memhp_state.is_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 40a1273..9427f4f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -133,6 +133,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_PCDIMM_ACPI] =        { 0x09070000, 0x00010000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -1648,6 +1649,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_platform_bus(vms, pic);
>  
> +    vms->acpi = virt_acpi_init();
> +
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -1832,11 +1835,19 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> +    HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>      Error *local_err = NULL;
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi);
> +    hhc->plug(HOTPLUG_HANDLER(vms->acpi), dev, &error_abort);
>  
> +out:
>      error_propagate(errp, local_err);
>  }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 6076167..e46a051 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -77,6 +77,7 @@ enum {
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_PCDIMM_ACPI,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> @@ -132,6 +133,7 @@ typedef struct {
>      uint32_t iommu_phandle;
>      int psci_conduit;
>      hwaddr highest_gpa;
> +    DeviceState *acpi;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> 
