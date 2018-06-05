Received: from eggs.gnu.org ([2001:4830:134:3::10]:37615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fQDnq-00057Y-1z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fQDnl-00009F-El
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:23:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fQDnl-00006M-91
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:23:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w55FJM8p008622
	for <qemu-devel@nongnu.org>; Tue, 5 Jun 2018 11:23:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jdv4qu4fd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 11:23:10 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 5 Jun 2018 16:23:08 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Jun 2018 17:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180605151449.22aafbfc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
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

On 05/06/2018 15:14, Cornelia Huck wrote:
> On Tue, 22 May 2018 17:10:44 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 22/05/2018 14:52, Cornelia Huck wrote:
>>> On Wed, 16 May 2018 15:32:48 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>  =20
>>>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>>>> On Fri, 11 May 2018 11:33:35 +0200
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>     =20
>>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>>>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_p=
rivate *private,
>>>>>>>     =20
>>>>>>>      	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>>>>>>     =20
>>>>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>>>>>> +	/*
>>>>>>> +	 * Start processing with the clear function, then halt, then st=
art.
>>>>>>> +	 * We may still be start pending when the caller wants to clean
>>>>>>> +	 * up things via halt/clear.
>>>>>>> +	 */
>>>>>> hum. The scsw here does not reflect the hardware state but the
>>>>>> command passed from the user interface.
>>>>>> Can we and should we authorize multiple commands in one call?
>>>>>>
>>>>>> If not, the comment is not appropriate and a switch on cmd.fctl
>>>>>> would be a clearer.
>>>>> There may be multiple functions specified, but we need to process t=
hem
>>>>> in precedence order (and clear wins over the others, so to speak).
>>>>> Would adding a sentence like "we always process just one function" =
help?
>>>> Why should we allow multiple commands in a single call ?
>>>> It brings no added value.
>>>> Is there a use case?
>>>> Currently QEMU does not do this and since we only have the SCSH ther=
e
>>>> is no difference having the bit set alone or not alone.
>>> I found this to be a very easy way to implement halt/clear. This stil=
l
>>> holds true if we switch to some kind of capabilities for this (did no=
t
>>> have time to look at this further, though).
>>>
>>> As we have the fctl field anyway, I'm in favour of processing this al=
l
>>> in one function.
>>>  =20
> [starting to look at this again]
>
>> Sorry, I do not understand if we agree or not.
>>
>> I agree we have the fctl field and we must continue to use it
>> for backward compatibility.
> It also mirrors the hardware, no?

No, in the hardware this is the result of the instruction in the SCSW.
Not the instruction itself.

>
>> I do not understand the "processing all in one function".
>>
>> Since yo already have 3 function to process these three instructions.
>>
>> Do you mean the if .. else if .. else if ?
> Yes. There is a lot of common handling for each of these.

There are also differences and it breaks the FSM

>
>> Then I come back to what you said earlier on the precedence of the cle=
ar
>> instruction:
>>
>> 1) do we have a use case to have more than one bit set in the fctl fie=
ld?
>>
>> - if no, there is no need for precedence
> It mirrors what the hardware does: you just set an additional bit if
> processing has not yet finished.

I do not agree, this is true for the SCSW but not for instructions.
We receive instructions in VFIO and give back status.
The name used to provide the command is misleading.

>
>> - if yes, why should clear have precedence ?
> Because it does on the hardware?

What you say is right if we would have a register inside the subchannel
where we write the commands.
But this is not what we handle we handle separate instructions coming
from an instruction stream.

We do never receive two instructions at the same time, but each after
the other.
If the sub-channel is busy on IO a clear or a cancel must be able to=20
stop the IO.
I agree upon this.
But we do not have any other command in the same call.

If we would construct the interface differently, for example using an=20
mmap() system
call and let the user ORing the command bitfield before using an ioctl=20
to inform
us from the change, or if we poll on the command bitfield we should=20
implement
it like you say.
But this is not what we do, and this is not what the architecture does.
does it?

>
>>   =C2=A0 How do QEMU set more than one bit in fctl?
>>   =C2=A0 why should we alter the order of the instructions given by th=
e guest?
>>   =C2=A0 How can we know this order if there are multiple instructions=
 at once?
> In the future, we should return after we fired off the start etc.
> request even if we did not receive an interrupt yet, so that the guest
> might do a halt or clear before the start has finished.

This is already what is done here:
We fire off the start (go to BUSY state) and return

If the guest want to start another command it polls on
the vfio_write() untill the channel isn't BUSY anymore.

On interrupt we set the channel back to IDLE and the next
command shall be proceed.

(I must enhance the cover letter (already said))

>   IOW, make this
> as asynchronous as the hardware. That's why I'd like to simply
> accumulate the things. The architecture already specified what happens
> in the response.
>
> Do you think that is feasible?
>
Yes I think it is feasible and it is what we need to do.

CLEAR, CANCEL and HALT must be able to overtake the
START and really stop the IO transfer.

They just should be able to proceed in the BUSY state
on the opposite of the START.
This is easily done with new events in the FSM inside
both IDLE and BUSY states

May be I should try to integrate your patches so we have a better view.

Thanks.

Best regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
