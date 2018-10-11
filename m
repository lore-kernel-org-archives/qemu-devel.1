Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAX0e-0004wG-4i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAX0c-0001e4-Se
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:11:56 -0400
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<20181010170309.12045-6-akrowiak@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <facedbb1-ae6d-3f13-7de3-b433cc08eba5@redhat.com>
Date: Thu, 11 Oct 2018 11:11:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181010170309.12045-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v11 5/6] s390x/vfio: ap:
 Introduce VFIO AP device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org, cohuck@redhat.com
Cc: akrowiak@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 2018-10-10 19:03, Tony Krowiak wrote:
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
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS                       |   2 +
>  default-configs/s390x-softmmu.mak |   1 +
>  hw/vfio/Makefile.objs             |   1 +
>  hw/vfio/ap.c                      | 179 ++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |   1 +
>  5 files changed, 184 insertions(+)
>  create mode 100644 hw/vfio/ap.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9984242820b..2730757b4482 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -88,6 +88,7 @@ F: hw/char/terminal3270.c
>  F: hw/intc/s390_flic.c
>  F: hw/intc/s390_flic_kvm.c
>  F: hw/s390x/
> +F: hw/vfio/ap.c
>  F: hw/vfio/ccw.c
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/s390x/
> @@ -1217,6 +1218,7 @@ F: hw/s390x/ap-device.c
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
> index 000000000000..8ec9ad7d4d90
> --- /dev/null
> +++ b/hw/vfio/ap.c
> @@ -0,0 +1,179 @@
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
> +    GError *gerror = NULL;
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

You also need to g_free(group_path) in this error case here. Maybe
Cornelia could add this when picking the patch up...

With that fix:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> +        return NULL;
> +    }
> +
> +    g_free(group_path);
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}
