Received: from eggs.gnu.org ([2001:4830:134:3::10]:50256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMa3r-0003wd-A2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMa3o-0003UB-75
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:48:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eMa3o-0003Tp-0w
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:48:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6Dk4ck095743
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 08:48:24 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eph2cjx67-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 08:48:23 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 6 Dec 2017 13:48:21 -0000
References: <20171206120000.63822-1-borntraeger@de.ibm.com>
	<0b60c788-0470-1fa0-390c-472d75aef0dc@redhat.com>
	<8c5f5393-9191-fdae-e852-196163d42d50@de.ibm.com>
	<48792114-6784-249d-0e5f-3b1f1ace7a75@redhat.com>
	<c040f027-54a5-f7d3-0406-e06fd1064fa6@de.ibm.com>
	<7f54eaa5-4100-ae59-b0fb-8a7faae2749a@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Dec 2017 14:48:16 +0100
MIME-Version: 1.0
In-Reply-To: <7f54eaa5-4100-ae59-b0fb-8a7faae2749a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d0abbfde-a562-6141-edea-d800db9dd707@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC] s390x: split memory into 4TB chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 12/06/2017 02:35 PM, Paolo Bonzini wrote:
> On 06/12/2017 13:15, Christian Borntraeger wrote:
>>> a) bumping up KVM_MEM_MAX_NR_PAGES makes sense.
>> The original limitation comes from the fact that this define is used to limit
>> the number of bits in the dirty bitmap as some architectures do not provide
>> bitops beyond 2^32.
>>
>>> b) as I said, transparently handle it in kvm slot handling code.
>> adding Paolo to check what he thinks.
> 
> It's a bit of a first-world problem, :) 

If a genie comes along and offers you to fufill 3 wishes, as an IT guy
you say: "I want a memory cardridge that is never full".
The genie say "ok, what is your 2nd wish". You say "A 2nd memory cartridge"....


> and working around it in QEMU
> makes is easy enough that it's okay in my opinion.

Since the dirty logging is synched between the qemu memory regions and the 
KVM slots I will look into something like keep the original memslots and create a
new one as soon as we cross the current KVM_MEM_MAX_NR_PAGES size.

> 
> Bumping up KVM_MEM_MAX_NR_PAGES if the bitops allows it should be a good
> idea too, but it requires auditing the code for overflows and truncations.
> 
> Paolo
> 
