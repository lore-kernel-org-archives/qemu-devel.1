Received: from eggs.gnu.org ([2001:4830:134:3::10]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGiS-00036v-Ia
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGiR-0004vB-IJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:01:00 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGiR-0004tY-9K
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:00:59 -0500
Received: by mail-pl0-x241.google.com with SMTP id 31so5205605ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:00:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-41-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 17:00:37 +0000
Message-ID: <CAFEAcA8vFOjA8OST2237SybD-187Bhke3DmBPLUy7ZLCcXSEhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 40/67] target/arm: Implement SVE Integer
 Compare - Scalars Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  2 +
>  target/arm/sve_helper.c    | 31 ++++++++++++++++
>  target/arm/translate-sve.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 ++++
>  4 files changed, 133 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index dd4f8f754d..1863106d0f 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -678,3 +678,5 @@ DEF_HELPER_FLAGS_4(sve_brkn, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
>
>  DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_3(sve_while, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index dd884bdd1c..80b78da834 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2716,3 +2716,34 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
>      }
>      return sum;
>  }
> +
> +uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)

This could really use a comment about what part of the overall
instruction it's doing.

> +{
> +    uintptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
> +    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
> +    uint64_t esz_mask = pred_esz_masks[esz];
> +    ARMPredicateReg *d = vd;
> +    uint32_t flags;
> +    intptr_t i;
> +
> +    /* Begin with a zero predicate register.  */
> +    flags = do_zero(d, oprsz);
> +    if (count == 0) {
> +        return flags;
> +    }
> +
> +    /* Scale from predicate element count to bits.  */
> +    count <<= esz;
> +    /* Bound to the bits in the predicate.  */
> +    count = MIN(count, oprsz * 8);
> +
> +    /* Set all of the requested bits.  */
> +    for (i = 0; i < count / 64; ++i) {
> +        d->p[i] = esz_mask;
> +    }
> +    if (count & 63) {
> +        d->p[i] = ~(-1ull << (count & 63)) & esz_mask;
> +    }
> +
> +    return predtest_ones(d, oprsz, esz_mask);
> +}
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 038800cc86..4b92a55c21 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -2847,6 +2847,98 @@ static void trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a,
>      do_sat_addsub_vec(s, a->esz, a->rd, a->rn, val, a->u, a->d);
>  }
>
> +static void trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
> +{
> +    TCGv_i64 op0 = read_cpu_reg(s, a->rn, 1);
> +    TCGv_i64 op1 = read_cpu_reg(s, a->rm, 1);
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i32 t2, t3;
> +    TCGv_ptr ptr;
> +    unsigned desc, vsz = vec_full_reg_size(s);
> +    TCGCond cond;
> +
> +    if (!a->sf) {
> +        if (a->u) {
> +            tcg_gen_ext32u_i64(op0, op0);
> +            tcg_gen_ext32u_i64(op1, op1);
> +        } else {
> +            tcg_gen_ext32s_i64(op0, op0);
> +            tcg_gen_ext32s_i64(op1, op1);
> +        }
> +    }
> +
> +    /* For the helper, compress the different conditions into a computation
> +     * of how many iterations for which the condition is true.
> +     *
> +     * This is slightly complicated by 0 <= UINT64_MAX, which is nominally
> +     * 2**64 iterations, overflowing to 0.  Of course, predicate registers
> +     * aren't that large, so any value >= predicate size is sufficient.
> +     */
> +    tcg_gen_sub_i64(t0, op1, op0);
> +
> +    /* t0 = MIN(op1 - op0, vsz).  */
> +    if (a->eq) {
> +        /* Equality means one more iteration.  */
> +        tcg_gen_movi_i64(t1, vsz - 1);
> +        tcg_gen_movcond_i64(TCG_COND_LTU, t0, t0, t1, t0, t1);
> +        tcg_gen_addi_i64(t0, t0, 1);
> +    } else {
> +        tcg_gen_movi_i64(t1, vsz);
> +        tcg_gen_movcond_i64(TCG_COND_LTU, t0, t0, t1, t0, t1);
> +    }
> +
> +    /* t0 = (condition true ? t0 : 0).  */
> +    cond = (a->u
> +            ? (a->eq ? TCG_COND_LEU : TCG_COND_LTU)
> +            : (a->eq ? TCG_COND_LE : TCG_COND_LT));
> +    tcg_gen_movi_i64(t1, 0);
> +    tcg_gen_movcond_i64(cond, t0, op0, op1, t0, t1);
> +
> +    t2 = tcg_temp_new_i32();
> +    tcg_gen_extrl_i64_i32(t2, t0);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +
> +    desc = (vsz / 8) - 2;
> +    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
> +    t3 = tcg_const_i32(desc);
> +
> +    ptr = tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a->rd));
> +
> +    gen_helper_sve_while(t2, ptr, t2, t3);
> +    do_pred_flags(t2);
> +
> +    tcg_temp_free_ptr(ptr);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t3);
> +}

I got confused by this -- it is too far different from what the
pseudocode is doing. Could we have more explanatory comments, please?

thanks
-- PMM
