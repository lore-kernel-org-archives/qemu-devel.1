Received: from eggs.gnu.org ([2001:4830:134:3::10]:35825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gAD36-0004WQ-AY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gAD2y-0002JP-N9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:53:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gAD2u-0002Gv-V8
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:52:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ABiOAO134365
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:52:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1fmxu7rq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:52:55 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 10 Oct 2018 12:52:52 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:52:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f989a663-13a0-481b-94c0-4b94a4437125@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com



On 10/09/2018 07:52 PM, Tony Krowiak wrote:
> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
> 
>     -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
> 
> There may be only one vfio-ap device configured for a guest.
> 
> The mediated matrix device is created by the VFIO AP device
> driver by writing a UUID to a sysfs attribute file (see
> docs/vfio-ap.txt). The mediated matrix device will be named
> after the UUID. Symbolic links to the $uuid are created in
> many places, so the path to the mediated matrix device $uuid
> can be specified in any of the following ways:
> 
> /sys/devices/vfio_ap/matrix/$uuid
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid
> /sys/bus/mdev/devices/$uuid
> /sys/bus/mdev/drivers/vfio_mdev/$uuid
> 
> When the vfio-ap device is realized, it acquires and opens the
> VFIO iommu group to which the mediated matrix device is
> bound. This causes a VFIO group notification event to be
> signaled. The vfio_ap device driver's group notification
> handler will get called at which time the device driver
> will configure the the AP devices to which the guest will
> be granted access.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>

Whit the things Thomas and David noticed fixed:

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS                       |   1 +
>  default-configs/s390x-softmmu.mak |   1 +
>  hw/vfio/Makefile.objs             |   1 +
>  hw/vfio/ap.c                      | 180 ++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |   1 +
>  5 files changed, 184 insertions(+)
>  create mode 100644 hw/vfio/ap.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97e8ed808bc0..29041da69237 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1209,6 +1209,7 @@ F: hw/s390x/ap-device.c
>  F: hw/s390x/ap-bridge.c
>  F: include/hw/s390x/ap-device.h
>  F: include/hw/s390x/ap-bridge.h
> +F: hw/vfio/ap.c
>  L: qemu-s390x@nongnu.org
>  
>  vhost
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index d6b67d50f0e4..5eef37592451 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -7,3 +7,4 @@ CONFIG_S390_FLIC=y
>  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
> +CONFIG_VFIO_AP=$(CONFIG_LINUX)
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index a2e7a0a7cf02..8b3f664d85f7 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -6,4 +6,5 @@ obj-$(CONFIG_SOFTMMU) += platform.o
>  obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
>  obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>  obj-$(CONFIG_SOFTMMU) += spapr.o
> +obj-$(CONFIG_VFIO_AP) += ap.o
>  endif
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> new file mode 100644
> index 000000000000..5543406afc58
> --- /dev/null
> +++ b/hw/vfio/ap.c
> @@ -0,0 +1,180 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *            Halil Pasic <pasic@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <linux/vfio.h>
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/vfio/vfio.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/s390x/ap-device.h"
> +#include "qemu/error-report.h"
> +#include "qemu/queue.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "cpu.h"
> +#include "kvm_s390x.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/s390x/ap-bridge.h"
> +#include "exec/address-spaces.h"
> +
> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
> +
> +typedef struct VFIOAPDevice {
> +    APDevice apdev;
> +    VFIODevice vdev;
> +} VFIOAPDevice;
> +
> +#define VFIO_AP_DEVICE(obj) \
> +        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
> +
> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> +{
> +    vdev->needs_reset = false;
> +}
> +
> +/*
> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
> + * vfio-ap device now.
> + */
> +struct VFIODeviceOps vfio_ap_ops = {
> +    .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
> +};
> +
> +static void vfio_ap_put_device(VFIOAPDevice *vapdev)
> +{
> +    g_free(vapdev->vdev.name);
> +    vfio_put_base_device(&vapdev->vdev);
> +}
> +
> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
> +{
> +    GError *gerror;
> +    char *symlink, *group_path;
> +    int groupid;
> +
> +    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
> +    group_path = g_file_read_link(symlink, &gerror);
> +    g_free(symlink);
> +
> +    if (!group_path) {
> +        error_setg(errp, "%s: no iommu_group found for %s: %s",
> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
> +        return NULL;
> +    }
> +
> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> +        error_setg(errp, "vfio: failed to read %s", group_path);
> +        return NULL;
> +    }
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}
> +
> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> +{
> +    int ret;
> +    char *mdevid;
> +    Error *local_err = NULL;
> +    VFIOGroup *vfio_group;
> +    APDevice *apdev = AP_DEVICE(dev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +
> +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vapdev->vdev.ops = &vfio_ap_ops;
> +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
> +    mdevid = basename(vapdev->vdev.sysfsdev);
> +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> +    vapdev->vdev.dev = dev;
> +
> +    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
> +    if (ret) {
> +        goto out_get_dev_err;
> +    }
> +
> +    /* Enable hardware to intepret AP instructions executed on the guest */
> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie", NULL);
> +
> +    return;
> +
> +out_get_dev_err:
> +    vfio_ap_put_device(vapdev);
> +    vfio_put_group(vfio_group);
> +out_err:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
> +{
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +    VFIOGroup *group = vapdev->vdev.group;
> +
> +    vfio_ap_put_device(vapdev);
> +    vfio_put_group(group);
> +}
> +
> +static Property vfio_ap_properties[] = {
> +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vfio_ap_reset(DeviceState *dev)
> +{
> +    int ret;
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +
> +    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    if (ret) {
> +        error_report("%s: failed to reset %s device: %s", __func__,
> +                     vapdev->vdev.name, strerror(ret));
> +    }
> +}
> +
> +static const VMStateDescription vfio_ap_vmstate = {
> +    .name = VFIO_AP_DEVICE_TYPE,
> +    .unmigratable = 1,
> +};
> +
> +static void vfio_ap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = vfio_ap_properties;
> +    dc->vmsd = &vfio_ap_vmstate;
> +    dc->desc = "VFIO-based AP device assignment";
> +    dc->realize = vfio_ap_realize;
> +    dc->unrealize = vfio_ap_unrealize;
> +    dc->hotpluggable = false;
> +    dc->reset = vfio_ap_reset;
> +    dc->bus_type = TYPE_AP_BUS;
> +}
> +
> +static const TypeInfo vfio_ap_info = {
> +    .name = VFIO_AP_DEVICE_TYPE,
> +    .parent = AP_DEVICE_TYPE,
> +    .instance_size = sizeof(VFIOAPDevice),
> +    .class_init = vfio_ap_class_init,
> +};
> +
> +static void vfio_ap_type_init(void)
> +{
> +    type_register_static(&vfio_ap_info);
> +}
> +
> +type_init(vfio_ap_type_init)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 821def05658f..6be9a93f611b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -37,6 +37,7 @@ enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
>      VFIO_DEVICE_TYPE_CCW = 2,
> +    VFIO_DEVICE_TYPE_AP = 3,
>  };
>  
>  typedef struct VFIOMmap {
> 
