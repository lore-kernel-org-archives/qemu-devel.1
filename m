Received: from eggs.gnu.org ([2001:4830:134:3::10]:45290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ23-000822-Ir
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ22-0006RL-5y
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:55 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-4-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1f8e3cd4-1e54-5350-3804-c77bbbfbd3e4@redhat.com>
Date: Mon, 28 May 2018 16:21:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180516152026.2920-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/6] hw/arm/virt: Add pc-dimm mem hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com

Hi Shameer,

On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
> This will be used in subsequent patches to model a chunk of
> memory as pc-dimm(cold plug) if the valid iova regions are
> non-contiguous. This is not yet a full hotplug support.
Please can you give more details about this restriction?
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  default-configs/aarch64-softmmu.mak |  1 +
>  hw/arm/virt.c                       | 82 +++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h               |  2 +
>  3 files changed, 85 insertions(+)
> 
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 9ddccf8..7a82ed8 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_DDC=y
>  CONFIG_DPCD=y
>  CONFIG_XLNX_ZYNQMP=y
>  CONFIG_XLNX_ZYNQMP_ARM=y
> +CONFIG_MEM_HOTPLUG=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 05fcb62..be3ad14 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1552,9 +1552,82 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>      return ms->possible_cpus;
>  }
>  
> +static void virt_dimm_plug(HotplugHandler *hotplug_dev,
> +                         DeviceState *dev, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    PCDIMMDevice *dimm = PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr;
> +    uint64_t align;
> +    Error *local_err = NULL;
> +
> +    mr = ddc->get_memory_region(dimm, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    align = memory_region_get_alignment(mr);
I see that on PC machine class they have an "enforce_aligned_dimm"
option. Also looks memory_region_get_alignment(mr) can return 0.

if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {


> +    pc_dimm_memory_plug(dev, &vms->hotplug_memory, mr, align, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
useless block and error_propagate does nothing if local_err is NULL so
we are fine.
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
> +                           DeviceState *dev, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    PCDIMMDevice *dimm = PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr;
> +    Error *local_err = NULL;
> +
> +    mr = ddc->get_memory_region(dimm, &local_err);
don't you want to avoid executing the following if local_err?
> +    pc_dimm_memory_unplug(dev, &vms->hotplug_memory, mr);
needs a rebase on top of "pc-dimm: no need to pass the memory region"
in master pc_dimm_memory_unplug we now have
 MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);

Thanks

Eric
> +    object_unparent(OBJECT(dev));
> +
> +    error_propagate(errp, local_err);
> +}
> +
> +static void virt_machinedevice_plug_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_dimm_plug(hotplug_dev, dev, errp);
> +    } else {
> +        error_setg(errp, "device plug request for not supported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
> +}
> +
> +static void virt_machinedevice_unplug_cb(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_dimm_unplug(hotplug_dev, dev, errp);
> +    } else {
> +        error_setg(errp, "device unplug for not supported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
> +}
> +
> +static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
> +                                             DeviceState *dev)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        return HOTPLUG_HANDLER(machine);
> +    }
> +    return NULL;
> +}
> +
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>  
>      mc->init = machvirt_init;
>      /* Start max_cpus at the maximum QEMU supports. We'll further restrict
> @@ -1573,6 +1646,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
> +
> +    mc->get_hotplug_handler = virt_get_hotplug_handler;
This requires a rebase on top of Igor's  and David's series.

Thanks

Eric
> +    hc->plug = virt_machinedevice_plug_cb;
> +    hc->unplug = virt_machinedevice_unplug_cb;
> +
>  }
>  
>  static const TypeInfo virt_machine_info = {
> @@ -1582,6 +1660,10 @@ static const TypeInfo virt_machine_info = {
>      .instance_size = sizeof(VirtMachineState),
>      .class_size    = sizeof(VirtMachineClass),
>      .class_init    = virt_machine_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +         { TYPE_HOTPLUG_HANDLER },
> +         { }
> +    },
>  };
>  
>  static void machvirt_machine_init(void)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index fc24f3a..a39f29e 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,7 @@
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
> +#include "hw/mem/pc-dimm.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -108,6 +109,7 @@ typedef struct {
>      uint32_t gic_phandle;
>      uint32_t msi_phandle;
>      int psci_conduit;
> +    MemoryHotplugState hotplug_memory;
>  } VirtMachineState;
>  
>  #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
> 
