Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEHnX-0004cv-9f
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEHnT-0007CR-Vb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:41:23 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEHnT-0007Bl-L5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:41:19 -0500
Received: by mail-wm0-x243.google.com with SMTP id b189so9686259wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 08:41:19 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-5-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 16:41:10 +0000
Message-ID: <87vaie9lnd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 04/12] target/arm: Decode aa64 armv8.1
 three same extra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h         |  9 +++++
>  target/arm/advsimd_helper.c | 74 +++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c  | 84 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 167 insertions(+)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index ec098d8337..67583b3c2e 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -542,6 +542,15 @@ DEF_HELPER_2(dc_zva, void, env, i64)
>  DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>
> +DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #endif
> diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
> index 583c2b0dce..b0f4b02a12 100644
> --- a/target/arm/advsimd_helper.c
> +++ b/target/arm/advsimd_helper.c
> @@ -26,6 +26,16 @@
>
>  #define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |=3D CPSR_Q
>
> +static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
> +{
> +    uint64_t *d =3D vd + opr_sz;
> +    uintptr_t i;
> +
> +    for (i =3D opr_sz; i < max_sz; i +=3D 8) {
> +        *d++ =3D 0;
> +    }
> +}
> +
>  static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
>                                  int16_t src2, int16_t src3)
>  {
> @@ -51,6 +61,22 @@ uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, ui=
nt32_t src1,
>      return deposit32(e1, 16, 16, e2);
>  }
>

A few one line comments wouldn't go amiss for those trying to decode the
letter salad, e.g.:

/* Vector signed saturating rounding doubling multiply accumulate high
half result */

> +void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
> +                              void *ve, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    int16_t *d =3D vd;
> +    int16_t *n =3D vn;
> +    int16_t *m =3D vm;
> +    CPUARMState *env =3D ve;
> +    uintptr_t i;
> +
> +    for (i =3D 0; i < opr_sz / 2; ++i) {
> +        d[i] =3D inl_qrdmlah_s16(env, n[i], m[i], d[i]);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
>  static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
>                                  int16_t src2, int16_t src3)
>  {
> @@ -76,6 +102,22 @@ uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, u=
int32_t src1,
>      return deposit32(e1, 16, 16, e2);
>  }
>
> +void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
> +                              void *ve, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    int16_t *d =3D vd;
> +    int16_t *n =3D vn;
> +    int16_t *m =3D vm;
> +    CPUARMState *env =3D ve;
> +    uintptr_t i;
> +
> +    for (i =3D 0; i < opr_sz / 2; ++i) {
> +        d[i] =3D inl_qrdmlsh_s16(env, n[i], m[i], d[i]);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
>  uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
>                                    int32_t src2, int32_t src3)
>  {
> @@ -90,6 +132,22 @@ uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, i=
nt32_t src1,
>      return ret;
>  }
>
> +void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
> +                              void *ve, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    int32_t *d =3D vd;
> +    int32_t *n =3D vn;
> +    int32_t *m =3D vm;
> +    CPUARMState *env =3D ve;
> +    uintptr_t i;
> +
> +    for (i =3D 0; i < opr_sz / 4; ++i) {
> +        d[i] =3D helper_neon_qrdmlah_s32(env, n[i], m[i], d[i]);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
>  uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
>                                    int32_t src2, int32_t src3)
>  {
> @@ -103,3 +161,19 @@ uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, =
int32_t src1,
>      }
>      return ret;
>  }
> +
> +void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
> +                              void *ve, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    int32_t *d =3D vd;
> +    int32_t *n =3D vn;
> +    int32_t *m =3D vm;
> +    CPUARMState *env =3D ve;
> +    uintptr_t i;
> +
> +    for (i =3D 0; i < opr_sz / 4; ++i) {
> +        d[i] =3D helper_neon_qrdmlsh_s32(env, n[i], m[i], d[i]);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 182853e3bb..0ea47a9dff 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -9874,6 +9874,89 @@ static void disas_simd_three_reg_same(DisasContext=
 *s, uint32_t insn)
>      }
>  }
>
> +/* AdvSIMD three same extra
> + *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
> + * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
> + * | 0 | Q | U | 0 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
> + * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
> + */
> +static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t in=
sn)
> +{
> +    void (*fn_gvec_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32=
);
> +    int rd =3D extract32(insn, 0, 5);
> +    int rn =3D extract32(insn, 5, 5);
> +    int opcode =3D extract32(insn, 11, 4);
> +    int rm =3D extract32(insn, 16, 5);
> +    int size =3D extract32(insn, 22, 2);
> +    bool u =3D extract32(insn, 29, 1);
> +    bool is_q =3D extract32(insn, 30, 1);
> +    int feature;
> +
> +    if (!u) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    switch (opcode) {
> +    case 0x0: /* SQRDMLAH (vector) */
> +    case 0x1: /* SQRDMLSH (vector) */
> +        if (size !=3D 1 && size !=3D 2) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        feature =3D ARM_FEATURE_V8_1_SIMD;
> +        break;
> +    default:
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    if (!arm_dc_feature(s, feature)) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +    if (!fp_access_check(s)) {
> +        return;
> +    }
> +
> +    switch (opcode) {
> +    case 0x0: /* SQRDMLAH (vector) */
> +        switch (size) {
> +        case 1:
> +            fn_gvec_ptr =3D gen_helper_gvec_qrdmlah_s16;
> +            break;
> +        case 2:
> +            fn_gvec_ptr =3D gen_helper_gvec_qrdmlah_s32;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        goto do_env;
> +
> +    case 0x1: /* SQRDMLSH (vector) */
> +        switch (size) {
> +        case 1:
> +            fn_gvec_ptr =3D gen_helper_gvec_qrdmlsh_s16;
> +            break;
> +        case 2:
> +            fn_gvec_ptr =3D gen_helper_gvec_qrdmlsh_s32;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    do_env:
> +        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> +                           vec_full_reg_offset(s, rn),
> +                           vec_full_reg_offset(s, rm), cpu_env,
> +                           is_q ? 16 : 8, vec_full_reg_size(s),
> +                           0, fn_gvec_ptr);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
>                                    int size, int rn, int rd)
>  {
> @@ -11261,6 +11344,7 @@ static void disas_crypto_two_reg_sha(DisasContext=
 *s, uint32_t insn)
>  static const AArch64DecodeTable data_proc_simd[] =3D {
>      /* pattern  ,  mask     ,  fn                        */
>      { 0x0e200400, 0x9f200400, disas_simd_three_reg_same },
> +    { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
>      { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
>      { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
>      { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },

Other that the comments:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
