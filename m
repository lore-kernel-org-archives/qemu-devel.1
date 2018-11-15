Received: from eggs.gnu.org ([2001:4830:134:3::10]:47809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNMjS-0000SP-H2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNMjO-0007oh-K5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:51:14 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNMjM-0007mT-NX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:51:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id r11-v6so19783571wmb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 10:51:07 -0800 (PST)
References: <20181029155339.15280-1-richard.henderson@linaro.org>
	<20181029155339.15280-2-richard.henderson@linaro.org>
	<CAFEAcA82DVtipZg7GVPJyUCKSUJUXzijRFzo6xRGmkYet0VuLA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94e3624b-a2a3-7a1e-7dc7-6e43d8447f1e@linaro.org>
Date: Thu, 15 Nov 2018 19:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82DVtipZg7GVPJyUCKSUJUXzijRFzo6xRGmkYet0VuLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] cputlb: Add tlb_set_asid_for_mmuidx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11/15/18 7:36 PM, Peter Maydell wrote:
> On 29 October 2018 at 15:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Although we can't do much with ASIDs except remember them, this
>> will allow cleanups within target/ that should make things clearer.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/exec/cpu-defs.h |  2 ++
>>  include/exec/exec-all.h | 19 +++++++++++++++++++
>>  accel/tcg/cputlb.c      | 23 +++++++++++++++++++++++
>>  3 files changed, 44 insertions(+)
>>
>> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
>> index 6a60f94a41..8fbfe8c8e2 100644
>> --- a/include/exec/cpu-defs.h
>> +++ b/include/exec/cpu-defs.h
>> @@ -152,6 +152,8 @@ typedef struct CPUTLBDesc {
>>      target_ulong large_page_mask;
>>      /* The next index to use in the tlb victim table.  */
>>      size_t vindex;
>> +    /* The current ASID for this tlb.  */
>> +    uint32_t asid;
>>  } CPUTLBDesc;
>>
>>  /*
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 815e5b1e83..478f488704 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -226,6 +226,21 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
>>   * depend on when the guests translation ends the TB.
>>   */
>>  void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
>> +/**
>> + * tlb_set_asid_for_mmuidx:
>> + * @cpu: Originating cpu
>> + * @asid: Address Space Identifier
>> + * @idxmap: bitmap of MMU indicies to set to @asid
> 
> "indices", but it looks like in this header we consistently
> use "MMU indexes", so better to stick with that. (Similarly below.)
> 
>> + * @depmap: bitmap of dependent MMU indicies
>> + *
>> + * Set an ASID for all of @idxmap.  If any previous ASID was different,
>> + * then we may flush the mmu idx.  If a flush is required, then also flush
> 
> presumably "will flush", rather than "may flush" ?
> 
>> + * all dependent mmu indicies in @depmap.  This latter is typically used
>> + * for secondary page resolution, for implementing virtualization within
>> + * the guest.
>> + */
>> +void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
>> +                             uint16_t idxmap, uint16_t dep_idxmap);
>>  /**
>>   * tlb_set_page_with_attrs:
>>   * @cpu: CPU to add this TLB entry for
>> @@ -311,6 +326,10 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
>>                                                         uint16_t idxmap)
>>  {
>>  }
>> +static inline void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
>> +                                           uint16_t idxmap, uint16_t depmap)
>> +{
>> +}
>>  #endif
>>
>>  #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index af6bd8ccf9..60b3dc2de3 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -360,6 +360,29 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
>>      tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
>>  }
>>
>> +void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
>> +                             uint16_t depmap)
>> +{
>> +    CPUArchState *env = cpu->env_ptr;
>> +    uint16_t work, to_flush = 0;
> 
> The other functions that work on the tlb defer their
> actual operation to an async-work type function or
> do a run-on-cpu if the passed-in CPU is not the current
> CPU. Do we need to do that here too?

I don't *think* so.  I would expect an ASID to be set in response to some
cpu-local change, like setting TTBR0_EL1.  Something that cannot be done across
cpus.  I could assert_cpu_is_self, if you like.

What I *should* be adding as well is cross-cpu asid-specific tlb flushing, a-la
TLBI ASID.  That would need the run-on-cpu stuff.

> So this will flush all the passed in indexes in idxmap
> if any one of them was previously the wrong ASID. Is that
> necessary, or could we just flush only the ones which
> were wrong and not flush any that were already the correct ASID ?

It probably wouldn't be necessary.  But I also sort of expect the set of
indexes to always have the same ASID -- e.g. kernel vs user views of the same
address space, e.g. S12NSE0 + S12NSE1.  I don't really know what to do when
this presumed invariant is violated.


r~
