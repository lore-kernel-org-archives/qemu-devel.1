Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkuPK-0000Mo-9F
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkuPH-0000hQ-4s
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkuPG-0000gu-S4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:50:55 -0400
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
Date: Thu, 24 Aug 2017 17:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

On 24.08.2017 17:47, Halil Pasic wrote:
> 
> 
> On 08/24/2017 05:35 PM, Thomas Huth wrote:
>> On 24.08.2017 17:13, Cornelia Huck wrote:
>>> On Thu, 24 Aug 2017 11:05:08 -0400
>>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> There is an issue in QEMU bios which is exposed by commit
>>>>
>>>> commit 198c0d1f9df8c429502cb744fc26b6ba6e71db74
>>>> Author: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Date:   Thu Jul 27 17:48:42 2017 +0200
>>>>
>>>>      s390x/css: check ccw address validity
>>>>
>>>>      According to the PoP channel command words (CCW) must be doubleword
>>>>      aligned and 31 bit addressable for format 1 and 24 bit addressable for
>>>>      format 0 CCWs.
>>>>
>>>>      If the channel subsystem encounters a ccw address which does not 
>>>> satisfy
>>>>      this alignment requirement a program-check condition is recognised.
>>>>
>>>>      The situation with 31 bit addressable is a bit more complicated: 
>>>> both the
>>>>      ORB and a format 1 CCW TIC hold the address of (the rest of) the 
>>>> channel
>>>>      program, that is the address of the next CCW in a word, and the PoP
>>>>      mandates that bit 0 of that word shall be zero -- or a program-check
>>>>      condition is to be recognized -- and does not belong to the field 
>>>> holding
>>>>      the ccw address.
>>>>
>>>>      Since in code the corresponding fields span across the whole word 
>>>> (unlike
>>>>      in PoP where these are defined as 31 bit wide) we can check this by
>>>>      applying a mask. The 24 addressable case isn't affecting TIC 
>>>> because the
>>>>      address is composed of a halfword and a byte portion (no additional 
>>>> zero
>>>>      bit requirements) and just slightly complicates the ORB case where also
>>>>      bits 1-7 need to be zero.
>>>>
>>>>      The same requirements (especially n-bit addressability) apply to the
>>>>      ccw addresses generated while chaining.
>>>>
>>>>      Let's make our CSS implementation follow the AR more closely.
>>>>
>>>>      Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>      Message-Id: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
>>>>      Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>>>      Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>
>>>>
>>>> It looks like the bios does not create a double word aligned CCW. 
>>>> Looking at the bios code we the CCW1 struct is not aligned
>>>>
>>>> /* channel command word (type 1) */
>>>> struct ccw1 {
>>>>      __u8 cmd_code;
>>>>      __u8 flags;
>>>>      __u16 count;
>>>>      __u32 cda;
>>>> } __attribute__ ((packed));
>>>>
>>>> and it looks like the compiler does not guarantee a doubleword alignment.
>>>
>>> :(
>>>
>>>>
>>>> The weird thing about it is I see it break in one of my system and works 
>>>> fine in another system. Trying a simple fix of aligning the struct also 
>>>> doesn't seem to work all the time.
>>>
>>> I have not seen this problem on any of the systems I tested on (well, I
>>> would not have merged this if I did...) - RHEL 7 and F26. Do we need a
>>> dynamic allocation to guarantee alignment?
>>
>> I guess the problem is the __attribute__((packed)) here - AFAIK GCC then
>> sometimes assumes that these structs can be byte-aligned. Does it work
>> if you remove the __attribute__((packed)) here? If yes, I think that
>> would be a valid fix, since there should not be any padding in this
>> struct at all (and if you're afraid, you could add an
>> assert(sizeof(struct ccw1) == 8) somewhere).
> 
> I don't think this packed is doing us any good. But even
> with the packed removed I not sure we would end up being
> 8 byte aligned (dobuleword). Wouldn't it be just 4 byte
> aligned (according to the ELF ABI supplement for s390)
> as the most strictly aligned member is __u32?

True, so that could still be an issue. Looking at the cio.h in the
kernel, they define the struct like this:

struct ccw1 {
        __u8  cmd_code;
        __u8  flags;
        __u16 count;
        __u32 cda;
} __attribute__ ((packed,aligned(8)));

So I guess adding the aligned(8) is the right way to go?

 Thomas
