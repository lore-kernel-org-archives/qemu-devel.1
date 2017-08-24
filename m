Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkuCI-0007b2-D4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkuCE-0001zd-Dj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkuCE-0001yx-4I
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OFaAbk135105
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 11:37:22 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cj0tkunbf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 11:37:22 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 16:37:19 +0100
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 17:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170824171355.29d1ec32.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <16a299e2-4c03-3b64-dfe6-15635b47d0fd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>



On 08/24/2017 05:13 PM, Cornelia Huck wrote:
> On Thu, 24 Aug 2017 11:05:08 -0400
> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
> 
>> Hi,
>>
>> There is an issue in QEMU bios which is exposed by commit
>>
>> commit 198c0d1f9df8c429502cb744fc26b6ba6e71db74
>> Author: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Date:   Thu Jul 27 17:48:42 2017 +0200
>>
>>      s390x/css: check ccw address validity
>>
>>      According to the PoP channel command words (CCW) must be doubleword
>>      aligned and 31 bit addressable for format 1 and 24 bit addressable for
>>      format 0 CCWs.
>>
>>      If the channel subsystem encounters a ccw address which does not 
>> satisfy
>>      this alignment requirement a program-check condition is recognised.
>>
>>      The situation with 31 bit addressable is a bit more complicated: 
>> both the
>>      ORB and a format 1 CCW TIC hold the address of (the rest of) the 
>> channel
>>      program, that is the address of the next CCW in a word, and the PoP
>>      mandates that bit 0 of that word shall be zero -- or a program-check
>>      condition is to be recognized -- and does not belong to the field 
>> holding
>>      the ccw address.
>>
>>      Since in code the corresponding fields span across the whole word 
>> (unlike
>>      in PoP where these are defined as 31 bit wide) we can check this by
>>      applying a mask. The 24 addressable case isn't affecting TIC 
>> because the
>>      address is composed of a halfword and a byte portion (no additional 
>> zero
>>      bit requirements) and just slightly complicates the ORB case where also
>>      bits 1-7 need to be zero.
>>
>>      The same requirements (especially n-bit addressability) apply to the
>>      ccw addresses generated while chaining.
>>
>>      Let's make our CSS implementation follow the AR more closely.
>>
>>      Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>      Message-Id: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
>>      Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>      Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>>
>> It looks like the bios does not create a double word aligned CCW. 
>> Looking at the bios code we the CCW1 struct is not aligned
>>
>> /* channel command word (type 1) */
>> struct ccw1 {
>>      __u8 cmd_code;
>>      __u8 flags;
>>      __u16 count;
>>      __u32 cda;
>> } __attribute__ ((packed));
>>
>> and it looks like the compiler does not guarantee a doubleword alignment.
> 
> :(
> 
>>
>> The weird thing about it is I see it break in one of my system and works 
>> fine in another system. Trying a simple fix of aligning the struct also 
>> doesn't seem to work all the time.
> 
> I have not seen this problem on any of the systems I tested on (well, I
> would not have merged this if I did...) - RHEL 7 and F26.

Same here, otherwise I would have mane it a series and posted a fix
first.

> Do we need a
> dynamic allocation to guarantee alignment?
> 

I think a dynamic allocation is one way to get around the
problem but it should be possible to keep the stuff on the
stack. Telling the compiler about the alignment requirement
should do the trick IMHO.

@Farhan:
Since it's your find you have precedence when it comes to
fixing. Are you willing to submit a fix?

Halil
