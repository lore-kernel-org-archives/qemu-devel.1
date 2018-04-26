Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fBiE8-0001HH-GU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fBiE6-0003I2-FW
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:50:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fBiE6-0003GX-6E
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:50:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3QEo80k023161
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hkfe3mw19-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:20 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 26 Apr 2018 10:50:12 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180419140345.7dfc584e.cohuck@redhat.com>
	<93f675a5-ff33-d916-49e7-4e13babb419e@linux.vnet.ibm.com>
	<20180423090020.3af9dbf4.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 10:50:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180423090020.3af9dbf4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7cf8803e-0ccc-108e-6736-993934f4f22e@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/23/2018 03:00 AM, Cornelia Huck wrote:
> On Sun, 22 Apr 2018 12:05:44 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 04/19/2018 08:03 AM, Cornelia Huck wrote:
>>> On Sun, 15 Apr 2018 15:07:23 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> Introduces a VFIO based AP device. The device is defined via
>>>> the QEMU command line by specifying:
>>>>
>>>>       -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
>>>>
>>>> There may be only one vfio-ap device configured for a guest.
>>>>
>>>> The mediated matrix device is created by the VFIO AP device
>>>> driver by writing a UUID to a sysfs attribute file (see
>>>> docs/vfio-ap.txt). The mediated matrix device will be named
>>>> after the UUID. Symbolic links to the $uuid are created in
>>>> many places, so the path to the mediated matrix device $uuid
>>>> can be specified in any of the following ways:
>>>>
>>>> /sys/devices/vfio_ap/matrix/$uuid
>>>> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid
>>>> /sys/bus/mdev/devices/$uuid
>>>> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>>>>
>>>> When the vfio-ap device is realized, it acquires and opens the
>>>> VFIO iommu group to which the mediated matrix device is
>>>> bound. This causes a VFIO group notification event to be
>>>> signaled. The vfio_ap device driver's group notification
>>>> handler will get called at which time the device driver
>>>> will configure the the AP devices to which the guest will
>>>> be granted access.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>>    default-configs/s390x-softmmu.mak |    1 +
>>>>    hw/vfio/Makefile.objs             |    1 +
>>>>    hw/vfio/ap.c                      |  191 +++++++++++++++++++++++++++++++++++++
>>>>    include/hw/vfio/vfio-common.h     |    1 +
>>>>    4 files changed, 194 insertions(+), 0 deletions(-)
>>>>    create mode 100644 hw/vfio/ap.c
>>>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    VFIODevice *vbasedev;
>>>> +    VFIOGroup *vfio_group;
>>>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>>>> +    char *mdevid;
>>>> +    Error *local_err = NULL;
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * Since a guest's matrix is configured in its entirety by the mediated
>>>> +     * matrix device and hot plug is not currently supported, there is no
>>>> +     * need to have more than one vfio-ap device. Check if a vfio-ap device
>>>> +     * has already been defined.
>>>> +     */
>>>> +    if (vfio_apdev) {
>>>> +        error_setg(&local_err, "Only one %s device is allowed",
>>>> +                   VFIO_AP_DEVICE_TYPE);
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    if (!s390_has_feat(S390_FEAT_AP)) {
>>>> +        error_setg(&local_err, "AP support not enabled");
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    vfio_apdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>>>> +
>>>> +    vfio_group = vfio_ap_get_group(vfio_apdev, &local_err);
>>>> +    if (!vfio_group) {
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    vfio_apdev->vdev.ops = &vfio_ap_ops;
>>>> +    vfio_apdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>>>> +    mdevid = basename(vfio_apdev->vdev.sysfsdev);
>>>> +    vfio_apdev->vdev.name = g_strdup_printf("%s", mdevid);
>>>> +    vfio_apdev->vdev.dev = dev;
>>>> +    QLIST_FOREACH(vbasedev, &vfio_group->device_list, next) {
>>>> +        if (strcmp(vbasedev->name, vfio_apdev->vdev.name) == 0) {
>>>> +            error_setg(&local_err,
>>>> +                       "%s: AP device %s has already been realized",
>>>> +                       VFIO_AP_DEVICE_TYPE, vfio_apdev->vdev.name);
>>>> +            goto out_device_err;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    ret = vfio_get_device(vfio_group, mdevid, &vfio_apdev->vdev, &local_err);
>>>> +    if (ret) {
>>>> +        goto out_device_err;
>>>> +    }
>>> Don't you need a put somewhere to avoid memory leaks?
>> There is a call to vfio_put_device in the unrealize function.
> I don't think unrealize is called if realize failed, so you need to
> clean up in the error cases?

Very true. I  misinterpreted your point. Yes, I need to clean up
if realize fails.

>
>>>   
>>>> +
>>>> +    return;
>>>> +
>>>> +
>>>> +out_device_err:
>>>> +    vfio_put_group(vfio_group);
>>>> +out_err:
>>>> +    vfio_apdev = NULL;
>>>> +    error_propagate(errp, local_err);
>>>> +}
>>
