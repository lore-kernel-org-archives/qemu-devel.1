Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpFiK-00048t-BM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpFiE-0000se-Qj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpFiE-0000rc-HB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:24:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85FNht3008250
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 11:24:25 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csu2wbpmf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:24:25 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 16:24:22 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 17:24:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170905100234.7a92128e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/05/2017 10:02 AM, Cornelia Huck wrote:
> On Thu, 31 Aug 2017 12:41:05 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 08/31/2017 11:19 AM, Cornelia Huck wrote:
>>> On Wed, 30 Aug 2017 18:36:02 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>   
>>>> According to the POP a start subchannel instruction (SSCH) returning with
>>>> cc 1 implies that the subchannel was status pending when SSCH executed.
>>>>
>>>> Due to a somewhat confusing error handling, where error codes are mapped
>>>> to cc value, sane looking error codes result in non AR compliant
>>>> behavior.
>>>>
>>>> Let's fix this! Instead of cc 1 we use cc 3 which means device not
>>>> operational, and is much closer to the truth in the given cases.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>> This patch turned out quite controversial. We did not reach a consensus
>>>> during the internal review.
>>>>
>>>> The most of the discussion revolved around the ORB flag which
>>>> architecturally must be supported, but are currently not supported by
>>>> vfio-ccw (not yet, or can't be). The idea showing the most promise for
>>>> consensus was to handle this via device status (along the lines better a
>>>> strange acting device than a non-conform machine) but since it's a
>>>> radical change we decided to first discuss upstream and then do whatever
>>>> needs to be done.
>>>> ---
>>>>  hw/s390x/css.c      | 15 ++++++---------
>>>>  hw/s390x/s390-ccw.c |  2 +-
>>>>  2 files changed, 7 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>> index a50fb0727e..0822538cde 100644
>>>> --- a/hw/s390x/css.c
>>>> +++ b/hw/s390x/css.c
>>>> @@ -1034,7 +1034,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>>>>       */
>>>>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>>>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>>> -        return -EINVAL;
>>>> +        return -ENODEV;  
>>>
>>> This feels wrong. If we don't support this yet, doing something like a
>>> channel-program check or an operand exception feels closer to the
>>> architecture than indicating a gone device.  
>>
>> I disagree, a channel-program check or an operand exception, or cc 1
>> (current solution) makes the machine obviously non-conform.
> 
> Well, it *is* not compliant...
> 

I'm trying to explain that could be. It is a design decision whether
to put the non-compliant in the machine or in the device attached
to the machine.

>>
>> My train of thought was that architecturally you can loose connection
>> to the device at any time (you can't prohibit admins pulling cables or
>> smashing equipment with a 10kg hammer).
> 
> But that's not what you're doing: Iff you want to signal 'device
> gone' (and I'm not convinced it's a good idea), you need to do more
> than signal cc 3.
> 

Valid (probably), but we already use this kind of gone cc 3 (IMHO).

>>
>> Also from the guest OS perspective I think saying device not operational
>> could provoke a proper reaction form the guest OS: that is just give up
>> on the device. The things you propose would in my opinion put the blame
>> on the guest OS driver (making non-conform requests) so in that case
>> it would make sense to give up on the driver (but the same driver could
>> wonderfully work with let's say a fully emulated device).
> 
> I'd not call that 'putting blame on the driver'. What happens is that
> we signal the driver 'you send us something we cannot deal with' - the
> more common reason for that is that the driver built an invalid
> request, but I've certainly seen rejects for stuff that simply was not
> implemented in the past.

I assume you are talking about a channel-program check or operand exception
now and not about cc 1. IMHO while your argument does make sense, it
contradicts the specified architecture. In my reading the architecture 
defines operand exception and program-check condition as triggered
solely by program (OS) error.

Yes, if one could re-write the architecture, the cleanest way would probably
be capability indication (e.g. can live without prefetching) and channel
program-check if the capability indication is disregarded. But as far as
I know we can't re-write the architecture.

> 
> The important thing is that I don't want to lie to the driver: The
> device is there, and will work with a different request. Also see my
> comment above.

I agree, telling the truth is important. My problem is, that
all the choice we have seems to be picking a lie. And we seem to not
agree, which lie is better.

> 
> (The real fix is of course to implement what is required by the
> architecture :), but I don't think cc 3 is a good stop-gap measure.)
> 
>>
>> As I have stated in the cover letter of this patch, I would find
>> setting device status even better, but I wanted to discuss first
>> before going from setting cc to something else.
>>
>> Setting cc was not my idea in the first place (AFAIK the -EINVAL
>> here effectively triggers cc 1).
> 
> Something else than cc 1 is better, yes (but the intention was probably
> a channel-program check or so).
> 

My problem with a program check (indicated by SCSW word 2 bit 10) is
that, in my reading of the architecture, the semantic behind it is: The
channel subsystem (not the cu or device) has detected, that the 
the channel program (previously submitted as an ORB) is erroneous. Which
programs are erroneous is specified by the architecture. What we have
here does not qualify.

My idea was to rather blame the virtual hardware (device) and put no blame
on the program nor he channel subsystem. This could be done using device
status (unit check with command reject, maybe unit exception) or interface
check. My train of thought was, the problem is not consistent across a
device type, so it has to be device specific.

Of course blaming the device could mislead the person encountering the
problem, and make him believe it's an non-virtual hardware problem.

About the misleading, I think the best we can do is log out a message
indicating what really happened.

In the end I don't care that deeply about vfio-ccw, and this problem
already took me more time than I intended to spend on this. We have
people driving this whole vfio-ccw stuff and I'm not one of them (I'm
rather in the supporting role).

I'm also fine with me being credited with a reported-by once the
more involved people figure out what to do, and keeping the vfio-ccw
stuff as is. Should we go with that option? 

>>
>>>   
>>>>      }
>>>>  
>>>>      ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
>>>> @@ -1046,16 +1046,13 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>>>>          break;
>>>>      case -ENODEV:
>>>>          break;
>>>> +    case -EFAULT:
>>>> +         break;
>>>>      case -EACCES:
>>>>          /* Let's reflect an inaccessible host device by cc 3. */
>>>> -        ret = -ENODEV;
>>>> -        break;
>>>>      default:
>>>> -       /*
>>>> -        * All other return codes will trigger a program check,
>>>> -        * or set cc to 1.
>>>> -        */
>>>> -       break;
>>>> +        /* Let's make all other return codes map to cc 3.  */
>>>> +        ret = -ENODEV;  
>>>
>>> Why? This feels wrong. For those cases where we want to signal an error
>>> but cc 1 is conceptually wrong, either an operand exception (for very
>>> few cases) or a channel-program check feels more in line with the
>>> architecture.  
>>
>> You mean the original code feels wrong, or? I keep the program check for
>> -EFAULT (that's why it's added) and just change cc 1 to cc 3 for the
>> not explicitly handled error codes (reason stated in the commit message).
> 
> I mean that both feel wrong :) Moving away from abuses of cc 1 makes
> sense, but I don't think cc 3 is the correct direction.
> 

