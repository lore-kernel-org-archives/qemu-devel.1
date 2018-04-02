Received: from eggs.gnu.org ([2001:4830:134:3::10]:34463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32u4-0000oF-PA
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32u0-0000Kc-9e
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:05:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57582
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32u0-0000K6-47
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:05:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w32H4q6Q043097
	for <qemu-devel@nongnu.org>; Mon, 2 Apr 2018 13:05:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h3rkt018d-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 13:05:50 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Mon, 2 Apr 2018 13:05:50 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
	<20180327140215.18c51d41.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 13:05:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180327140215.18c51d41.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <5d7d8eac-180f-ed9a-df2a-3be2c51ecaf0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 03/27/2018 08:02 AM, Cornelia Huck wrote:
> On Fri, 16 Mar 2018 14:22:52 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>
>> On 03/16/2018 11:42 AM, Pierre Morel wrote:
>>> On 16/03/2018 00:24, Tony Krowiak wrote:
>>>> Introduces a VFIO based AP device. The device is defined via
>>>> the QEMU command line by specifying:
>>>>
>>>>       -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
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
>> [..]
>>>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    VFIODevice *vbasedev;
>>>> +    VFIOGroup *vfio_group;
>>>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>>>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>>>> +    char *mdevid;
>>>> +    Error *local_err = NULL;
>>>> +    int ret;
>>>> +
>>>> +    if (!s390_has_feat(S390_FEAT_AP)) {
>>>> +        error_setg(&local_err, "AP support not enabled");
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    ret = kvm_s390_set_interpret_ap(1);
>>> If we have several devices, this is called once per device.
>> I don't think having several of these in a single vm makes
>> any sense. Or does it? IMHO we should make sure there is at
>> most one device taking care of the crypto pass-through.
> Yes, I think we should fence off adding a second device in the realize
> function (probably by checking a global variable?)
I agree, will do.
>
