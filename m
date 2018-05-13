Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHlJe-0003lf-1x
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHlJZ-0000xM-M3
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:21:08 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fHlJZ-0000vW-Ba
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:21:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id h5-v6so9073592wrm.4
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 00:21:05 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
	<20180512003217.9105-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180512003217.9105-4-richard.henderson@linaro.org>
Date: Sun, 13 May 2018 08:21:02 +0100
Message-ID: <87r2mgowbl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/11] target/arm: Implement FCVT
 (scalar, integer) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Cc: qemu-stable@nongnu.org
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hmm oddly this fails to apply:

Applying: target/arm: Implement FCVT (scalar,integer) for fp16
Using index info to reconstruct a base tree...
M	target/arm/helper.c
M	target/arm/helper.h
M	target/arm/translate-a64.c
Falling back to patching base and 3-way merge...
Auto-merging target/arm/translate-a64.c
Auto-merging target/arm/helper.h
CONFLICT (content): Merge conflict in target/arm/helper.h
Auto-merging target/arm/helper.c
CONFLICT (content): Merge conflict in target/arm/helper.c
error: Failed to merge in the changes.
Patch failed at 0001 target/arm: Implement FCVT (scalar,integer) for fp16
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Which is odd considering not much has changed there recently.

> ---
>  target/arm/helper.h        |  6 +++
>  target/arm/helper.c        | 38 ++++++++++++++-
>  target/arm/translate-a64.c | 96 +++++++++++++++++++++++++++++++-------
>  3 files changed, 122 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 1969b37f2d..ce89968b2d 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -151,6 +151,10 @@ DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32,=
 ptr)
