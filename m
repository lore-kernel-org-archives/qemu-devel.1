Received: from eggs.gnu.org ([2001:4830:134:3::10]:50310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZzX4-0003EK-6h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZzX1-0005Yv-05
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:10:22 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZzX0-0005Ye-Na
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:10:18 -0400
Received: by mail-pf0-x243.google.com with SMTP id e10-v6so1010580pfn.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:10:18 -0700 (PDT)
References: <20180629213703.13833-1-richard.henderson@linaro.org>
	<CAFEAcA8La4xrHxJpRGnmO1uDj34-igu1A+O6AJNyf=6L3FG8Mg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43e1fe6e-ef6d-070e-9852-f7f85b993a43@linaro.org>
Date: Mon, 2 Jul 2018 07:10:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8La4xrHxJpRGnmO1uDj34-igu1A+O6AJNyf=6L3FG8Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Avoid caching overwritten tlb
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On 07/02/2018 03:37 AM, Peter Maydell wrote:
> On 29 June 2018 at 22:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> When installing a TLB entry, remove any cached version of the
>> same page in the VTLB.  If the existing TLB entry matches, do
>> not copy into the VTLB, but overwrite it.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> This may fix some problems with Q800 that Laurent reported.
>>
>> On IRC, Peter suggested that regardless of the m68k ptest insn, we
>> need to be more careful with installed TLB entries.
>>
>> I added some temporary logging and concur.  This sort of overwrite
>> happens often when writable pages are marked read-only in order to
>> track a dirty bit.  After the dirty bit is set, we re-install the
>> TLB entry as read-write.
>>
>> I'm mildly surprised we haven't run into problems before...
>>
>>
>> r~
>>
>> ---
>>  accel/tcg/cputlb.c | 60 +++++++++++++++++++++++++---------------------
>>  1 file changed, 33 insertions(+), 27 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index cc90a5fe92..250b024c5d 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -235,17 +235,30 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>>      async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
>>  }
>>
>> -
>> -
>> -static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
>> +static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
>> +                                        target_ulong page)
>>  {
>> -    if (tlb_hit_page(tlb_entry->addr_read, addr) ||
>> -        tlb_hit_page(tlb_entry->addr_write, addr) ||
>> -        tlb_hit_page(tlb_entry->addr_code, addr)) {
>> +    return (tlb_hit_page(tlb_entry->addr_read, page) ||
>> +            tlb_hit_page(tlb_entry->addr_write, page) ||
>> +            tlb_hit_page(tlb_entry->addr_code, page));
> 
> Checkpatch warns that the outer brackets here are not required.

Yeah, well, emacs requires them for alignment.
Checkpatch isn't too smart about multi-line expressions.

> 
> 
>> +    /* If the old entry matches the new page, just overwrite TE.  */
>> +    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
> 
> I found it slightly confusing that the sense of the "if" in
> the comment is backwards from the "if" in the code.
> Maybe
>    /*
>     * Only evict the old entry to the victim tlb if it's for a
>     * different page; otherwise just overwrite the stale data.
>     */
> ?

The if got reorganized a few times before settling on the current.  I agree
that your comment matches the current form much better.


r~
