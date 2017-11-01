Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9yUc-0006rb-OK
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9yUX-0000CJ-LZ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:16:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59480
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e9yUX-00009D-Es
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:15:57 -0400
References: <ea7e7a76-09ac-b8b2-a480-6c7d341c6881@ilande.co.uk>
	<a2183a93-e00a-3900-4be6-0c34644cfaf2@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ebe4884a-4a35-724e-729a-4e3693f7b76c@ilande.co.uk>
Date: Wed, 1 Nov 2017 19:15:39 +0000
MIME-Version: 1.0
In-Reply-To: <a2183a93-e00a-3900-4be6-0c34644cfaf2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] How to implement different endian accesses per MMU
 page?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 15/08/17 19:10, Richard Henderson wrote:

> [CC Peter re MemTxAttrs below]
> 
> On 08/15/2017 09:38 AM, Mark Cave-Ayland wrote:
>> Working through an incorrect endian issue on qemu-system-sparc64, it has
>> become apparent that at least one OS makes use of the IE (Invert Endian)
>> bit in the SPARCv9 MMU TTE to map PCI memory space without the
>> programmer having to manually endian-swap accesses.
>>
>> In other words, to quote the UltraSPARC specification: "if this bit is
>> set, accesses to the associated page are processed with inverse
>> endianness from what is specified by the instruction (big-for-little and
>> little-for-big)".
>>
>> Looking through various bits of code, I'm trying to get a feel for the
>> best way to implement this in an efficient manner. From what I can see
>> this could be solved using an additional MMU index, however I'm not
>> overly familiar with the memory and softmmu subsystems.
> 
> No, it can't be solved with an MMU index.
> 
>> Can anyone point me in the right direction as to what would be the best
>> way to implement this feature within QEMU?
> 
> It's definitely tricky.
> 
> We definitely need some TLB_FLAGS_MASK bit set so that we're forced through the
> memory slow path.  There is no other way to bypass the endianness that we've
> already encoded from the target instruction.
> 
> Given the tlb_set_page_with_attrs interface, I would think that we need a new
> bit in MemTxAttrs, so that the target/sparc tlb_fill (and subroutines) can pass
> along the TTE bit for the given page.
> 
> We have an existing problem in softmmu_template.h,
> 
>     /* ??? Note that the io helpers always read data in the target
>        byte ordering.  We should push the LE/BE request down into io.  */
>     res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
>     res = TGT_BE(res);
> 
> We do not want to add a third(!) byte swap along the i/o path.  We need to
> collapse the two that we have already before considering this one.
> 
> This probably takes the form of:
> 
> (1) Replacing the "int size" argument with "TCGMemOp memop" for
>       a) io_{read,write}x in accel/tcg/cputlb.c,
>       b) memory_region_dispatch_{read,write} in memory.c,
>       c) adjust_endianness in memory.c.
>     This carries size+sign+endianness down to the next level.
> 
> (2) In memory.c, adjust_endianness,
> 
>      if (memory_region_wrong_endianness(mr)) {
> -        switch (size) {
> +        memop ^= MO_BSWAP;
> +    }
> +    if (memop & MO_BSWAP) {
> 
>     For extra credit, re-arrange memory_region_wrong_endianness
>     to something more explicit -- "wrong" isn't helpful.

Finally I've had a bit of spare time to experiment with this approach,
and from what I can see there are currently 2 issues:


1) Using TCGMemOp in memory.c means it is no longer accelerator agnostic

For the moment I've defined a separate MemOp in memory.h and provided a
mapping function in io_{read,write}x to map from TCGMemOp to MemOp and
then pass that into memory_region_dispatch_{read,write}.

Other than not referencing TCGMemOp in the memory API, another reason
for doing this was that I wasn't convinced that all the MO_ attributes
were valid outside of TCG. I do, of course, strongly defer to other
people's knowledge in this area though.


2) The above changes to adjust_endianness() fail when
memory_region_dispatch_{read,write} are called recursively

Whilst booting qemu-system-sparc64 I see that
memory_region_dispatch_{read,write} get called recursively - once via
io_{read,write}x and then again via flatview_read_continue() in exec.c.

The net effect of this is that we perform the bswap correctly at the
tail of the recursion, but then as we travel back up the stack we hit
memory_region_dispatch_{read,write} once again causing a second bswap
which means the value is returned with the incorrect endian again.


My understanding from your softmmu_template.h comment above is that the
memory API should do the endian swapping internally allowing the removal
of the final TGT_BE/TGT_LE applied to the result, or did I get this wrong?

> (3) In tlb_set_page_with_attrs, notice attrs.byte_swap and set
>     a new TLB_FORCE_SLOW bit within TLB_FLAGS_MASK.
> 
> (4) In io_{read,write}x, if iotlbentry->attrs.byte_swap is set,
>     then memop ^= MO_BSWAP.


ATB,

Mark.
