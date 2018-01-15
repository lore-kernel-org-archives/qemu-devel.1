Received: from eggs.gnu.org ([2001:4830:134:3::10]:56044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9EU-0008Tc-Qh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9ET-0003QS-In
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:11:42 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:43706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb9ET-0003QD-Cc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:11:41 -0500
Received: by mail-ot0-x22b.google.com with SMTP id p36so3325114otd.10
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:11:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-9-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 18:11:19 +0000
Message-ID: <CAFEAcA_WuV7dJxZ7PB0Lazq4vzAUfRJqX7KVFDJBRF76VnkzXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] target/arm: Decode aa64 armv8.3
 fcadd
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

On 18 December 2017 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h         |  7 ++++
>  target/arm/advsimd_helper.c | 93 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/translate-a64.c  | 36 +++++++++++++++++-
>  3 files changed, 135 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 06ca458614..0f0fc942b0 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -567,6 +567,13 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG=
,
>  DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #endif
> diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
> index d5185165a5..afc2bb1142 100644
> --- a/target/arm/advsimd_helper.c
> +++ b/target/arm/advsimd_helper.c
> @@ -24,6 +24,18 @@
>  #include "tcg/tcg-gvec-desc.h"
>
>
> +/* Note that vector data is stored in host-endian 64-bit chunks,
> +   so addressing units smaller than that needs a host-endian fixup.  */
> +#ifdef HOST_WORDS_BIGENDIAN
> +#define H1(x)  ((x) ^ 7)
> +#define H2(x)  ((x) ^ 3)
> +#define H4(x)  ((x) ^ 1)
> +#else
> +#define H1(x)  (x)
> +#define H2(x)  (x)
> +#define H4(x)  (x)
> +#endif
> +
>  #define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |=3D CPSR_Q
>
>  static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
> @@ -181,3 +193,84 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, vo=
id *vm,
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> +
> +void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    float16 *d =3D vd;
> +    float16 *n =3D vn;
> +    float16 *m =3D vm;
> +    float_status *fpst =3D vfpst;
> +    uint32_t neg_real =3D extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag =3D neg_real ^ 1;
> +    uintptr_t i;
> +
> +    neg_real <<=3D 15;
> +    neg_imag <<=3D 15;

This took me a little while to figure out, given that it's
somewhat different from the pseudocode. (I think I was also
thrown by the <<=3D 15 being done on its own line rather than
in the assignment.) A comment might help?

> +
> +    for (i =3D 0; i < opr_sz / 2; i +=3D 2) {
> +        float16 e0 =3D n[H2(i)];
> +        float16 e1 =3D m[H2(i + 1)] ^ neg_imag;
> +        float16 e2 =3D n[H2(i + 1)];
> +        float16 e3 =3D m[H2(i)] ^ neg_real;
> +
> +        d[H2(i)] =3D float16_add(e0, e1, fpst);
> +        d[H2(i + 1)] =3D float16_add(e2, e3, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    float32 *d =3D vd;
> +    float32 *n =3D vn;
> +    float32 *m =3D vm;
> +    float_status *fpst =3D vfpst;
> +    uint32_t neg_real =3D extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag =3D neg_real ^ 1;
> +    uintptr_t i;
> +
> +    neg_real <<=3D 31;
> +    neg_imag <<=3D 31;
> +
> +    for (i =3D 0; i < opr_sz / 4; i +=3D 2) {
> +        float32 e0 =3D n[H4(i)];
> +        float32 e1 =3D m[H4(i + 1)] ^ neg_imag;
> +        float32 e2 =3D n[H4(i + 1)];
> +        float32 e3 =3D m[H4(i)] ^ neg_real;
> +
> +        d[H4(i)] =3D float32_add(e0, e1, fpst);
> +        d[H4(i + 1)] =3D float32_add(e2, e3, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz =3D simd_oprsz(desc);
> +    float64 *d =3D vd;
> +    float64 *n =3D vn;
> +    float64 *m =3D vm;
> +    float_status *fpst =3D vfpst;
> +    uint64_t neg_real =3D extract64(desc, SIMD_DATA_SHIFT, 1);
> +    uint64_t neg_imag =3D neg_real ^ 1;
> +    uintptr_t i;
> +
> +    neg_real <<=3D 63;
> +    neg_imag <<=3D 63;
> +
> +    for (i =3D 0; i < opr_sz / 8; i +=3D 2) {
> +        float64 e0 =3D n[i];
> +        float64 e1 =3D m[i + 1] ^ neg_imag;
> +        float64 e2 =3D n[i + 1];
> +        float64 e3 =3D m[i] ^ neg_real;
> +
> +        d[i] =3D float64_add(e0, e1, fpst);
> +        d[i + 1] =3D float64_add(e2, e3, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 85fc7af491..89a0616894 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10696,7 +10696,8 @@ static void disas_simd_three_reg_same_extra(Disas=
Context *s, uint32_t insn)
>      int size =3D extract32(insn, 22, 2);
>      bool u =3D extract32(insn, 29, 1);
>      bool is_q =3D extract32(insn, 30, 1);
> -    int feature;
> +    int feature, data;
> +    TCGv_ptr fpst;
>
>      if (!u) {
>          unallocated_encoding(s);
> @@ -10712,6 +10713,14 @@ static void disas_simd_three_reg_same_extra(Disa=
sContext *s, uint32_t insn)
>          }
>          feature =3D ARM_FEATURE_V8_1_SIMD;
>          break;
> +    case 0xc: /* FCADD, #90 */
> +    case 0xe: /* FCADD, #270 */
> +        if (size =3D=3D 0 || (size =3D=3D 3 && !is_q)) {
> +            unallocated_encoding(s);
> +            return;
> +        }

The pseudocode says you need to also check whether the
FP16 extension is supported, or else UNDEF on size =3D=3D 1.

> +        feature =3D ARM_FEATURE_V8_FCMA;
> +        break;
>      default:
>          unallocated_encoding(s);
>          return;
> @@ -10758,6 +10767,31 @@ static void disas_simd_three_reg_same_extra(Disa=
sContext *s, uint32_t insn)
>                             0, fn_gvec_ptr);
>          break;
>
> +    case 0xc: /* FCADD, #90 */
> +    case 0xe: /* FCADD, #270 */
> +        switch (size) {
> +        case 1:
> +            fn_gvec_ptr =3D gen_helper_gvec_fcaddh;
> +            break;
> +        case 2:
> +            fn_gvec_ptr =3D gen_helper_gvec_fcadds;
> +            break;
> +        case 3:
> +            fn_gvec_ptr =3D gen_helper_gvec_fcaddd;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        data =3D extract32(opcode, 1, 1);

The pseudocode calls this field "rot", which is a bit more
descriptive than "data".

> +        fpst =3D get_fpstatus_ptr(size =3D=3D 1);
> +        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> +                           vec_full_reg_offset(s, rn),
> +                           vec_full_reg_offset(s, rm), fpst,
> +                           is_q ? 16 : 8, vec_full_reg_size(s),
> +                           data, fn_gvec_ptr);
> +        tcg_temp_free_ptr(fpst);
> +        break;
> +
>      default:
>          g_assert_not_reached();
>      }
> --
> 2.14.3

Otherwise I think this looks OK.

thanks
-- PMM
