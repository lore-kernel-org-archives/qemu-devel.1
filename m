Received: from eggs.gnu.org ([2001:4830:134:3::10]:36659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVeND-0003uJ-Ko
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVeN9-0002GF-LX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:41:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVeN9-0002De-Bb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:41:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DDdIfr019010
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:41:36 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3s1803-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:41:36 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 14:41:33 +0100
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
	<606fdb06-cb0e-00b3-ffa3-18a024f14309@de.ibm.com>
	<20170713151054.28eb7909@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 15:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170713151054.28eb7909@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d46b68eb-19b0-b9f6-45f5-bc617f0f6335@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/s390-next 3/3] s390x/flic: migrate ais
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 07/13/2017 03:10 PM, Cornelia Huck wrote:
> On Thu, 13 Jul 2017 15:02:08 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 07/13/2017 02:27 PM, Cornelia Huck wrote:
>>> On Thu, 13 Jul 2017 12:40:29 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>   
>>>> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>>
>>>> During migration we should transfer ais states to the target guest.
>>>> This patch introduces a subsection to kvm_s390_flic_vmstate and new
>>>> vmsd for qemu_flic. The ais states need to be migrated only when
>>>> ais is supported.
>>>>
>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  hw/intc/s390_flic.c          | 20 ++++++++++++
>>>>  hw/intc/s390_flic_kvm.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/hw/s390x/s390_flic.h |  1 +
>>>>  3 files changed, 96 insertions(+)
> 
>>>> +static int kvm_flic_ais_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    KVMS390FLICStateMigTmp *tmp = opaque;
>>>> +    KVMS390FLICState *flic = tmp->parent;
>>>> +    struct kvm_s390_ais_all ais = {
>>>> +        .simm = tmp->simm,
>>>> +        .nimm = tmp->nimm,
>>>> +    };
>>>> +    struct kvm_device_attr attr = {
>>>> +        .group = KVM_DEV_FLIC_AISM_ALL,
>>>> +        .addr = (uint64_t)&ais,
>>>> +    };
>>>> +
>>>> +    if (!ais_needed(flic)) {
>>>> +        return -ENOSYS;
>>>> +    }  
>>>
>>> I do not understand this... does that mean that
>>> - we should never get here or 
>>> - we should not try to change the fields or
>>> - I need coffee?  
>>
>> My understanding is that this should not happen with a normal setup, 
>> but it can happen if the user does something "wrong". For example
>> use qemu without libvirt and with -cpu host (which is not migration safe)
>> and do a migration from a host that has AIS to a host that has no AIS.
>> In that case the target system will reject the migration (late, but hopefully
>> not too late).
> 
> A comment would be helpful here.
> 

I was actually pushing for explaining the design decisions regarding these
corner cases (there is the inverse problem too) in the commit message
(during the internal review).

I'm not sure about this "wrong" though. Can one of you provide a
reference why is the scenario described "wrong". This question
decomposes into three: 
1) How do I, as a qemu developer, know what is the management
software supposed to do? (E.g. has to use a cpu model other than
host if it wants to migrate (probably).)
2) What can I assume about the stuff not properly covered in the
user manual when I reason "right" usage and "wrong" usage.
3) Is being 'fool-proof' a design goal, or are we satisfied with
providing mechanisms for using something safely and (like with
undefined behavior in C) don't really care about possible damage
if the user does not stick to these safe mechanisms (which are
documented as such)?

I've looked up the user manual regarding migration. It was not
very helpful regarding the matter of differentiating between
right and wrong usage.

Regards,
Halil
