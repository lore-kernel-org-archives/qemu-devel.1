Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emLkv-0001dg-48
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emLkr-0006hL-79
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:47:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53450
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emLkr-0006gP-0w
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:47:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FFj9If032820
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:47:22 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5aq1qc12-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:47:22 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 10:47:21 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
	<8259c694-3f9a-ce9e-9d1d-252568f3e73a@redhat.com>
	<ad1e16df-8ebe-5271-b62c-76924c758cbc@linux.vnet.ibm.com>
	<30b25d5a-2525-c34c-a862-7b5bcbbcffe3@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 10:47:19 -0500
MIME-Version: 1.0
In-Reply-To: <30b25d5a-2525-c34c-a862-7b5bcbbcffe3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <90cf5fb5-ea0f-51aa-4d2b-0bef0d3925c5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 02/15/2018 02:04 AM, Thomas Huth wrote:
> On 14.02.2018 16:33, Collin L. Walling wrote:
>> On 02/14/2018 05:57 AM, David Hildenbrand wrote:
> [...]
>>> 1. CKC interrupts can be cleared by resetting the CKC
>>> 2. SCLP interrupts can be cleared only via delivery (apart from CPU
>>> reset)
>>>
>>> So if you have CKC and SCLP pending at the same time, you get the CKC
>>> delivered first and the SCLP remains pending.
>>>
>>> Now, the easiest way to clear that (if you don't know if any is
>>> pending!) is to simply print a string. Then you know that you have
>>> exactly one SCLP interrupt pending.
>>>
>>> So simply printing a string after potentially reading should be
>>> sufficient to clear the SCLP interrupt deterministically :)
>> Perhaps it is due to my lack of understanding of how irqs are queued,
>> but is it
>> possible that we could still end up with service interrupts pending in
>> the SCLP?
>> Specifically if we're still accepting external interrupts from
>> keystrokes but we
>> aren't reading anything from the SCLP.
>>
>> Let's say we have 1 service signal pending and we go to print somethin=
g.
>> This
>> executes the sclp service call instruction and generates a new service
>> signal.
>> The SCLP would consume one of the service interrupts and write to the
>> console.
>> We still have 1 interrupt pending that we need to deal with.
>>
>> That 1 pending interrupt could have been generated at any time we're s=
till
>> listening to activity from the keyboard.
> There is no "queue" or something like this for service interrupts.
> Either one service interrupt is pending, or it is not. Have a look at
> arch/s390/kvm/interrupt.c in the Linux kernel sources and search for th=
e
> functions __deliver_service() and __inject_service() for example.
>
>> In my next update to this patch, I setup the control program receive
>> mask in
>> the SCLP only when we need to get input from the user and then clear t=
he
>> mask
>> when we're done. Doing so will make it so we generate an interrupt fro=
m
>> keystrokes ONLY when the mask is set. No external interrupts from
>> keystrokes
>> will be generated when the cp_receive mask is NOT set.
>>
>> After I clear the cp_receive mask, we consume any leftover interrupts =
by
>> calling consume_sclp_int (I also fixup the patch to make sure we only =
end
>> irq-clearing on a ckc interrupt -- oops).
> Not sure whether you really have to deal with the ckc here again to get
> rid of pending service interrupts... David's idea to simply print out
> something to clear the pending service interrupt sounds easier to me.
>
>   Thomas
>

Ah, I understand the problem now. We can't have a multiple irqs of the=20
*same* *type*
pending at the same time, but we /can/ have multiple irqs of *different*=20
*types* pending
at the same time (i.e. a ckc and service signal).

Thanks for clearing this up for me.=C2=A0 I was over thinking the problem=
 and=20
I agree that
a print would be the easiest solution. :)

--=20
- Collin L Walling
