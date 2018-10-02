Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7MEx-0001PW-OI
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7MEu-0004wR-BS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:05:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g7MEt-0004tP-PH
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:05:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w92F4MBm090138
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 11:05:18 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mv9udbd72-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 11:05:18 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 2 Oct 2018 09:05:17 -0600
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-6-akrowiak@linux.vnet.ibm.com>
	<2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 2 Oct 2018 11:05:05 -0400
MIME-Version: 1.0
In-Reply-To: <2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <27f1509a-cd62-a8ef-86b1-b55d5161c5d4@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v9 5/6] s390x/vfio: ap:
 Introduce VFIO AP device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 09/27/2018 09:56 AM, Thomas Huth wrote:
> On 2018-09-27 00:54, Tony Krowiak wrote:
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
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
> [...]
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> new file mode 100644
>> index 000000000000..429988f23f98
>> --- /dev/null
>> +++ b/hw/vfio/ap.c
>> @@ -0,0 +1,181 @@
>> +/*
>> + * VFIO based AP matrix device assignment
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *            Halil Pasic <pasic@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
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
>> +#include "hw/s390x/ap-bridge.h"
>> +#include "exec/address-spaces.h"
>> +
>> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>> +
>> +typedef struct VFIOAPDevice {
>> +    APDevice apdev;
>> +    VFIODevice vdev;
>> +} VFIOAPDevice;
>> +
>> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> +{
>> +    vdev->needs_reset = false;
>> +}
>> +
>> +/*
>> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>> + * vfio-ap device now.
>> + */
>> +struct VFIODeviceOps vfio_ap_ops = {
>> +    .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>> +};
>> +
>> +static void vfio_ap_put_device(VFIOAPDevice *vapdev)
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
> 
> You could maybe use g_file_read_link() instead to avoid the ugliness
> that is needed around readlink().

I will make that change.

> 
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
>> +    int ret;
>> +    char *mdevid;
>> +    Error *local_err = NULL;
>> +    VFIOGroup *vfio_group;
>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> 
> IIRC DO_UPCAST should be avoided in new code. So this is now here the
> right place to finally use the AP_DEVICE() macro?

Will do.

> 
>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>> +
>> +    vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
> 
> Double assignment to vapdev.

Ah, yes ... it needs to go

> 
>> +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
>> +    if (!vfio_group) {
>> +        goto out_err;
>> +    }
>> +
>> +    vapdev->vdev.ops = &vfio_ap_ops;
>> +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>> +    mdevid = basename(vapdev->vdev.sysfsdev);
>> +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> 
> g_strdup instead of g_strdup_printf should be sufficient here, shouldn't it?

Yes, it is sufficient, I'll change it.

> 
>> +    vapdev->vdev.dev = dev;
>> +
>> +    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
>> +    if (ret) {
>> +        goto out_get_dev_err;
>> +    }
>> +
>> +    /* Enable hardware to intepret AP instructions executed on the guest */
>> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie", NULL);
>> +
>> +    return;
>> +
>> +out_get_dev_err:
>> +    vfio_ap_put_device(vapdev);
>> +    vfio_put_group(vfio_group);
>> +out_err:
>> +    error_propagate(errp, local_err);
>> +}
> 
>   Thomas
> 
