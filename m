Received: from eggs.gnu.org ([2001:4830:134:3::10]:57203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQGID-0003go-Vv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQGIB-0005Rf-Jd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:02:49 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQGIB-0005Qw-6z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:02:47 -0400
Received: by mail-oi0-x243.google.com with SMTP id 14-v6so2941232oie.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 11:02:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-16-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 19:02:25 +0100
Message-ID: <CAFEAcA-weWiOLsrucjWMUjAh3tgS02RgBChpZOiOgd3HZK+imw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 15/18] target/arm: Implement SVE
 Integer Compare - Scalars Group
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

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |   2 +
>  target/arm/sve_helper.c    |  31 +++++++++++
>  target/arm/translate-sve.c | 102 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |   8 +++
>  4 files changed, 143 insertions(+)
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
> index 8d1631ea3c..a65a06cc9e 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2736,3 +2736,34 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
>      }
>      return sum;
>  }
> +
> +uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
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

Is this d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask; ?

> +    }
> +
> +    return predtest_ones(d, oprsz, esz_mask);
> +}
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index e4815e4912..75eb36f110 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3081,6 +3081,108 @@ static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a,
>      return true;
>  }
>
> +/*
> + *** SVE Integer Compare Scalars Group
> + */
> +
> +static bool trans_CTERM(DisasContext *s, arg_CTERM *a, uint32_t insn)
> +{
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    TCGCond cond = (a->ne ? TCG_COND_NE : TCG_COND_EQ);
> +    TCGv_i64 rn = read_cpu_reg(s, a->rn, a->sf);
> +    TCGv_i64 rm = read_cpu_reg(s, a->rm, a->sf);
> +    TCGv_i64 cmp = tcg_temp_new_i64();
> +
> +    tcg_gen_setcond_i64(cond, cmp, rn, rm);
> +    tcg_gen_extrl_i64_i32(cpu_NF, cmp);
> +    tcg_temp_free_i64(cmp);
> +
> +    /* VF = !NF & !CF.  */
> +    tcg_gen_xori_i32(cpu_VF, cpu_NF, 1);
> +    tcg_gen_andc_i32(cpu_VF, cpu_VF, cpu_CF);
> +
> +    /* Both NF and VF actually look at bit 31.  */
> +    tcg_gen_neg_i32(cpu_NF, cpu_NF);
> +    tcg_gen_neg_i32(cpu_VF, cpu_VF);

Microoptimization, but I think you can save an instruction here
using
       /* VF = !NF & !CF == !(NF || CF); we know NF and CF are
        * both 0 or 1, so the result of the logical NOT has
        * VF bit 31 set or clear as required.
        */
       tcg_gen_or_i32(cpu_VF, cpu_NF, cpu_CF);
       tcg_gen_not_i32(cpu_VF, cpu_VF);
       tcg_gen_neg_i32(cpu_NF, cpu_NF);

though the OR ends up being 3-operand rather than 2.

> +    return true;
> +}
> +
> +static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
> +{
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
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

The comment says that 0 <= UINT64_MAX is a special case,
but I don't understand how the code accounts for it ?

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
> +    return true;
> +}
> +


thanks
-- PMM
