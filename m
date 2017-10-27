Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86PU-0003gH-4k
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86PQ-00060Q-Vg
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e86PQ-0005zj-PQ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:18:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RFE0L8048063
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:18:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv3t5ccx8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:18:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 16:18:49 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
	<03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
	<108a9258-f245-f0bc-44cd-29f6528d34d4@linux.vnet.ibm.com>
	<277f202a-212b-2868-06e0-62c262909c03@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 17:18:44 +0200
MIME-Version: 1.0
In-Reply-To: <277f202a-212b-2868-06e0-62c262909c03@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a98a959b-dc89-a75b-6479-9d8c2d9666b7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH/QEMU] s390x/kvm: use
 cpu_model_available for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 10/27/2017 04:06 PM, Christian Borntraeger wrote:
> 
> 
> On 10/27/2017 03:40 PM, Halil Pasic wrote:
>>
>>
>> On 10/27/2017 02:57 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 10/27/2017 02:45 PM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 10/27/2017 02:31 PM, Halil Pasic wrote:
>>>> gs is explicitly disabled.
>>>>>
>>>>> Now that I think about it, maybe the 2.9 binary is going to reject
>>>>> the explicit gs flag altogether, because it's unknown.
>>>>>
>>>>> Isn't this a problem? 
>>>>
>>>> No. This is exactly the _solution_ and not the problem. The target will reject
>>>> unknown cpu features and migration will be aborted. This is exactly what the CPU
>>>> model is for.
>>
>> I'm not sure we talk abut the same thing. I'm talking about the following. I
>> want to disable a cpu-model feature for the sake of migration (because I know
>> that binary version X does not support the feature, because it does not know
>> about it). Now if I do it via let's say -cpu z13,gs=off on let's say 2.11,
>> and start with the exact same command line (-cpu z13,gs=off) on lets say 2.9
>> my migration will explode because of the unknown feature I'm specifying
>> not to be used.
> 
> The migration will be rejected because the target qemu will not startup.
> You can easily simulate that, e.g. by doing
> 
> qemu-system-s390x -cpu z13,notyetknown=off
> qemu-system-s390x: can't apply global z13-s390x-cpu.notyetknown=off: Property '.notyetknown' not found
> 
> But libvirt will not use a full model (and the disable things) instead it will
> use the base model and add things. (So libvirt should never use xxx=off)
> 

That piece of the puzzle was missing for me (no xxx=off for M minus M-base
features).

> 
> I think this is really not an issue. If you specify a feature that is not known then
> QEMU will not start on the target and migration is rejected. The guest continues to run
> on the source. So if you specify a "too new" facility yourself its really a user error.
> Everything that uses an explicit model (e.g. -cpu z13 or -cpu,sief2=on) will work, but only
> as long as the conditions are met. If you specify -cpu z14, it does not matter if it fails
> if the kernel or QEMU is too old, or if you just happen to run on a z13.
> 
> The  only question is/was:  what is about "host-model".
> With my patch (+ the gs fixup) the following things will work:
> - host-model will work on z13
> - host-model will work on z14 (any machine version)
> - host model on z13 and then migrating to z14 will work (any machine version)
> - host model on z13 and then migrating to z14 and then migrating back will work (any version)
> - qemu with fixup + host model on z14 with machine version 2.10 can be migrated
> 
> The only thing that does not work is
> - qemu with fixup + host model on z14 with machine 2.9 can not be migrated to qemu 2.9 on z14.
> 


I agree.

> Now: this would have not worked anyway, because qemu 2.9 does not know z14. So in theory 
> QEMU must forbit z14 for compat machines (which we do not know).>

Noted.
 
> I talked to several people and it seems that on x86 the host model will also enable new features
> that are not known by older QEMUs and its considered works as designed. (see also Jiris mail)
> 

Yes, I've seen that. It would be nice though if this design was easier to
find in written. Unfortunately I can read minds only to a very limited extent,
and the written stuff I've read did not give me a full understanding of the
design -- although the entity to blame for this could be my limited intellect. 

> 
>>
>> Well I'm not sure what I describe is relevant. My thinking is along the lines
>> some features are added incrementally. How do use those of the features not included
>> in -base model which both of my environments support and disable those that
>> are unsupported by one of the environments.
>>
>> I will think about it some more. I've asked Boris about this situation,
>> and he did not put my mind at ease (to be more precise he seemed to
>> see this as a potential problem too), so I've decided to mention it.
>> Sorry if I've generated some unnecessary noise.
>>
>> I think the root of the problem is that I don't understand the difference between
>> z13-base and z13, and the associated rules and expected/intended usages. 
> 
> z13-base contains only those features that a guaranteed to be there (there is
> the list of non-hypervisor managed features). z13 is z13-base + all features that
> will be available in a reasonably recent kernel+qemu combination and make sense
> to be there a default. So it might happen that you cannot start -cpu z14, e.g. 
> if you run on a kernel < 4.12.
> 

OK. I will have to learn more about this. IMHO it does not make sense
to burden the community with the holes in my knowledge any more, but I will
have to stuff them to feel comfortable in this area.

Regards,
Halil
