Received: from eggs.gnu.org ([2001:4830:134:3::10]:36408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHL0-0002ZI-7i
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHKx-0001ne-1f
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:55:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fAHKw-0001nY-Oa
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:55:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MFsrl4114019
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:55:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk2nyw8c-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:55:32 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 22 Apr 2018 11:55:31 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1452b9f7-8cec-31be-b097-b136317a5921@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 11:55:25 -0400
MIME-Version: 1.0
In-Reply-To: <1452b9f7-8cec-31be-b097-b136317a5921@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <e78e0a7a-ca1d-072d-02f8-919104885bcc@linux.vnet.ibm.com>
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/18/2018 05:11 AM, Pierre Morel wrote:
> On 15/04/2018 21:07, Tony Krowiak wrote:
>> Introduces a VFIO based AP device. The device is defined via
>> the QEMU command line by specifying:
>>
>>      -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
>>
>> There may be only one vfio-ap device configured for a guest.
>>
>> The mediated matrix device is created by the VFIO AP device
>> driver by writing a UUID to a sysfs attribute file (see
>> docs/vfio-ap.txt). The mediated matrix device will be named
>> after the UUID. Symbolic links to the $uuid are created in
>> many places, so the path to the mediated matrix device $uuid
>> can be specified in any of the following ways:
>>
>> /sys/devices/vfio_ap/matrix/$uuid
>> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid 
>>
>> /sys/bus/mdev/devices/$uuid
>> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>>
>> When the vfio-ap device is realized, it acquires and opens the
>> VFIO iommu group to which the mediated matrix device is
>> bound. This causes a VFIO group notification event to be
>> signaled. The vfio_ap device driver's group notification
>> handler will get called at which time the device driver
>> will configure the the AP devices to which the guest will
>> be granted access.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   default-configs/s390x-softmmu.mak |    1 +
>>   hw/vfio/Makefile.objs             |    1 +
>>   hw/vfio/ap.c                      |  191 
>> +++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h     |    1 +
>>   4 files changed, 194 insertions(+), 0 deletions(-)
>>   create mode 100644 hw/vfio/ap.c
>>
>> diff --git a/default-configs/s390x-softmmu.mak 
>> b/default-configs/s390x-softmmu.mak
>> index 2f4bfe7..0b784b6 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -9,3 +9,4 @@ CONFIG_S390_FLIC=y
>>   CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>>   CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>>   CONFIG_WDT_DIAG288=y
>> +CONFIG_VFIO_AP=$(CONFIG_LINUX)
>> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
>> index a2e7a0a..8b3f664 100644
>> --- a/hw/vfio/Makefile.objs
>> +++ b/hw/vfio/Makefile.objs
>> @@ -6,4 +6,5 @@ obj-$(CONFIG_SOFTMMU) += platform.o
>>   obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
>>   obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>>   obj-$(CONFIG_SOFTMMU) += spapr.o
>> +obj-$(CONFIG_VFIO_AP) += ap.o
>>   endif
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> new file mode 100644
>> index 0000000..7b48a3a
>> --- /dev/null
>> +++ b/hw/vfio/ap.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + * VFIO based AP matrix device assignment
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 
>> or (at
>> + * your option) any later version. See the COPYING file in the 
>> top-level
>> + * directory.
>> + */
>> +
>> +#include <linux/vfio.h>
>> +#include <sys/ioctl.h>
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/vfio/vfio.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "hw/s390x/ap-device.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/queue.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "cpu.h"
>> +#include "kvm_s390x.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>> +
>> +typedef struct VFIOAPDevice {
>> +    APDevice apdev;
>> +    VFIODevice vdev;
>> +    QTAILQ_ENTRY(VFIOAPDevice) sibling;
>> +} VFIOAPDevice;
>> +
>> +VFIOAPDevice *vfio_apdev;
>> +
>> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> +{
>> +    vdev->needs_reset = false;
>> +}
>> +
>> +/*
>> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>> + * vfio-ap-matrix device now.
>> + */
>> +struct VFIODeviceOps vfio_ap_ops = {
>> +    .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>> +};
>> +
>> +static void vfio_put_device(VFIOAPDevice *vapdev)
>> +{
>> +    g_free(vapdev->vdev.name);
>> +    vfio_put_base_device(&vapdev->vdev);
>> +}
>> +
>> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>> +{
>> +    char *tmp, group_path[PATH_MAX];
>> +    ssize_t len;
>> +    int groupid;
>> +
>> +    tmp = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>> +    len = readlink(tmp, group_path, sizeof(group_path));
>> +    g_free(tmp);
>> +
>> +    if (len <= 0 || len >= sizeof(group_path)) {
>> +        error_setg(errp, "%s: no iommu_group found for %s",
>> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev);
>> +        return NULL;
>> +    }
>> +
>> +    group_path[len] = 0;
>> +
>> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>> +        error_setg(errp, "vfio: failed to read %s", group_path);
>> +        return NULL;
>> +    }
>> +
>> +    return vfio_get_group(groupid, &address_space_memory, errp);
>> +}
>> +
>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VFIODevice *vbasedev;
>> +    VFIOGroup *vfio_group;
>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>> +    char *mdevid;
>> +    Error *local_err = NULL;
>> +    int ret;
>> +
>> +    /*
>> +     * Since a guest's matrix is configured in its entirety by the 
>> mediated
>> +     * matrix device and hot plug is not currently supported, there 
>> is no
>> +     * need to have more than one vfio-ap device. Check if a vfio-ap 
>> device
>> +     * has already been defined.
>> +     */
>> +    if (vfio_apdev) {
>> +        error_setg(&local_err, "Only one %s device is allowed",
>> +                   VFIO_AP_DEVICE_TYPE);
>> +        goto out_err;
>> +    }
>> +
>> +    if (!s390_has_feat(S390_FEAT_AP)) {
>> +        error_setg(&local_err, "AP support not enabled");
>> +        goto out_err;
>> +    }
>> +
>> +    vfio_apdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>> +
>> +    vfio_group = vfio_ap_get_group(vfio_apdev, &local_err);
>> +    if (!vfio_group) {
>> +        goto out_err;
>> +    }
>> +
>> +    vfio_apdev->vdev.ops = &vfio_ap_ops;
>> +    vfio_apdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>> +    mdevid = basename(vfio_apdev->vdev.sysfsdev);
>> +    vfio_apdev->vdev.name = g_strdup_printf("%s", mdevid);
>> +    vfio_apdev->vdev.dev = dev;
>> +    QLIST_FOREACH(vbasedev, &vfio_group->device_list, next) {
>
> can this happen if you have only one device ?

No, it is a remnant from previous versions when we didn't enforce
the single device requirement. I can remove it.

>
>
>> +        if (strcmp(vbasedev->name, vfio_apdev->vdev.name) == 0) {
>> +            error_setg(&local_err,
>> +                       "%s: AP device %s has already been realized",
>> +                       VFIO_AP_DEVICE_TYPE, vfio_apdev->vdev.name);
>> +            goto out_device_err;
>> +        }
>> +    }
>> +
>> +
> ...snip...
>
