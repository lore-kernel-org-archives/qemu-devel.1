Received: from eggs.gnu.org ([2001:4830:134:3::10]:39736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eNHXi-00020V-FP
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eNHXf-0005YL-7K
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:14:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eNHXf-0005Xm-1i
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:14:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB8C3qCG049946
	for <qemu-devel@nongnu.org>; Fri, 8 Dec 2017 07:14:07 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eqsputjag-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 07:14:07 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Dec 2017 12:14:06 -0000
References: <20171128134648.21530-1-cohuck@redhat.com>
	<20171205085906.GA3894@lagrange>
	<20171207173418.7c70e5e9.cohuck@redhat.com>
	<786c5a2c-d61e-cfa1-c3b7-f36c69ec3a75@linux.vnet.ibm.com>
	<20171207180650.68cc909e.cohuck@redhat.com>
	<95059339-fac0-ee39-2e68-4ff5bc793893@linux.vnet.ibm.com>
	<20171208124245.53eb5db6.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 13:14:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171208124245.53eb5db6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <888b2af4-46a7-68b2-4d1a-fc66ff0263cb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390x: cut down on unattached
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pmorel@linux.vnet.ibm.com, Bjoern Walk <bwalk@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 12/08/2017 12:42 PM, Cornelia Huck wrote:
[..]
>>>>>> In general, I kind of agree with Halil. Unless somewhere in QEMU it is
>>>>>> documented that the QOM tree is not guaranteed to be stable for
>>>>>> exploiters, I'd consider is part of the API. libvirt does use at least
>>>>>> some hardcoded paths, most of the time for CPUs in /machine/unattached,
>>>>>> so if that relation would change, things break. However, there is also
>>>>>> code to traverse the QOM tree recursively and find a path for a given
>>>>>> type(?) name. If this is the preferred way, we probably should change
>>>>>> this in libvirt to be safe.    
>>>>>
>>>>> OK, with that in mind and as we're now adding a property to check on
>>>>> the css bridge, I vote for including patch 1 now (having a fixed
>>>>> location under /machine looks saner that having to
>>>>> check /machine/unattached/device[<n>], which might not be stable).
>>>>>
>>>>> Patch 2 needs more discussion, as I'm not sure whether what I'm doing
>>>>> is the correct way to go about this (and other machines are in the same
>>>>> situation). Not sure whether it is worth trying to attach the zpci
>>>>> devices somewhere.
>>>>>     
>>>>
>>>> I think, if it's kind of API, then fixing sooner is better than fixing
>>>> later.
>>>>
>>>> I also agree that patch 1 should be higher priority.
>>>>
>>>> Before we do patch 1 I would like having agreed and documented whether
>>>> this is API or not.
>>>>
>>>> If we decide it's an API, I think we should consider deprecating
>>>> the current interface, but keep it working for two releases or
>>>> so. I think nothing speaks against introducing a link form unattached
>>>> in patch 1 (but I have not tried yet).  
>>>
>>> No, just no. That's completely overengineered.
>>>   
>>
>> Which part is totally overengineered? Having it clear what is API and
>> what not? Having this documented? Or caring about our deprecation
>> policy (if it's API)?
>>
> 
> You're building a monster to fix a non-existing problem. I will not go
> down that rabbit hole any further, and just apply patch 1.
> 

I'm not building anything. I've basically just asked a simple question:
Are  paths in the qom composition tree external API or not (and if not,
what is the canonical way to accomplish certain things)? Then I though
out loud about the branches we can take based on the answer.

Based on the answers I got it seems I'm not particularly good at asking
questions. Sorry about that.

Halil