>  DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
>  DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
>  DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
> +DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
> +DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
> +DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
> +DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
>  DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
>  DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
>  DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
> @@ -177,6 +181,8 @@ DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
>  DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
>  DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
>  DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
> +DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
> +DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
>
>  DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
>  DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 817f9d81a0..c6fd7f9479 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11427,8 +11427,12 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
>  #undef VFP_CONV_FIX_A64
>
>  /* Conversion to/from f16 can overflow to infinity before/after scaling.
> - * Therefore we convert to f64 (which does not round), scale,
> - * and then convert f64 to f16 (which may round).
> + * Therefore we convert to f64, scale, and then convert f64 to f16; or
> + * vice versa for conversion to integer.
> + *
> + * For 16- and 32-bit integers, the conversion to f64 never rounds.
> + * For 64-bit integers, any integer that would cause rounding will also
> + * overflow to f16 infinity, so there is no double rounding problem.
>   */
>
>  static float16 do_postscale_fp16(float64 f, int shift, float_status *fps=
t)
> @@ -11446,6 +11450,16 @@ float16 HELPER(vfp_ultoh)(uint32_t x, uint32_t s=
hift, void *fpst)
>      return do_postscale_fp16(uint32_to_float64(x, fpst), shift, fpst);
>  }
>
> +float16 HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
> +{
> +    return do_postscale_fp16(int64_to_float64(x, fpst), shift, fpst);
> +}
> +
> +float16 HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
> +{
> +    return do_postscale_fp16(uint64_to_float64(x, fpst), shift, fpst);
> +}
> +
>  static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
>  {
>      if (unlikely(float16_is_any_nan(f))) {
> @@ -11475,6 +11489,26 @@ uint32_t HELPER(vfp_touhh)(float16 x, uint32_t s=
hift, void *fpst)
>      return float64_to_uint16(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>
> +uint32_t HELPER(vfp_toslh)(float16 x, uint32_t shift, void *fpst)
> +{
> +    return float64_to_int32(do_prescale_fp16(x, shift, fpst), fpst);
> +}
> +
> +uint32_t HELPER(vfp_toulh)(float16 x, uint32_t shift, void *fpst)
> +{
> +    return float64_to_uint32(do_prescale_fp16(x, shift, fpst), fpst);
> +}
> +
> +uint64_t HELPER(vfp_tosqh)(float16 x, uint32_t shift, void *fpst)
> +{
> +    return float64_to_int64(do_prescale_fp16(x, shift, fpst), fpst);
> +}
> +
> +uint64_t HELPER(vfp_touqh)(float16 x, uint32_t shift, void *fpst)
> +{
> +    return float64_to_uint64(do_prescale_fp16(x, shift, fpst), fpst);
> +}
> +
>  /* Set the current fp rounding mode and return the old one.
>   * The argument is a softfloat float_round_ value.
>   */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 11d8c07943..93fb15d185 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5511,11 +5511,11 @@ static void handle_fpfpcvt(DisasContext *s, int r=
d, int rn, int opcode,
>                             bool itof, int rmode, int scale, int sf, int =
type)
>  {
>      bool is_signed =3D !(opcode & 1);
> -    bool is_double =3D type;
>      TCGv_ptr tcg_fpstatus;
> -    TCGv_i32 tcg_shift;
> +    TCGv_i32 tcg_shift, tcg_single;
> +    TCGv_i64 tcg_double;
>
> -    tcg_fpstatus =3D get_fpstatus_ptr(false);
> +    tcg_fpstatus =3D get_fpstatus_ptr(type =3D=3D 3);
>
>      tcg_shift =3D tcg_const_i32(64 - scale);
>
> @@ -5533,8 +5533,9 @@ static void handle_fpfpcvt(DisasContext *s, int rd,=
 int rn, int opcode,
>              tcg_int =3D tcg_extend;
>          }
>
> -        if (is_double) {
> -            TCGv_i64 tcg_double =3D tcg_temp_new_i64();
> +        switch (type) {
> +        case 1: /* float64 */
> +            tcg_double =3D tcg_temp_new_i64();
>              if (is_signed) {
>                  gen_helper_vfp_sqtod(tcg_double, tcg_int,
>                                       tcg_shift, tcg_fpstatus);
> @@ -5544,8 +5545,10 @@ static void handle_fpfpcvt(DisasContext *s, int rd=
, int rn, int opcode,
>              }
>              write_fp_dreg(s, rd, tcg_double);
>              tcg_temp_free_i64(tcg_double);
> -        } else {
> -            TCGv_i32 tcg_single =3D tcg_temp_new_i32();
> +            break;
> +
> +        case 0: /* float32 */
> +            tcg_single =3D tcg_temp_new_i32();
>              if (is_signed) {
>                  gen_helper_vfp_sqtos(tcg_single, tcg_int,
>                                       tcg_shift, tcg_fpstatus);
> @@ -5555,6 +5558,23 @@ static void handle_fpfpcvt(DisasContext *s, int rd=
, int rn, int opcode,
>              }
>              write_fp_sreg(s, rd, tcg_single);
>              tcg_temp_free_i32(tcg_single);
> +            break;
> +
> +        case 3: /* float16 */
> +            tcg_single =3D tcg_temp_new_i32();
> +            if (is_signed) {
> +                gen_helper_vfp_sqtoh(tcg_single, tcg_int,
> +                                     tcg_shift, tcg_fpstatus);
> +            } else {
> +                gen_helper_vfp_uqtoh(tcg_single, tcg_int,
> +                                     tcg_shift, tcg_fpstatus);
> +            }
> +            write_fp_sreg(s, rd, tcg_single);
> +            tcg_temp_free_i32(tcg_single);
> +            break;
> +
> +        default:
> +            g_assert_not_reached();
>          }
>      } else {
>          TCGv_i64 tcg_int =3D cpu_reg(s, rd);
> @@ -5571,8 +5591,9 @@ static void handle_fpfpcvt(DisasContext *s, int rd,=
 int rn, int opcode,
>
>          gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
>
> -        if (is_double) {
> -            TCGv_i64 tcg_double =3D read_fp_dreg(s, rn);
> +        switch (type) {
> +        case 1: /* float64 */
> +            tcg_double =3D read_fp_dreg(s, rn);
>              if (is_signed) {
>                  if (!sf) {
>                      gen_helper_vfp_tosld(tcg_int, tcg_double,
> @@ -5590,9 +5611,14 @@ static void handle_fpfpcvt(DisasContext *s, int rd=
, int rn, int opcode,
>                                           tcg_shift, tcg_fpstatus);
>                  }
>              }
> +            if (!sf) {
> +                tcg_gen_ext32u_i64(tcg_int, tcg_int);
> +            }
>              tcg_temp_free_i64(tcg_double);
> -        } else {
> -            TCGv_i32 tcg_single =3D read_fp_sreg(s, rn);
> +            break;
> +
> +        case 0: /* float32 */
> +            tcg_single =3D read_fp_sreg(s, rn);
>              if (sf) {
>                  if (is_signed) {
>                      gen_helper_vfp_tosqs(tcg_int, tcg_single,
> @@ -5614,14 +5640,39 @@ static void handle_fpfpcvt(DisasContext *s, int r=
d, int rn, int opcode,
>                  tcg_temp_free_i32(tcg_dest);
>              }
>              tcg_temp_free_i32(tcg_single);
> +            break;
> +
> +        case 3: /* float16 */
> +            tcg_single =3D read_fp_sreg(s, rn);
> +            if (sf) {
> +                if (is_signed) {
> +                    gen_helper_vfp_tosqh(tcg_int, tcg_single,
> +                                         tcg_shift, tcg_fpstatus);
> +                } else {
> +                    gen_helper_vfp_touqh(tcg_int, tcg_single,
> +                                         tcg_shift, tcg_fpstatus);
> +                }
> +            } else {
> +                TCGv_i32 tcg_dest =3D tcg_temp_new_i32();
> +                if (is_signed) {
> +                    gen_helper_vfp_toslh(tcg_dest, tcg_single,
> +                                         tcg_shift, tcg_fpstatus);
> +                } else {
> +                    gen_helper_vfp_toulh(tcg_dest, tcg_single,
> +                                         tcg_shift, tcg_fpstatus);
> +                }
> +                tcg_gen_extu_i32_i64(tcg_int, tcg_dest);
> +                tcg_temp_free_i32(tcg_dest);
> +            }
> +            tcg_temp_free_i32(tcg_single);
> +            break;
> +
> +        default:
> +            g_assert_not_reached();
>          }
>
>          gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
>          tcg_temp_free_i32(tcg_rmode);
> -
> -        if (!sf) {
> -            tcg_gen_ext32u_i64(tcg_int, tcg_int);
> -        }
>      }
>
>      tcg_temp_free_ptr(tcg_fpstatus);
> @@ -5791,7 +5842,20 @@ static void disas_fp_int_conv(DisasContext *s, uin=
t32_t insn)
>          /* actual FP conversions */
>          bool itof =3D extract32(opcode, 1, 1);
>
> -        if (type > 1 || (rmode !=3D 0 && opcode > 1)) {
> +        if (rmode !=3D 0 && opcode > 1) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        switch (type) {
> +        case 0: /* float32 */
> +        case 1: /* float64 */
> +            break;
> +        case 3: /* float16 */
> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                break;
> +            }
> +            /* fallthru */
> +        default:
>              unallocated_encoding(s);
>              return;
>          }


--
Alex Benn=C3=A9e
