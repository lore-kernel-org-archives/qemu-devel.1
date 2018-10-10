Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFEd-0007JR-2n
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFEX-00055T-9u
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAFEU-00053U-Sn
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:13:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AEArUM114780
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:12:57 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1gugxs5e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:12:57 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:12:56 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 10:12:47 -0400
MIME-Version: 1.0
In-Reply-To: <3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4e9aeb85-e6c4-6807-60da-4935293b6683@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 5/6] s390x/vfio: ap:
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
Cc: cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com

On 10/10/2018 04:25 AM, Thomas Huth wrote:
> On 2018-10-09 19:52, Tony Krowiak wrote:
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
>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
>> ---
> [...]
>> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>> +{
>> +    GError *gerror;
>> +    char *symlink, *group_path;
>> +    int groupid;
>> +
>> +    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>> +    group_path = g_file_read_link(symlink, &gerror);
>> +    g_free(symlink);
>> +
>> +    if (!group_path) {
>> +        error_setg(errp, "%s: no iommu_group found for %s: %s",
>> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
>> +        return NULL;
>> +    }
>> +
>> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>> +        error_setg(errp, "vfio: failed to read %s", group_path);
>> +        return NULL;
>> +    }
>> +
>> +    return vfio_get_group(groupid, &address_space_memory, errp);
>> +}
> 
> I think you've got to g_free(group_path) after you don't need it anymore.

Right you are.

> 
>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>> +{
>> +    int ret;
>> +    char *mdevid;
>> +    Error *local_err = NULL;
>> +    VFIOGroup *vfio_group;
>> +    APDevice *apdev = AP_DEVICE(dev);
>> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>> +
>> +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
>> +    if (!vfio_group) {
>> +        goto out_err;
>> +    }
>> +
>> +    vapdev->vdev.ops = &vfio_ap_ops;
>> +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>> +    mdevid = basename(vapdev->vdev.sysfsdev);
>> +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
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
>> +
>> +static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
> 
> Didn't you want to remove the DO_UPCASTs ?

oops, missed these .... fixed them in the realize function, but
missed this one and the next .... will fix

> 
>> +    VFIOGroup *group = vapdev->vdev.group;
>> +
>> +    vfio_ap_put_device(vapdev);
>> +    vfio_put_group(group);
>> +}
>> +
>> +static Property vfio_ap_properties[] = {
>> +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void vfio_ap_reset(DeviceState *dev)
>> +{
>> +    int ret;
>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
> 
> dito

ditto

> 
>> +    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>> +    if (ret) {
>> +        error_report("%s: failed to reset %s device: %s", __func__,
>> +                     vapdev->vdev.name, strerror(ret));
>> +    }
>> +}
> 
>   Thomas
> 
