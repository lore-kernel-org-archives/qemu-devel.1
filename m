Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss40-0007FO-IL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss3x-0006C4-7d
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:02:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fss3w-0006BQ-Sd
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:02:21 -0400
Received: by mail-oi0-x242.google.com with SMTP id z185-v6so9716387oia.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:02:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-13-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:01:58 +0100
Message-ID: <CAFEAcA-izkDJQiojLu=B9gf-vwUL_pba0+E5KLBuaS2_N1hYbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Rewrite
 helper_sve_ld1*_r using pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Uses tlb_vaddr_to_host for correct operation with softmmu.
> Optimize for accesses within a single page or pair of pages.
>
> Perf report comparison for cortex-strings test-strlen
> with aarch64-linux-user:
>
> before:
>    1.59%  qemu-aarch64  qemu-aarch64  [.] do_sve_ld1bb_r
>    0.86%  qemu-aarch64  qemu-aarch64  [.] do_sve_ldff1bb_r
> after:
>    0.09%  qemu-aarch64  qemu-aarch64  [.] helper_sve_ldff1bb_r
>    0.01%  qemu-aarch64  qemu-aarch64  [.] sve_ld1bb_host
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 839 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 675 insertions(+), 164 deletions(-)

Oof, this is a large patch...

> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index e03f954a26..4ca9412e20 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1688,6 +1688,45 @@ static void swap_memmove(void *vd, void *vs, size_t n)
>      }
>  }
>
> +/* Similarly for memset of 0.  */
> +static void swap_memzero(void *vd, size_t n)
> +{
> +    uintptr_t d = (uintptr_t)vd;
> +    uintptr_t o = (d | n) & 7;
> +    size_t i;
> +
> +    if (likely(n == 0)) {

Why is "caller asked us to do nothing" the likely case?

> +        return;
> +    }
> +#ifndef HOST_WORDS_BIGENDIAN
> +    o = 0;
> +#endif
> +    switch (o) {
> +    case 0:
> +        memset(vd, 0, n);
> +        break;
> +
> +    case 4:
> +        for (i = 0; i < n; i += 4) {
> +            *(uint32_t *)H1_4(d + i) = 0;
> +        }
> +        break;
> +
> +    case 2:
> +    case 6:
> +        for (i = 0; i < n; i += 2) {
> +            *(uint16_t *)H1_2(d + i) = 0;
> +        }
> +        break;
> +
> +    default:
> +        for (i = 0; i < n; i++) {
> +            *(uint8_t *)H1(d + i) = 0;
> +        }
> +        break;
> +    }
> +}
> +
>  void HELPER(sve_ext)(void *vd, void *vn, void *vm, uint32_t desc)
>  {
>      intptr_t opr_sz = simd_oprsz(desc);
> @@ -3927,32 +3966,438 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
>  /*
>   * Load contiguous data, protected by a governing predicate.
>   */
> -#define DO_LD1(NAME, FN, TYPEE, TYPEM, H)                  \
> -static void do_##NAME(CPUARMState *env, void *vd, void *vg, \
> -                      target_ulong addr, intptr_t oprsz,   \
> -                      uintptr_t ra)                        \
> -{                                                          \
> -    intptr_t i = 0;                                        \
> -    do {                                                   \
> -        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
> -        do {                                               \
> -            TYPEM m = 0;                                   \
> -            if (pg & 1) {                                  \
> -                m = FN(env, addr, ra);                     \
> -            }                                              \
> -            *(TYPEE *)(vd + H(i)) = m;                     \
> -            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);      \
> -            addr += sizeof(TYPEM);                         \
> -        } while (i & 15);                                  \
> -    } while (i < oprsz);                                   \
> -}                                                          \
> -void HELPER(NAME)(CPUARMState *env, void *vg,              \
> -                  target_ulong addr, uint32_t desc)        \
> -{                                                          \
> -    do_##NAME(env, &env->vfp.zregs[simd_data(desc)], vg,   \
> -              addr, simd_oprsz(desc), GETPC());            \
> +
> +/* Load elements into VD, controlled by VG, from HOST+MEM_OFS.
> + * Memory is valid through MEM_MAX.  The register element indicies
> + * are inferred from MEM_OFS, as modified by the types for which
> + * the helper is built.  Return the MEM_OFS of the first element
> + * not loaded (which is MEM_MAX if they are all loaded).

"@vd", "@mem_ofs" is the usual style.

> + *
> + * For softmmu, we have fully validated the guest page.  For user-only,
> + * we cannot fully validate without taking the mmap lock, but since we
> + * know the access is within one host page, if any access is valid they
> + * all must be valid.  However, it may be that no access is valid and
> + * they have all been predicated false.
> + */
> +typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
> +                                 intptr_t mem_ofs, intptr_t mem_max);
> +
> +/* Load one element into VD+REG_OFF from (ENV,VADDR,RA).
> + * The controlling predicate is known to be true.
> + */
> +typedef void sve_ld1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
> +                            target_ulong vaddr, int mmu_idx, uintptr_t ra);
> +
> +/*
> + * Generate the above primitives.
> + */
> +
> +#define DO_LD_HOST(NAME, H, TYPEE, TYPEM, HOST) \
> +static intptr_t sve_##NAME##_host(void *vd, void *vg, void *host,           \
> +                                  intptr_t mem_off, const intptr_t mem_max) \
> +{                                                                           \
> +    intptr_t reg_off = mem_off * (sizeof(TYPEE) / sizeof(TYPEM));           \
> +    uint64_t *pg = vg;                                                      \
> +    while (mem_off + sizeof(TYPEM) <= mem_max) {                            \
> +        TYPEM val = 0;                                                      \
> +        if (likely((pg[reg_off >> 6] >> (reg_off & 63)) & 1)) {             \
> +            val = HOST(host + mem_off);                                     \
> +        }                                                                   \
> +        *(TYPEE *)(vd + H(reg_off)) = val;                                  \
> +        mem_off += sizeof(TYPEM), reg_off += sizeof(TYPEE);                 \
> +    }                                                                       \
> +    return mem_off;                                                         \
>  }
>
> +#ifdef CONFIG_SOFTMMU
> +#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB) \
> +static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
> +                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
> +{                                                                           \
> +    TCGMemOpIdx oi = make_memop_idx(ctz32(sizeof(TYPEM)) | MOEND, mmu_idx); \
> +    TYPEM val = TLB(env, addr, oi, ra);                                     \
> +    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
> +}
> +#else
> +#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB)                  \
> +static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
> +                             target_ulong addr, int mmu_idx, uintptr_t ra)  \
> +{                                                                           \
> +    TYPEM val = HOST(g2h(addr));                                            \
> +    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
> +}
> +#endif
> +
> +DO_LD_TLB(ld1bb, H1, uint8_t, uint8_t, ldub_p, 0, helper_ret_ldub_mmu)
> +
> +#define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
> +    DO_LD_HOST(NAME, H, TE, TM, ldub_p)                 \
> +    DO_LD_TLB(NAME, H, TE, TM, ldub_p, 0, helper_ret_ldub_mmu)
> +
> +DO_LD_PRIM_1(ld1bhu, H1_2, uint16_t, uint8_t)
> +DO_LD_PRIM_1(ld1bhs, H1_2, uint16_t,  int8_t)
> +DO_LD_PRIM_1(ld1bsu, H1_4, uint32_t, uint8_t)
> +DO_LD_PRIM_1(ld1bss, H1_4, uint32_t,  int8_t)
> +DO_LD_PRIM_1(ld1bdu,     , uint64_t, uint8_t)
> +DO_LD_PRIM_1(ld1bds,     , uint64_t,  int8_t)
> +
> +#define DO_LD_PRIM_2(NAME, end, MOEND, H, TE, TM, PH, PT)  \
> +    DO_LD_HOST(NAME##_##end, H, TE, TM, PH##_##end##_p)    \
> +    DO_LD_TLB(NAME##_##end, H, TE, TM, PH##_##end##_p,     \
> +              MOEND, helper_##end##_##PT##_mmu)
> +
> +DO_LD_PRIM_2(ld1hh,  le, MO_LE, H1_2, uint16_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hsu, le, MO_LE, H1_4, uint32_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hss, le, MO_LE, H1_4, uint32_t,  int16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hdu, le, MO_LE,     , uint64_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hds, le, MO_LE,     , uint64_t,  int16_t, lduw, lduw)
> +
> +DO_LD_PRIM_2(ld1ss,  le, MO_LE, H1_4, uint32_t, uint32_t, ldl, ldul)
> +DO_LD_PRIM_2(ld1sdu, le, MO_LE,     , uint64_t, uint32_t, ldl, ldul)
> +DO_LD_PRIM_2(ld1sds, le, MO_LE,     , uint64_t,  int32_t, ldl, ldul)

It's a shame that we have two different conventions here
that mean one part of this is using 'ldl' and the other 'ldul'...

> +
> +DO_LD_PRIM_2(ld1dd,  le, MO_LE,     , uint64_t, uint64_t, ldq, ldq)
> +
> +DO_LD_PRIM_2(ld1hh,  be, MO_BE, H1_2, uint16_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hsu, be, MO_BE, H1_4, uint32_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hss, be, MO_BE, H1_4, uint32_t,  int16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hdu, be, MO_BE,     , uint64_t, uint16_t, lduw, lduw)
> +DO_LD_PRIM_2(ld1hds, be, MO_BE,     , uint64_t,  int16_t, lduw, lduw)
> +
> +DO_LD_PRIM_2(ld1ss,  be, MO_BE, H1_4, uint32_t, uint32_t, ldl, ldul)
> +DO_LD_PRIM_2(ld1sdu, be, MO_BE,     , uint64_t, uint32_t, ldl, ldul)
> +DO_LD_PRIM_2(ld1sds, be, MO_BE,     , uint64_t,  int32_t, ldl, ldul)
> +
> +DO_LD_PRIM_2(ld1dd,  be, MO_BE,     , uint64_t, uint64_t, ldq, ldq)
> +
> +#undef DO_LD_TLB
> +#undef DO_LD_HOST
> +#undef DO_LD_PRIM_1
> +#undef DO_LD_PRIM_2
> +
> +/*
> + * Special case contiguous loads of bytes to accellerate strings.

"accelerate"

> + *
> + * The assumption is that the governing predicate will be mostly true.
> + * When it is not all true, it has been set by whilelo and so has a
> + * block of true elements followed by a block of false elements.
> + * Thus anything we can do to handle as many bytes as possible in one
> + * step will pay dividends.
> + *
> + * Because of how vector registers are represented in CPUARMState,
> + * each block of 8 can be read with a little-endian load to be stored
> + * into the vector register in host-endian order.
> + *
> + * TODO: For LE host and LE guest (by far the most common combination),
> + * the only difference for other non-extending loads is the controlling
> + * predicate.  Even for other combinations, it might be fastest to use
> + * this primitive to block load all of the data and then reorder the
> + * bytes afterward.
> + */
> +
> +/* For user-only, conditionally load and mask from HOST, returning 0
> + * if the predicate is false.  This is required because, as described
> + * above, we have not fully validated the page, and faults are not
> + * permitted when the predicate is false.
> + * For softmmu, we never arrive here with invalid host memory; just mask.
> + */
> +static inline uint64_t ldq_le_pred_b(uint8_t pg, void *host)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    if (pg == 0) {
> +        return 0;
> +    }
> +#endif
> +    return ldq_le_p(host) & expand_pred_b(pg);
> +}
> +
> +static inline uint8_t ldub_pred(uint8_t pg, void *host)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return pg & 1 ? ldub_p(host) : 0;
> +#else
> +    return ldub_p(host) & -(pg & 1);
> +#endif
> +}
> +
> +static intptr_t sve_ld1bb_host(void *vd, void *vg, void *host,
> +                               intptr_t off, const intptr_t max)
> +{
> +    uint64_t *d = vd;
> +    uint8_t *g = vg;
> +
> +    /* Assuming OFF and MAX may be misaligned, but also the most common
> +     * case is an entire vector register: OFF == 0, MAX % 16 == 0.
> +     */
> +    if (likely(off + 8 <= max)) {
> +        const intptr_t max_div_8 = max >> 3;
> +        intptr_t off_div_8 = off >> 3;
> +        uint64_t data;
> +
> +        if (unlikely(off & 63)) {
> +            /* Align for a loop-of-8.  We know from the range check
> +             * above that we have enough remaining to load 8 bytes.
> +             */
> +            if (unlikely(off & 7)) {
> +                int off_7 = off & 7;
> +                uint8_t pg = g[H1(off_div_8)] >> off_7;
> +
> +                off_7 *= 8;
> +                data = ldq_le_pred_b(pg, host + off);
> +                data = deposit64(d[off_div_8], off_7, 64 - off_7, data);
> +                d[off_div_8] = data;
> +
> +                off_div_8 += 1;
> +            }
> +
> +            /* If there are not sufficient bytes to align for 64
> +             * and also execute that loop at least once, skip to tail.
> +             */
> +            if (ROUND_UP(off_div_8, 8) + 8 > max_div_8) {
> +                goto skip_64;
> +            }
> +
> +            /* Align for the loop-of-64.  */
> +            if (unlikely(off_div_8 & 7)) {
> +                do {
> +                    uint8_t pg = g[off_div_8];
> +                    data = ldq_le_pred_b(pg, host + off_div_8 * 8);
> +                    d[off_div_8] = data;
> +                } while (++off_div_8 & 7);
> +            }
> +        }
> +
> +        /* While we have blocks of 64 remaining, we can perform tests
> +         * against large blocks of predicates at once.
> +         */
> +        for (; off_div_8 + 8 <= max_div_8; off_div_8 += 8) {
> +            uint64_t pg = *(uint64_t *)(g + off_div_8);
> +            if (likely(pg == -1ULL)) {
> +#ifndef HOST_WORDS_BIGENDIAN
> +                memcpy(d + off_div_8, host + off_div_8 * 8, 64);
> +#else
> +                intptr_t j;
> +                for (j = 0; j < 8; j++) {
> +                    data = ldq_le_p(host + (off_div_8 + j) * 8);
> +                    d[off_div_8 + j] = data;
> +                }
> +#endif
> +            } else if (pg == 0) {
> +                memset(d + off_div_8, 0, 64);
> +            } else {
> +                intptr_t j;
> +                for (j = 0; j < 8; j++) {
> +                    data = ldq_le_pred_b(pg >> (j * 8),
> +                                         host + (off_div_8 + j) * 8);
> +                    d[off_div_8 + j] = data;
> +                }
> +            }
> +        }
> +
> + skip_64:
> +        /* Final tail or a copy smaller than 64 bytes.  */
> +        for (; off_div_8 < max_div_8; off_div_8++) {
> +            uint8_t pg = g[H1(off_div_8)];
> +            data = ldq_le_pred_b(pg, host + off_div_8 * 8);
> +            d[off_div_8] = data;
> +        }
> +
> +        /* Restore using OFF.  */
> +        off = off_div_8 * 8;
> +    }
> +
> +    /* Final tail or a really small copy.  */
> +    if (unlikely(off < max)) {
> +        do {
> +            uint8_t pg = g[H1(off >> 3)] >> (off & 7);
> +            ((uint8_t *)vd)[H1(off)] = ldub_pred(pg, host + off);
> +        } while (++off < max);
> +    }
> +
> +    return max;
> +}

