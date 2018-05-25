Received: from eggs.gnu.org ([2001:4830:134:3::10]:41131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fMGnb-0003Zn-JP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fMGnW-00013e-Nf
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:46:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52482
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fMGnW-00013H-Gr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:46:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4PHiCuK062395
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:46:37 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6q0srdxt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:46:37 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 May 2018 18:46:35 +0100
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
	<20180525114033.3c514091.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 25 May 2018 19:46:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180525114033.3c514091.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c1c246bd-c0a8-7e30-dd0c-ba99c2346d15@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/25/2018 11:40 AM, Cornelia Huck wrote:
> On Thu, 24 May 2018 19:58:27 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> There is at least one guest (OS) such that although it does not rely on
>> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
>> P bit) not being set, it fails to tell this to the machine.

[..]

>> +static inline void warn_once(bool *warned, const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +
>> +    if (!warned || *warned) {
>> +        return;
>> +    }
>> +    *warned = true;
>> +    va_start(ap, fmt);
>> +    warn_vreport(fmt, ap);
>> +    va_end(ap);
>> +}
>> +
>> +static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
>> +                                  const char *msg)
>> +{
>> +    warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (devno %x.%x.%04x): %s",
>> +              sch->cssid, sch->ssid, sch->devno, msg);
>> +}
>> +
> 
> While I still think we want warn_once() in common error handling code,
> this looks reasonable enough. We can still move it later.
>

I agree. I was a bit surprised to not find any warn_once functionality.
Let see what Markus says.
  
>>   static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset = false;
>> @@ -54,6 +76,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>>       struct ccw_io_region *region = vcdev->io_region;
>>       int ret;
>>   
>> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
>> +        if (!(vcdev->force_orb_pfch)) {
>> +            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
>> +            sch_gen_unit_exception(sch);
>> +            css_inject_io_interrupt(sch);
>> +            return IOINST_CC_EXPECTED;
>> +        } else {
>> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> +            warn_once_pfch(vcdev, sch, "PFCH flag forced");
>> +        }
>> +    }
>> +
> 
> Looks good to me. I plan to queue this (and the other patch) to
> s390-next, but (as always) further tags are still welcome :)
> 

Thanks!

Halil
