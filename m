Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fL8wE-0007Vf-Qe
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fL8w9-0005iM-Ra
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:10:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27615
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fL8w9-0005hY-La
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:10:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4MF9w7M041302
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 11:10:51 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j4kwqecna-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 11:10:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 22 May 2018 16:10:49 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 22 May 2018 17:10:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180522145208.310143ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
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

On 22/05/2018 14:52, Cornelia Huck wrote:
> On Wed, 16 May 2018 15:32:48 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>> On Fri, 11 May 2018 11:33:35 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>  =20
>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_pri=
vate *private,
>>>>>    =20
>>>>>     	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>>>>    =20
>>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>>>> +	/*
>>>>> +	 * Start processing with the clear function, then halt, then star=
t.
>>>>> +	 * We may still be start pending when the caller wants to clean
>>>>> +	 * up things via halt/clear.
>>>>> +	 */
>>>> hum. The scsw here does not reflect the hardware state but the
>>>> command passed from the user interface.
>>>> Can we and should we authorize multiple commands in one call?
>>>>
>>>> If not, the comment is not appropriate and a switch on cmd.fctl
>>>> would be a clearer.
>>> There may be multiple functions specified, but we need to process the=
m
>>> in precedence order (and clear wins over the others, so to speak).
>>> Would adding a sentence like "we always process just one function" he=
lp?
>> Why should we allow multiple commands in a single call ?
>> It brings no added value.
>> Is there a use case?
>> Currently QEMU does not do this and since we only have the SCSH there
>> is no difference having the bit set alone or not alone.
> I found this to be a very easy way to implement halt/clear. This still
> holds true if we switch to some kind of capabilities for this (did not
> have time to look at this further, though).
>
> As we have the fctl field anyway, I'm in favour of processing this all
> in one function.
>

Sorry, I do not understand if we agree or not.

I agree we have the fctl field and we must continue to use it
for backward compatibility.

I do not understand the "processing all in one function".

Since yo already have 3 function to process these three instructions.

Do you mean the if .. else if .. else if ?

Then I come back to what you said earlier on the precedence of the clear=20
instruction:

1) do we have a use case to have more than one bit set in the fctl field?

- if no, there is no need for precedence

- if yes, why should clear have precedence ?
 =C2=A0 How do QEMU set more than one bit in fctl?
 =C2=A0 why should we alter the order of the instructions given by the gu=
est?
 =C2=A0 How can we know this order if there are multiple instructions at =
once?


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
