Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gADgZ-0001Wg-Li
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gADgW-0005YX-6b
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gADgV-0005YF-WE
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:33:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ACUQVQ018895
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:33:51 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ef78548-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:33:50 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 10 Oct 2018 13:33:46 +0100
Reply-To: pmorel@linux.ibm.com
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 10 Oct 2018 14:33:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bb7ce734-4e0a-00ec-133d-54943b2c39e0@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org

On 09/10/2018 19:52, Tony Krowiak wrote:
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
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>   MAINTAINERS                       |   1 +
>   default-configs/s390x-softmmu.mak |   1 +
>   hw/vfio/Makefile.objs             |   1 +
>   hw/vfio/ap.c                      | 180 +++++++++++++++++++++++++++++=
+
>   include/hw/vfio/vfio-common.h     |   1 +
>   5 files changed, 184 insertions(+)
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
> +#define VFIO_AP_DEVICE(obj) \
> +        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
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
> +    GError *gerror;
> +    char *symlink, *group_path;
> +    int groupid;
> +
> +    symlink =3D g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsde=
v);
> +    group_path =3D g_file_read_link(symlink, &gerror);

hum I oversaw this, it leads to segfault.

You must initialize gerror before use.
The following patch avoid a segmentation fault:


diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 5543406afc..3b8e9ba6dc 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -59,7 +59,7 @@ static void vfio_ap_put_device(VFIOAPDevice *vapdev)

  static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
  {
-    GError *gerror;
+    GError *gerror =3D NULL;
      char *symlink, *group_path;
      int groupid;



Regards,
Pierre

=09




--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
