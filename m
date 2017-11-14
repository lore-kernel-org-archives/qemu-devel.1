Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEckF-0007Jb-2Q
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEckA-0002dL-0N
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:03:23 -0500
Date: Tue, 14 Nov 2017 16:03:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171114160308.77eb92ab.cohuck@redhat.com>
In-Reply-To: <1509033294-4945-3-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1509033294-4945-3-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/5] s390x/vfio: ap-matrix: Introduce VFIO AP
 Matrix device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 26 Oct 2017 11:54:51 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces a VFIO based AP matrix device. This device will establish
> a communication pathway to the VFIO AP Matrix kernel device driver
> via a mediated AP matrix device file descriptor. This communication pathway
> will be used to:
> 
> 1. Signal the VFIO AP matrix device driver via the VFIO_AP_MATRIX_CONFIGURE
>    ioctl to configure the AP matrix for the KVM guest. The device driver
>    will set the bits in the APM, AQM and ADM fields of the CRYCB
>    referenced by the KVM guest's SIE state description according to
>    the AP matrix configuration specified for the mediated AP matrix
>    device's sysfs attribute files. The AP matrix configuration will be
>    returned to the guest from the ioctl call to notify the KVM guest
>    about the AP resources to which the guest has access.
> 
> 2. Pass intercepted AP instructions to the VFIO AP Matrix driver
>    for execution on an AP adapter assigned to the LPAR in which the
>    linux host is running.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  default-configs/s390x-softmmu.mak |    1 +
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap-matrix.c               |  179 +++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |    1 +
>  linux-headers/linux/vfio.h        |   28 +++++-
>  5 files changed, 207 insertions(+), 3 deletions(-)
>  create mode 100644 hw/vfio/ap-matrix.c
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 444bf16..1fe53ea 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=y
>  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
> +CONFIG_VFIO_AP_MATRIX=$(CONFIG_LINUX)
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index c3ab909..47e482f 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -6,4 +6,5 @@ obj-$(CONFIG_SOFTMMU) += platform.o
>  obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
>  obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>  obj-$(CONFIG_SOFTMMU) += spapr.o
> +obj-$(CONFIG_VFIO_AP_MATRIX) += ap-matrix.o
>  endif
> diff --git a/hw/vfio/ap-matrix.c b/hw/vfio/ap-matrix.c
> new file mode 100644
> index 0000000..eeaa439
> --- /dev/null
> +++ b/hw/vfio/ap-matrix.c
> @@ -0,0 +1,179 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2017 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> + * your option) any version. See the COPYING file in the top-level
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
> +#include "hw/s390x/s390-ap-matrix.h"
> +#include "hw/s390x/ap-matrix-device.h"
> +#include "qemu/error-report.h"
> +
> +#define TYPE_VFIO_AP_MATRIX_DEVICE      "vfio-ap-matrix"
> +#define AP_MATRIX_SYSFSDEV_PROP_NAME    "sysfsdev"
> +
> +typedef struct VFIOAPMatrixDevice {
> +    S390APMatrixDevice apmdev;
> +    VFIODevice vdev;
> +} VFIOAPMatrixDevice;
> +
> +static void vfio_ap_matrix_compute_needs_reset(VFIODevice *vdev)
> +{
> +    vdev->needs_reset = false;

This does not look like very much computing :)

