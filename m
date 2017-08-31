Received: from eggs.gnu.org ([2001:4830:134:3::10]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnMZ9-0004cA-GR
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnMZ4-0006uX-Ia
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:19:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33963
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dnMZ4-0006uI-9E
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:19:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VAIsng048290
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:19:09 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cpbh8hmfq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:19:09 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 11:19:07 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-2-pasic@linux.vnet.ibm.com>
	<b5d3ac95-3811-c39a-c4d7-bb85dc4580e8@redhat.com>
	<20170831083859.11694707.cohuck@redhat.com>
	<c8bbd500-c5b6-dd66-1e84-feb80978ee34@redhat.com>
	<20170831104243.43cd8992.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 12:19:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170831104243.43cd8992.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b844bf40-b79c-12ca-d730-bd2278d9a7b3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/31/2017 10:42 AM, Cornelia Huck wrote:
> On Thu, 31 Aug 2017 09:32:49 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 31.08.2017 08:38, Cornelia Huck wrote:
>>> On Thu, 31 Aug 2017 07:51:17 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   
>>>> On 30.08.2017 18:36, Halil Pasic wrote:  
>>>>> The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
>>>>> present cc 1 and the other way around, because css_do_xsch has the error
>>>>> codes mixed up. Fixing the error codes also fixes the priority.
>>>>>
>>>>> Let us fix this.    
>>>>
>>>> (Nit: In case you respin, I'd suggest to remove the last sentence. You
>>>> already used "fix" two times in the previous one)  
>>>
>>> I can also remove it on applying, if Halil agrees (I have not yet
>>> reviewed it, though).
>>>   
>>>>  
>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>> Reported-by: Pierre Morel<pmorel@linux.vnet.ibm.com>    
>>>>
>>>> Space missing -------------^  
>>>
>>> And I can also add that space on applying :)
>>>   
>>>>  
>>>>> ---
>>>>>  hw/s390x/css.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>>> index 1880b1a0ff..a50fb0727e 100644
>>>>> --- a/hw/s390x/css.c
>>>>> +++ b/hw/s390x/css.c
>>>>> @@ -1281,12 +1281,12 @@ int css_do_xsch(SubchDev *sch)
>>>>>          (!(s->ctrl &
>>>>>             (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
>>>>>          (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
>>>>> -        ret = -EINPROGRESS;
>>>>> +        ret = -EBUSY;
>>>>>          goto out;
>>>>>      }
>>>>>  
>>>>>      if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
>>>>> -        ret = -EBUSY;
>>>>> +        ret = -EINPROGRESS;
>>>>>          goto out;
>>>>>      }    
>>>>
>>>> Using both, EBUSY and EINPROGRESS as error codes sounds very confusing
>>>> to me here ... what's the difference between busy and in-progress? So
>>>> while you're at it, maybe you could replace the code for CC 2 ("CANCEL
>>>> SUBCHANNEL not applicable") with a different error code?  
>>>
>>> IIRC, I used these two as they matched my idea of what happens best
>>> (there's a difference between "subchannel is busy" and "the I/O is
>>> already in progress, too late to cancel"). "xsch not applicable" is
>>> very hard to translate to an Unix error code :/  
>>
>> OK, the codes make more sense with your description ==> Maybe simply add
>> a proper comment for each of the return codes?
> 
> Taking a step back and looking at the other I/O instructions and their
> implementation in qemu:
> 
> - For those instructions that can set it, cc 1 is set when the
>   subchannel is status pending. That's usually the "default" branch in
>   ioinst.c.
> - cc 2 is set when the subchannel is "busy" (or, in the case of xsch,
>   "not applicable for xsch"... sigh) This is supposed to be handled via
>   -EBUSY.
> 
> So, there are actually two problems with the current implementation of
> xsch:
> 
> - The return codes are switched around, which this patch fixes.
> - But "status pending" should also take precedence over "not
>   applicable", if I read the PoP correctly, so the second if needs to
>   be moved up.

You are right and I was wrong. "Condition code 1 has precedence over
condition code 2." So it's 3 > 1 > 2 (and I remembered 3 > 2 > 1).

I will fix this for v2.

> 
> And yes, it makes sense do add some comments...
> 

If we apply the series as a whole adding comments would an overkill
IMHO. We will switch this to iret.cc = ? so it should become obvious.
