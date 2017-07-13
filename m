Received: from eggs.gnu.org ([2001:4830:134:3::10]:53056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVgJ8-0003yV-0l
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVgJ4-0004bf-TD
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:45:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46749
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVgJ4-0004bU-NG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:45:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DFhw9K021353
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 11:45:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bnt3pp5pq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 11:45:33 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 16:45:31 +0100
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
	<1798a9f2-63f0-ab03-11ad-5513d9a90da9@linux.vnet.ibm.com>
	<20170713144941.GD2121@work-vm>
	<99be1408-f8e4-7ecb-f47e-9de94a20ff18@de.ibm.com>
	<20170713151104.GE2121@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 17:45:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170713151104.GE2121@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1a32d619-0b5b-fe11-36b4-94ef6bdcb331@linux.vnet.ibm.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Juan Quintela <quintela@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 07/13/2017 05:11 PM, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> On 07/13/2017 04:49 PM, Dr. David Alan Gilbert wrote:
>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>>>
>>>>
>>>> On 07/13/2017 02:27 PM, Cornelia Huck wrote:
>>>>>> +static void kvm_flic_ais_pre_save(void *opaque)
>>>>>> +{
>>>>>> +    KVMS390FLICStateMigTmp *tmp = opaque;
>>>>>> +    KVMS390FLICState *flic = tmp->parent;
>>>>>> +    struct kvm_s390_ais_all ais;
>>>>>> +    struct kvm_device_attr attr = {
>>>>>> +        .group = KVM_DEV_FLIC_AISM_ALL,
>>>>>> +        .addr = (uint64_t)&ais,
>>>>>> +        .attr = sizeof(ais),
>>>>>> +    };
>>>>>> +
>>>>>> +    if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
>>>>>> +        error_report("Failed to retrieve kvm flic ais states");
>>>>> There's not much else we can do in that case, is there?
>>>>>
>>>>
>>>> I think this is a very good question! The ioctl should not fail
>>>> under any circumstances, but if it does we have a problem.
>>>>
>>>> Carrying on happily (what we do now) means effectively discarding
>>>> ais state. In general just discarding state ain't a good idea.
>>>>
>>>> In particular it might be OK, but the patch should explain that!
>>>>
>>>> Regarding what could/should we do in such a case (instead
>>>> of discarding state and carrying on happily) I don't know, so
>>>> I tend to agree with you regarding 'not much else we can do'.
>>>>
>>>> Adding Dave and Juan. Maybe they can tell.
>>>
>>> I keep meaning to make the pre_save give a return value for failure,
>>> but it hasn't currently got one.
>>
>> Would you accept patches for that?
> 
> Sure.
> 
>>>
>>> You could try something like:
>>>
>>>   qemu_file_set_error(migrate_get_current()->to_dst_file, -EINVAL);

@Dave:
Thanks Dave! I was not aware of that! Had a quick look at the
code, I think qemu_file_set_error would indeed do the right thing.

I would prefer error handling being part of the pre_save interface,
because that would be easier to understand, and would provoke thinking
about these problems.

@Christian:
Would you like to implement 'return value for pre_save'
yourself? I mean, I the meanwhile I'm familiar with the code in question
and I enjoy working with Dave and Juan, so if you aren't interested in
doing it yourself but think it's important enough to get it done, I could
take it too?

@Dave:
There are a couple of questions I'm gonna have to ask/investigate should
it be me doing the 'return value for pre_save' (also notes to myself):

Would you see this error handling via pre_save as a parallel infrastructure
(keep the current qemu_file_set_error mechanism) or would you prefer
things converted? IMHO having a single method would be cleaner, but I
have not looked into this in great detail.

Also the question what is the semantic of qemu_file_set_error arises.
It ain't documented and I would intuitively suspect that it's rather
about the 'file' (that is transport) than the whole migration.



>>>
>>>   I *think* the migration code should spot that before it finishes
>>> but it might carry on for a little while before it does.
>>
>> I will keep this patch as is, since this is one of the "should not happen"
>> cases.

@Christian
I'm OK with it, because knowing the kernel code behind the ioctl
this is really unlikely and even if it should happen the risks involved
are rather limited. But I would be much happier if all such
cases would result in refusing migration.

Regards,
Halil
