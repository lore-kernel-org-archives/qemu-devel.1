Received: from eggs.gnu.org ([209.51.188.92]:44882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3L11-0003gh-6G
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3L0w-0001fk-2P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:30:51 -0400
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-5-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7cea0bf3-2eba-d649-fb33-a84648f856e0@redhat.com>
Date: Mon, 11 Mar 2019 14:24:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/11] hw/arm/virt: Add virtual ACPI
 device
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
> From: Samuel Ortiz <sameo@linux.intel.com>
> 
> This is to provide an acpi device interface for Arm/virt.
> This will be used by Arm/Virt to add hotplug support via
> ACPI GED device.

I think this would deserves to mention this is a skeleton or,
wouldn't it make sense to merge the virt-acpi part of "hw/arm/virt: Add
ACPI support for device memory cold-plug" inside this patch; and keep
its instantiation in machvirt in a separate patch?

> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/Makefile.objs  |   2 +-
>  hw/arm/virt-acpi.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |   1 +
>  3 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/virt-acpi.c
> 
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index fa57c7c..e0db3cd 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,6 +1,6 @@
>  obj-y += boot.o sysbus-fdt.o
>  obj-$(CONFIG_ARM_VIRT) += virt.o
> -obj-$(CONFIG_ACPI) += virt-acpi-build.o
> +obj-$(CONFIG_ACPI) += virt-acpi-build.o virt-acpi.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
> diff --git a/hw/arm/virt-acpi.c b/hw/arm/virt-acpi.c
> new file mode 100644
> index 0000000..df8a02b
> --- /dev/null
> +++ b/hw/arm/virt-acpi.c
> @@ -0,0 +1,111 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/range.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +
> +#include "hw/hw.h"
> +#include "hw/hotplug.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/virt.h"
> +
> +#include "hw/acpi/acpi.h"
> +
> +typedef struct VirtAcpiState {
> +    SysBusDevice parent_obj;
> +} VirtAcpiState;
> +
> +#define TYPE_VIRT_ACPI "virt-acpi"
> +#define VIRT_ACPI(obj) \
> +    OBJECT_CHECK(VirtAcpiState, (obj), TYPE_VIRT_ACPI)
> +
> +static const VMStateDescription vmstate_acpi = {
> +    .name = "virt_acpi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +};
> +
> +static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void virt_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                          DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void virt_device_unplug_cb(HotplugHandler *hotplug_dev,
> +                                  DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void virt_send_ged(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> +{
> +}
> +
> +static void virt_device_realize(DeviceState *dev, Error **errp)
> +{
> +}
> +
> +DeviceState *virt_acpi_init(void)
> +{
> +    return sysbus_create_simple(TYPE_VIRT_ACPI, -1, NULL);
> +}
> +
> +static Property virt_acpi_properties[] = {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virt_acpi_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> +
> +    dc->desc = "ACPI";
> +    dc->vmsd = &vmstate_acpi;
do we really need the vmsd field as of now?
> +    dc->props = virt_acpi_properties;> +    dc->realize = virt_device_realize;
> +
> +    hc->plug = virt_device_plug_cb;
> +    hc->unplug_request = virt_device_unplug_request_cb;
> +    hc->unplug = virt_device_unplug_cb;
unplug_request and unplug still aren't implemented at the end of the
series. Maybe we can ignore them at the moment?
> +
> +    adevc->send_event = virt_send_ged;
> +}
> +
> +static const TypeInfo virt_acpi_info = {
> +    .name          = TYPE_VIRT_ACPI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(VirtAcpiState),
> +    .class_init    = virt_acpi_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void virt_acpi_register_types(void)
> +{
> +    type_register_static(&virt_acpi_info);
> +}
> +
> +type_init(virt_acpi_register_types)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 507517c..6076167 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -145,6 +145,7 @@ typedef struct {
>      OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
>  
>  void virt_acpi_setup(VirtMachineState *vms);
> +DeviceState *virt_acpi_init(void);
>  
>  /* Return the number of used redistributor regions  */
>  static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
> 

Thanks

Eric