> +}
> +
> +/*
> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
> + * vfio-ap-matrix device now.
> + */
> +struct VFIODeviceOps vfio_ap_matrix_ops = {
> +    .vfio_compute_needs_reset = vfio_ap_matrix_compute_needs_reset,
> +};
> +
> +static void vfio_ap_matrix_reset(DeviceState *dev)
> +{
> +    APMatrixDevice *apmdev = DO_UPCAST(APMatrixDevice, parent_obj, dev);
> +    S390APMatrixDevice *sapmdev = DO_UPCAST(S390APMatrixDevice, parent_obj,
> +                                            apmdev);
> +    VFIOAPMatrixDevice *vapmdev = DO_UPCAST(VFIOAPMatrixDevice, apmdev,
> +                                            sapmdev);
> +
> +    ioctl(vapmdev->vdev.fd, VFIO_DEVICE_RESET);
> +}
> +
> +static void vfio_put_device(VFIOAPMatrixDevice *apmdev)
> +{
> +    g_free(apmdev->vdev.name);
> +    vfio_put_base_device(&apmdev->vdev);
> +}
> +
> +static VFIOGroup *vfio_ap_matrix_get_group(VFIOAPMatrixDevice *vapmdev,
> +                                           Error **errp)
> +{
> +    char *tmp, group_path[PATH_MAX];
> +    ssize_t len;
> +    int groupid;
> +
> +    tmp = g_strdup_printf("%s/iommu_group", vapmdev->vdev.sysfsdev);
> +    len = readlink(tmp, group_path, sizeof(group_path));
> +    g_free(tmp);
> +
> +    if (len <= 0 || len >= sizeof(group_path)) {
> +        error_setg(errp, "%s: no iommu_group found for %s",
> +                   TYPE_VFIO_AP_MATRIX_DEVICE, vapmdev->vdev.sysfsdev);
> +        return NULL;
> +    }
> +
> +    group_path[len] = 0;
> +
> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> +        error_setg(errp, "vfio: failed to read %s", group_path);
> +        return NULL;
> +    }
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}
> +
> +static void vfio_ap_matrix_realize(DeviceState *dev, Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    VFIOGroup *vfio_group;
> +    APMatrixDevice *apmdev = DO_UPCAST(APMatrixDevice, parent_obj, dev);
> +    S390APMatrixDevice *sapmdev = DO_UPCAST(S390APMatrixDevice, parent_obj,
> +                                            apmdev);
> +    VFIOAPMatrixDevice *vapmdev = DO_UPCAST(VFIOAPMatrixDevice, apmdev,
> +                                            sapmdev);
> +    char *mdevid;
> +    Error *local_err = NULL;
> +
> +    vfio_group = vfio_ap_matrix_get_group(vapmdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vapmdev->vdev.ops = &vfio_ap_matrix_ops;
> +    vapmdev->vdev.type = VFIO_DEVICE_TYPE_AP_MATRIX;
> +    mdevid = basename(vapmdev->vdev.sysfsdev);
> +    vapmdev->vdev.name = g_strdup_printf("%s-%s", TYPE_VFIO_AP_MATRIX_DEVICE,
> +                                         mdevid);
> +    vapmdev->vdev.dev = dev;
> +    QLIST_FOREACH(vbasedev, &vfio_group->device_list, next) {
> +        if (strcmp(vbasedev->name, vapmdev->vdev.name) == 0) {
> +            error_setg(&local_err,
> +                       "%s: AP matrix device %s has already been realized",
> +                       TYPE_VFIO_AP_MATRIX_DEVICE, vapmdev->vdev.name);
> +            goto out_device_err;
> +        }
> +    }
> +
> +    if (vfio_get_device(vfio_group, mdevid, &vapmdev->vdev, &local_err)) {
> +        goto out_device_err;
> +    }
> +
> +    return;
> +
> +out_device_err:
> +    vfio_put_group(vfio_group);
> +out_err:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void vfio_ap_matrix_unrealize(DeviceState *dev, Error **errp)
> +{
> +    APMatrixDevice *apm_dev = DO_UPCAST(APMatrixDevice, parent_obj, dev);
> +    S390APMatrixDevice *apmdev = DO_UPCAST(S390APMatrixDevice, parent_obj,
> +                                           apm_dev);
> +    VFIOAPMatrixDevice *vapmdev = DO_UPCAST(VFIOAPMatrixDevice, apmdev, apmdev);
> +    VFIOGroup *group = vapmdev->vdev.group;
> +
> +    vfio_put_device(vapmdev);
> +    vfio_put_group(group);
> +}
> +
> +static Property vfio_ap_matrix_properties[] = {
> +    DEFINE_PROP_STRING(AP_MATRIX_SYSFSDEV_PROP_NAME, VFIOAPMatrixDevice,
> +                       vdev.sysfsdev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const VMStateDescription vfio_ap_matrix_vmstate = {
> +    .name = TYPE_VFIO_AP_MATRIX_DEVICE,
> +    .unmigratable = 1,
> +};
> +
> +static void vfio_ap_matrix_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = vfio_ap_matrix_properties;
> +    dc->vmsd = &vfio_ap_matrix_vmstate;
> +    dc->desc = "VFIO-based AP matrix assignment";
> +    dc->realize = vfio_ap_matrix_realize;
> +    dc->unrealize = vfio_ap_matrix_unrealize;
> +    dc->reset = vfio_ap_matrix_reset;
> +}
> +
> +static const TypeInfo vfio_ap_matrix_info = {
> +    .name = TYPE_VFIO_AP_MATRIX_DEVICE,
> +    .parent = TYPE_S390_AP_MATRIX_DEVICE,
> +    .instance_size = sizeof(VFIOAPMatrixDevice),
> +    .class_init = vfio_ap_matrix_class_init,
> +};
> +
> +static void register_vfio_ap_matrix_type(void)
> +{
> +    type_register_static(&vfio_ap_matrix_info);
> +}
> +
> +type_init(register_vfio_ap_matrix_type)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9..7cdc1f3 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -46,6 +46,7 @@ enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
>      VFIO_DEVICE_TYPE_CCW = 2,
> +    VFIO_DEVICE_TYPE_AP_MATRIX = 3,
>  };
>  
>  typedef struct VFIOMmap {
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4e7ab4c..2d96c57 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h

It would make sense to split this out as a dummy headers update.

> @@ -8,8 +8,8 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#ifndef VFIO_H
> -#define VFIO_H
> +#ifndef _UAPIVFIO_H
> +#define _UAPIVFIO_H
>  
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> @@ -199,6 +199,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>  #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
> +#define VFIO_DEVICE_FLAGS_AP_MATRIX (1 << 5)	/* vfio-ap-matrix device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -214,6 +215,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
>  #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
>  #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
> +#define VFIO_DEVICE_API_AP_MATRIX_STRING	"vfio-ap-matrix"
>  
>  /**
>   * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
> @@ -714,6 +716,26 @@ struct vfio_iommu_spapr_tce_remove {
>  };
>  #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>  
> +/**
> + * VFIO_AP_MATRIX_CONFIGURE		_IO(VFIO_TYPE, VFIO_BASE + 21
> + *
> + * Configure the AP matrix for a KVM guest.
> + */
> +#define VFIO_AP_MATRIX_CONFIGURE	_IO(VFIO_TYPE, VFIO_BASE + 21)
> +
> +#define VFIO_AP_MATRIX_MASK_INDICES	4
> +#define VFIO_AP_MATTRIX_MASK_BYTES	(VFIO_AP_MATRIX_MASK_INDICES * \
> +					 sizeof(__u64))
> +#define VFIO_AP_MATRIX_MASK_BITS	(VFIO_AP_MATTRIX_MASK_BYTES * 8)
> +
> +struct vfio_ap_matrix_config {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* out */
> +	__u64 apm[VFIO_AP_MATRIX_MASK_INDICES];
> +	__u64 aqm[VFIO_AP_MATRIX_MASK_INDICES];
> +	__u64 adm[VFIO_AP_MATRIX_MASK_INDICES];
> +};
>  /* ***************************************************************** */
>  
> -#endif /* VFIO_H */
> +#endif /* _UAPIVFIO_H */
