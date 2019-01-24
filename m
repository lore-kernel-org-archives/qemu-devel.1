Received: from eggs.gnu.org ([209.51.188.92]:37430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmkUN-0008E4-5N
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmkUL-0006v0-47
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:16:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34368
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gmkUK-0006sM-Uu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:16:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OJDkMx107802
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:16:30 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q7jr4t4pt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:16:30 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 24 Jan 2019 19:16:29 -0000
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
	<20190122134612.40a7745e@oc2783563651>
	<20190122182617.23fab5e9.cohuck@redhat.com>
	<20190122200331.14ff2818@oc2783563651>
	<20190123113447.04354ae4.cohuck@redhat.com>
	<20190123140601.54b2c768@oc2783563651>
	<20190123143429.7a8da112.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 24 Jan 2019 14:16:21 -0500
MIME-Version: 1.0
In-Reply-To: <20190123143429.7a8da112.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b1f0a5f6-51b0-0986-00dd-51bdd79a4779@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 01/23/2019 08:34 AM, Cornelia Huck wrote:
> On Wed, 23 Jan 2019 14:06:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Wed, 23 Jan 2019 11:34:47 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> Yes, one can usually think of interfaces as contracts: both sides need
>> to keep their end for things to work as intended. Unfortunately the
>> vfio-ccw iterface is not a very well specified one, and that makes
>> reasoning about right order so much harder.
> 
> That's probably where our disconnect comes from.
> 
>>
>> I was under the impression that the right ordering is dictated by the
>> SCSW in userspace. E.g. if there is an FC bit set there userspace is not
>> ought to issue a SSCH request (write to the io_region). The kernel part
>> however may say 'userspace read the actual SCSW' by signaling
>> the io_trigger eventfd. Userspace is supposed to read the IRB from the
>> region and update it's SCSW.
>>
>> Now if userspace reads a broken SCSW from the IRB, because of a race
>> (due to poorly written kernel part -- userspace not at fault), it is
>> going to make wrong assumptions about currently legal and illegal
>> operations (ordering).
> 
> My understanding of the interface was that writing to the I/O region
> triggers a ssch (unless rejected with error) and that reading it just
> gets whatever the kernel wrote there the last time it updated its
> internal structures. The eventfd simply triggers to say "the region has
> been updated with an IRB", not to say "userspace, read this".
> 
>>
>> Previously I described a scenario where IRB can break without userspace
>> being at fault (race between unsolicited interrupt -- can happen at any
>> time -- and a legit io request). I was under the impression we agreed on
>> this.
> 
> There is a bug in there (clearing the cp for non-final interrupts), and
> it needs to be fixed. I'm not so sure if the unsolicited interrupt
> thing is a bug (beyond that the internal state machine is confused).
> 
>>
>> This in turn could lead to userspace violating the contract, as perceived
>> by the kernel side.
> 
> Which contract? ;)
> 
> Also, I'm not sure if we'd rather get a deferred cc 1?

As I'm encountering dcc=1 quite regularly lately, it's a nice error. 
But we don't have a good way of recovering from it, and so my test tends 
to go down in a heap quite quickly.  This patch set will probably help; 
I should really get it applied and try it out.

> 
>>
>>> At this point, I'm mostly confused... I'd prefer to simply fix things
>>> as they come up so that we can finally move forward with the halt/clear
>>> handling (and probably rework the state machine on top of that.)

+1 for fixing things as we go.  I hear the complaints about this code 
(and probably say them too), but remain convinced that a large rewrite 
is unnecessary.  Lots of opportunities for improvement, with lots of 
willing and motivated participants, means it can only get better!

>>>    
>>
>> I understand. I guess you will want to send a new version because of the
>> stuff that got lost in the rebase, or?
> 
> Yes, I'll send a new version; but I'll wait for more feedback for a bit.
> 

I'll try to provide some now.  Still digging through the emails marked 
"todo" :)

  - Eric
