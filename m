Received: from eggs.gnu.org ([2001:4830:134:3::10]:60524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dUY0l-0007lq-27
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dUY0h-0002Yq-3k
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:41:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dUY0g-0002YF-PV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:41:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6ACd3iE072772
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:41:53 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bjux75c4h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:41:52 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 10 Jul 2017 08:41:51 -0400
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-6-cohuck@redhat.com>
	<7e4e8d2d-66f6-8884-96a1-83f285171c13@de.ibm.com>
	<20170707150452.1f12890b@dhcp-192-215.str.redhat.com>
	<20170710130429.2ba605a4@dhcp-192-215.str.redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Jul 2017 14:41:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170710130429.2ba605a4@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <8acf64f8-90b4-4ce8-5648-d6b2edc725de@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 5/7] s390x/pci: fence off instructions
 for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/10/2017 01:04 PM, Cornelia Huck wrote:
> On Fri, 7 Jul 2017 15:04:52 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Fri, 7 Jul 2017 14:55:23 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 07/07/2017 02:21 PM, Cornelia Huck wrote:  
>>>> If a guest running on a non-pci build issues a pci instruction,
>>>> throw them an exception.
>>>>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  target/s390x/kvm.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index a3d00196f4..c5c7c27a21 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -1160,6 +1160,9 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
>>>>  {
>>>>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
>>>>
>>>> +#ifndef CONFIG_PCI
>>>> +    return -1;
>>>> +#endif    
>>>
>>> Instead of this ifdefing, can you use the cpu model to decide if the instruction
>>> should be available? We need to do this anyway for proper handling.
>>>
>>> You can then fence off the PCI bits in the CPU model for
>>> CONFIG_PCI == off.  
>>
>> Sounds like a good idea, I'll give it a try.
>>
>> We'll probably also want to fence off the sclp facility bit via that
>> mechanism.
> 
> Slight problem here... we don't have the relevant facilities defined
> yet, and they are not in the POP (other than "Assigned to IBM internal
> use").
> 
> While I'm pretty sure that the magic number is 69 (judging from the
> Linux code), I think they should be introduced in a patch by someone
> who has access to the documentation including the proper names.

I will try to get some patches out for PCI in the next days that will contain
the PCI related facilities.
