Received: from eggs.gnu.org ([2001:4830:134:3::10]:54226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqhq1-00057V-Kb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqhpy-0000ZM-DX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:43:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqhpy-0000Z5-5J
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:42:58 -0400
Date: Fri, 17 Aug 2018 12:42:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180817164253.GA7067@flamenco>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816025452.21358-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] tcg: Split CONFIG_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Aug 15, 2018 at 19:54:48 -0700, Richard Henderson wrote:
> GCC7+ will no longer advertise support for 16-byte __atomic operations
> if only cmpxchg is supported, as for x86_64.  Fortunately, x86_64 still
> has support for __sync_compare_and_swap_16 and we can make use of that.
> AArch64 does not have, nor ever has had such support, so open-code it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Great stuff!

A few minor comments below.

> diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
(snip)
> +#if defined(CONFIG_ATOMIC128)
> +static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
> +{
> +    return atomic_cmpxchg__nocheck(ptr, cmp, new);
> +}
> +# define HAVE_CMPXCHG128 1
> +#elif defined(CONFIG_CMPXCHG128)
> +static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
> +{
> +    return __sync_val_compare_and_swap_16(ptr, cmp, new);
> +}
> +# define HAVE_CMPXCHG128 1
> +#elif defined(__aarch64__)
> +/* Through gcc 8, aarch64 has no support for 128-bit at all.  */
> +static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
> +{
> +    uint64_t cmpl = cmp, cmph = cmp >> 64;
> +    uint64_t newl = new, newh = new >> 64;

Here I'd use int128_getlo/hi, since we're not checking for
CONFIG_INT128 (I'm thinking of old compilers here)

(snip)
> +    return int128_make128(oldl, oldh);
> +}
> +# define HAVE_CMPXCHG128 1
> +#endif /* Some definition for HAVE_CMPXCHG128 */
> +
> +
> +#if defined(CONFIG_ATOMIC128)
> +static inline Int128 atomic16_read(Int128 *ptr)
> +{
> +    return atomic_read__nocheck(ptr);
> +}
> +
> +static inline void atomic16_set(Int128 *ptr, Int128 val)
> +{
> +    atomic_set__nocheck(ptr, val);
> +}
> +
> +# define HAVE_ATOMIC128 1
> +#elif !defined(CONFIG_USER_ONLY)
> +# ifdef __aarch64__
> +/* We can do better than cmpxchg for AArch64.  */
> +static inline Int128 atomic16_read(Int128 *ptr)
> +{
> +    uint64_t l, h;
> +    uint32_t tmp;
> +
> +    /* The load must be paired with the store to guarantee not tearing.  */
> +    asm("0: ldxp %[l], %[h], %[mem]\n\t"
> +        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
> +        "cbz %w[tmp], 0b"
> +        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
> +
> +    return int128_make128(l, h);
> +}
> +
> +static inline void atomic16_set(Int128 *ptr, Int128 val)
> +{
> +    uint64_t l = val, h = val >> 64, t1, t2;

Ditto

> +
> +    /* Load into temporaries to acquire the exclusive access lock.  */
> +    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
> +        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
> +        "cbz %w[t1], 0b"
> +        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
> +        : [l] "r"(l), [h] "r"(h));
> +}
> +
> +#  define HAVE_ATOMIC128 1
> +# elif HAVE_CMPXCHG128
> +static inline Int128 atomic16_read(Int128 *ptr)
> +{
> +    /* Maybe replace 0 with 0, returning the old value.  */
> +    return atomic16_cmpxchg(ptr, 0, 0);
> +}
> +
> +static inline void atomic16_set(Int128 *ptr, Int128 val)
> +{
> +    Int128 old = *ptr, cmp;
> +    do {
> +        cmp = old;
> +        old = atomic16_cmpxchg(ptr, cmp, val);
> +    } while (old != cmp);
> +}
> +
> +#  define HAVE_ATOMIC128 1
> +# endif
> +#endif
> +
> +/*
> + * Fallback definitions that must be optimized away, or error.
> + */
> +
> +#ifndef HAVE_CMPXCHG128
> +Int128 __attribute__((error("unsupported cmpxchg")))
> +    atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new);
> +# define HAVE_CMPXCHG128 0
> +#endif
> +
> +#ifndef HAVE_ATOMIC128
> +Int128 __attribute__((error("unsupported atomic16_read")))
> +    atomic16_read(Int128 *ptr, Int128 cmp, Int128 new);

Int128 atomic16_read(Int128 *ptr)

> +Int128 __attribute__((error("unsupported atomic16_set")))
> +    atomic16_set(Int128 *ptr, Int128 cmp, Int128 new);

void atomic16_set(Int128 *ptr, Int128 val)

> +# define HAVE_ATOMIC128 0
> +#endif
> +
> +#endif /* QEMU_ATOMIC128_H */
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index f9f12378e9..297b3f06ee 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -32,6 +32,8 @@
>  #include "qemu/queue.h"
>  #include "tcg-mo.h"
>  #include "tcg-target.h"
> +#include "qemu/atomic.h"
> +#include "qemu/int128.h"
>  
>  /* XXX: make safe guess about sizes */
>  #define MAX_OP_PER_INSTR 266
> @@ -1454,27 +1456,28 @@ GEN_ATOMIC_HELPER_ALL(xchg)
>  #undef GEN_ATOMIC_HELPER
>  #endif /* CONFIG_SOFTMMU */
>  
> -#ifdef CONFIG_ATOMIC128
> -#include "qemu/int128.h"
> -
> -/* These aren't really a "proper" helpers because TCG cannot manage Int128.
> -   However, use the same format as the others, for use by the backends. */
> +/*
> + * These aren't really a "proper" helpers because TCG cannot manage Int128.
> + * However, use the same format as the others, for use by the backends.
> + *
> + * The cmpxchg functions are only defined if HAVE_CMPXCHG128;
> + * the ld/st functions are only defined if HAVE_ATOMIC128,
> + * as defined by <qemu/atomic128.h>.
> + */
>  Int128 helper_atomic_cmpxchgo_le_mmu(CPUArchState *env, target_ulong addr,
>                                       Int128 cmpv, Int128 newv,
> -                                     TCGMemOpIdx oi, uintptr_t retaddr);
> +                                     TCGMemOpIdx oi, uintptr_t ra);
>  Int128 helper_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,
>                                       Int128 cmpv, Int128 newv,
> -                                     TCGMemOpIdx oi, uintptr_t retaddr);
> +                                     TCGMemOpIdx oi, uintptr_t ra);
>  
>  Int128 helper_atomic_ldo_le_mmu(CPUArchState *env, target_ulong addr,
> -                                TCGMemOpIdx oi, uintptr_t retaddr);
> +                                TCGMemOpIdx oi, uintptr_t ra);
>  Int128 helper_atomic_ldo_be_mmu(CPUArchState *env, target_ulong addr,
> -                                TCGMemOpIdx oi, uintptr_t retaddr);
> +                                TCGMemOpIdx oi, uintptr_t ra);
>  void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
> -                              TCGMemOpIdx oi, uintptr_t retaddr);
> +                              TCGMemOpIdx oi, uintptr_t ra);
>  void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
> -                              TCGMemOpIdx oi, uintptr_t retaddr);
> -
> -#endif /* CONFIG_ATOMIC128 */
> +                              TCGMemOpIdx oi, uintptr_t ra);

The s/retaddr/ra/ changes are probably not meant to be in this patch.

Thanks,

		Emilio
