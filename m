Received: from eggs.gnu.org ([2001:4830:134:3::10]:52738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dLT8h-0000E6-2s
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dLT8d-00065V-5L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dLT8c-00065L-S8
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:40:35 -0400
References: <20170614133819.18480-1-david@redhat.com>
	<20170614133819.18480-3-david@redhat.com>
	<25d4dffd-786c-9a24-80ed-6a71724435ae@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bb20b5ae-df1a-6345-d789-95e2420ac41b@redhat.com>
Date: Thu, 15 Jun 2017 13:40:30 +0200
MIME-Version: 1.0
In-Reply-To: <25d4dffd-786c-9a24-80ed-6a71724435ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, Miroslav Benes <mbenes@suse.cz>


>>  
>> +#ifndef CONFIG_USER_ONLY
>> +static void fast_memmove_idx(CPUS390XState *env, uint64_t dest, uint64_t src,
>> +                             uint32_t len, int dest_idx, int src_idx,
>> +                             uintptr_t ra)
>> +{
>> +    TCGMemOpIdx oi_dest = make_memop_idx(MO_UB, dest_idx);
>> +    TCGMemOpIdx oi_src = make_memop_idx(MO_UB, src_idx);
>> +    uint32_t len_adj;
>> +    void *src_p;
>> +    void *dest_p;
>> +    uint8_t x;
>> +
>> +    while (len > 0) {
>> +        src = wrap_address(env, src);
>> +        dest = wrap_address(env, dest);
>> +        src_p = tlb_vaddr_to_host(env, src, MMU_DATA_LOAD, src_idx);
>> +        dest_p = tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, dest_idx);
>> +
>> +        if (src_p && dest_p) {
>> +            /* Access to both whole pages granted.  */
>> +            len_adj = adj_len_to_page(adj_len_to_page(len, src), dest);
>> +            memmove(dest_p, src_p, len_adj);
>> +        } else {
>> +            /* We failed to get access to one or both whole pages. The next
>> +               read or write access will likely fill the QEMU TLB for the
>> +               next iteration.  */
>> +            len_adj = 1;
>> +            x = helper_ret_ldub_mmu(env, src, oi_src, ra);
>> +            helper_ret_stb_mmu(env, dest, x, oi_dest, ra);
>> +        }
>> +        src += len_adj;
>> +        dest += len_adj;
>> +        len -= len_adj;
>> +    }
>> +}
> 
> The code is pretty similar to fast_memmove() ... I wonder whether it makes
> sense to change fast_memmove() to call fast_memmove_idx(), too?
> 
> Something like:
> 
> static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
>                          uint32_t l, uintptr_t ra)
> {
>     int mmu_idx = cpu_mmu_index(env, false);
> 
>     fast_memmove_idx(env, dest, src, l, mmu_idx, mmu_idx, ra);
> }

The problem is that all these instructions have different specialties,
especially regarding
a) address wrapping (which would be wrong in this case! only mvcos
states to do that)
b) how overlapping operands are handled (e.g. that's a reason why MOVE
TO PRIMARY/SECONDARY cannot simply reuse fast_memmove_idx - they have
to fallback to byte-based copies if in doubt).
c) MVPG theoretically exception suppression (not implemented)

We could implement all in one function by adding additional parameters
(wrap, check_overlap), but I think we should do that later on.

> 
> Or could that result in some speed penalty here?
> Anyway, this should likely be done in a separate patch.
> 
>> +static int mmu_idx_from_as(uint8_t as)
>> +{
>> +    switch (as) {
>> +    case AS_PRIMARY:
>> +        return MMU_PRIMARY_IDX;
>> +    case AS_SECONDARY:
>> +        return MMU_SECONDARY_IDX;
>> +    case AS_HOME:
>> +        return MMU_HOME_IDX;
>> +    }
>> +    /* FIXME AS_ACCREG */
>> +    assert(false);
>> +    return -1;
>> +}
> 
> Hmm, maybe it would make sense to change the MMU_*_IDX defines to match
> the AS value directly?

Let's defer that to introduction of ACC range, otherwise we would have
holes in our MMU_.*_IDX definition

> 
>> +static void fast_memmove_as(CPUS390XState *env, uint64_t dest, uint64_t src,
>> +                            uint32_t len, uint8_t dest_as, uint8_t src_as,
>> +                            uintptr_t ra)
>> +{
>> +    int src_idx = mmu_idx_from_as(src_as);
>> +    int dest_idx = mmu_idx_from_as(dest_as);
>> +
>> +    fast_memmove_idx(env, dest, src, len, dest_idx, src_idx, ra);
>> +}
>> +#endif
>> +
>>  static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
[...]
>> +    if (!dest_k) {
>> +        dest_key = psw_key;
>> +    }
>> +    if (!src_k) {
>> +        src_key = psw_key;
>> +    }
>> +    if (!dest_a) {
>> +        dest_as = psw_as;
>> +    }
>> +    if (!src_a) {
>> +        src_as = psw_as;
>> +    }
> 
> Not sure, but maybe it's nicer to write all this in a more compact way?

Yes, we could to that, at least to reduce the LOC. As Richard already
picked up that patch for his series, I think we could do that as an
addon patch later.

[...]
> 
> Apart from the bikeshed-painting-worthy cosmetic nits, this looks fine
> now to me. Thanks for tackling this!
> 
>  Thomas
> 

Thanks Thomas for your very helpful review(s)!

-- 

Thanks,

David
