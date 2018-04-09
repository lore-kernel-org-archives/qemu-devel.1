Received: from eggs.gnu.org ([2001:4830:134:3::10]:53538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f5UBR-0007Sn-5b
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f5UBO-0003Jh-0Y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:37:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f5UBN-0003Hw-NC
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:37:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w39AYFM1021033
	for <qemu-devel@nongnu.org>; Mon, 9 Apr 2018 06:37:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h83ek8erh-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 06:37:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 9 Apr 2018 11:37:48 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
	<20180409113244.380a32c4.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 12:37:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180409113244.380a32c4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1b0c08f8-c98c-c79c-574f-5c75229decf4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, David Hildenbrand <david@redhat.com>, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 04/09/2018 11:32 AM, Cornelia Huck wrote:
>> We can kind of (i.e. modulo EECA.28) ensure this in a different fashion I think. How
>> about proclaiming a 'has ap instructions, but nothing to see here' in the
>> SIE interpreted flavor (ECA.28 set) the default way of having ap instructions
>> under KVM. This should be easily accomplished with an all zero CRYCB and eca.28
>> set. The for the guest to actually get real work done with AP we would
>> still require some sort of driver to either provide a non-zero matrix by
>> altering the CRYCB or unsettling ECA.28 and doing the intercepted flavor.
>>
>> Please notice, the cpu facility ap would still keep it's semantic
>> 'has ap instructions' (opposed to 'has ap instructions implemented in
>> SIE interpreted flavor). And give us all the flexibility.
>>
>> Yet implementing what we want to have in absence of a driver would become
>> much easier (under the assumption that ECA.28 equals EECA.28).
>>
>> How about this?
> Unfortunately, this is really hard to follow without the AR... let me
> summarize it to check whether I got the gist of it :)
> 
> - If the "ap" cpu feature is specified, set a bit that indicates "hey,
>   we basically have have AP support" and create the basics, but don't
>   enable actual SIE handling. This means the guest gets exceptions from
>   the SIE already and we don't need to emulate them.

Kind of. The bit is ECA.28 and tells SIE 'hey SIE shall interpret ap
instructions for the guest (as specified)'. Then SIE has an SD satellite
called CRYCB that contains the which ap resources is the guest authorized
to use. These are the masks. If we set each mask to all zero, we will
effectively accomplish 'hey,we basically have have AP support but no
resources at the moment'. So, right, we don't have to emulate that.

I don't know what do you mean by exceptions. For most legit requests the
SIE should say APQN invalid, with QCI being a notable exception. But
of course SIE would inject program exceptions (access, specification,
and privileged operation) accordingly I guess.


In short, the SIE would do what we are trying to emulate in this patch.

> - Actually enable the missing pieces if a vfio device is created. This
>   would enable processing by the SIE, and we would not need to do
>   emulation, either (for most of it, IIRC).

Yes. It would actually assign resources to the guest. That would enable
doing real work with the AP instructions.

> 
> I may be all wrong, though... can we at least have a translation of
> ECA.28 and EECA.28 (the "ap is there" bit and the "ap instructions are
> interpreted" bit?)
> 

I think we have a misunderstanding here. I will wait for Tony. Maybe
he can understand this better or explain in more accessible way.

Regards,
Halil
