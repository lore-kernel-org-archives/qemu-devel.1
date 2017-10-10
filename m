Received: from eggs.gnu.org ([2001:4830:134:3::10]:52008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1rQt-0004so-TF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1rQp-0005M0-Np
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:06:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1rQp-0005LR-FW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:06:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AA4gjd047543
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 06:06:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgp2s91td-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 06:06:30 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 11:06:26 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
	<20171010081310.GA4754@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 12:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <20171010081310.GA4754@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e2f89019-2def-c0bc-960c-9c7d06de30ec@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/10/2017 10:13 AM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-04 17:41:39 +0200]:
> 
> [...]
> 
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 4f47dbc8b0..b2978c3bae 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1003,12 +1003,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>>
>>  }
>>
>> -static int sch_handle_start_func_passthrough(SubchDev *sch)
>> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>>  {
>>
>>      PMCW *p = &sch->curr_status.pmcw;
>>      SCSW *s = &sch->curr_status.scsw;
>> -    int ret;
>>
>>      ORB *orb = &sch->orb;
>>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
>> @@ -1022,31 +1021,11 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>>       */
>>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>> -        return -EINVAL;
>> +        sch_gen_unit_exception(sch);
>> +        css_inject_io_interrupt(sch);
> Last cycle, we agreed to add some log here. Sth. like:
> warn_report("vfio-ccw requires PFCH and C64 flags set...");
> 
> I promised to do a fix for this piece of code. But since this patch
> already fixed it, I guess what I have to do is to add the log only? Or
> you would like to add it by yourself? ;)
> 

I think I forgot this one. Should there be a v3 I could add this too.
Otherwise I would not mind if you do it on top.

>> +        return (IOInstEnding){.cc = 0};
>>      }
>> -
>> -    ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
>> -    switch (ret) {
>> -    /* Currently we don't update control block and just return the cc code. */
>> -    case 0:
>> -        break;
>> -    case -EBUSY:
>> -        break;
>> -    case -ENODEV:
>> -        break;
>> -    case -EACCES:
>> -        /* Let's reflect an inaccessible host device by cc 3. */
>> -        ret = -ENODEV;
>> -        break;
>> -    default:
>> -       /*
>> -        * All other return codes will trigger a program check,
>> -        * or set cc to 1.
>> -        */
>> -       break;
>> -    };
>> -
>> -    return ret;
>> +    return s390_ccw_cmd_request(sch);
>>  }
>>
>>  /*
> [...]
> 
>> @@ -1084,16 +1063,15 @@ int do_subchannel_work_passthrough(SubchDev *sch)
>>          /* TODO: Halt handling */
>>          sch_handle_halt_func(sch);
>>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>> -        ret = sch_handle_start_func_passthrough(sch);
>> +        return sch_handle_start_func_passthrough(sch);
>>      }
>> -
>> -    return ret;
>> +    return (IOInstEnding){.cc = 0};
>>  }
>>
>> -static int do_subchannel_work(SubchDev *sch)
>> +static IOInstEnding do_subchannel_work(SubchDev *sch)
>>  {
>>      if (!sch->do_subchannel_work) {
>> -        return -EINVAL;
>> +        return (IOInstEnding){.cc = 1};
> This keeps the logic here as-is, so it is right.
> 

Yep.

> Anybody agrees that also adding an assert() here?

With automated regression testing in place I'm for it, without
I feel uncomfortable doing it myself. You could do this
on top if you like.

> 
> [...]
> 
>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>> index 8614dda6f8..5d2c305b71 100644
>> --- a/hw/s390x/s390-ccw.c
>> +++ b/hw/s390x/s390-ccw.c
>> @@ -18,15 +18,14 @@
>>  #include "hw/s390x/css-bridge.h"
>>  #include "hw/s390x/s390-ccw.h"
>>
>> -int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
>> +IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
>>  {
>> -    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(data);
>> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
>>
>> -    if (cdc->handle_request) {
>> -        return cdc->handle_request(orb, scsw, data);
>> -    } else {
>> -        return -ENOSYS;
>> +    if (!cdc->handle_request) {
>> +        return (IOInstEnding){.cc = 1};
> Same consideration as the last comment.

Same here.

> 
>>      }
>> +    return cdc->handle_request(sch);
>>  }
>>
>>  static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> 
> [...]
> 

Except for the missing warning are you OK with the rest
of the patch? I would like to re-claim your r-b (dropped
because changes weren't just minor).

Halil