Noted. Discussed above.

>>
>>>
>>> That's a general problem with doing stuff in the hypervisor: We have
>>> sets of internal problems that obviously don't show up in the
>>> architecture, and we can either handle them internally or use what the
>>> architecture offers for problem signaling. z/VM has probably faced the
>>> same problems :)  
>>
>> I agree.
>>
>>>   
>>>>      };
>>>>  
>>>>      return ret;
>>>> @@ -1115,7 +1112,7 @@ static int do_subchannel_work(SubchDev *sch)
>>>>      if (sch->do_subchannel_work) {
>>>>          return sch->do_subchannel_work(sch);
>>>>      } else {
>>>> -        return -EINVAL;
>>>> +        return -ENODEV;  
>>>
>>> This rather seems like a job for an assert? If we don't have a function
>>> for the 'asynchronous' handling of the various functions assigned for a
>>> subchannel, that looks like an internal error.
>>>   
>>
>> IMHO it depends. Aborting qemu is heavy handed, and as an user I would not
>> be happy about it. But certainly it is an assert situation.  We can look for
>> an even better solution, but I think this is an improvement. The logic behind
>> is that the device is broken and can't be talked to properly.
> 
> We currently don't have a vast array of subchannel types (and are
> unlikely to get more types that need a different handler function). We
> know the current ones are fine, and an assert would catch programming
> errors early.
> 

Despite of that we already had a problem of this type: see 1728cff2ab
("s390x/3270: fix instruction interception handler", 2017-06-09) by 
Dong Jia. If we had some automated testing covering all the asserts
I would not think twice about using an assert here. But I don't think
we do and I'm reluctant (not positive that assert is superior to what
we have now). Maybe we could agree on reported by again.

>>
>>>>      }
>>>>  }
>>>>  
>>>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>>>> index 8614dda6f8..2b0741741c 100644
>>>> --- a/hw/s390x/s390-ccw.c
>>>> +++ b/hw/s390x/s390-ccw.c
>>>> @@ -25,7 +25,7 @@ int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
>>>>      if (cdc->handle_request) {
>>>>          return cdc->handle_request(orb, scsw, data);
>>>>      } else {
>>>> -        return -ENOSYS;
>>>> +        return -ENODEV;  
>>>
>>> If we get here, it means that we called a request handler (which is
>>> only done for the passthrough variety) without having assigned a
>>> request handler beforehand. This also looks like an internal error to
>>> me...
>>>   
>>
>> Certainly. Again I was not the one who wrote or accepted the original
>> code. My previous comment about whether assert or not applies here as
>> well.
> 
> My answer applies even more here :)
> 

This is again vfio-ccw.

I've just noticed that I did not answer to your comments
for patch 4. Sorry, I was waiting for more feedback on patches 4-9,
but it turns out the ball is in my court. I will do that right away.

Regards,
Halil
