Received: from eggs.gnu.org ([2001:4830:134:3::10]:49556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQ8Y-0004vj-OL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQ8X-00021k-IP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:28:50 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erQ8X-00021N-BM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:28:49 -0500
Received: by mail-oi0-x242.google.com with SMTP id a207so4733840oii.10
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 07:28:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pUMgUnR0cWd9j7n0EyTeXkMTzhPQU_fqhyaXy1hMfxw@mail.gmail.com>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-13-richard.henderson@linaro.org>
	<CAFEAcA-pUMgUnR0cWd9j7n0EyTeXkMTzhPQU_fqhyaXy1hMfxw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 15:28:28 +0000
Message-ID: <CAFEAcA-FOV6JSaZrhD+FZ-T46n_e--suEDbha5EXAEPyW5YAEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/16] target/arm: Decode aa64 armv8.3
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

On 1 March 2018 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 28 February 2018 at 19:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper.h        |  11 ++++
>>  target/arm/translate-a64.c |  94 +++++++++++++++++++++++++---
>>  target/arm/vec_helper.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 246 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/arm/helper.h b/target/arm/helper.h
>> index 1e2d7025de..0d2094f2be 100644
>> --- a/target/arm/helper.h
>> +++ b/target/arm/helper.h
>> @@ -585,6 +585,17 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
>>  DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
>>                     void, ptr, ptr, ptr, ptr, i32)
>>
>> +DEF_HELPER_FLAGS_5(gvec_fcmlah, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +DEF_HELPER_FLAGS_5(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +DEF_HELPER_FLAGS_5(gvec_fcmlas, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +
>>  #ifdef TARGET_AARCH64
>>  #include "helper-a64.h"
>>  #endif
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index efed4fd9d2..31ff0479e6 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -10842,6 +10842,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>>          }
>>          feature = ARM_FEATURE_V8_RDM;
>>          break;
>> +    case 0x8: /* FCMLA, #0 */
>> +    case 0x9: /* FCMLA, #90 */
>> +    case 0xa: /* FCMLA, #180 */
>> +    case 0xb: /* FCMLA, #270 */
>>      case 0xc: /* FCADD, #90 */
>>      case 0xe: /* FCADD, #270 */
>>          if (size == 0
>> @@ -10891,6 +10895,29 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>>          }
>>          return;
>>
>> +    case 0x8: /* FCMLA, #0 */
>> +    case 0x9: /* FCMLA, #90 */
>> +    case 0xa: /* FCMLA, #180 */
>> +    case 0xb: /* FCMLA, #270 */
>> +        rot = extract32(opcode, 0, 2);
>> +        switch (size) {
>> +        case 1:
>> +            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, true, rot,
>> +                              gen_helper_gvec_fcmlah);
>> +            break;
>> +        case 2:
>> +            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
>> +                              gen_helper_gvec_fcmlas);
>> +            break;
>> +        case 3:
>> +            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
>> +                              gen_helper_gvec_fcmlad);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +        return;
>> +
>>      case 0xc: /* FCADD, #90 */
>>      case 0xe: /* FCADD, #270 */
>>          rot = extract32(opcode, 1, 1);
>
> Shouldn't there be a feature check on ARM_FEATURE_V8_FCMA somewhere
> in the three_reg_same_extra code path?
>
>
>> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
>> index a868ca6aac..d81eb7730d 100644
>> --- a/target/arm/vec_helper.c
>> +++ b/target/arm/vec_helper.c
>> @@ -278,3 +278,152 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
>>      }
>>      clear_tail(d, opr_sz, simd_maxsz(desc));
>>  }
>> +
>> +void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
>> +                         void *vfpst, uint32_t desc)
>> +{
>> +    uintptr_t opr_sz = simd_oprsz(desc);
>> +    float16 *d = vd;
>> +    float16 *n = vn;
>> +    float16 *m = vm;
>> +    float_status *fpst = vfpst;
>> +    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
>> +    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
>> +    uint32_t neg_real = flip ^ neg_imag;
>> +    uintptr_t i;
>> +
>> +    /* Shift boolean to the sign bit so we can xor to negate.  */
>> +    neg_real <<= 15;
>> +    neg_imag <<= 15;
>> +
>> +    for (i = 0; i < opr_sz / 2; i += 2) {
>> +        float16 e1 = n[H2(i + flip)];
>> +        float16 e2 = m[H2(i + flip)] ^ neg_real;
>> +        float16 e3 = e1;
>> +        float16 e4 = m[H2(i + 1 - flip)] ^ neg_imag;
>
> These don't match up with the element1 ... element4 in the
> Arm ARM pseudocode. It's e2 and e4 that are always the same,
> not e1 and e3. Ditto in the other functions.

Specifically I think:
 this code    pseudocode
   e1          element2
   e2          element1
   e3          element4
   e4          element2

So if we renumber these to match the pseudocode

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
