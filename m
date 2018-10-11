Received: from eggs.gnu.org ([2001:4830:134:3::10]:58021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVvT-0001Ix-0e
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVvK-00006X-6q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:02:30 -0400
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-8-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5a792d12-3a9a-6645-1c8d-2e92e2d3a647@redhat.com>
Date: Thu, 11 Oct 2018 10:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <20181003193931.18096-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 7/9] target/s390x: Split
 do_cdsg, do_lpq, do_stpq
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
>  target/s390x/mem_helper.c | 128 ++++++++++++++++++--------------------
>  1 file changed, 61 insertions(+), 67 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index e106f61b4e..b5858d2fa2 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1380,57 +1380,58 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
>      return cc;
>  }
>  
> -static void do_cdsg(CPUS390XState *env, uint64_t addr,
> -                    uint32_t r1, uint32_t r3, bool parallel)
> +void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
> +                  uint32_t r1, uint32_t r3)
>  {
>      uintptr_t ra = GETPC();
>      Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
>      Int128 newv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
>      Int128 oldv;
> +    uint64_t oldh, oldl;
>      bool fail;
>  
> -    if (parallel) {
> -#if !HAVE_CMPXCHG128
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -#else
> -        int mem_idx = cpu_mmu_index(env, false);
> -        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> -        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
> -        fail = !int128_eq(oldv, cmpv);
> -#endif
> -    } else {
> -        uint64_t oldh, oldl;
> +    check_alignment(env, addr, 16, ra);
>  
> -        check_alignment(env, addr, 16, ra);
> +    oldh = cpu_ldq_data_ra(env, addr + 0, ra);
> +    oldl = cpu_ldq_data_ra(env, addr + 8, ra);
>  
> -        oldh = cpu_ldq_data_ra(env, addr + 0, ra);
> -        oldl = cpu_ldq_data_ra(env, addr + 8, ra);
> -
> -        oldv = int128_make128(oldl, oldh);
> -        fail = !int128_eq(oldv, cmpv);
> -        if (fail) {
> -            newv = oldv;
> -        }
> -
> -        cpu_stq_data_ra(env, addr + 0, int128_gethi(newv), ra);
> -        cpu_stq_data_ra(env, addr + 8, int128_getlo(newv), ra);
> +    oldv = int128_make128(oldl, oldh);
> +    fail = !int128_eq(oldv, cmpv);
> +    if (fail) {
> +        newv = oldv;
>      }
>  
> +    cpu_stq_data_ra(env, addr + 0, int128_gethi(newv), ra);
> +    cpu_stq_data_ra(env, addr + 8, int128_getlo(newv), ra);
> +
>      env->cc_op = fail;
>      env->regs[r1] = int128_gethi(oldv);
>      env->regs[r1 + 1] = int128_getlo(oldv);
>  }
>  
> -void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
> -                  uint32_t r1, uint32_t r3)
> -{
> -    do_cdsg(env, addr, r1, r3, false);
> -}
> -
>  void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
>                             uint32_t r1, uint32_t r3)
>  {
> -    do_cdsg(env, addr, r1, r3, true);
> +    uintptr_t ra = GETPC();
> +    Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
> +    Int128 newv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
> +    int mem_idx;
> +    TCGMemOpIdx oi;
> +    Int128 oldv;
> +    bool fail;
> +
> +    if (!HAVE_CMPXCHG128) {
> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> +    }
> +
> +    mem_idx = cpu_mmu_index(env, false);
> +    oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> +    oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
> +    fail = !int128_eq(oldv, cmpv);
> +
> +    env->cc_op = fail;
> +    env->regs[r1] = int128_gethi(oldv);
> +    env->regs[r1 + 1] = int128_getlo(oldv);
>  }
>  
>  static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
> @@ -2097,16 +2098,25 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
>  #endif
>  
>  /* load pair from quadword */
> -static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
> +uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
>  {
>      uintptr_t ra = GETPC();
>      uint64_t hi, lo;
>  
> -    if (!parallel) {
> -        check_alignment(env, addr, 16, ra);
> -        hi = cpu_ldq_data_ra(env, addr + 0, ra);
> -        lo = cpu_ldq_data_ra(env, addr + 8, ra);
> -    } else if (HAVE_ATOMIC128) {
> +    check_alignment(env, addr, 16, ra);
> +    hi = cpu_ldq_data_ra(env, addr + 0, ra);
> +    lo = cpu_ldq_data_ra(env, addr + 8, ra);
> +
> +    env->retxl = lo;
> +    return hi;
> +}
> +
> +uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
> +{
> +    uintptr_t ra = GETPC();
> +    uint64_t hi, lo;
> +
> +    if (HAVE_ATOMIC128) {
>          int mem_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
>          Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
> @@ -2120,27 +2130,23 @@ static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
>      return hi;
>  }
>  
> -uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
> -{
> -    return do_lpq(env, addr, false);
> -}
> -
> -uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
> -{
> -    return do_lpq(env, addr, true);
> -}
> -
>  /* store pair to quadword */
> -static void do_stpq(CPUS390XState *env, uint64_t addr,
> -                    uint64_t low, uint64_t high, bool parallel)
> +void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
> +                  uint64_t low, uint64_t high)
>  {
>      uintptr_t ra = GETPC();
>  
> -    if (!parallel) {
> -        check_alignment(env, addr, 16, ra);
> -        cpu_stq_data_ra(env, addr + 0, high, ra);
> -        cpu_stq_data_ra(env, addr + 8, low, ra);
> -    } else if (HAVE_ATOMIC128) {
> +    check_alignment(env, addr, 16, ra);
> +    cpu_stq_data_ra(env, addr + 0, high, ra);
> +    cpu_stq_data_ra(env, addr + 8, low, ra);
> +}
> +
> +void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
> +                           uint64_t low, uint64_t high)
> +{
> +    uintptr_t ra = GETPC();
> +
> +    if (HAVE_ATOMIC128) {
>          int mem_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
>          Int128 v = int128_make128(low, high);
> @@ -2150,18 +2156,6 @@ static void do_stpq(CPUS390XState *env, uint64_t addr,
>      }
>  }
>  
> -void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
> -                  uint64_t low, uint64_t high)
> -{
> -    do_stpq(env, addr, low, high, false);
> -}
> -
> -void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
> -                           uint64_t low, uint64_t high)
> -{
> -    do_stpq(env, addr, low, high, true);
> -}
> -
>  /* Execute instruction.  This instruction executes an insn modified with
>     the contents of r1.  It does not change the executed instruction in memory;
>     it does not change the program counter.
> 

Way easier to read.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
