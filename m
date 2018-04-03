Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0631802794=akrowiak@linux.vnet.ibm.com>)
	id 1f3R3j-0008JO-4W
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0631802794=akrowiak@linux.vnet.ibm.com>)
	id 1f3R3g-0003VJ-1o
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:53:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0631802794=akrowiak@linux.vnet.ibm.com>)
	id 1f3R3f-0003V0-PR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:53:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w33IoPpo038755
	for <qemu-devel@nongnu.org>; Tue, 3 Apr 2018 14:53:26 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4dgne7gx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 14:53:26 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 3 Apr 2018 12:53:24 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
	<20180327140215.18c51d41.cohuck@redhat.com>
	<5d7d8eac-180f-ed9a-df2a-3be2c51ecaf0@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 14:53:15 -0400
MIME-Version: 1.0
In-Reply-To: <5d7d8eac-180f-ed9a-df2a-3be2c51ecaf0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <c6c72fec-0c5f-20fe-534d-954336e6ded3@linux.vnet.ibm.com>
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
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

On 04/02/2018 01:05 PM, Tony Krowiak wrote:
> On 03/27/2018 08:02 AM, Cornelia Huck wrote:
>> On Fri, 16 Mar 2018 14:22:52 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 03/16/2018 11:42 AM, Pierre Morel wrote:
>>>> On 16/03/2018 00:24, Tony Krowiak wrote:
>>>>> Introduces a VFIO based AP device. The device is defined via
>>>>> the QEMU command line by specifying:
>>>>>
>>>>>       -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
>>>>>
>>>>> The mediated matrix device is created by the VFIO AP device
>>>>> driver by writing a UUID to a sysfs attribute file (see
>>>>> docs/vfio-ap.txt). The mediated matrix device will be named
>>>>> after the UUID. Symbolic links to the $uuid are created in
>>>>> many places, so the path to the mediated matrix device $uuid
>>>>> can be specified in any of the following ways:
>>>>>
>>>>> /sys/devices/vfio_ap/matrix/$uuid
>>>>> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid 
>>>>>
>>>>> /sys/bus/mdev/devices/$uuid
>>>>> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>>>>>
>>>>> When the vfio-ap device is realized, it acquires and opens the
>>>>> VFIO iommu group to which the mediated matrix device is
>>>>> bound. This causes a VFIO group notification event to be
>>>>> signaled. The vfio_ap device driver's group notification
>>>>> handler will get called at which time the device driver
>>>>> will configure the the AP devices to which the guest will
>>>>> be granted access.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>>> ---
>>> [..]
>>>>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>>> +{
>>>>> +    VFIODevice *vbasedev;
>>>>> +    VFIOGroup *vfio_group;
>>>>> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
>>>>> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>>>>> +    char *mdevid;
>>>>> +    Error *local_err = NULL;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!s390_has_feat(S390_FEAT_AP)) {
>>>>> +        error_setg(&local_err, "AP support not enabled");
>>>>> +        goto out_err;
>>>>> +    }
>>>>> +
>>>>> +    ret = kvm_s390_set_interpret_ap(1);
>>>> If we have several devices, this is called once per device.
>>> I don't think having several of these in a single vm makes
>>> any sense. Or does it? IMHO we should make sure there is at
>>> most one device taking care of the crypto pass-through.
>> Yes, I think we should fence off adding a second device in the realize
>> function (probably by checking a global variable?)
> I agree, will do.
In light of comments Connie made in Message ID: 
<20180403113619.54ff1e18.cohuck@redhat.com>, this
raises the question: What about hotplug? If we allow only one vfio_ap 
device for a guest, then
there will be no hot plugging of vfio_ap devices except for the case 
where no vfio_ap device is
defined for the guest at startup. The question then becomes how do we 
configure (hot plug?)
additional queues for guest usage? I will have to give this some 
additional thought before
committing to a solution here.
>
>>
>
