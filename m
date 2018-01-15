Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9Lg-00057j-3Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9Le-00009n-HS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:19:08 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb9Le-00009M-Bi
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:19:06 -0500
Received: by mail-ot0-x241.google.com with SMTP id s3so11382581otc.9
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:19:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-10-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 18:18:45 +0000
Message-ID: <CAFEAcA9Dmdh+u7AZHhjEkS3zc6i4yf+Eo1-NuksgVdo1cqmKFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/arm: Decode aa64 armv8.3
 fcmla
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h         |  11 ++++
>  target/arm/advsimd_helper.c | 144 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c  | 149 ++++++++++++++++++++++++++++++++------------
>  3 files changed, 265 insertions(+), 39 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 0f0fc942b0..5b6333347d 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -574,6 +574,17 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
>  DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_5(gvec_fcmlah, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcmlas, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #endif
> diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
> index afc2bb1142..6a2a53e111 100644
> --- a/target/arm/advsimd_helper.c
> +++ b/target/arm/advsimd_helper.c
> @@ -274,3 +274,147 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> +
> +void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz = simd_oprsz(desc);
> +    float16 *d = vd;
> +    float16 *n = vn;
> +    float16 *m = vm;
> +    float_status *fpst = vfpst;
> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    uint32_t neg_real = flip ^ neg_imag;
> +    uintptr_t i;
> +
> +    neg_real <<= 15;
> +    neg_imag <<= 15;
> +
> +    for (i = 0; i < opr_sz / 2; i += 2) {
> +        float16 e0 = n[H2(i + flip)];
> +        float16 e1 = m[H2(i + flip)] ^ neg_real;
> +        float16 e2 = e0;
> +        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;

This is again rather confusing to compare against the pseudocode.
What order are your e0/e1/e2/e3 compared to the pseudocode's
element1/element2/element3/element4 ?

> +
> +        d[H2(i)] = float16_muladd(e0, e1, d[H2(i)], 0, fpst);
> +        d[H2(i + 1)] = float16_muladd(e2, e3, d[H2(i + 1)], 0, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
> +                             void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz = simd_oprsz(desc);
> +    float16 *d = vd;
> +    float16 *n = vn;
> +    float16 *m = vm;
> +    float_status *fpst = vfpst;
> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    uint32_t neg_real = flip ^ neg_imag;
> +    uintptr_t i;
> +    float16 e1 = m[H2(flip)];
> +    float16 e3 = m[H2(1 - flip)];
> +
> +    neg_real <<= 15;
> +    neg_imag <<= 15;
> +    e1 ^= neg_real;
> +    e3 ^= neg_imag;
> +
> +    for (i = 0; i < opr_sz / 2; i += 2) {
> +        float16 e0 = n[H2(i + flip)];
> +        float16 e2 = e0;
> +
> +        d[H2(i)] = float16_muladd(e0, e1, d[H2(i)], 0, fpst);
> +        d[H2(i + 1)] = float16_muladd(e2, e3, d[H2(i + 1)], 0, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz = simd_oprsz(desc);
> +    float32 *d = vd;
> +    float32 *n = vn;
> +    float32 *m = vm;
> +    float_status *fpst = vfpst;
> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    uint32_t neg_real = flip ^ neg_imag;
> +    uintptr_t i;
> +
> +    neg_real <<= 31;
> +    neg_imag <<= 31;
> +
> +    for (i = 0; i < opr_sz / 4; i += 2) {
> +        float32 e0 = n[H4(i + flip)];
> +        float32 e1 = m[H4(i + flip)] ^ neg_real;
> +        float32 e2 = e0;
> +        float32 e3 = m[H4(i + 1 - flip)] ^ neg_imag;
> +
> +        d[H4(i)] = float32_muladd(e0, e1, d[H4(i)], 0, fpst);
> +        d[H4(i + 1)] = float32_muladd(e2, e3, d[H4(i + 1)], 0, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
> +                             void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz = simd_oprsz(desc);
> +    float32 *d = vd;
> +    float32 *n = vn;
> +    float32 *m = vm;
> +    float_status *fpst = vfpst;
> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    uint32_t neg_real = flip ^ neg_imag;
> +    uintptr_t i;
> +    float32 e1 = m[H4(flip)];
> +    float32 e3 = m[H4(1 - flip)];
> +
> +    neg_real <<= 31;
> +    neg_imag <<= 31;
> +    e1 ^= neg_real;
> +    e3 ^= neg_imag;
> +
> +    for (i = 0; i < opr_sz / 4; i += 2) {
> +        float32 e0 = n[H4(i + flip)];
> +        float32 e2 = e0;
> +
> +        d[H4(i)] = float32_muladd(e0, e1, d[H4(i)], 0, fpst);
> +        d[H4(i + 1)] = float32_muladd(e2, e3, d[H4(i + 1)], 0, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
> +                         void *vfpst, uint32_t desc)
> +{
> +    uintptr_t opr_sz = simd_oprsz(desc);
> +    float64 *d = vd;
> +    float64 *n = vn;
> +    float64 *m = vm;
> +    float_status *fpst = vfpst;
> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    uint64_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
> +    uint64_t neg_real = flip ^ neg_imag;
> +    uintptr_t i;
> +
> +    neg_real <<= 63;
> +    neg_imag <<= 63;
> +
> +    for (i = 0; i < opr_sz / 8; i += 2) {
> +        float64 e0 = n[i + flip];
> +        float64 e1 = m[i + flip] ^ neg_real;
> +        float64 e2 = e0;
> +        float64 e3 = m[i + 1 - flip] ^ neg_imag;
> +
> +        d[i] = float64_muladd(e0, e1, d[i], 0, fpst);
> +        d[i + 1] = float64_muladd(e2, e3, d[i + 1], 0, fpst);
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 89a0616894..79fede35c1 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10713,6 +10713,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>          }
>          feature = ARM_FEATURE_V8_1_SIMD;
>          break;
> +    case 0x8: /* FCMLA, #0 */
> +    case 0x9: /* FCMLA, #90 */
> +    case 0xa: /* FCMLA, #180 */
> +    case 0xb: /* FCMLA, #270 */
>      case 0xc: /* FCADD, #90 */
>      case 0xe: /* FCADD, #270 */
>          if (size == 0 || (size == 3 && !is_q)) {
> @@ -10767,6 +10771,26 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>                             0, fn_gvec_ptr);
>          break;
>
> +    case 0x8: /* FCMLA, #0 */
> +    case 0x9: /* FCMLA, #90 */
> +    case 0xa: /* FCMLA, #180 */
> +    case 0xb: /* FCMLA, #270 */
> +        switch (size) {
> +        case 1:
> +            fn_gvec_ptr = gen_helper_gvec_fcmlah;
> +            break;
> +        case 2:
> +            fn_gvec_ptr = gen_helper_gvec_fcmlas;
> +            break;
> +        case 3:
> +            fn_gvec_ptr = gen_helper_gvec_fcmlad;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        data = extract32(opcode, 0, 2);
> +        goto do_fpst;

These need the "size 0b01 is UNDEF unless FP16 extn present" check too.

> +
>      case 0xc: /* FCADD, #90 */
>      case 0xe: /* FCADD, #270 */
>          switch (size) {
> @@ -10783,6 +10807,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>              g_assert_not_reached();
>          }
>          data = extract32(opcode, 1, 1);
> +    do_fpst:
>          fpst = get_fpstatus_ptr(size == 1);
>          tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
>                             vec_full_reg_offset(s, rn),
> @@ -11864,80 +11889,80 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>      int rn = extract32(insn, 5, 5);
>      int rd = extract32(insn, 0, 5);
>      bool is_long = false;
> -    bool is_fp = false;
> +    int is_fp = 0;
> +    bool is_fp16 = false;
>      int index;
>      TCGv_ptr fpst;
>
> -    switch (opcode) {
> -    case 0x0: /* MLA */
> -    case 0x4: /* MLS */
> -        if (!u || is_scalar) {
> +    switch (16 * u + opcode) {
> +    case 0x00: /* MLA */
> +    case 0x04: /* MLS */
> +    case 0x08: /* MUL */
> +        if (is_scalar) {
>              unallocated_encoding(s);
>              return;
>          }

This would all be easier to read if "refactor to switch on u:opcode"
was a separate patch from adding the new insns.


thanks
-- PMM
