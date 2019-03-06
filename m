Received: from eggs.gnu.org ([209.51.188.92]:50988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1XxW-0004Lf-CY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1XxV-0008Hw-7O
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33802
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1XxU-0008Ga-SO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x26EntRX014155
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 09:55:46 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r2ffqub9g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 09:55:45 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 6 Mar 2019 14:55:45 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
	<20190304144010.109e5ee1.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 6 Mar 2019 09:55:40 -0500
MIME-Version: 1.0
In-Reply-To: <20190304144010.109e5ee1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cf5e9c71-a78a-02b1-eaa8-4c8ba5c2c8a3@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] s390 vfio-ccw: Add bootindex
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/4/19 8:40 AM, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:21 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
>> forward boot information into the bios for vfio-ccw devices.
>>
>> Refactor s390_get_ccw_device() to return device type. This prevents us from
>> having to use messy casting logic in several places.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                 |  1 +
>>   hw/s390x/ipl.c              | 39 +++++++++++++++++++++++++++++++++------
>>   hw/s390x/s390-ccw.c         |  9 +++++++++
>>   hw/vfio/ccw.c               |  2 +-
>>   include/hw/s390x/s390-ccw.h |  1 +
>>   include/hw/s390x/vfio-ccw.h | 28 ++++++++++++++++++++++++++++
>>   6 files changed, 73 insertions(+), 7 deletions(-)
>>   create mode 100644 include/hw/s390x/vfio-ccw.h
>>
> (...)
>> @@ -305,16 +306,29 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>>       *timeout = cpu_to_be32(splash_time);
>>   }
>>   
>> -static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>> +#define CCW_DEVTYPE_NONE    0x00
>> +#define CCW_DEVTYPE_VIRTIO  0x01
>> +#define CCW_DEVTYPE_SCSI    0x02
>> +#define CCW_DEVTYPE_VFIO    0x03
> 
> Hm, how would the code look if you introduced a CCW_DEVTYPE_VIRTIO_NET
> or so? You could use the simply set the netboot flag in
> get_initial_iplb and fall through to the handling of
> CCW_DEVTYPE_VIRTIO...
> 
>> +
>> +static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int* devtype)
> 
> s/int* devtype/int *devtype/
> 
>>   {
>>       CcwDevice *ccw_dev = NULL;
>>   
>> +    *devtype = CCW_DEVTYPE_NONE;
>> +
>>       if (dev_st) {
>>           VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
>>               object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>>                                   TYPE_VIRTIO_CCW_DEVICE);
>> +        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
>> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>>           if (virtio_ccw_dev) {
>>               ccw_dev = CCW_DEVICE(virtio_ccw_dev);
>> +            *devtype = CCW_DEVTYPE_VIRTIO;
>> +        } else if (vfio_ccw_dev) {
>> +            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
>> +            *devtype = CCW_DEVTYPE_VFIO;
>>           } else {
>>               SCSIDevice *sd = (SCSIDevice *)
>>                   object_dynamic_cast(OBJECT(dev_st),
>> @@ -327,6 +341,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>>   
>>                   ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
>>                                                              TYPE_CCW_DEVICE);
>> +                *devtype = CCW_DEVTYPE_SCSI;
>>               }
>>           }
>>       }
>> @@ -337,10 +352,11 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>   {
>>       DeviceState *dev_st;
>>       CcwDevice *ccw_dev = NULL;
>> +    int devtype;
>>   
>>       dev_st = get_boot_device(0);
>>       if (dev_st) {
>> -        ccw_dev = s390_get_ccw_device(dev_st);
>> +        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>>       }
>>   
>>       /*
>> @@ -349,8 +365,10 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>       if (ccw_dev) {
>>           SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>>                                                               TYPE_SCSI_DEVICE);
>> +        VirtIONet *vn;
> 
> I think you could get rid of this variable with my suggestion from
> above.
> 
>>   
>> -        if (sd) {
>> +        switch (devtype) {
>> +        case CCW_DEVTYPE_SCSI:
> 
> Move obtaining sd into this case?
> 
>>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>>               ipl->iplb.blk0_len =
>>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
>> @@ -360,8 +378,15 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>               ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
>>               ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
>>               ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
>> -        } else {
>> -            VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
>> +            break;
>> +        case CCW_DEVTYPE_VFIO:
>> +            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>> +            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
>> +            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
>> +            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
>> +            break;
>> +        case CCW_DEVTYPE_VIRTIO:
>> +            vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
>>                                                                 TYPE_VIRTIO_NET);
>>   
>>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>> @@ -374,6 +399,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>               if (vn) {
>>                   ipl->netboot = true;
>>               }
>> +            break;
>>           }
>>   
>>           if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
>> @@ -518,6 +544,7 @@ IplParameterBlock *s390_ipl_get_iplb(void)
>>   void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>   {
>>       S390IPLState *ipl = get_ipl_device();
>> +    int devtype;
>>   
>>       if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
>>           /* use CPU 0 for full resets */
>> @@ -532,7 +559,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>           !ipl->netboot &&
>>           ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
>>           is_virtio_scsi_device(&ipl->iplb)) {
>> -        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
>> +        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), &devtype);
> 
> It feels wrong to have a variable that is not used later... what about
> either
> - making s390_get_ccw_device() capable of handling a NULL second
>    parameter, or
> - (what I think would be nicer) passing in the devtype as an optional
>    parameter to gen_initial_iplb() so you don't need to do the casting
>    dance twice?
> 

I'm with you on everything suggested for this patch except this last item. I'm not sure 
what you are suggesting here. I can easily visualize passing NULL for devtype when we want 
to ignore it but I'm not sure what you mean by 'optional parameter'

>>   
>>           if (ccw_dev &&
>>               cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
> 
> 


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
