Received: from eggs.gnu.org ([209.51.188.92]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz2n5-0000vL-9Q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz2mx-000703-OO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:14:40 -0500
Date: Wed, 27 Feb 2019 18:14:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190227181412.2a69a926@redhat.com>
In-Reply-To: <20190128110545.20644-4-shameerali.kolothum.thodi@huawei.com>
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<20190128110545.20644-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] hw/arm/virt: Enable pc-dimm
 hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: eric.auger@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, linuxarm@huawei.com, xuwei5@huawei.com

On Mon, 28 Jan 2019 11:05:45 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> pc-dimm memory hotplug is enabled using GPIO(Pin 2) based ACPI
> event. Hot removal functionality is not yet supported.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 884960d..cf64554 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -62,6 +62,7 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pc-hotplug.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1651,7 +1652,14 @@ static void machvirt_init(MachineState *machine)
>          nvdimm_init_acpi_state(acpi_nvdimm_state, sysmem,
>                                 vms->fw_cfg, OBJECT(vms));
>      }
> +    if (vms->acpi_memhp_state.is_enabled) {
> +        MemHotplugState *state =  &vms->acpi_memhp_state;
> +        hwaddr base;
>  
> +        state->hw_reduced_acpi = true;
> +        base = vms->memmap[VIRT_ACPI_IO].base + ACPI_MEMORY_HOTPLUG_BASE;
> +        acpi_memory_hotplug_init(sysmem, OBJECT(vms), state, base);
> +    }
this hunk should be a part of 'acpi' device that owns respective interrupts and mmio regions.
(something like we do in x86)
In this case I'd suggest to make 'base' its property and the board will set it during
device creation.

>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -1819,6 +1827,20 @@ static void virt_set_nvdimm_persistence(Object *obj, const char *value,
>      nvdimm_state->persistence_string = g_strdup(value);
>  }
>  
> +static bool virt_get_memhp_support(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return vms->acpi_memhp_state.is_enabled;
> +}
> +
> +static void virt_set_memhp_support(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    vms->acpi_memhp_state.is_enabled = value;
> +}
> +
>  static CpuInstanceProperties
>  virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {
> @@ -1863,8 +1885,8 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>  
> -    if (dev->hotplugged) {
> -        error_setg(errp, "memory hotplug is not supported");
> +    if (dev->hotplugged && is_nvdimm) {
> +        error_setg(errp, "nvdimm hotplug is not supported");
>      }
>  
>      if (is_nvdimm && !vms->acpi_nvdimm_state.is_enabled) {
> @@ -1875,6 +1897,22 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
>  
> +static void virt_memhp_send_event(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                  Error **errp)
> +{
> +    DeviceState *gpio_dev;
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
> +    gpio_dev = virt_get_gpio_dev(GPIO_PCDIMM);
> +    if (!gpio_dev) {
> +        error_setg(errp, "No dev interface to send hotplug event");
                             ^^^^^^ confusing
> +        return;
> +    }
> +    acpi_memory_plug_cb(hotplug_dev, &vms->acpi_memhp_state,
> +                        dev, errp);
> +    qemu_set_irq(qdev_get_gpio_in(gpio_dev, 0), 1);
> +}
> +
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> @@ -1891,6 +1929,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>          nvdimm_plug(&vms->acpi_nvdimm_state);
>      }
>  
> +    if (dev->hotplugged && !is_nvdimm) {
> +        virt_memhp_send_event(hotplug_dev, dev, errp);
...
  acpi_memory_plug_cb();
  hotplug_handler_plug(HOTPLUG_HANDLER(pcms->gpio_dev), dev, &error_abort);
  ^^^^ forward snd process hotplug notification event in gpio_dev,
       machine should not care about which and how to deal with random IRQs

> +    }
> +
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -1898,6 +1940,11 @@ out:
>  static void virt_memory_unplug(HotplugHandler *hotplug_dev,
>                                 DeviceState *dev, Error **errp)
>  {
> +    if (dev->hotplugged) {
> +        error_setg(errp, "memory hot unplug is not supported");
> +        return;
> +    }
what if unplug is called on cold-plugged device?

Better way to disable mgmt initiated unplug is to forbid it in unplug_request()
For guest initiated one ('unplug' handler), the best we can do is log error
and ignore it (provided guest won't get in confused). it's also possible 
to hide _EJ method and then it would be even fine to abort if it gets here,
since guest is not supposed to interface with MMIO interface without using AML.

> +
>      pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>  }
> @@ -2085,6 +2132,12 @@ static void virt_instance_init(Object *obj)
>                                      "Set NVDIMM persistence"
>                                      "Valid values are cpu and mem-ctrl", NULL);
>  
> +    vms->acpi_memhp_state.is_enabled = true;
> +    object_property_add_bool(obj, "memory-hotplug-support",
> +                             virt_get_memhp_support,
> +                             virt_set_memhp_support,
> +                             NULL);
> +
>      vms->irqmap = a15irqmap;
>  }
>  
