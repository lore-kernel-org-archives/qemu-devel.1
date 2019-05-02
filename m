Received: from eggs.gnu.org ([209.51.188.92]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDvu-0006Xe-2l
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDvs-00021d-Ep
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:47:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDvs-00021I-2N
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:47:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id s15so4003224wra.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:47:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s3sm45295626wre.97.2019.05.02.08.47.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 08:47:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 94B811FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 16:47:33 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-21-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-21-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 16:47:33 +0100
Message-ID: <8736lw6ep6.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/29] tcg: Add support for vector
 absolute value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/tcg-runtime.h      |  5 +++
>  tcg/aarch64/tcg-target.h     |  1 +
>  tcg/i386/tcg-target.h        |  1 +
>  tcg/tcg-op-gvec.h            |  2 ++
>  tcg/tcg-opc.h                |  1 +
>  tcg/tcg.h                    |  1 +
>  accel/tcg/tcg-runtime-gvec.c | 48 +++++++++++++++++++++++++++
>  tcg/tcg-op-gvec.c            | 63 ++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c             | 39 ++++++++++++++++++++++
>  tcg/tcg.c                    |  2 ++
>  tcg/README                   |  4 +++
>  11 files changed, 167 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index ed3ce5fd91..6d73dc2d65 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -225,6 +225,11 @@ DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void=
, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_3(gvec_abs8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_3(gvec_not, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_and, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index f5640a229b..21d06d928c 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -132,6 +132,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_orc_vec          1
>  #define TCG_TARGET_HAS_not_vec          1
>  #define TCG_TARGET_HAS_neg_vec          1
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          0
>  #define TCG_TARGET_HAS_shv_vec          1
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 618aa520d2..7445f05885 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -182,6 +182,7 @@ extern bool have_avx2;
>  #define TCG_TARGET_HAS_orc_vec          0
>  #define TCG_TARGET_HAS_not_vec          0
>  #define TCG_TARGET_HAS_neg_vec          0
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          1
>  #define TCG_TARGET_HAS_shv_vec          have_avx2
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index 6ee98f3378..52a398c190 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -228,6 +228,8 @@ void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, u=
int32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz);
>
>  void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 4bf71f261f..4a2dd116eb 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -225,6 +225,7 @@ DEF(add_vec, 1, 2, 0, IMPLVEC)
>  DEF(sub_vec, 1, 2, 0, IMPLVEC)
>  DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
>  DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +DEF(abs_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_abs_vec))
>  DEF(ssadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
>  DEF(usadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
>  DEF(sssub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 2c7315da25..0e01a70d66 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -176,6 +176,7 @@ typedef uint64_t TCGRegSet;
>      && !defined(TCG_TARGET_HAS_v128) \
>      && !defined(TCG_TARGET_HAS_v256)
>  #define TCG_TARGET_MAYBE_vec            0
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_neg_vec          0
>  #define TCG_TARGET_HAS_not_vec          0
>  #define TCG_TARGET_HAS_andc_vec         0
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 2152fb6903..0f09e0ef38 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -398,6 +398,54 @@ void HELPER(gvec_neg64)(void *d, void *a, uint32_t d=
esc)
>      clear_high(d, oprsz, desc);
>  }
>
> +void HELPER(gvec_abs8)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int8_t)) {
> +        int8_t aa =3D *(int8_t *)(a + i);
> +        *(int8_t *)(d + i) =3D aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int16_t)) {
> +        int16_t aa =3D *(int16_t *)(a + i);
> +        *(int16_t *)(d + i) =3D aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs32)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
> +        int32_t aa =3D *(int32_t *)(a + i);
> +        *(int32_t *)(d + i) =3D aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs64)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
> +        int64_t aa =3D *(int64_t *)(a + i);
> +        *(int64_t *)(d + i) =3D aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
>  void HELPER(gvec_mov)(void *d, void *a, uint32_t desc)
>  {
>      intptr_t oprsz =3D simd_oprsz(desc);
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 8fc5ba042b..bbccb3f5a1 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -2177,6 +2177,69 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>      tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
>  }
>
> +static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
> +{
> +    TCGv_i64 t =3D tcg_temp_new_i64();
> +    int nbit =3D 8 << vece;
> +
> +    /* Create -1 for each negative element.  */
> +    tcg_gen_shri_i64(t, b, nbit - 1);
> +    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
> +    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
> +
> +    /*
> +     * Invert (via xor -1) and add one (via sub -1).
> +     * Because of the ordering the msb is cleared,
> +     * so we never have carry into the next element.
> +     */
> +    tcg_gen_xor_i64(d, b, t);
> +    tcg_gen_sub_i64(d, d, t);
> +
> +    tcg_temp_free_i64(t);
> +}
> +
> +static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    gen_absv_mask(d, b, MO_8);
> +}
> +
> +static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    gen_absv_mask(d, b, MO_16);
> +}
> +
> +void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_abs_vec, 0 };
> +    static const GVecGen2 g[4] =3D {
> +        { .fni8 =3D tcg_gen_vec_abs8_i64,
> +          .fniv =3D tcg_gen_abs_vec,
> +          .fno =3D gen_helper_gvec_abs8,
> +          .opt_opc =3D vecop_list,
> +          .vece =3D MO_8 },
> +        { .fni8 =3D tcg_gen_vec_abs16_i64,
> +          .fniv =3D tcg_gen_abs_vec,
> +          .fno =3D gen_helper_gvec_abs16,
> +          .opt_opc =3D vecop_list,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_abs_i32,
> +          .fniv =3D tcg_gen_abs_vec,
> +          .fno =3D gen_helper_gvec_abs32,
> +          .opt_opc =3D vecop_list,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_abs_i64,
> +          .fniv =3D tcg_gen_abs_vec,
> +          .fno =3D gen_helper_gvec_abs64,
> +          .opt_opc =3D vecop_list,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .vece =3D MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
> +}
> +
>  void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 16062f5995..543508d545 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -110,6 +110,14 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
>                  continue;
>              }
>              break;
> +        case INDEX_op_abs_vec:
> +            if (tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece)
> +                && (tcg_can_emit_vec_op(INDEX_op_smax_vec, type, vece) >=
 0
> +                    || tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece=
) > 0
> +                    || tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece)=
)) {
> +                continue;
> +            }
> +            break;
>          default:
>              break;
>          }
> @@ -429,6 +437,37 @@ void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv=
_vec a)
>      tcg_swap_vecop_list(hold_list);
>  }
>
> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
> +{
> +    const TCGOpcode *hold_list;
> +
> +    tcg_assert_listed_vecop(INDEX_op_abs_vec);
> +    hold_list =3D tcg_swap_vecop_list(NULL);
> +
> +    if (!do_op2(vece, r, a, INDEX_op_abs_vec)) {
> +        TCGType type =3D tcgv_vec_temp(r)->base_type;
> +        TCGv_vec t =3D tcg_temp_new_vec(type);
> +
> +        tcg_debug_assert(tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vec=
e));
> +        if (tcg_can_emit_vec_op(INDEX_op_smax_vec, type, vece) > 0) {
> +            tcg_gen_neg_vec(vece, t, a);
> +            tcg_gen_smax_vec(vece, r, a, t);
> +        } else {
> +            if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
> +                tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
> +            } else {
> +                do_dupi_vec(t, MO_REG, 0);
> +                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
> +            }
> +            tcg_gen_xor_vec(vece, r, a, t);
> +            tcg_gen_sub_vec(vece, r, r, t);
> +        }
> +
> +        tcg_temp_free_vec(t);
> +    }
> +    tcg_swap_vecop_list(hold_list);
> +}
> +
>  static void do_shifti(TCGOpcode opc, unsigned vece,
>                        TCGv_vec r, TCGv_vec a, int64_t i)
>  {
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index bb1e124e80..9393f21a5b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1616,6 +1616,8 @@ bool tcg_op_supported(TCGOpcode op)
>          return have_vec && TCG_TARGET_HAS_not_vec;
>      case INDEX_op_neg_vec:
>          return have_vec && TCG_TARGET_HAS_neg_vec;
> +    case INDEX_op_abs_vec:
> +        return have_vec && TCG_TARGET_HAS_abs_vec;
>      case INDEX_op_andc_vec:
>          return have_vec && TCG_TARGET_HAS_andc_vec;
>      case INDEX_op_orc_vec:
> diff --git a/tcg/README b/tcg/README
> index c30e5418a6..cbdfd3b6bc 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -561,6 +561,10 @@ E.g. VECL=3D1 -> 64 << 1 -> v128, and VECE=3D2 -> 1 =
<< 2 -> i32.
>
>    Similarly, v0 =3D -v1.
>
> +* abs_vec   v0, v1
> +
> +  Similarly, v0 =3D v1 < 0 ? -v1 : v1, in elements across the vector.
> +
>  * smin_vec:
>  * umin_vec:


--
Alex Benn=C3=A9e