This is an awful lot of cleverness for optimisation purposes.
Can't we start with "simple but works" and add the optimisation
later?

> +
> +/* Skip through a sequence of inactive elements in the guarding predicate VG,
> + * beginning at REG_OFF bounded by REG_MAX.  Return the offset of the active
> + * element >= REG_OFF, or REG_MAX if there were no active elements at all.
> + */
> +static intptr_t find_next_active(uint64_t *vg, intptr_t reg_off,
> +                                 intptr_t reg_max, int esz)
> +{
> +    uint64_t pg_mask = pred_esz_masks[esz];
> +    uint64_t pg = (vg[reg_off >> 6] & pg_mask) >> (reg_off & 63);
> +
> +    /* In normal usage, the first element is active.  */
> +    if (likely(pg & 1)) {
> +        return reg_off;
> +    }
> +
> +    if (pg == 0) {
> +        reg_off &= -64;
> +        do {
> +            reg_off += 64;
> +            if (unlikely(reg_off >= reg_max)) {
> +                /* The entire predicate was false.  */
> +                return reg_max;
> +            }
> +            pg = vg[reg_off >> 6] & pg_mask;
> +        } while (pg == 0);
> +    }
> +    reg_off += ctz64(pg);
> +
> +    /* We should never see an out of range predicate bit set.  */
> +    tcg_debug_assert(reg_off < reg_max);
> +    return reg_off;
> +}
> +
> +/* Return the maximum offset <= MEM_MAX which is still within the page
> + * referenced by BASE+MEM_OFF.
> + */
> +static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
> +                             intptr_t mem_max)
> +{
> +    target_ulong addr = base + mem_off;
> +    intptr_t split = -(intptr_t)(addr | TARGET_PAGE_MASK);
> +    return MIN(split, mem_max - mem_off) + mem_off;
> +}
> +
> +static inline void set_helper_retaddr(uintptr_t ra)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    helper_retaddr = ra;
> +#endif
> +}
> +
> +static inline bool test_host_page(void *host)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return true;
> +#else
> +    return likely(host != NULL);
> +#endif
> +}
> +
> +/*
> + * Common helper for all contiguous one-register predicated loads.
> + */
> +static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
> +                      uint32_t desc, const uintptr_t retaddr,
> +                      const int esz, const int msz,
> +                      sve_ld1_host_fn *host_fn,
> +                      sve_ld1_tlb_fn *tlb_fn)
> +{
> +    void *vd = &env->vfp.zregs[simd_data(desc)];
> +    const int diffsz = esz - msz;
> +    const intptr_t reg_max = simd_oprsz(desc);
> +    const intptr_t mem_max = reg_max >> diffsz;
> +    const int mmu_idx = cpu_mmu_index(env, false);
> +    ARMVectorReg scratch;
> +    void *host, *result;
> +    intptr_t split;
> +
> +    set_helper_retaddr(retaddr);
> +
> +    host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
> +    if (test_host_page(host)) {
> +        split = max_for_page(addr, 0, mem_max);
> +        if (likely(split == mem_max)) {
> +            /* The load is entirely within a valid page.  For softmmu,
> +             * no faults.  For user-only, if the first byte does not
> +             * fault then none of them will fault, so Vd will never be
> +             * partially modified.
> +             */
> +            host_fn(vd, vg, host, 0, mem_max);
> +            set_helper_retaddr(0);
> +            return;
> +        }
> +    }
> +
> +    /* Perform the predicated read into a temporary, thus ensuring
> +     * if the load of the last element faults, Vd is not modified.
> +     */
> +    result = &scratch;
> +#ifdef CONFIG_USER_ONLY
> +    host_fn(vd, vg, host, 0, mem_max);
> +#else
> +    memset(result, 0, reg_max);
> +    for (intptr_t reg_off = find_next_active(vg, 0, reg_max, esz);
> +         reg_off < reg_max;
> +         reg_off = find_next_active(vg, reg_off, reg_max, esz)) {
> +        intptr_t mem_off = reg_off >> diffsz;
> +
> +        split = max_for_page(addr, mem_off, mem_max);
> +        if (msz == 0 || split - mem_off >= (1 << msz)) {
> +            /* At least one whole element on this page.  */
> +            host = tlb_vaddr_to_host(env, addr + mem_off,
> +                                     MMU_DATA_LOAD, mmu_idx);
> +            if (host) {
> +                mem_off = host_fn(result, vg, host - mem_off, mem_off, split);
> +                reg_off = mem_off << diffsz;
> +                continue;
> +            }
> +        }
> +
> +        /* Perform one normal read.  This may fault, longjmping out to the
> +         * main loop in order to raise an exception.  It may succeed, and
> +         * as a side-effect load the TLB entry for the next round.  Finally,
> +         * in the extremely unlikely case we're performing this operation
> +         * on I/O memory, it may succeed but not bring in the TLB entry.
> +         * But even then we have still made forward progress.
> +         */
> +        tlb_fn(env, result, reg_off, addr + mem_off, mmu_idx, retaddr);
> +        reg_off += 1 << esz;
> +    }
> +#endif
> +
> +    set_helper_retaddr(0);
> +    memcpy(vd, result, reg_max);
> +}
> +
> +#define DO_LD1_1(NAME, ESZ) \
> +void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
> +                            target_ulong addr, uint32_t desc)  \
> +{                                                              \
> +    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, 0,            \
> +              sve_##NAME##_host, sve_##NAME##_tlb);            \
> +}
> +
> +/* TODO: Propagate the endian check back to the translator.  */
> +#define DO_LD1_2(NAME, ESZ, MSZ) \
> +void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
> +                            target_ulong addr, uint32_t desc)  \
> +{                                                              \
> +    if (arm_cpu_data_is_big_endian(env)) {                     \
> +        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
> +                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);  \
> +    } else {                                                   \
> +        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
> +                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);  \
> +    }                                                          \
> +}
> +
> +DO_LD1_1(ld1bb,  0)
> +DO_LD1_1(ld1bhu, 1)
> +DO_LD1_1(ld1bhs, 1)
> +DO_LD1_1(ld1bsu, 2)
> +DO_LD1_1(ld1bss, 2)
> +DO_LD1_1(ld1bdu, 3)
> +DO_LD1_1(ld1bds, 3)
> +
> +DO_LD1_2(ld1hh,  1, 1)
> +DO_LD1_2(ld1hsu, 2, 1)
> +DO_LD1_2(ld1hss, 2, 1)
> +DO_LD1_2(ld1hdu, 3, 1)
> +DO_LD1_2(ld1hds, 3, 1)
> +
> +DO_LD1_2(ld1ss,  2, 2)
> +DO_LD1_2(ld1sdu, 3, 2)
> +DO_LD1_2(ld1sds, 3, 2)
> +
> +DO_LD1_2(ld1dd,  3, 3)
> +
> +#undef DO_LD1_1
> +#undef DO_LD1_2
> +
>  #define DO_LD2(NAME, FN, TYPEE, TYPEM, H)                  \
>  void HELPER(NAME)(CPUARMState *env, void *vg,              \
>                    target_ulong addr, uint32_t desc)        \
> @@ -4037,52 +4482,40 @@ void HELPER(NAME)(CPUARMState *env, void *vg,              \
>      }                                                      \
>  }
>
> -DO_LD1(sve_ld1bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
> -DO_LD1(sve_ld1bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
> -DO_LD1(sve_ld1bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
> -DO_LD1(sve_ld1bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
> -DO_LD1(sve_ld1bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
> -DO_LD1(sve_ld1bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
> -
> -DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
> -DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int16_t, H1_4)
> -DO_LD1(sve_ld1hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
> -DO_LD1(sve_ld1hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
> -
> -DO_LD1(sve_ld1sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
> -DO_LD1(sve_ld1sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
> -
> -DO_LD1(sve_ld1bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
>  DO_LD2(sve_ld2bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
>  DO_LD3(sve_ld3bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
>  DO_LD4(sve_ld4bb_r, cpu_ldub_data_ra, uint8_t, uint8_t, H1)
>
> -DO_LD1(sve_ld1hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
>  DO_LD2(sve_ld2hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
>  DO_LD3(sve_ld3hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
>  DO_LD4(sve_ld4hh_r, cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
>
> -DO_LD1(sve_ld1ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
>  DO_LD2(sve_ld2ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
>  DO_LD3(sve_ld3ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
>  DO_LD4(sve_ld4ss_r, cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
>
> -DO_LD1(sve_ld1dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
>  DO_LD2(sve_ld2dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
>  DO_LD3(sve_ld3dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
>  DO_LD4(sve_ld4dd_r, cpu_ldq_data_ra, uint64_t, uint64_t, )
>
> -#undef DO_LD1
>  #undef DO_LD2
>  #undef DO_LD3
>  #undef DO_LD4
>
>  /*
>   * Load contiguous data, first-fault and no-fault.
> + *
> + * For user-only, one could argue that we should hold the mmap_lock during
> + * the operation so that there is no race between page_check_range and the
> + * load operation.  However, unmapping pages out from under operating thread

missing "an" ?

> + * is extrodinarily unlikely.  This theoretical race condition also affects

"extraordinarily"

> + * linux-user/ in its get_user/put_user macros.
> + *
> + * TODO: Construct some helpers, written in assembly, that interact with
> + * handle_cpu_signal to produce memory ops which can properly report errors
> + * without racing.
>   */
>
> -#ifdef CONFIG_USER_ONLY
> -
>  /* Fault on byte I.  All bits in FFR from I are cleared.  The vector
>   * result from I is CONSTRAINED UNPREDICTABLE; we choose the MERGE
>   * option, which leaves subsequent data unchanged.
> @@ -4092,147 +4525,225 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
>      uint64_t *ffr = env->vfp.pregs[FFR_PRED_NUM].p;
>
>      if (i & 63) {
> -        ffr[i / 64] &= MAKE_64BIT_MASK(0, i & 63);
> +        ffr[i >> 6] &= MAKE_64BIT_MASK(0, i & 63);
>          i = ROUND_UP(i, 64);
>      }
>      for (; i < oprsz; i += 64) {
> -        ffr[i / 64] = 0;
> +        ffr[i >> 6] = 0;
>      }
>  }

Should be in different patch ?

>
> -/* Hold the mmap lock during the operation so that there is no race
> - * between page_check_range and the load operation.  We expect the
> - * usual case to have no faults at all, so we check the whole range
> - * first and if successful defer to the normal load operation.
> - *
> - * TODO: Change mmap_lock to a rwlock so that multiple readers
> - * can run simultaneously.  This will probably help other uses
> - * within QEMU as well.
> +/*
> + * Common helper for all contiguous first-fault loads.
>   */
> -#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                             \
> -static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,    \
> -                               target_ulong addr, intptr_t oprsz,       \
> -                               bool first, uintptr_t ra)                \
> -{                                                                       \
> -    intptr_t i = 0;                                                     \
> -    do {                                                                \
> -        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
> -        do {                                                            \
> -            TYPEM m = 0;                                                \
> -            if (pg & 1) {                                               \
> -                if (!first &&                                           \
> -                    unlikely(page_check_range(addr, sizeof(TYPEM),      \
> -                                              PAGE_READ))) {            \
> -                    record_fault(env, i, oprsz);                        \
> -                    return;                                             \
> -                }                                                       \
> -                m = FN(env, addr, ra);                                  \
> -                first = false;                                          \
> -            }                                                           \
> -            *(TYPEE *)(vd + H(i)) = m;                                  \
> -            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);                   \
> -            addr += sizeof(TYPEM);                                      \
> -        } while (i & 15);                                               \
> -    } while (i < oprsz);                                                \
> -}                                                                       \
> -void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,                \
> -                             target_ulong addr, uint32_t desc)          \
> -{                                                                       \
> -    intptr_t oprsz = simd_oprsz(desc);                                  \
> -    unsigned rd = simd_data(desc);                                      \
> -    void *vd = &env->vfp.zregs[rd];                                     \
> -    mmap_lock();                                                        \
> -    if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
> -        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
> -    } else {                                                            \
> -        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, true, GETPC());    \
> -    }                                                                   \
> -    mmap_unlock();                                                      \
> -}
> +static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
> +                        uint32_t desc, const uintptr_t retaddr,
> +                        const int esz, const int msz,
> +                        sve_ld1_host_fn *host_fn,
> +                        sve_ld1_tlb_fn *tlb_fn)
> +{
> +    void *vd = &env->vfp.zregs[simd_data(desc)];
> +    const int diffsz = esz - msz;
> +    const intptr_t reg_max = simd_oprsz(desc);
> +    const intptr_t mem_max = reg_max >> diffsz;
> +    const int mmu_idx = cpu_mmu_index(env, false);
> +    intptr_t split, reg_off, mem_off;
> +    void *host;
>
> -/* No-fault loads are like first-fault loads without the
> - * first faulting special case.
> - */
> -#define DO_LDNF1(PART)                                                  \
> -void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,                \
> -                             target_ulong addr, uint32_t desc)          \
> -{                                                                       \
> -    intptr_t oprsz = simd_oprsz(desc);                                  \
> -    unsigned rd = simd_data(desc);                                      \
> -    void *vd = &env->vfp.zregs[rd];                                     \
> -    mmap_lock();                                                        \
> -    if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
> -        do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
> -    } else {                                                            \
> -        do_sve_ldff1##PART(env, vd, vg, addr, oprsz, false, GETPC());   \
> -    }                                                                   \
> -    mmap_unlock();                                                      \
> -}
> +    set_helper_retaddr(retaddr);
>
> +    split = max_for_page(addr, 0, mem_max);
> +    if (likely(split == mem_max)) {
> +        /* The entire operation is within one page.  */
> +        host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
> +        if (test_host_page(host)) {
> +            mem_off = host_fn(vd, vg, host, 0, mem_max);
> +            tcg_debug_assert(mem_off == mem_max);
> +            set_helper_retaddr(0);
> +            return;
> +        }
> +    }
> +
> +    /* Skip to the first true predicate.  */
> +    reg_off = find_next_active(vg, 0, reg_max, esz);
> +    if (unlikely(reg_off == reg_max)) {
> +        /* The entire predicate was false; no load occurs.  */
> +        set_helper_retaddr(0);
> +        memset(vd, 0, reg_max);
> +        return;
> +    }
> +    mem_off = reg_off >> diffsz;
> +
> +#ifdef CONFIG_USER_ONLY
> +    /* The page(s) containing this first element at ADDR+MEM_OFF must
> +     * be valid.  Considering that this first element may be misaligned
> +     * and cross a page boundary itself, take the rest of the page from
> +     * the last byte of the element.
> +     */
> +    split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
> +    mem_off = host_fn(vd, vg, g2h(addr), mem_off, split);
> +
> +    /* After any fault, zero any leading predicated false elts.  */
> +    swap_memzero(vd, reg_off);
> +    reg_off = mem_off << diffsz;
>  #else
> +    /* Perform one normal read, which will fault or not.
> +     * But it is likely to bring the page into the tlb.
> +     */
> +    tlb_fn(env, vd, reg_off, addr + mem_off, mmu_idx, retaddr);
>
> -/* TODO: System mode is not yet supported.
> - * This would probably use tlb_vaddr_to_host.
> - */
> -#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                     \
> -void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,        \
> -                  target_ulong addr, uint32_t desc)             \
> -{                                                               \
> -    g_assert_not_reached();                                     \
> -}
> -
> -#define DO_LDNF1(PART)                                          \
> -void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,        \
> -                  target_ulong addr, uint32_t desc)             \
> -{                                                               \
> -    g_assert_not_reached();                                     \
> -}
> +    /* After any fault, zero any leading predicated false elts.  */
> +    swap_memzero(vd, reg_off);
> +    mem_off += 1 << msz;
> +    reg_off += 1 << esz;
>
> +    /* Try again to read the balance of the page.  */
> +    split = max_for_page(addr, mem_off - 1, mem_max);
> +    if (split >= (1 << msz)) {
> +        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
> +        if (host) {
> +            mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
> +            reg_off = mem_off << diffsz;
> +        }
> +    }
>  #endif
>
> -DO_LDFF1(bb_r,  cpu_ldub_data_ra, uint8_t, uint8_t, H1)
> -DO_LDFF1(bhu_r, cpu_ldub_data_ra, uint16_t, uint8_t, H1_2)
> -DO_LDFF1(bhs_r, cpu_ldsb_data_ra, uint16_t, int8_t, H1_2)
> -DO_LDFF1(bsu_r, cpu_ldub_data_ra, uint32_t, uint8_t, H1_4)
> -DO_LDFF1(bss_r, cpu_ldsb_data_ra, uint32_t, int8_t, H1_4)
> -DO_LDFF1(bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
> -DO_LDFF1(bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
> +    set_helper_retaddr(0);
> +    record_fault(env, reg_off, reg_max);
> +}
>
> -DO_LDFF1(hh_r,  cpu_lduw_data_ra, uint16_t, uint16_t, H1_2)
> -DO_LDFF1(hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
> -DO_LDFF1(hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
> -DO_LDFF1(hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
> -DO_LDFF1(hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
> +/*
> + * Common helper for all contiguous no-fault loads.
> + */
> +static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
> +                        uint32_t desc, const int esz, const int msz,
> +                        sve_ld1_host_fn *host_fn)
> +{
> +    void *vd = &env->vfp.zregs[simd_data(desc)];
> +    const int diffsz = esz - msz;
> +    const intptr_t reg_max = simd_oprsz(desc);
> +    const intptr_t mem_max = reg_max >> diffsz;
> +    intptr_t split, reg_off, mem_off;
> +    void *host;
>
> -DO_LDFF1(ss_r,  cpu_ldl_data_ra, uint32_t, uint32_t, H1_4)
> -DO_LDFF1(sdu_r, cpu_ldl_data_ra, uint64_t, uint32_t, )
> -DO_LDFF1(sds_r, cpu_ldl_data_ra, uint64_t, int32_t, )
> +#ifdef CONFIG_USER_ONLY
> +    /* Do not set helper_retaddr as there should be no fault.  */
> +    host = g2h(addr);
> +    if (likely(page_check_range(addr, mem_max, PAGE_READ) == 0)) {
> +        /* The entire operation is valid.  */
> +        host_fn(vd, vg, host, 0, mem_max);
> +        return;
> +    }
> +#else
> +    const int mmu_idx = extract32(desc, SIMD_DATA_SHIFT, 4);
> +    /* Unless we can load the entire vector from the same page,
> +     * we need to search for the first active element.
> +     */
> +    split = max_for_page(addr, 0, mem_max);
> +    if (likely(split == mem_max)) {
> +        host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
> +        if (host) {
> +            host_fn(vd, vg, host, 0, mem_max);
> +            return;
> +        }
> +    }
> +#endif
>
> -DO_LDFF1(dd_r,  cpu_ldq_data_ra, uint64_t, uint64_t, )
> +    /* There will be no fault, so we may modify in advance.  */
> +    memset(vd, 0, reg_max);
>
> -#undef DO_LDFF1
> +    /* Skip to the first true predicate.  */
> +    reg_off = find_next_active(vg, 0, reg_max, esz);
> +    if (unlikely(reg_off == reg_max)) {
> +        /* The entire predicate was false; no load occurs.  */
> +        return;
> +    }
> +    mem_off = reg_off >> diffsz;
>
> -DO_LDNF1(bb_r)
> -DO_LDNF1(bhu_r)
> -DO_LDNF1(bhs_r)
> -DO_LDNF1(bsu_r)
> -DO_LDNF1(bss_r)
> -DO_LDNF1(bdu_r)
> -DO_LDNF1(bds_r)
> +#ifdef CONFIG_USER_ONLY
> +    if (page_check_range(addr + mem_off, 1 << msz, PAGE_READ) == 0) {
> +        /* At least one load is valid; take the rest of the page.  */
> +        split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
> +        mem_off = host_fn(vd, vg, host, mem_off, split);
> +        reg_off = mem_off << diffsz;
> +    }
> +#else
> +    /* If the address is not in the TLB, we have no way to bring the
> +     * entry into the TLB without also risking a fault.  Note that
> +     * the corollary is that we never load from an address not in RAM.
> +     * ??? This last may be out of spec.

Yes, it is out of spec, in a slightly weird corner case.
Per the MemNF/MemSingleNF pseudocode, an NF load from
Device memory mustn't actually go externally -- it returns
UNKNOWN data instead. But if you map non-RAM with Normal
memory attributes and do an NF load then it should really
access the bus. (Nobody's going to actually do this in the
real world, obviously.)

To do this fully correctly you would need to do a get_phys_addr()
then an address_space_ld*(), checking for either VA->PA failure or
getting back a non-MEMTX_OK result on the physical access.
You'd also need to make get_phys_addr() tell you the Arm memory
attributes so you could avoid doing the access on Device memory.

There are probably also annoying special cases with interactions
with watchpoints set up via the architectural debug.

We can probably ignore all this for now apart from making
a TODO comment...

> +     */
> +    host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
> +    split = max_for_page(addr, mem_off, mem_max);
> +    if (host && split >= (1 << msz)) {
> +        mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
> +        reg_off = mem_off << diffsz;
> +    }
> +#endif
>
> -DO_LDNF1(hh_r)
> -DO_LDNF1(hsu_r)
> -DO_LDNF1(hss_r)
> -DO_LDNF1(hdu_r)
> -DO_LDNF1(hds_r)
> +    record_fault(env, reg_off, reg_max);
> +}
>
> -DO_LDNF1(ss_r)
> -DO_LDNF1(sdu_r)
> -DO_LDNF1(sds_r)
> +#define DO_LDFF1_LDNF1_1(PART, ESZ) \
> +void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
> +                                 target_ulong addr, uint32_t desc)      \
> +{                                                                       \
> +    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, 0,                   \
> +                sve_ld1##PART##_host, sve_ld1##PART##_tlb);             \
> +}                                                                       \
> +void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
> +                                 target_ulong addr, uint32_t desc)      \
> +{                                                                       \
> +    sve_ldnf1_r(env, vg, addr, desc, ESZ, 0, sve_ld1##PART##_host);     \
> +}
>
> -DO_LDNF1(dd_r)
> +/* TODO: Propagate the endian check back to the translator.  */
> +#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
> +void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
> +                                 target_ulong addr, uint32_t desc)      \
> +{                                                                       \
> +    if (arm_cpu_data_is_big_endian(env)) {                              \
> +        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
> +                    sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);   \
> +    } else {                                                            \
> +        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
> +                    sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);   \
> +    }                                                                   \
> +}                                                                       \
> +void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
> +                                 target_ulong addr, uint32_t desc)      \
> +{                                                                       \
> +    if (arm_cpu_data_is_big_endian(env)) {                              \
> +        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
> +                    sve_ld1##PART##_be_host);                           \
> +    } else {                                                            \
> +        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
> +                    sve_ld1##PART##_le_host);                           \
> +    }                                                                   \
> +}
>
> -#undef DO_LDNF1
> +DO_LDFF1_LDNF1_1(bb,  0)
> +DO_LDFF1_LDNF1_1(bhu, 1)
> +DO_LDFF1_LDNF1_1(bhs, 1)
> +DO_LDFF1_LDNF1_1(bsu, 2)
> +DO_LDFF1_LDNF1_1(bss, 2)
> +DO_LDFF1_LDNF1_1(bdu, 3)
> +DO_LDFF1_LDNF1_1(bds, 3)
> +
> +DO_LDFF1_LDNF1_2(hh,  1, 1)
> +DO_LDFF1_LDNF1_2(hsu, 2, 1)
> +DO_LDFF1_LDNF1_2(hss, 2, 1)
> +DO_LDFF1_LDNF1_2(hdu, 3, 1)
> +DO_LDFF1_LDNF1_2(hds, 3, 1)
> +
> +DO_LDFF1_LDNF1_2(ss,  2, 2)
> +DO_LDFF1_LDNF1_2(sdu, 3, 2)
> +DO_LDFF1_LDNF1_2(sds, 3, 2)
> +
> +DO_LDFF1_LDNF1_2(dd,  3, 3)
> +
> +#undef DO_LDFF1_LDNF1_1
> +#undef DO_LDFF1_LDNF1_2
>
>  /*
>   * Store contiguous data, protected by a governing predicate.

Generally the code looks ok, but there was so much of it that
I kind of stopped checking the details...

thanks
-- PMM
