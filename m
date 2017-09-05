Received: from eggs.gnu.org ([2001:4830:134:3::10]:46682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpHWx-0007Fn-PX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpHWs-00075z-L6
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpHWs-000759-Bd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:20:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85HJpix040429
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 13:20:49 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csyqvsfs3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 13:20:48 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 18:20:46 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 19:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170905174606.1e0c6404.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
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



On 09/05/2017 05:46 PM, Cornelia Huck wrote:
> On Tue, 5 Sep 2017 17:24:19 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> My problem with a program check (indicated by SCSW word 2 bit 10) is
>> that, in my reading of the architecture, the semantic behind it is: The
>> channel subsystem (not the cu or device) has detected, that the 
>> the channel program (previously submitted as an ORB) is erroneous. Which
>> programs are erroneous is specified by the architecture. What we have
>> here does not qualify.
>>
>> My idea was to rather blame the virtual hardware (device) and put no blame
>> on the program nor he channel subsystem. This could be done using device
>> status (unit check with command reject, maybe unit exception) or interface
>> check. My train of thought was, the problem is not consistent across a
>> device type, so it has to be device specific.
> 
> Unit exception might be a better way to express what is happening here.
> At least, it moves us away from cc 1 and not towards cc 3 :)
> 

I will do a follow up patch pursuing device exception.

>>
>> Of course blaming the device could mislead the person encountering the
>> problem, and make him believe it's an non-virtual hardware problem.
>>
>> About the misleading, I think the best we can do is log out a message
>> indicating what really happened.
> 
> Just document it in the code? If it doesn't happen with Linux as a
> guest, it is highly unlikely to be seen in the wild.
> 


Well we have two problems here:
1) Unit exception can be already defined by the device type for the
command (reference: http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar110/2.6.10?DT=19920904110920).
I think this one is what you mean. And I agree that's best handled
with comment in code.
2) The poor user/programmer is trying to figure out why things
don't work (why are we getting the unit exception)? I think that's
best remedied with producing something for the log (maybe a warning
with warn_report which states that the implementation vfio-ccw requires
the given flags).

[..] 
>>>>>> @@ -1115,7 +1112,7 @@ static int do_subchannel_work(SubchDev *sch)
>>>>>>      if (sch->do_subchannel_work) {
>>>>>>          return sch->do_subchannel_work(sch);
>>>>>>      } else {
>>>>>> -        return -EINVAL;
>>>>>> +        return -ENODEV;    
>>>>>
>>>>> This rather seems like a job for an assert? If we don't have a function
>>>>> for the 'asynchronous' handling of the various functions assigned for a
>>>>> subchannel, that looks like an internal error.
>>>>>     
>>>>
>>>> IMHO it depends. Aborting qemu is heavy handed, and as an user I would not
>>>> be happy about it. But certainly it is an assert situation.  We can look for
>>>> an even better solution, but I think this is an improvement. The logic behind
>>>> is that the device is broken and can't be talked to properly.  
>>>
>>> We currently don't have a vast array of subchannel types (and are
>>> unlikely to get more types that need a different handler function). We
>>> know the current ones are fine, and an assert would catch programming
>>> errors early.
>>>   
>>
>> Despite of that we already had a problem of this type: see 1728cff2ab
>> ("s390x/3270: fix instruction interception handler", 2017-06-09) by 
>> Dong Jia. If we had some automated testing covering all the asserts
>> I would not think twice about using an assert here. But I don't think
>> we do and I'm reluctant (not positive that assert is superior to what
>> we have now). Maybe we could agree on reported by again.
> 
> Yes, we (as in generally 'we') are really lacking automated testing...
> (it is somewhere on my todo list).
> 
> Either leave it as-is, or do an assert. -ENODEV just feels wrong.
> 

I think I will leave this one as is and maybe try to discuss with
the folks here about reliable test coverage. Just spoke with Marc H.,
and according to that we have a long way to go.
