Received: from eggs.gnu.org ([2001:4830:134:3::10]:39487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7iB-00014e-Jk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7iA-0002cV-JR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:01:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dW7iA-0002PC-CV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:01:18 -0400
Date: Fri, 14 Jul 2017 23:01:05 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170714210105.mchifmgphjjmaehz@aurel32.net>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710204521.2058-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-10 10:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |   1 +
>  target/s390x/cpu_models.c  |   2 +
>  target/s390x/mem_helper.c  | 189 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  13 +++-
>  target/s390x/insn-data.def |   2 +
>  5 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index ede8471..513b402 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1353,6 +1353,195 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
>      env->regs[r1 + 1] = int128_getlo(oldv);
>  }
>  
> +uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
> +{
> +#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
> +    uint32_t mem_idx = cpu_mmu_index(env, false);
> +#endif
> +    uintptr_t ra = GETPC();
> +    uint32_t fc = extract32(env->regs[0], 0, 8);
> +    uint32_t sc = extract32(env->regs[0], 8, 8);
> +    uint64_t pl = get_address(env, 1) & -16;
> +    uint64_t svh, svl;
> +    uint32_t cc;
> +
> +    /* Sanity check the function code and storage characteristic.  */
> +    if (fc > 1 || sc > 3) {
> +        if (!s390_has_feat(S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2)) {
> +            goto spec_exception;
> +        }
> +        if (fc > 2 || sc > 4 || (fc == 2 && (r3 & 1))) {
> +            goto spec_exception;
> +        }
> +    }
> +
> +    /* Sanity check the alignments.  */
> +    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
> +        goto spec_exception;
> +    }
> +
> +    /* Sanity check writability of the store address.  */
> +#ifndef CONFIG_USER_ONLY
> +    probe_write(env, a2, mem_idx, ra);
> +#endif
> +
> +    /* Note that the compare-and-swap is atomic, and the store is atomic, but
> +       the complete operation is not.  Therefore we do not need to assert serial
> +       context in order to implement this.  That said, restart early if we can't
> +       support either operation that is supposed to be atomic.  */
> +    if (parallel_cpus) {
> +        int mask = 0;
> +#if !defined(CONFIG_ATOMIC64)
> +        mask = -8;
> +#elif !defined(CONFIG_ATOMIC128)
> +        mask = -16;
> +#endif
> +        if (((4 << fc) | (1 << sc)) & mask) {
> +            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> +        }
> +    }

This doesn't look correct. For a 16-byte store, ie sc = 4, and with
ATOMIC128 support, ie mask = -16, the condition is true.

> +    /* All loads happen before all stores.  For simplicity, load the entire
> +       store value area from the parameter list.  */
> +    svh = cpu_ldq_data_ra(env, pl + 16, ra);
> +    svl = cpu_ldq_data_ra(env, pl + 24, ra);
> +
> +    switch (fc) {
> +    case 0:
> +        {
> +            uint32_t nv = cpu_ldl_data_ra(env, pl, ra);
> +            uint32_t cv = env->regs[r3];
> +            uint32_t ov;
> +
> +            if (parallel_cpus) {
> +#ifdef CONFIG_USER_ONLY
> +                uint32_t *haddr = g2h(a1);
> +                ov = atomic_cmpxchg__nocheck(haddr, cv, nv);
> +#else
> +                TCGMemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mem_idx);
> +                ov = helper_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi, ra);
> +#endif

Not a problem with the patch itself, but how complicated would it be to
make helper_atomic_cmpxchgl_be_mmu (just like the o version) available
also in user mode? That would make less #ifdef in the backends.


The remaining of the patch looks all good to me.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
