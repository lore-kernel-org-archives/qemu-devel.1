Received: from eggs.gnu.org ([2001:4830:134:3::10]:49317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7zbt-0001jm-Ih
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7zbm-0003xi-SJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:07:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1g7zbm-0003wY-Eo
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:07:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9494CNV138731
	for <qemu-devel@nongnu.org>; Thu, 4 Oct 2018 05:07:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mwds7d95s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 05:07:44 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 4 Oct 2018 10:07:42 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-6-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 4 Oct 2018 11:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180926225440.6204-6-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <02837613-c197-78c1-4d75-6a5945b0b340@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 5/6] s390x/vfio: ap: Introduce VFIO AP
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

On 27/09/2018 00:54, Tony Krowiak wrote:
> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
>=20
>      -device vfio-ap,sysfsdev=3D<path-to-mediated-matrix-device>
>=20
> There may be only one vfio-ap device configured for a guest.
>=20
> The mediated matrix device is created by the VFIO AP device
> driver by writing a UUID to a sysfs attribute file (see
> docs/vfio-ap.txt). The mediated matrix device will be named
> after the UUID. Symbolic links to the $uuid are created in
> many places, so the path to the mediated matrix device $uuid
> can be specified in any of the following ways:
>=20
> /sys/devices/vfio_ap/matrix/$uuid
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/de=
vices/$uuid
> /sys/bus/mdev/devices/$uuid
> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>=20
> When the vfio-ap device is realized, it acquires and opens the
> VFIO iommu group to which the mediated matrix device is
> bound. This causes a VFIO group notification event to be
> signaled. The vfio_ap device driver's group notification
> handler will get called at which time the device driver
> will configure the the AP devices to which the guest will
> be granted access.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   MAINTAINERS                       |   1 +
>   default-configs/s390x-softmmu.mak |   1 +
>   hw/vfio/Makefile.objs             |   1 +
>   hw/vfio/ap.c                      | 181 +++++++++++++++++++++++++++++=
+
>   include/hw/vfio/vfio-common.h     |   1 +
>   5 files changed, 185 insertions(+)
>   create mode 100644 hw/vfio/ap.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97e8ed808bc0..29041da69237 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1209,6 +1209,7 @@ F: hw/s390x/ap-device.c
>   F: hw/s390x/ap-bridge.c
>   F: include/hw/s390x/ap-device.h
>   F: include/hw/s390x/ap-bridge.h
> +F: hw/vfio/ap.c
>   L: qemu-s390x@nongnu.org
>=20
>   vhost
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-=
softmmu.mak
> index d6b67d50f0e4..5eef37592451 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -7,3 +7,4 @@ CONFIG_S390_FLIC=3Dy
>   CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
>   CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
>   CONFIG_WDT_DIAG288=3Dy
> +CONFIG_VFIO_AP=3D$(CONFIG_LINUX)
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index a2e7a0a7cf02..8b3f664d85f7 100644
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
> index 000000000000..429988f23f98
> --- /dev/null
> +++ b/hw/vfio/ap.c
> @@ -0,0 +1,181 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *            Halil Pasic <pasic@linux.ibm.com>
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
> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> +{
> +    vdev->needs_reset =3D false;
> +}
> +
> +/*
> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
> + * vfio-ap device now.
> + */
> +struct VFIODeviceOps vfio_ap_ops =3D {
> +    .vfio_compute_needs_reset =3D vfio_ap_compute_needs_reset,
> +};
> +
> +static void vfio_ap_put_device(VFIOAPDevice *vapdev)
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
> +    int ret;
> +    char *mdevid;
> +    Error *local_err =3D NULL;
> +    VFIOGroup *vfio_group;
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +
> +    vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +
> +    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vapdev->vdev.ops =3D &vfio_ap_ops;
> +    vapdev->vdev.type =3D VFIO_DEVICE_TYPE_AP;
> +    mdevid =3D basename(vapdev->vdev.sysfsdev);
> +    vapdev->vdev.name =3D g_strdup_printf("%s", mdevid);
> +    vapdev->vdev.dev =3D dev;
> +
> +    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_=
err);
> +    if (ret) {
> +        goto out_get_dev_err;
> +    }
> +
> +    /* Enable hardware to intepret AP instructions executed on the gue=
st */
> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie",=
 NULL);
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
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +    VFIOGroup *group =3D vapdev->vdev.group;
> +
> +    vfio_ap_put_device(vapdev);
> +    vfio_put_group(group);
> +}
> +
> +static Property vfio_ap_properties[] =3D {
> +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vfio_ap_reset(DeviceState *dev)
> +{
> +    int ret;
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);
> +
> +    ret =3D ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    if (ret) {
> +        error_report("%s: failed to reset %s device: %s", __func__,
> +                     vapdev->vdev.name, strerror(ret));
> +    }
> +}
> +
> +static const VMStateDescription vfio_ap_vmstate =3D {
> +    .name =3D VFIO_AP_DEVICE_TYPE,
> +    .unmigratable =3D 1,
> +};
> +
> +static void vfio_ap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props =3D vfio_ap_properties;
> +    dc->vmsd =3D &vfio_ap_vmstate;
> +    dc->desc =3D "VFIO-based AP device assignment";
> +    dc->realize =3D vfio_ap_realize;
> +    dc->unrealize =3D vfio_ap_unrealize;
> +    dc->hotpluggable =3D false;
> +    dc->reset =3D vfio_ap_reset;
> +    dc->bus_type =3D TYPE_AP_BUS;
> +}
> +
> +static const TypeInfo vfio_ap_info =3D {
> +    .name =3D VFIO_AP_DEVICE_TYPE,
> +    .parent =3D AP_DEVICE_TYPE,
> +    .instance_size =3D sizeof(VFIOAPDevice),
> +    .class_init =3D vfio_ap_class_init,
> +};
> +
> +static void vfio_ap_type_init(void)
> +{
> +    type_register_static(&vfio_ap_info);
> +}
> +
> +type_init(vfio_ap_type_init)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-commo=
n.h
> index 821def05658f..6be9a93f611b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -37,6 +37,7 @@ enum {
>       VFIO_DEVICE_TYPE_PCI =3D 0,
>       VFIO_DEVICE_TYPE_PLATFORM =3D 1,
>       VFIO_DEVICE_TYPE_CCW =3D 2,
> +    VFIO_DEVICE_TYPE_AP =3D 3,
>   };
>=20
>   typedef struct VFIOMmap {
>=20


It works as expected.

Tested-by: Pierre Morel<pmorel@linux.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
