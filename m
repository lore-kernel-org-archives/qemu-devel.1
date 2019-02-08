Received: from eggs.gnu.org ([209.51.188.92]:59577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gs8e8-00062I-EE
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gs8e6-0003Wk-RQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:04:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gs8e6-0003Im-EV
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:04:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18G4WOJ071991
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 11:04:41 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhagqyjx2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 11:04:37 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 8 Feb 2019 16:04:34 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<e22e1a26-2dd7-cc4c-86cc-2a78adba409f@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 8 Feb 2019 11:04:29 -0500
MIME-Version: 1.0
In-Reply-To: <e22e1a26-2dd7-cc4c-86cc-2a78adba409f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd56798a-e32f-d46f-4a5c-0f8728e64fbd@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 2/6/19 6:30 AM, Thomas Huth wrote:
> On 2019-01-29 14:29, Jason J. Herne wrote:
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
>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>> index cad91ee..f5f025d 100644
>> --- a/hw/s390x/s390-ccw.c
>> +++ b/hw/s390x/s390-ccw.c
>> @@ -124,6 +124,14 @@ static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
>>       g_free(cdev->mdevid);
>>   }
>>   
>> +static void s390_ccw_instance_init(Object *obj)
>> +{
>> +    S390CCWDevice *dev = S390_CCW_DEVICE(obj);
>> +
>> +    device_add_bootindex_property(obj, &dev->bootindex, "bootindex",
>> +                                  "/disk@0,0", DEVICE(obj), NULL);
>> +}
>> +
>>   static void s390_ccw_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -137,6 +145,7 @@ static void s390_ccw_class_init(ObjectClass *klass, void *data)
>>   static const TypeInfo s390_ccw_info = {
>>       .name          = TYPE_S390_CCW,
>>       .parent        = TYPE_CCW_DEVICE,
>> +    .instance_init = s390_ccw_instance_init,
>>       .instance_size = sizeof(S390CCWDevice),
>>       .class_size    = sizeof(S390CCWDeviceClass),
>>       .class_init    = s390_ccw_class_init,
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 9246729..d815a4f 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -21,22 +21,11 @@
>>   #include "hw/vfio/vfio.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "hw/s390x/s390-ccw.h"
>> +#include "hw/s390x/vfio-ccw.h"
>>   #include "hw/s390x/ccw-device.h"
>>   #include "exec/address-spaces.h"
>>   #include "qemu/error-report.h"
>>   
>> -#define TYPE_VFIO_CCW "vfio-ccw"
>> -typedef struct VFIOCCWDevice {
>> -    S390CCWDevice cdev;
>> -    VFIODevice vdev;
>> -    uint64_t io_region_size;
>> -    uint64_t io_region_offset;
>> -    struct ccw_io_region *io_region;
>> -    EventNotifier io_notifier;
>> -    bool force_orb_pfch;
>> -    bool warned_orb_pfch;
>> -} VFIOCCWDevice;
>> -
>>   static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
>>                                     const char *msg)
>>   {
>> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
>> index 7d15a1a..901d805 100644
>> --- a/include/hw/s390x/s390-ccw.h
>> +++ b/include/hw/s390x/s390-ccw.h
>> @@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
>>       CcwDevice parent_obj;
>>       CssDevId hostid;
>>       char *mdevid;
>> +    int32_t bootindex;
>>   } S390CCWDevice;
>>   
>>   typedef struct S390CCWDeviceClass {
>> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
>> new file mode 100644
>> index 0000000..a7d699d
>> --- /dev/null
>> +++ b/include/hw/s390x/vfio-ccw.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * vfio based subchannel assignment support
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#ifndef HW_VFIO_CCW_H
>> +#define HW_VFIO_CCW_H
>> +
>> +#include "hw/vfio/vfio-common.h"
>> +#include "hw/s390x/s390-ccw.h"
>> +#include "hw/s390x/ccw-device.h"
>> +
>> +#define TYPE_VFIO_CCW "vfio-ccw"
>> +#define VFIO_CCW(obj) \
>> +        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
>> +
>> +
> 
> Remove one empty line, please.
> 
>> +#define TYPE_VFIO_CCW "vfio-ccw"
>> +typedef struct VFIOCCWDevice {
>> +    S390CCWDevice cdev;
>> +    VFIODevice vdev;
>> +    uint64_t io_region_size;
>> +    uint64_t io_region_offset;
>> +    struct ccw_io_region *io_region;
>> +    EventNotifier io_notifier;
>> +    bool force_orb_pfch;
>> +    bool warned_orb_pfch;
>> +} VFIOCCWDevice;
> 
> Do you really need to make the whole structure public here? If not, I
> think it would be sufficient to only have the "anonymous" typedef here:
> 
> typedef struct VFIOCCWDevice VFIOCCWDevice;
> 
>   Thomas
Perhaps the entire struct is not needed in ipl.c, and we could get by with only the 
typedef. But then the only thing in vfio-ccw.h will be the one line. Seems a little 
confusing to me. What do we gain by doing this?

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
