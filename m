Received: from eggs.gnu.org ([2001:4830:134:3::10]:58739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fEFeV-0003WK-FX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fEFeT-0001jB-DQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57084
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fEFeT-0001ik-7W
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:56:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43Eo8Bs098216
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 10:56:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hr47h1eeu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:56:06 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 3 May 2018 08:56:04 -0600
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1808b8f3-9cff-c849-d012-b23f29d1c11f@redhat.com>
	<354ba31f-7502-b873-e254-fe3dbfc07b54@de.ibm.com>
	<20180418094029.14b64108.cohuck@redhat.com>
	<9a0e71af-24cf-9674-e634-fdb3bf180d95@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 10:54:39 -0400
MIME-Version: 1.0
In-Reply-To: <9a0e71af-24cf-9674-e634-fdb3bf180d95@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <cdf8687a-4f75-bfdf-5586-1aa1de42552f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/18/2018 04:59 AM, David Hildenbrand wrote:
> On 18.04.2018 09:40, Cornelia Huck wrote:
>> On Tue, 17 Apr 2018 20:21:31 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 04/16/2018 05:44 PM, David Hildenbrand wrote:
>>>>    
>>>>>   
>>>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>>>> index 0cdbc15..0d5b0f7 100644
>>>>> --- a/target/s390x/gen-features.c
>>>>> +++ b/target/s390x/gen-features.c
>>>>> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
>>>>>       S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>>>>       S390_FEAT_EDAT_2,
>>>>>       S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>>>>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>>>>> +    S390_FEAT_AP_FACILITIES_TEST,
>>>>> +    S390_FEAT_AP,
>>>>>   };
>>>>>     
>>>> Now I have to ask a very stupid question:
>>>>
>>>> I heard that the execution controls in the SIE block for AP are one of
>>>> the oldest ones we have around. How can it be that the AP feature cannot
>>>> be used before zEC12?
>>> It was a suggestion from the crypto team due to testability. Nobody has a z196
>>> with the older cards.
>>>
>> Might be worth adding a note to that respect?
>>
> We used to have the CPU model stick as close as possible to the real CPU
> models.
>
> Support statements should cover in specific products what is expected to
> work and what not.
>
> So is there any real (!support statement / !testability) reason to not
> allow this feature on older CPU models that also had support for it?

This is a business decision based on the following factors:
1. We do not have access to the older cards/systems for testing of the 
older devices.
2. Pre-CEX2 cards are no longer supported in the kernel with others to 
follow.
3. Keep the code base as small as possible and ensure it can be 
adequately tested.
4. Business investment priorities - i.e., $$$$'s.

>
