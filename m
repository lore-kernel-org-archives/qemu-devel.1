Received: from eggs.gnu.org ([2001:4830:134:3::10]:53009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMZCM-00035W-2Y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMZCG-0007cm-L2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:53:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eMZCG-0007cA-C4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:53:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6Cqemu129169
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:53:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epg59axa5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:53:06 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 6 Dec 2017 12:53:03 -0000
References: <20171206120000.63822-1-borntraeger@de.ibm.com>
	<0b60c788-0470-1fa0-390c-472d75aef0dc@redhat.com>
	<8c5f5393-9191-fdae-e852-196163d42d50@de.ibm.com>
	<48792114-6784-249d-0e5f-3b1f1ace7a75@redhat.com>
	<c040f027-54a5-f7d3-0406-e06fd1064fa6@de.ibm.com>
	<f671ca94-c63a-8d68-72d4-7f5c518b3960@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Dec 2017 13:52:59 +0100
MIME-Version: 1.0
In-Reply-To: <f671ca94-c63a-8d68-72d4-7f5c518b3960@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c9ddf45d-ee8e-9272-d987-64df71b5c4b2@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC] s390x: split memory into 4TB chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>



On 12/06/2017 01:19 PM, David Hildenbrand wrote:
> 
>>>>> This will most certainly break migration, no?
>>>>
>>>> Probably yes. Thats why the patch has RFC. I was looking for ideas.
>>>
>>> As other architectures might also run into this problem, wonder if
>>>
>>> a) bumping up KVM_MEM_MAX_NR_PAGES makes sense.
>>
>> The original limitation comes from the fact that this define is used to limit
>> the number of bits in the dirty bitmap as some architectures do not provide
>> bitops beyond 2^32.
> 
> Then my question would be if we can bump it up for all architectures
> that support it.
> 
>>
>>> b) as I said, transparently handle it in kvm slot handling code.
>>
>> adding Paolo to check what he thinks.

Another quick variant would be to keep the name of the first memslot as 
is (to be compatible) and start a new one just after the maximum size of.
After all migration will fail anyway for larger guests.

>>>
>>>>>
>>>>> 1. I remember the name being used for migration, I might be wrong.
>>>>> 2. Migration of guests > 4TB is certainly broken ;)
>>>>>
>>>>> I wonder if this should rather be handled in the kvm_slot code.
>>>>> (silently create an manage two slots)
>>>>
>>>
>>>
>>
> 
> 
