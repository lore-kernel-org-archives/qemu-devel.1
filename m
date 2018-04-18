Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f8j7X-00073I-8Z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1f8j7U-0002QB-1b
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:11:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1f8j7T-0002Md-Pg
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:11:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3I99Io4058812
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 05:11:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2he2ky1wdu-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 05:11:13 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 18 Apr 2018 10:11:10 +0100
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-5-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 11:11:05 +0200
MIME-Version: 1.0
In-Reply-To: <1523819244-29954-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1452b9f7-8cec-31be-b097-b136317a5921@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] s390x/vfio: ap: Introduce VFIO AP
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
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 15/04/2018 21:07, Tony Krowiak wrote:
> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
>
>      -device vfio-ap,sysfsdev=3D<path-to-mediated-matrix-device>
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
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/de=
vices/$uuid
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
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   default-configs/s390x-softmmu.mak |    1 +
>   hw/vfio/Makefile.objs             |    1 +
>   hw/vfio/ap.c                      |  191 ++++++++++++++++++++++++++++=
+++++++++
>   include/hw/vfio/vfio-common.h     |    1 +
>   4 files changed, 194 insertions(+), 0 deletions(-)
>   create mode 100644 hw/vfio/ap.c
>
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-=
softmmu.mak
> index 2f4bfe7..0b784b6 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -9,3 +9,4 @@ CONFIG_S390_FLIC=3Dy
>   CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
>   CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
>   CONFIG_WDT_DIAG288=3Dy
> +CONFIG_VFIO_AP=3D$(CONFIG_LINUX)
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index a2e7a0a..8b3f664 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -6,4 +6,5 @@ obj-$(CONFIG_SOFTMMU) +=3D platform.o
>   obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
>   obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
>   obj-$(CONFIG_SOFTMMU) +=3D spapr.o
> +obj-$(CONFIG_VFIO_AP) +=3D ap.o
>   endif
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> new file mode 100644
> index 0000000..7b48a3a
> --- /dev/null
> +++ b/hw/vfio/ap.c
> @@ -0,0 +1,191 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
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
> +
> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
> +
> +typedef struct VFIOAPDevice {
> +    APDevice apdev;
> +    VFIODevice vdev;
> +    QTAILQ_ENTRY(VFIOAPDevice) sibling;
> +} VFIOAPDevice;
> +
> +VFIOAPDevice *vfio_apdev;
> +
> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> +{
> +    vdev->needs_reset =3D false;
> +}
> +
> +/*
> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
> + * vfio-ap-matrix device now.
> + */
> +struct VFIODeviceOps vfio_ap_ops =3D {
> +    .vfio_compute_needs_reset =3D vfio_ap_compute_needs_reset,
> +};
> +
> +static void vfio_put_device(VFIOAPDevice *vapdev)
> +{
> +    g_free(vapdev->vdev.name);
> +    vfio_put_base_device(&vapdev->vdev);
> +}
> +
> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp=
)
> +{
> +    char *tmp, group_path[PATH_MAX];
> +    ssize_t len;
> +    int groupid;
> +
> +    tmp =3D g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
> +    len =3D readlink(tmp, group_path, sizeof(group_path));
> +    g_free(tmp);
> +
> +    if (len <=3D 0 || len >=3D sizeof(group_path)) {
> +        error_setg(errp, "%s: no iommu_group found for %s",
> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev);
> +        return NULL;
> +    }
> +
> +    group_path[len] =3D 0;
> +
> +    if (sscanf(basename(group_path), "%d", &groupid) !=3D 1) {
> +        error_setg(errp, "vfio: failed to read %s", group_path);
> +        return NULL;
> +    }
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}
> +
> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    VFIOGroup *vfio_group;
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    char *mdevid;
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +    /*
> +     * Since a guest's matrix is configured in its entirety by the med=
iated
> +     * matrix device and hot plug is not currently supported, there is=
 no
> +     * need to have more than one vfio-ap device. Check if a vfio-ap d=
evice
> +     * has already been defined.
> +     */
> +    if (vfio_apdev) {
> +        error_setg(&local_err, "Only one %s device is allowed",
> +                   VFIO_AP_DEVICE_TYPE);
> +        goto out_err;
> +    }
> +
> +    if (!s390_has_feat(S390_FEAT_AP)) {
> +        error_setg(&local_err, "AP support not enabled");
> +        goto out_err;
> +    }
> +
> +    vfio_apdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +
> +    vfio_group =3D vfio_ap_get_group(vfio_apdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vfio_apdev->vdev.ops =3D &vfio_ap_ops;
> +    vfio_apdev->vdev.type =3D VFIO_DEVICE_TYPE_AP;
> +    mdevid =3D basename(vfio_apdev->vdev.sysfsdev);
> +    vfio_apdev->vdev.name =3D g_strdup_printf("%s", mdevid);
> +    vfio_apdev->vdev.dev =3D dev;
> +    QLIST_FOREACH(vbasedev, &vfio_group->device_list, next) {

can this happen if you have only one device ?

> +        if (strcmp(vbasedev->name, vfio_apdev->vdev.name) =3D=3D 0) {
> +            error_setg(&local_err,
> +                       "%s: AP device %s has already been realized",
> +                       VFIO_AP_DEVICE_TYPE, vfio_apdev->vdev.name);
> +            goto out_device_err;
> +        }
> +    }
> +
> +
...snip...

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
