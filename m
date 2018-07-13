Received: from eggs.gnu.org ([2001:4830:134:3::10]:44675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1fdy15-0005LX-6G
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1fdy12-0000vo-0d
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:21:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1fdy11-0000uo-M6
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:21:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6DDIoc3061107
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 09:21:42 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k6tjr5yau-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 09:21:42 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Fri, 13 Jul 2018 07:21:41 -0600
References: <1530312483-23864-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1530312483-23864-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180704132429.3444bd18.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 13 Jul 2018 15:21:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180704132429.3444bd18.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <5456873f-5587-ca49-830b-7787e600027e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/5] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 07/04/2018 01:24 PM, Cornelia Huck wrote:
> On Fri, 29 Jun 2018 18:48:02 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
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
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Nit: You may want to decide one address or the other :)

Unintentional .... I'll correct it.

>
>> ---
>>   MAINTAINERS                       |    1 +
>>   default-configs/s390x-softmmu.mak |    1 +
>>   hw/vfio/Makefile.objs             |    1 +
>>   hw/vfio/ap.c                      |  183 +++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h     |    1 +
>>   5 files changed, 187 insertions(+), 0 deletions(-)
>>   create mode 100644 hw/vfio/ap.c
> No complaints about the code from me.

I like no complaints:)

>
