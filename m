Received: from eggs.gnu.org ([2001:4830:134:3::10]:36385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4mLv-0006dY-0j
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4mLr-00055k-Mb
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:17:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4mLr-000556-GZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:17:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9IBE65E021163
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:17:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dp1agnwsw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:17:27 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 18 Oct 2017 12:17:26 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
	<0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
	<20171018115219.2dafd05c.cohuck@redhat.com>
	<efc6c522-e359-0f10-2ddc-6a434da4557a@redhat.com>
	<9dd53d1b-9242-d0bc-5e0f-3c0997eb5988@linux.vnet.ibm.com>
	<8bc221e3-3fa5-ce36-0ce2-6c6cef586a32@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 13:17:24 +0200
MIME-Version: 1.0
In-Reply-To: <8bc221e3-3fa5-ce36-0ce2-6c6cef586a32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c57830f0-c7ab-33ef-63a6-eaaef40fa5ca@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/18/2017 01:12 PM, Thomas Huth wrote:
> On 18.10.2017 13:07, Halil Pasic wrote:
>>
>>
>> On 10/18/2017 12:07 PM, Thomas Huth wrote:
>>> On 18.10.2017 11:52, Cornelia Huck wrote:
>>>> On Wed, 18 Oct 2017 11:30:47 +0200
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>>> On 17.10.2017 16:04, Halil Pasic wrote:
>>>>>> Simplify the error handling of the SSCH and RSCH handler avoiding
>>>>>> arbitrary and cryptic error codes being used to tell how the instruction
>>>>>> is supposed to end.  Let the code detecting the condition tell how it's
>>>>>> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
>>>>>> in one go as the emulation of the two shares a lot of code.
>>>>>>
>>>>>> For passthrough this change isn't pure refactoring, but changes the way
>>>>>> kernel reported EFAULT is handled. After clarifying the kernel interface
>>>>>> we decided that EFAULT shall be mapped to unit exception.  Same goes for
>>>>>> unexpected error codes and absence of required ORB flags.
>>>>>>
>>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> [...]
>>>>>> @@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
>>>>>>      }
>>>>>>  }
>>>>>>  
>>>>>> -int css_do_rsch(SubchDev *sch)
>>>>>> +IOInstEnding css_do_rsch(SubchDev *sch)
>>>>>>  {
>>>>>>      SCSW *s = &sch->curr_status.scsw;
>>>>>>      PMCW *p = &sch->curr_status.pmcw;
>>>>>> -    int ret;
>>>>>>  
>>>>>>      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
>>>>>> -        ret = -ENODEV;
>>>>>> -        goto out;
>>>>>> +        return IOINST_CC_NOT_OPERATIONAL;
>>>>>>      }
>>>>>>  
>>>>>>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
>>>>>> -        ret = -EINPROGRESS;
>>>>>> -        goto out;
>>>>>> +        return IOINST_CC_STATUS_PRESENT;
>>>>>>      }
>>>>>>  
>>>>>>      if (((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
>>>>>>          (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
>>>>>>          (!(s->ctrl & SCSW_ACTL_SUSP))) {
>>>>>> -        ret = -EINVAL;
>>>>>> -        goto out;
>>>>>> +        return IOINST_CC_BUSY;  
>>>>>
>>>>> Why is EINVAL now mapped to IOINST_CC_BUSY? Shouldn't that be
>>>>> IOINST_CC_STATUS_PRESENT instead?
>>>>
>>>> No, that is correct (see the PoP for when cc 2 is supposed to be set by
>>>> rsch).
>>>
>>> So if this is on purpose, this change in behavior should also be
>>> mentioned in the patch description, I think.
>>
>> No. have a look at the function ioinst_handle_rsch. It used
>> to map -EINVAL to cc 2 (and was an oddball in this respect) so we
>> keep the old behavior, it's just more obvious whats happening.
> 
> Oh, you're right, I missed that different mapping of the error codes!
> ... so I see, the previous behavior was really confusing and error
> prone, it's really good that you're cleaning this up now!
> 
>  Thomas
> 

Many thanks for the watchful eyes! In the end I did manage to sneak
in a bug (for MSCH). I prefer a lots of false positives that than a
couple of false negatives (for review).

Regards,
Halil
