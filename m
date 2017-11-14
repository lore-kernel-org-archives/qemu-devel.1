Received: from eggs.gnu.org ([2001:4830:134:3::10]:59698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEf92-0001zo-7J
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEf8y-0002DB-A2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:37:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eEf8x-0002BB-U2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:37:04 -0500
Date: Tue, 14 Nov 2017 18:36:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1710270020350.57430@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1711141836210.54166@zero.eik.bme.hu>
References: <20171021124213.84AEC7456EF@zero.eik.bme.hu>
	<alpine.BSF.2.21.1710270020350.57430@zero.eik.bme.hu>
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
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, 27 Oct 2017, BALATON Zoltan wrote:
> On Sat, 21 Oct 2017, BALATON Zoltan wrote:
>> When a section with non-0 offset_within_region field is tested to
>> cover an address the offset should be taken into account as well.
>> 
>> This fixes a crash caused by picking the wrong memory region in
>> address_space_lookup_region seen with client code accessing a device
>> model that uses alias memory regions.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>
> Ping? http://patchwork.ozlabs.org/project/qemu-devel/list/?series=9457

Ping!

>> This seems to fix the problem described in
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03356.html
>> but I'm not completely sure about it. This seems to be introduced in
>> 729633c exec: Introduce AddressSpaceDispatch.mru_section and the patch
>> before that which split off section_covers_addr from phys_page_find so
>> this patch also changes that caller. Is that OK to do? It appears to
>> work but I don't know this part of QEMU.
>> 
>> Also the bug seems to be caused by section_covers_addr accepting
>> sii3112.bar5 when that's the mru_section instead of picking
>> sii3112.bar0 (which it picks when going through phys_page_find) when
>> client code is accessing 0xc08001006 from this address map (full
>> address map is at above URL):
>> 
>> address-space: memory
>>    0000000c08000000-0000000c0800ffff (prio 0, i/o): alias isa_mmio @io 
>> 0000000000000000-000000000000ffff
>> 
>> address-space: I/O
>>  0000000000000000-000000000000ffff (prio 0, i/o): io
>>    0000000000001000-0000000000001007 (prio 1, i/o): alias sii3112.bar0 
>> @sii3112.bar5 0000000000000080-0000000000000087
>>    0000000000001008-000000000000100b (prio 1, i/o): alias sii3112.bar1 
>> @sii3112.bar5 0000000000000088-000000000000008b
>>    0000000000001010-0000000000001017 (prio 1, i/o): alias sii3112.bar2 
>> @sii3112.bar5 00000000000000c0-00000000000000c7
>>    0000000000001018-000000000000101b (prio 1, i/o): alias sii3112.bar3 
>> @sii3112.bar5 00000000000000c8-00000000000000cb
>>    0000000000001020-000000000000102f (prio 1, i/o): alias sii3112.bar4 
>> @sii3112.bar5 0000000000000000-000000000000000f
>> 
>> which this patch fixes but would the same problem happen if the
>> mru_section is bar5 but bar4 is accessed? I could not reproduce that
>> case but then the offset is 0 but in this case the address would be
>> above 0xc08001020 and size is 0xf so they probably won't match. But
>> this is only because of the size of the region. Could that mean the
>> bug is caused by something else and should be fixed elsewhere?
>> 
>> ---
>> exec.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/exec.c b/exec.c
>> index db5ae23..a915817 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -370,7 +370,8 @@ static inline bool section_covers_addr(const 
>> MemoryRegionSection *section,
>>      * the section must cover the entire address space.
>>      */
>>     return int128_gethi(section->size) ||
>> -           range_covers_byte(section->offset_within_address_space,
>> +           range_covers_byte(section->offset_within_address_space +
>> +                             section->offset_within_region,
>>                              int128_getlo(section->size), addr);
>> }
>> 
>> 
>
