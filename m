Received: from eggs.gnu.org ([2001:4830:134:3::10]:60494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTUpa-0002Wv-8v
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTUpV-0005f6-BQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTUpV-0005ec-28
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:06:01 -0400
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-2-git-send-email-thuth@redhat.com>
	<67f92ccb-0bb4-7092-46f7-17adfc097800@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e141899c-12d3-9144-d0ed-370dbb108111@redhat.com>
Date: Fri, 7 Jul 2017 17:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <67f92ccb-0bb4-7092-46f7-17adfc097800@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/8] pc-bios/s390-ccw: Move libc
 functions to separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 07.07.2017 15:46, Christian Borntraeger wrote:
> On 07/07/2017 12:26 PM, Thomas Huth wrote:
>> The upcoming netboot code will use the libc from SLOF. To be able
>> to still use s390-ccw.h there, the libc related functions in this
>> header have to be moved to a different location.
>> And while we're at it, remove the duplicate memcpy() function from
>> sclp.c.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> one suggestion below, but 
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> for change and no change
> 
> [...]
>> +static inline void *memcpy(void *s1, const void *s2, size_t n)
>> +{
>> +    uint8_t *p1 = s1;
>> +    const uint8_t *p2 = s2;
>> +
>> +    while (n--) {
>> +        p1[n] = p2[n];
>> +    }
>> +    return s1;
>> +}
> 
> Not that it matters, and no idea if moving forward like in the for loop below
> might allow gcc to generate better code, but a for loop like below will be the 
> same direction as the MVC instruction. Can you double check if this generates
> better code?

At least with my compiler version (old 4.8.1), the code looks pretty
similar. Backward loop:

 1d8:   a7 19 04 d1             lghi    %r1,1233
 1dc:   e3 40 50 00 00 04       lg      %r4,0(%r5)
 1e2:   e3 30 70 00 00 04       lg      %r3,0(%r7)
 1e8:   a7 29 04 d2             lghi    %r2,1234
 1ec:   43 01 30 00             ic      %r0,0(%r1,%r3)
 1f0:   a7 1b ff ff             aghi    %r1,-1
 1f4:   42 01 40 01             stc     %r0,1(%r1,%r4)
 1f8:   a7 27 ff fa             brctg   %r2,1ec <main+0x1ec>

Forward loop:

 238:   a7 19 00 00             lghi    %r1,0
 23c:   e3 40 50 00 00 04       lg      %r4,0(%r5)
 242:   e3 30 70 00 00 04       lg      %r3,0(%r7)
 248:   a7 29 04 d2             lghi    %r2,1234
 24c:   43 01 30 00             ic      %r0,0(%r1,%r3)
 250:   42 01 40 00             stc     %r0,0(%r1,%r4)
 254:   a7 1b 00 01             aghi    %r1,1
 258:   a7 27 ff fa             brctg   %r2,24c <main+0x24c>

But I can switch to the for-loop version in my patch anyway, if you
prefer that.

 Thomas
