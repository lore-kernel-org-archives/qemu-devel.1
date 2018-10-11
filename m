Received: from eggs.gnu.org ([2001:4830:134:3::10]:57010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVri-0007hs-Hi
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVrf-0005mW-9o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:58:38 -0400
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-7-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ed672a6-0d50-c24b-fb28-9f0b7c9e1e5a@redhat.com>
Date: Thu, 11 Oct 2018 09:58:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181003193931.18096-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 6/9] target/s390x: Convert
 to HAVE_CMPXCHG128 and HAVE_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 03/10/2018 21:39, Richard Henderson wrote:
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/mem_helper.c | 92 +++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 51 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index bacae4f503..e106f61b4e 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -25,6 +25,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "qemu/int128.h"
> +#include "qemu/atomic128.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/s390x/storage-keys.h"
> @@ -1389,7 +1390,7 @@ static void do_cdsg(CPUS390XState *env, uint64_t addr,
>      bool fail;
>  
>      if (parallel) {
> -#ifndef CONFIG_ATOMIC128
> +#if !HAVE_CMPXCHG128
>          cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>  #else
>          int mem_idx = cpu_mmu_index(env, false);
> @@ -1435,9 +1436,7 @@ void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
>  static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>                          uint64_t a2, bool parallel)
>  {
> -#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
>      uint32_t mem_idx = cpu_mmu_index(env, false);
> -#endif
>      uintptr_t ra = GETPC();
>      uint32_t fc = extract32(env->regs[0], 0, 8);
>      uint32_t sc = extract32(env->regs[0], 8, 8);
> @@ -1465,18 +1464,20 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>      probe_write(env, a2, 0, mem_idx, ra);
>  #endif
>  
> -    /* Note that the compare-and-swap is atomic, and the store is atomic, but
> -       the complete operation is not.  Therefore we do not need to assert serial
> -       context in order to implement this.  That said, restart early if we can't
> -       support either operation that is supposed to be atomic.  */
> +    /*
> +     * Note that the compare-and-swap is atomic, and the store is atomic,
> +     * but the complete operation is not.  Therefore we do not need to
> +     * assert serial context in order to implement this.  That said,
> +     * restart early if we can't support either operation that is supposed
> +     * to be atomic.
> +     */
>      if (parallel) {
> -        int mask = 0;
> -#if !defined(CONFIG_ATOMIC64)
> -        mask = -8;
> -#elif !defined(CONFIG_ATOMIC128)
> -        mask = -16;
> +        uint32_t max = 2;
> +#ifdef CONFIG_ATOMIC64
> +        max = 3;
>  #endif
> -        if (((4 << fc) | (1 << sc)) & mask) {
> +        if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
> +            (HAVE_ATOMIC128  ? 0 : sc > max)) {
>              cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>          }
>      }
> @@ -1546,16 +1547,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>              Int128 cv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
>              Int128 ov;
>  
> -            if (parallel) {
> -#ifdef CONFIG_ATOMIC128
> -                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> -                ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
> -                cc = !int128_eq(ov, cv);
> -#else
> -                /* Note that we asserted !parallel above.  */
> -                g_assert_not_reached();
> -#endif
> -            } else {
> +            if (!parallel) {
>                  uint64_t oh = cpu_ldq_data_ra(env, a1 + 0, ra);
>                  uint64_t ol = cpu_ldq_data_ra(env, a1 + 8, ra);
>  
> @@ -1567,6 +1559,13 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>  
>                  cpu_stq_data_ra(env, a1 + 0, int128_gethi(nv), ra);
>                  cpu_stq_data_ra(env, a1 + 8, int128_getlo(nv), ra);
> +            } else if (HAVE_CMPXCHG128) {
> +                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> +                ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
> +                cc = !int128_eq(ov, cv);
> +            } else {
> +                /* Note that we asserted !parallel above.  */
> +                g_assert_not_reached();
>              }
>  
>              env->regs[r3 + 0] = int128_gethi(ov);
> @@ -1596,18 +1595,16 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>              cpu_stq_data_ra(env, a2, svh, ra);
>              break;
>          case 4:
> -            if (parallel) {
> -#ifdef CONFIG_ATOMIC128
> +            if (!parallel) {
> +                cpu_stq_data_ra(env, a2 + 0, svh, ra);
> +                cpu_stq_data_ra(env, a2 + 8, svl, ra);
> +            } else if (HAVE_ATOMIC128) {
>                  TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
>                  Int128 sv = int128_make128(svl, svh);
>                  helper_atomic_sto_be_mmu(env, a2, sv, oi, ra);
> -#else
> +            } else {
>                  /* Note that we asserted !parallel above.  */
>                  g_assert_not_reached();
> -#endif
> -            } else {
> -                cpu_stq_data_ra(env, a2 + 0, svh, ra);
> -                cpu_stq_data_ra(env, a2 + 8, svl, ra);
>              }
>              break;
>          default:
> @@ -2105,21 +2102,18 @@ static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
>      uintptr_t ra = GETPC();
>      uint64_t hi, lo;
>  
> -    if (parallel) {
> -#ifndef CONFIG_ATOMIC128
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -#else
> +    if (!parallel) {
> +        check_alignment(env, addr, 16, ra);
> +        hi = cpu_ldq_data_ra(env, addr + 0, ra);
> +        lo = cpu_ldq_data_ra(env, addr + 8, ra);
> +    } else if (HAVE_ATOMIC128) {
>          int mem_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
>          Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
>          hi = int128_gethi(v);
>          lo = int128_getlo(v);
> -#endif
>      } else {
> -        check_alignment(env, addr, 16, ra);
> -
> -        hi = cpu_ldq_data_ra(env, addr + 0, ra);
> -        lo = cpu_ldq_data_ra(env, addr + 8, ra);
> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>      }
>  
>      env->retxl = lo;
> @@ -2142,21 +2136,17 @@ static void do_stpq(CPUS390XState *env, uint64_t addr,
>  {
>      uintptr_t ra = GETPC();
>  
> -    if (parallel) {
> -#ifndef CONFIG_ATOMIC128
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -#else
> -        int mem_idx = cpu_mmu_index(env, false);
> -        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> -
> -        Int128 v = int128_make128(low, high);
> -        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
> -#endif
> -    } else {
> +    if (!parallel) {
>          check_alignment(env, addr, 16, ra);
> -
>          cpu_stq_data_ra(env, addr + 0, high, ra);
>          cpu_stq_data_ra(env, addr + 8, low, ra);
> +    } else if (HAVE_ATOMIC128) {
> +        int mem_idx = cpu_mmu_index(env, false);
> +        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> +        Int128 v = int128_make128(low, high);
> +        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
> +    } else {
> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>      }
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Only case 1 still looks fairly ugly with the ifdefs.

-- 

Thanks,

David / dhildenb
