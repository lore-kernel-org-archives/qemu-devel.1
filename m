Received: from eggs.gnu.org ([209.51.188.92]:54379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtunV-0007L0-7Y
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtunU-0004Gi-1e
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:41:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44860
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gtunT-0004CL-Qq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:41:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DDeT7J120780
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:41:52 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmk3xuv8g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:41:50 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 13 Feb 2019 13:41:50 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<20190204112630.75eac242.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 13 Feb 2019 08:41:43 -0500
MIME-Version: 1.0
In-Reply-To: <20190204112630.75eac242.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <97cdb9a7-bd44-153d-72a3-30cf01a67d13@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>

On 2/4/19 5:26 AM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 08:29:08 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
>> forward boot information into the bios for vfio-ccw devices.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/ipl.c              | 14 ++++++++++++++
>>   hw/s390x/s390-ccw.c         |  9 +++++++++
>>   hw/vfio/ccw.c               | 13 +------------
>>   include/hw/s390x/s390-ccw.h |  1 +
>>   include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 63 insertions(+), 12 deletions(-)
>>   create mode 100644 include/hw/s390x/vfio-ccw.h
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 21f64ad..a993f65 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -19,6 +19,7 @@
>>   #include "hw/loader.h"
>>   #include "hw/boards.h"
>>   #include "hw/s390x/virtio-ccw.h"
>> +#include "hw/s390x/vfio-ccw.h"
>>   #include "hw/s390x/css.h"
>>   #include "hw/s390x/ebcdic.h"
>>   #include "ipl.h"
>> @@ -311,8 +312,12 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>>           VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
>>               object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>>                                   TYPE_VIRTIO_CCW_DEVICE);
>> +        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
>> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>>           if (virtio_ccw_dev) {
>>               ccw_dev = CCW_DEVICE(virtio_ccw_dev);
>> +        } else if (vfio_ccw_dev) {
>> +            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
>>           } else {
>>               SCSIDevice *sd = (SCSIDevice *)
>>                   object_dynamic_cast(OBJECT(dev_st),
>> @@ -347,6 +352,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>       if (ccw_dev) {
>>           SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>>                                                               TYPE_SCSI_DEVICE);
>> +        VFIOCCWDevice *vc = (VFIOCCWDevice *)
>> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>>   
>>           if (sd) {
>>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>> @@ -358,6 +365,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>               ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
>>               ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
>>               ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
>> +        } else if (vc) {
>> +            CcwDevice *ccw_dev = CCW_DEVICE(vc);
>> +
>> +            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>> +            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
>> +            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
>> +            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
>>           } else {
>>               VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
>>                                                                 TYPE_VIRTIO_NET);
> 
> Hm, I think that this find-out-the-boot-type-and-set-up-the-right-thing
> mechanism is getting a bit unwieldy. Basically, we
> 
> - call s390_get_ccw_device() to find out the device type via a bunch of
>    casts and return a pointer to a CcwDevice if it's a supported type
> - do a bunch of casts here *again* to find out what we have and fill
>    out the iplb, while we really only need to do grab a non-CcwDevice
>    for the scsi case
> 
> Should maybe s390_get_ccw_device() give us an ipl type in addition to
> the pointer to the CcwDevice, so we can use a switch/case statement to
> fill out the iplb here?

I think this idea makes sense. s390_ipl_reset_request also calls s390_get_ccw_device but 
does not care bout the device type, so how about a separate function instead of 
integrating it with s390_get_ccw_device? Maybe s390_get_ccw_device_type?

Is there any easy way to grab the type or are we just hiding the ugly casting inside our 
helper function?


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
