Received: from eggs.gnu.org ([2001:4830:134:3::10]:54886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYWvj-00059U-1d
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYWve-0005O9-0h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:25:47 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYWvd-0005NI-DN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:25:41 -0400
Received: by mail-wr0-x234.google.com with SMTP id e18-v6so5525816wrs.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:25:41 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-31-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-31-richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 14:25:38 +0100
Message-ID: <87vaa3ujot.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 30/35] target/arm: Pass index
 to AdvSIMD FCMLA (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> For aa64 advsimd, we had been passing the pre-indexed vector.
> However, sve applies the index to each 128-bit segment, so we
> need to pass in the index separately.
>
> For aa32 advsimd, the fp32 operation always has index 0, but
> we failed to interpret the fp16 index correctly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> ---
> v6:
>   * Fix double-indexing in translate-a64.c
>   * Fix non-indexing of fp16 in translate.c.
> ---
>  target/arm/translate-a64.c | 21 ++++++++++++---------
>  target/arm/translate.c     | 32 +++++++++++++++++++++++---------
>  target/arm/vec_helper.c    | 10 ++++++----
>  3 files changed, 41 insertions(+), 22 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8d8a4cecb0..eb3a4ab2f0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12669,15 +12669,18 @@ static void disas_simd_indexed(DisasContext *s,=
 uint32_t insn)
>      case 0x13: /* FCMLA #90 */
>      case 0x15: /* FCMLA #180 */
>      case 0x17: /* FCMLA #270 */
> -        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> -                           vec_full_reg_offset(s, rn),
> -                           vec_reg_offset(s, rm, index, size), fpst,
> -                           is_q ? 16 : 8, vec_full_reg_size(s),
> -                           extract32(insn, 13, 2), /* rot */
> -                           size =3D=3D MO_64
> -                           ? gen_helper_gvec_fcmlas_idx
> -                           : gen_helper_gvec_fcmlah_idx);
> -        tcg_temp_free_ptr(fpst);
> +        {
> +            int rot =3D extract32(insn, 13, 2);
> +            int data =3D (index << 2) | rot;
> +            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> +                               vec_full_reg_offset(s, rn),
> +                               vec_full_reg_offset(s, rm), fpst,
> +                               is_q ? 16 : 8, vec_full_reg_size(s), data,
> +                               size =3D=3D MO_64
> +                               ? gen_helper_gvec_fcmlas_idx
> +                               : gen_helper_gvec_fcmlah_idx);
> +            tcg_temp_free_ptr(fpst);
> +        }
>          return;
>      }
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2a3e4f5d4c..a7a980b1f2 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7826,26 +7826,42 @@ static int disas_neon_insn_3same_ext(DisasContext=
 *s, uint32_t insn)
>
>  static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t ins=
n)
>  {
> -    int rd, rn, rm, rot, size, opr_sz;
> +    gen_helper_gvec_3_ptr *fn_gvec_ptr;
> +    int rd, rn, rm, opr_sz, data;
>      TCGv_ptr fpst;
>      bool q;
>
>      q =3D extract32(insn, 6, 1);
>      VFP_DREG_D(rd, insn);
>      VFP_DREG_N(rn, insn);
> -    VFP_DREG_M(rm, insn);
>      if ((rd | rn) & q) {
>          return 1;
>      }
>
>      if ((insn & 0xff000f10) =3D=3D 0xfe000800) {
>          /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
> -        rot =3D extract32(insn, 20, 2);
> -        size =3D extract32(insn, 23, 1);
> -        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
> -            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
> +        int rot =3D extract32(insn, 20, 2);
> +        int size =3D extract32(insn, 23, 1);
> +        int index;
> +
> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
>              return 1;
>          }
> +        if (size =3D=3D 0) {
> +            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                return 1;
> +            }
> +            /* For fp16, rm is just Vm, and index is M.  */
> +            rm =3D extract32(insn, 0, 4);
> +            index =3D extract32(insn, 5, 1);
> +        } else {
> +            /* For fp32, rm is the usual M:Vm, and index is 0.  */
> +            VFP_DREG_M(rm, insn);
> +            index =3D 0;
> +        }
> +        data =3D (index << 2) | rot;
> +        fn_gvec_ptr =3D (size ? gen_helper_gvec_fcmlas_idx
> +                       : gen_helper_gvec_fcmlah_idx);
>      } else {
>          return 1;
>      }
> @@ -7864,9 +7880,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasCon=
text *s, uint32_t insn)
>      tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
>                         vfp_reg_offset(1, rn),
>                         vfp_reg_offset(1, rm), fpst,
> -                       opr_sz, opr_sz, rot,
> -                       size ? gen_helper_gvec_fcmlas_idx
> -                       : gen_helper_gvec_fcmlah_idx);
> +                       opr_sz, opr_sz, data, fn_gvec_ptr);
>      tcg_temp_free_ptr(fpst);
>      return 0;
>  }
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index 073e5c58e7..8f2dc4b989 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -317,10 +317,11 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, vo=
id *vm,
>      float_status *fpst =3D vfpst;
>      intptr_t flip =3D extract32(desc, SIMD_DATA_SHIFT, 1);
>      uint32_t neg_imag =3D extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    intptr_t index =3D extract32(desc, SIMD_DATA_SHIFT + 2, 2);
>      uint32_t neg_real =3D flip ^ neg_imag;
>      uintptr_t i;
> -    float16 e1 =3D m[H2(flip)];
> -    float16 e3 =3D m[H2(1 - flip)];
> +    float16 e1 =3D m[H2(2 * index + flip)];
> +    float16 e3 =3D m[H2(2 * index + 1 - flip)];
>
>      /* Shift boolean to the sign bit so we can xor to negate.  */
>      neg_real <<=3D 15;
> @@ -377,10 +378,11 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, vo=
id *vm,
>      float_status *fpst =3D vfpst;
>      intptr_t flip =3D extract32(desc, SIMD_DATA_SHIFT, 1);
>      uint32_t neg_imag =3D extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    intptr_t index =3D extract32(desc, SIMD_DATA_SHIFT + 2, 2);
>      uint32_t neg_real =3D flip ^ neg_imag;
>      uintptr_t i;
> -    float32 e1 =3D m[H4(flip)];
> -    float32 e3 =3D m[H4(1 - flip)];
> +    float32 e1 =3D m[H4(2 * index + flip)];
> +    float32 e3 =3D m[H4(2 * index + 1 - flip)];
>
>      /* Shift boolean to the sign bit so we can xor to negate.  */
>      neg_real <<=3D 31;


--
Alex Benn=C3=A9e
