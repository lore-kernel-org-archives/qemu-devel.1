Received: from eggs.gnu.org ([2001:4830:134:3::10]:51613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTcZM-0003Fr-Tc
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTcZH-00037W-VG
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:49:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cTcZH-00036x-Lj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:49:31 -0500
Date: Tue, 17 Jan 2017 15:49:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170117154928.6b7886fb@t450s.home>
In-Reply-To: <20170112072513.98411-8-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-8-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 07/12] vfio/ccw: vfio based
 subchannel passthrough driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Thu, 12 Jan 2017 08:25:08 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> We use the IOMMU_TYPE1 of VFIO to realize the subchannels
> passthrough, implement a vfio based subchannels passthrough
> driver called "vfio-ccw".
> 
> Support qemu parameters in the style of:
> "-device vfio-ccw,id=xx,hostid=xx(,guestid=xx),mdevid=xx"

Why not adopt the same syntax as vfio-pci with mdev devices,
sysfsdev=%s where %s is a path to the mdev device in sysfs, which can
be /sys/bus/mdev/devices/$UUID or as you create from the hostid
below /sys/bus/css/devices/%x.%x.%04x/$UUID.  It seems if we know where
to find the mdev device then we can determine the parent information on
our own through sysfs.

> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> ---
>  default-configs/s390x-softmmu.mak |   1 +
>  hw/s390x/s390-ccw.h               |   1 +
>  hw/vfio/Makefile.objs             |   1 +
>  hw/vfio/ccw.c                     | 209 ++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |   1 +
>  5 files changed, 213 insertions(+)
>  create mode 100644 hw/vfio/ccw.c
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 36e15de..5576b0a 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -4,4 +4,5 @@ CONFIG_VIRTIO=y
>  CONFIG_SCLPCONSOLE=y
>  CONFIG_S390_FLIC=y
>  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
> +CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
> diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
> index 9ced8cb..1fa4a97 100644
> --- a/hw/s390x/s390-ccw.h
> +++ b/hw/s390x/s390-ccw.h
> @@ -26,6 +26,7 @@
>  typedef struct S390CCWDevice {
>      CcwDevice parent_obj;
>      CssDevId hostid;
> +    char *mdevid;
>  } S390CCWDevice;
>  
>  typedef struct S390CCWDeviceClass {
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index c25e32b..4c3a462 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,6 +1,7 @@
>  ifeq ($(CONFIG_LINUX), y)
>  obj-$(CONFIG_SOFTMMU) += common.o
>  obj-$(CONFIG_PCI) += pci.o pci-quirks.o
> +obj-$(CONFIG_VFIO_CCW) += ccw.o
>  obj-$(CONFIG_SOFTMMU) += platform.o
>  obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
>  obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> new file mode 100644
> index 0000000..881010b
> --- /dev/null
> +++ b/hw/vfio/ccw.c
> @@ -0,0 +1,209 @@
> +/*
> + * vfio based subchannel assignment support
> + *
> + * Copyright 2017 IBM Corp.
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> + * your option) any version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <linux/vfio.h>
> +#include <sys/ioctl.h>
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/vfio/vfio.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/s390x/s390-ccw.h"
> +#include "hw/s390x/ccw-device.h"
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +typedef struct VFIOCCWDevice {
> +    S390CCWDevice cdev;
> +    VFIODevice vdev;
> +} VFIOCCWDevice;
> +
> +static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> +{
> +    vdev->needs_reset = false;
> +}
> +
> +/*
> + * We don't need vfio_hot_reset_multi and vfio_eoi operationis for
> + * vfio_ccw device now.
> + */
> +struct VFIODeviceOps vfio_ccw_ops = {
> +    .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
> +};
> +
> +static void vfio_ccw_reset(DeviceState *dev)
> +{
> +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +
> +    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> +}
> +
> +static void vfio_put_device(VFIOCCWDevice *vcdev)
> +{
> +    g_free(vcdev->vdev.name);
> +    vfio_put_base_device(&vcdev->vdev);
> +}
> +
> +static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, char **path,
> +                                     Error **errp)
> +{
> +    struct stat st;
> +    int groupid;
> +    GError *gerror = NULL;
> +
> +    /* Check that host subchannel exists. */
> +    path[0] = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x",
> +                              cdev->hostid.cssid,
> +                              cdev->hostid.ssid,
> +                              cdev->hostid.devid);
> +    if (stat(path[0], &st) < 0) {
> +        error_setg(errp, "vfio: no such host subchannel %s", path[0]);
> +        return NULL;
> +    }
> +
> +    /* Check that mediated device exists. */
> +    path[1] = g_strdup_printf("%s/%s", path[0], cdev->mdevid);
> +    if (stat(path[0], &st) < 0) {
> +        error_setg(errp, "vfio: no such mediated device %s", path[1]);
> +        return NULL;
> +    }
> +
> +    /* Get the iommu_group patch as the interim variable. */
> +    path[2] = g_strconcat(path[1], "/iommu_group", NULL);
> +
> +    /* Get the link file path of the device iommu_group. */
> +    path[3] = g_file_read_link(path[2], &gerror);
> +    if (!path[3]) {
> +        error_setg(errp, "vfio: error no iommu_group for subchannel");
> +        return NULL;
> +    }
> +
> +    /* Get the device groupid. */
> +    if (sscanf(basename(path[3]), "%d", &groupid) != 1) {
> +        error_setg(errp, "vfio: error reading %s:%m", path[3]);
> +        return NULL;
> +    }
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}
> +
> +static void vfio_ccw_put_group(VFIOGroup *group, char **path)
> +{
> +    g_free(path);
> +    vfio_put_group(group);
> +}
> +
> +static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    VFIOGroup *group;
> +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    char *path[4] = {NULL, NULL, NULL, NULL};
> +
> +    /* Call the class init function for subchannel. */
> +    if (cdc->realize) {
> +        cdc->realize(cdev, errp);
> +        if (*errp) {
> +            return;
> +        }
> +    }
> +
> +    group = vfio_ccw_get_group(cdev, path, errp);
> +    if (!group) {
> +        goto out_group_err;
> +    }
> +
> +    vcdev->vdev.ops = &vfio_ccw_ops;
> +    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> +    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> +                                       cdev->hostid.ssid, cdev->hostid.devid);
> +    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
> +            error_setg(errp, "vfio: subchannel %s has already been attached",
> +                       basename(path[0]));
> +            goto out_device_err;
> +        }
> +    }
> +
> +    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
> +        goto out_device_err;
> +    }
> +
> +    return;
> +
> +out_device_err:
> +    vfio_ccw_put_group(group, path);
> +out_group_err:
> +    if (cdc->unrealize) {
> +        cdc->unrealize(cdev, errp);
> +    }
> +}
> +
> +static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> +{
> +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    VFIOGroup *group = vcdev->vdev.group;
> +
> +    if (cdc->unrealize) {
> +        cdc->unrealize(cdev, errp);
> +    }
> +
> +    vfio_put_device(vcdev);
> +    vfio_put_group(group);
> +}
> +
> +static Property vfio_ccw_properties[] = {
> +    DEFINE_PROP_CSS_DEV_ID("hostid", VFIOCCWDevice, cdev.hostid),
> +    DEFINE_PROP_CSS_DEV_ID("guestid", VFIOCCWDevice, cdev.parent_obj.bus_id),
> +    DEFINE_PROP_STRING("mdevid", VFIOCCWDevice, cdev.mdevid),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const VMStateDescription vfio_ccw_vmstate = {
> +    .name = TYPE_VFIO_CCW,
> +    .unmigratable = 1,
> +};
> +
> +static void vfio_ccw_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = vfio_ccw_properties;
> +    dc->vmsd = &vfio_ccw_vmstate;
> +    dc->desc = "VFIO-based subchannel assignment";
> +    dc->realize = vfio_ccw_realize;
> +    dc->unrealize = vfio_ccw_unrealize;
> +    dc->reset = vfio_ccw_reset;
> +}
> +
> +static const TypeInfo vfio_ccw_info = {
> +    .name = TYPE_VFIO_CCW,
> +    .parent = TYPE_S390_CCW,
> +    .instance_size = sizeof(VFIOCCWDevice),
> +    .class_init = vfio_ccw_class_init,
> +};
> +
> +static void register_vfio_ccw_type(void)
> +{
> +    type_register_static(&vfio_ccw_info);
> +}
> +
> +type_init(register_vfio_ccw_type)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c582de1..9521013 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -45,6 +45,7 @@
>  enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
> +    VFIO_DEVICE_TYPE_CCW = 2,
>  };
>  
>  typedef struct VFIOMmap {
