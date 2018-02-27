Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqlPZ-0001nR-Fa
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqlPU-0000vZ-I5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:59:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1eqlPU-0000vG-6V
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:59:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RJxSWX090165
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:59:34 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gdcccm2mj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:59:30 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 12:59:11 -0700
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180227180458.64ea3d61.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 14:59:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180227180458.64ea3d61.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <816dc833-96f3-b3a8-e4c7-b6a305d35707@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] s390x/vfio: ap: Introduce VFIO AP
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

On 02/27/2018 12:04 PM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 10:44:18 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Introduces a VFIO based AP device. The device is defined via
>> the QEMU command line by specifying:
>>
>>      -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
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
>> ---
>>   default-configs/s390x-softmmu.mak |    1 +
>>   hw/vfio/Makefile.objs             |    1 +
>>   hw/vfio/ap.c                      |  167 +++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h     |    1 +
>>   4 files changed, 170 insertions(+), 0 deletions(-)
>>   create mode 100644 hw/vfio/ap.c
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> new file mode 100644
>> index 0000000..8aa5221
>> --- /dev/null
>> +++ b/hw/vfio/ap.c
>> @@ -0,0 +1,167 @@
>> +/*
>> + * VFIO based AP matrix device assignment
>> + *
>> + * Copyright 2017 IBM Corp.
> Happy new year?
Happy New Year to you too ;)
>
> [Also the other new files, here and in the Linux part.]
I'll fix this in all new files in the patch series.
>
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or(at
>> + * your option) any version. See the COPYING file in the top-level
> That probably should be "any later version" (I'm not even sure what GPL
> v1 says :)
Will do.
>
> And I just noticed that the vfio-ccw code has the same problem...
I'm not fixing those :)
>
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
>> +
>> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>> +#define AP_SYSFSDEV_PROP_NAME    "sysfsdev"
> Using a #define for a property name seems unusual (and I think it
> decreases readability).
I'll remove it
>
> Otherwise, looks fine (on first read-through).
>
