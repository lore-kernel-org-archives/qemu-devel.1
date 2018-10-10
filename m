Received: from eggs.gnu.org ([2001:4830:134:3::10]:45537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAF64-0004za-9f
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAF60-0007bP-Ck
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:04:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42578
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAF60-0007bE-6x
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:04:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ADwhgY019795
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:04:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1gs2pbws-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:04:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:04:14 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<cd6e06e4-0549-3c1a-96e4-2b2354b9866d@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 10:04:03 -0400
MIME-Version: 1.0
In-Reply-To: <cd6e06e4-0549-3c1a-96e4-2b2354b9866d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <00b3fde5-2cd5-1b4d-85b3-4178c0070dbd@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com

On 10/09/2018 03:51 PM, David Hildenbrand wrote:
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
> 
> I commented on the old version that this is wrong (if I am not starting
> to lose my memory). This has to go. (there is no such property, this
> will simply report an error we ignore)
> 
> (can most probably be fixed when applying)

I don't recall whether you mentioned it, but I will fix it, or it can be
fixed when applied .... Connie?

> 
