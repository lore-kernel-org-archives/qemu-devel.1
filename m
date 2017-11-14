Received: from eggs.gnu.org ([2001:4830:134:3::10]:54376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEkEf-0001Lt-Am
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEkEc-0004Lf-8I
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:03:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eEkEc-0004KY-27
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:03:14 -0500
Date: Wed, 15 Nov 2017 00:03:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <eba4f539-3474-57a2-a44c-6c60f55d90ac@redhat.com>
Message-ID: <alpine.BSF.2.21.1711142359490.42634@zero.eik.bme.hu>
References: <20171021124213.84AEC7456EF@zero.eik.bme.hu>
	<eba4f539-3474-57a2-a44c-6c60f55d90ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] exec: Fix section_covers_addr() for
 sections with non-zero offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 14 Nov 2017, Paolo Bonzini wrote:
> On 21/10/2017 13:24, BALATON Zoltan wrote:
>> diff --git a/exec.c b/exec.c
>> index db5ae23..a915817 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -370,7 +370,8 @@ static inline bool section_covers_addr(const MemoryRegionSection *section,
>>       * the section must cover the entire address space.
>>       */
>>      return int128_gethi(section->size) ||
>> -           range_covers_byte(section->offset_within_address_space,
>> +           range_covers_byte(section->offset_within_address_space +
>> +                             section->offset_within_region,
>>                               int128_getlo(section->size), addr);
>>  }
>
> Sorry, this is incorrect.  addr is an address in the address space, and
> range_covers_byte checks if it is between
> section->offset_within_address_space and
> section->offset_within_address_space + section->size.  I am not sure how
> things don't explode completely by adding section->offset_within_region
> (probably it's just because section->offset_within_region is usually 0).

I had a feeling this might not be correct but appeared to work, very 
likely because in most cases the offset is 0 (which is why the bug wasn't 
happening very often either). How about the alternative I've just sent 
according to your suggestion? That also appears to fix the problem and 
hopefully more correct.

Thank you,
BALATON Zoltan
