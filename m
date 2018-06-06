Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fQZE2-0007e3-L9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fQZDx-0002sE-Jt
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:15:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fQZDx-0002rO-Dj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:15:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56EEhDv043264
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 10:15:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jegywru5e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 10:15:39 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 6 Jun 2018 15:15:38 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 6 Jun 2018 16:15:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180606142131.74ea2eb7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 06/06/2018 14:21, Cornelia Huck wrote:
> On Tue, 5 Jun 2018 17:23:02 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 05/06/2018 15:14, Cornelia Huck wrote:
>>> On Tue, 22 May 2018 17:10:44 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>  =20
>>>> On 22/05/2018 14:52, Cornelia Huck wrote:
>>>>> On Wed, 16 May 2018 15:32:48 +0200
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>     =20
>>>>>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>>>>>> On Fri, 11 May 2018 11:33:35 +0200
>>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>>        =20
>>>>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
...snip...
> Not sure if I parse this correctly... but the architecture says that
> the subchannel has the {start,halt,clear} function set as a result of
> {start,halt,clear} subchannel, doesn't it?
The fc field of the SCSW indicates the functions pending or in progress
resulting of the execution of the instructions START, CLEAR or HALT which
have been accepted by the subchannel.
Up to 2 functions being pending or in progress.
The fc field is only updated when the condition code is set to 0 during=20
the execution
of the instruction.

1) The guest do a SSCH instruction
2) we intercept and QEMU issue the write with SSCH bit set
3) In the driver we are called in write and issue the SSCH instruction
4) the subchannel (the real one) set the start bit in fc field

later
1) The guest do a CSCH instruction
2) we intercept and QEMU issue the write with CSCH bit set
3) In the driver we are called in write and issue the CSCH instruction
4) the subchannel (the real one) set the clear bit in fc and clear the=20
start bit


The subchannel accept to handle functions (start, halt, clear)=20
asynchronously
otherwise it could not accept a CLEAR instruction to stop a previous STAR=
T
instruction.
But the instructions are issued one after the other to the sub-channel.

I think we can only agree on this and that we had at some point a=20
misunderstanding.


>
>>>  =20
>>>> I do not understand the "processing all in one function".
>>>>
>>>> Since yo already have 3 function to process these three instructions.
>>>>
>>>> Do you mean the if .. else if .. else if ?
>>> Yes. There is a lot of common handling for each of these.
>> There are also differences and it breaks the FSM
> Depends on what we will do with the fsm ;)

Yes :)

>
>>>  =20
>>>> Then I come back to what you said earlier on the precedence of the c=
lear
>>>> instruction:
>>>>
>>>> 1) do we have a use case to have more than one bit set in the fctl f=
ield?
>>>>
>>>> - if no, there is no need for precedence
>>> It mirrors what the hardware does: you just set an additional bit if
>>> processing has not yet finished.
>> I do not agree, this is true for the SCSW but not for instructions.
>> We receive instructions in VFIO and give back status.
>> The name used to provide the command is misleading.
> Confused. What we get over the interface is an scsw (the current scsw
> for the subchannel in QEMU). A halt does set an additional bit in the
> fctl if the start is not yet finished.
>
> But that had me re-reading the PoP, and clear is indeed different (it,
> ah, clears the other bits). So, clear handling is different enough from
> the others, and I'm not sure anymore whether it makes sense to handle
> start and halt together. I'll rework this.

OK, it matches with my comprehension.

>
>>>  =20
>>>> - if yes, why should clear have precedence ?
>>> Because it does on the hardware?
>> What you say is right if we would have a register inside the subchanne=
l
>> where we write the commands.
>> But this is not what we handle we handle separate instructions coming
>> from an instruction stream.
>>
>> We do never receive two instructions at the same time, but each after
>> the other.
>> If the sub-channel is busy on IO a clear or a cancel must be able to
>> stop the IO.
>> I agree upon this.
>> But we do not have any other command in the same call.
>>
>> If we would construct the interface differently, for example using an
>> mmap() system
>> call and let the user ORing the command bitfield before using an ioctl
>> to inform
>> us from the change, or if we poll on the command bitfield we should
>> implement
>> it like you say.
>> But this is not what we do, and this is not what the architecture does.
>> does it?
> The thing is that the guest does not interact with this interface at
> all, it is just the backend implementation. The instructions set the
> bits in the scsw fctl field, and we get the scsw from QEMU. By the
> architecture, both start and halt may be set in the fctl at the same
> time. [That this currently does not happen because QEMU is not really
> handling things asynchronously is an implementation detail.]

I do not understand the point of sending a halt and a start to the same
sub-channel at the same time?

If QEMU, once asynchronous, can do this, it could just
halt the start before asking this to the backend. Don't it?

Another point is that the start must have been accepted by the
sub-channel for the start bit in the fc field of the SCSW to be set.

>
>>>  =20
>>>>    =C2=A0 How do QEMU set more than one bit in fctl?
>>>>    =C2=A0 why should we alter the order of the instructions given by=
 the guest?
>>>>    =C2=A0 How can we know this order if there are multiple instructi=
ons at once?
>>> In the future, we should return after we fired off the start etc.
>>> request even if we did not receive an interrupt yet, so that the gues=
t
>>> might do a halt or clear before the start has finished.
>> This is already what is done here:
>> We fire off the start (go to BUSY state) and return
>>
>> If the guest want to start another command it polls on
>> the vfio_write() untill the channel isn't BUSY anymore.
> It's not the guest that polls, but QEMU (resp. another user space
> program). And it should be able to fire a halt etc. even if the start
> function is still active, as the architecture allows that. (I would
> expect the real hardware to give us a busy if applicable anyway.)

I do not find where QEMU is waiting when the sub-channel is busy.
I found a loop on EAGAIN (which is never returned but by the system AFAIU=
)
and I missed the place where a retry is implemented when I followed
the back calls.

>
...snip...
> On re-reading the PoP, the three of them do have some different
> requirements:
>
> - cancel is currently handled completely in QEMU, and it also has quite
>    different semantics as it is not asynchronous etc.
> - halt can be made pending in addition to a start function
> - clear will need to clear anything that's currently going on
>
> I'll need to rethink some of this; probably does not make sense for you
> to try to integrate my patches.
>

Make sense (that it doesn't (make sense)).

Regards,

Pierre



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
