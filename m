Received: from eggs.gnu.org ([2001:4830:134:3::10]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkuad-0006IK-D7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkuaa-0000KU-92
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:02:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45582
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkuaZ-0000Jg-Sh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:02:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OFxVPx113551
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:02:32 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2chvsnay9c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:02:32 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 17:02:29 +0100
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
	<ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 18:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bf87a46e-197e-a993-cca7-6d5b5e3752e6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>



On 08/24/2017 05:53 PM, Farhan Ali wrote:
> 
> 
> On 08/24/2017 11:50 AM, Thomas Huth wrote:
>> On 24.08.2017 17:47, Halil Pasic wrote:
>>>
>>>
>>> On 08/24/2017 05:35 PM, Thomas Huth wrote:
>>>> On 24.08.2017 17:13, Cornelia Huck wrote:
>>>>> On Thu, 24 Aug 2017 11:05:08 -0400
>>>>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> There is an issue in QEMU bios which is exposed by commit
>>>>>>
>>>>>> commit 198c0d1f9df8c429502cb744fc26b6ba6e71db74
>>>>>> Author: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>>> Date:   Thu Jul 27 17:48:42 2017 +0200
>>>>>>
>>>>>>      s390x/css: check ccw address validity
>>>>>>
>>>>>>      According to the PoP channel command words (CCW) must be doubleword
>>>>>>      aligned and 31 bit addressable for format 1 and 24 bit addressable for
>>>>>>      format 0 CCWs.
>>>>>>
>>>>>>      If the channel subsystem encounters a ccw address which does not
>>>>>> satisfy
>>>>>>      this alignment requirement a program-check condition is recognised.
>>>>>>
>>>>>>      The situation with 31 bit addressable is a bit more complicated:
>>>>>> both the
>>>>>>      ORB and a format 1 CCW TIC hold the address of (the rest of) the
>>>>>> channel
>>>>>>      program, that is the address of the next CCW in a word, and the PoP
>>>>>>      mandates that bit 0 of that word shall be zero -- or a program-check
>>>>>>      condition is to be recognized -- and does not belong to the field
>>>>>> holding
>>>>>>      the ccw address.
>>>>>>
>>>>>>      Since in code the corresponding fields span across the whole word
>>>>>> (unlike
>>>>>>      in PoP where these are defined as 31 bit wide) we can check this by
>>>>>>      applying a mask. The 24 addressable case isn't affecting TIC
>>>>>> because the
>>>>>>      address is composed of a halfword and a byte portion (no additional
>>>>>> zero
>>>>>>      bit requirements) and just slightly complicates the ORB case where also
>>>>>>      bits 1-7 need to be zero.
>>>>>>
>>>>>>      The same requirements (especially n-bit addressability) apply to the
>>>>>>      ccw addresses generated while chaining.
>>>>>>
>>>>>>      Let's make our CSS implementation follow the AR more closely.
>>>>>>
>>>>>>      Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>>>      Message-Id: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
>>>>>>      Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>>>>>      Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>
>>>>>>
>>>>>> It looks like the bios does not create a double word aligned CCW.
>>>>>> Looking at the bios code we the CCW1 struct is not aligned
>>>>>>
>>>>>> /* channel command word (type 1) */
>>>>>> struct ccw1 {
>>>>>>      __u8 cmd_code;
>>>>>>      __u8 flags;
>>>>>>      __u16 count;
>>>>>>      __u32 cda;
>>>>>> } __attribute__ ((packed));
>>>>>>
>>>>>> and it looks like the compiler does not guarantee a doubleword alignment.
>>>>>
>>>>> :(
>>>>>
>>>>>>
>>>>>> The weird thing about it is I see it break in one of my system and works
>>>>>> fine in another system. Trying a simple fix of aligning the struct also
>>>>>> doesn't seem to work all the time.
>>>>>
>>>>> I have not seen this problem on any of the systems I tested on (well, I
>>>>> would not have merged this if I did...) - RHEL 7 and F26. Do we need a
>>>>> dynamic allocation to guarantee alignment?
>>>>
>>>> I guess the problem is the __attribute__((packed)) here - AFAIK GCC then
>>>> sometimes assumes that these structs can be byte-aligned. Does it work
>>>> if you remove the __attribute__((packed)) here? If yes, I think that
>>>> would be a valid fix, since there should not be any padding in this
>>>> struct at all (and if you're afraid, you could add an
>>>> assert(sizeof(struct ccw1) == 8) somewhere).
>>>
>>> I don't think this packed is doing us any good. But even
>>> with the packed removed I not sure we would end up being
>>> 8 byte aligned (dobuleword). Wouldn't it be just 4 byte
>>> aligned (according to the ELF ABI supplement for s390)
>>> as the most strictly aligned member is __u32?
>>
>> True, so that could still be an issue. Looking at the cio.h in the
>> kernel, they define the struct like this:
>>
>> struct ccw1 {
>>         __u8  cmd_code;
>>         __u8  flags;
>>         __u16 count;
>>         __u32 cda;
>> } __attribute__ ((packed,aligned(8)));
>>
>> So I guess adding the aligned(8) is the right way to go?
>>
>>  Thomas
>>
> 
> This was my initial fix and it works on my system. But for some reason this fix does not work on my colleague's system. So I am hesitant about submitting this fix

That sounds mysterious. Could you debug that with your colleague
and verify that the problem is indeed the alignment? If it
is I would have to re-read the gcc doc because I can't think of
anything else than a bug either in my understanding or in their product.

A stupid question is he testing with the current master?

Halil 
