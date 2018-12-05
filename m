Received: from eggs.gnu.org ([2001:4830:134:3::10]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUYdW-0004MJ-W3
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUYdT-0006XX-Mf
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:58:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57428
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gUYdT-0006X5-D9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:58:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5EuXD9047591
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 09:58:46 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6gvgg3f0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 09:58:46 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 5 Dec 2018 14:58:45 -0000
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<a49bf8e8-d5dc-5687-de65-5f4c77edd53d@redhat.com>
	<c5130ab3-a539-fa1b-37cc-3db3904b3053@de.ibm.com>
	<20181205125429.5134adfd.cohuck@redhat.com>
	<f4c47bf9-0294-eb8c-e5a6-1c73fa3bff87@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 5 Dec 2018 09:58:37 -0500
MIME-Version: 1.0
In-Reply-To: <f4c47bf9-0294-eb8c-e5a6-1c73fa3bff87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7c72c6ea-e9f3-22e0-6035-b0c6914ddd57@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390: guest support for
 diagnose 318 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: cotte@de.ibm.com, qemu-devel@nongnu.org, thuth@redhat.com, qemu-s390x@nongnu.org, cornelia.huck@de.ibm.com, mimu@linux.ibm.com

On 12/5/18 6:57 AM, David Hildenbrand wrote:
> On 05.12.18 12:54, Cornelia Huck wrote:
>> On Wed, 5 Dec 2018 09:27:44 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 05.12.2018 09:26, David Hildenbrand wrote:
>>>> On 04.12.18 23:18, Collin Walling wrote:  
>>>>> Add migration and reset support for diagnose 318. This is a new z14 GA2 
>>>>> hardware feature, but we can provide guest support starting with the 
>>>>> zEC12-full CPU model.
>>>>>
>>>>> Because new hardware introduces a new facility-availability byte in 
>>>>> the Read SCP Info block, we lose one byte in the CPU entries list 
>>>>> and must limit the maximum VCPUs to 247 (down from 248).  
>>>>
>>>> This could break setups that upgrade/migrate. At least forward migration
>>>> can be broken. Do we care about that?  
>>>
>>> Can we maybe bind this feature and the cpu limit to the 4.0 machine?
>>
>> I think that would make sense.
> 
> Won't be that easy, as we'll have different sizes of the struct size.
> Something that might uglify the code quite a bit.
> 
> Also we'll get a dependence between the cpu model features (e.g. probed
> via the NULL machine) and the compat machine. Have to think about this.
> 

Are you referring to the struct CPUS390XState? Could we get away by adding
a one-byte "unused" field after the bitmap?

>>
>>>>
>>>> Can you split off
>>>>
>>>> 1. linux-header changes
>>>> 2. CPU model changes? (introduction and definition of new feature, but
>>>> not when it is used?)
>>>>   
>>>>>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>> ---
> 
> 

I'll split the patches into:

1) linux-header changes
2) CPU model changes
3) diag318 usages / migration

-- 
Respectfully,
- Collin Walling
