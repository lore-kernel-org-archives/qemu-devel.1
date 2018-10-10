Received: from eggs.gnu.org ([2001:4830:134:3::10]:48630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFFU-0007z7-Kt
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFFR-0005TN-UI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:14:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAFFR-0005SY-KS
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:14:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AEADP2139556
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:14:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jwxr9q1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:13:59 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:13:58 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
	<20181010105256.1ee6e099.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 10:13:47 -0400
MIME-Version: 1.0
In-Reply-To: <20181010105256.1ee6e099.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <88692ed8-b432-92e8-6094-1fbd3a7d113a@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com

On 10/10/2018 04:52 AM, Cornelia Huck wrote:
> On Wed, 10 Oct 2018 10:25:22 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 2018-10-09 19:52, Tony Krowiak wrote:
> 
>> [...]
>>> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>>> +{
>>> +    GError *gerror;
>>> +    char *symlink, *group_path;
>>> +    int groupid;
>>> +
>>> +    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>>> +    group_path = g_file_read_link(symlink, &gerror);
>>> +    g_free(symlink);
>>> +
>>> +    if (!group_path) {
>>> +        error_setg(errp, "%s: no iommu_group found for %s: %s",
>>> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>>> +        error_setg(errp, "vfio: failed to read %s", group_path);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return vfio_get_group(groupid, &address_space_memory, errp);
>>> +}
>>
>> I think you've got to g_free(group_path) after you don't need it anymore.
>>
>>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    int ret;
>>> +    char *mdevid;
>>> +    Error *local_err = NULL;
>>> +    VFIOGroup *vfio_group;
>>> +    APDevice *apdev = AP_DEVICE(dev);
>>> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>>> +
>>> +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
>>> +    if (!vfio_group) {
>>> +        goto out_err;
>>> +    }
>>> +
>>> +    vapdev->vdev.ops = &vfio_ap_ops;
>>> +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>>> +    mdevid = basename(vapdev->vdev.sysfsdev);
>>> +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>>> +    vapdev->vdev.dev = dev;
>>> +
>>> +    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
>>> +    if (ret) {
>>> +        goto out_get_dev_err;
>>> +    }
>>> +
>>> +    /* Enable hardware to intepret AP instructions executed on the guest */
>>> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie", NULL);
>>> +
>>> +    return;
>>> +
>>> +out_get_dev_err:
>>> +    vfio_ap_put_device(vapdev);
>>> +    vfio_put_group(vfio_group);
>>> +out_err:
>>> +    error_propagate(errp, local_err);
>>> +}
>>> +
>>> +static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>>> +{
>>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>>
>> Didn't you want to remove the DO_UPCASTs ?
>>
>>> +    VFIOGroup *group = vapdev->vdev.group;
>>> +
>>> +    vfio_ap_put_device(vapdev);
>>> +    vfio_put_group(group);
>>> +}
>>> +
>>> +static Property vfio_ap_properties[] = {
>>> +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void vfio_ap_reset(DeviceState *dev)
>>> +{
>>> +    int ret;
>>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>>
>> dito
>>
>>> +    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>>> +    if (ret) {
>>> +        error_report("%s: failed to reset %s device: %s", __func__,
>>> +                     vapdev->vdev.name, strerror(ret));
>>> +    }
>>> +}
> 
> OK, this is now a bit too much stuff all in all to change while
> applying...
> 
> Tony, can you please do a respin with these changes and the other
> things people have noticed? Thanks!

I will have v11 posted today.

> 
