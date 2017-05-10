Received: from eggs.gnu.org ([2001:4830:134:3::10]:41154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8Ief-0004Xo-SZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8Iec-0002jo-Q0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:51:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d8Iec-0002ja-Gy
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:51:10 -0400
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-6-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66216250-14b3-b7e0-f981-15a57bf11361@redhat.com>
Date: Wed, 10 May 2017 05:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170509180715.22910-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] target/s390x: Use atomic operations
 for COMPARE SWAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 09.05.2017 20:07, Richard Henderson wrote:
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def | 10 +++---
>  target/s390x/mem_helper.c  | 39 ++++++++++++++++++++++
>  target/s390x/translate.c   | 83 ++++++++--------------------------------------
>  4 files changed, 59 insertions(+), 74 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 01adb50..0b70770 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -25,6 +25,7 @@ DEF_HELPER_3(cxgb, i64, env, s64, i32)
>  DEF_HELPER_3(celgb, i64, env, i64, i32)
>  DEF_HELPER_3(cdlgb, i64, env, i64, i32)
>  DEF_HELPER_3(cxlgb, i64, env, i64, i32)
> +DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
>  DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 0909060..5e5fcc5 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -239,12 +239,12 @@
>      D(0xec7d, CLGIJ,   RIE_c, GIE, r1_o, i2_8u, 0, 0, cj, 0, 1)
>  
>  /* COMPARE AND SWAP */
> -    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, 0)
> -    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, 0)
> -    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, 1)
> +    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
> +    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
> +    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, MO_TEQ)
>  /* COMPARE DOUBLE AND SWAP */
> -    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, 1)
> -    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, 1)
> +    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
> +    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
>      C(0xeb3e, CDSG,    RSY_a, Z,   0, 0, 0, 0, cdsg, 0)
>  
>  /* COMPARE AND TRAP */
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 675aba2..c74ded3 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -844,6 +844,45 @@ uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
>      return cc;
>  }
>  
> +void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
> +                  uint32_t r1, uint32_t r3)
> +{
> +    uintptr_t ra = GETPC();
> +    Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
> +    Int128 newv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
> +    int mem_idx = cpu_mmu_index(env, false);
> +    Int128 oldv;
> +    bool fail;
> +
> +    if (parallel_cpus) {
> +#ifndef CONFIG_ATOMIC128
> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> +#else
> +        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> +        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
> +        fail = !int128_eq(oldv, cmpv);
> +#endif
> +    } else {

Have you seen the compilation issue that patchew reported? I think
you've got to move the definition of mem_idx into the "#else" part, too.

 Thomas
