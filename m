Received: from eggs.gnu.org ([2001:4830:134:3::10]:52752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKhM-0007Vs-3v
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKhH-0004vZ-4w
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:16:08 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKhG-0004vI-VZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:16:03 -0500
Received: by mail-pl0-x244.google.com with SMTP id d4so5590236pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:16:02 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-44-richard.henderson@linaro.org>
	<CAFEAcA_VMcqarGdf1nN9=yXn-ybsvHYMzYS6EF0UUDdECJ02_g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca46b9e2-54ad-8547-e869-8c3c238cdaad@linaro.org>
Date: Fri, 23 Feb 2018 13:15:58 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VMcqarGdf1nN9=yXn-ybsvHYMzYS6EF0UUDdECJ02_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 43/67] target/arm: Implement SVE
 Floating Point Arithmetic - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 09:25 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper-sve.h    | 14 +++++++
>>  target/arm/helper.h        | 19 ++++++++++
>>  target/arm/translate-sve.c | 41 ++++++++++++++++++++
>>  target/arm/vec_helper.c    | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/Makefile.objs   |  2 +-
>>  target/arm/sve.decode      | 10 +++++
>>  6 files changed, 179 insertions(+), 1 deletion(-)
>>  create mode 100644 target/arm/vec_helper.c
>>
> 
>> +/* Floating-point trigonometric starting value.
>> + * See the ARM ARM pseudocode function FPTrigSMul.
>> + */
>> +static float16 float16_ftsmul(float16 op1, uint16_t op2, float_status *stat)
>> +{
>> +    float16 result = float16_mul(op1, op1, stat);
>> +    if (!float16_is_any_nan(result)) {
>> +        result = float16_set_sign(result, op2 & 1);
>> +    }
>> +    return result;
>> +}
>> +
>> +static float32 float32_ftsmul(float32 op1, uint32_t op2, float_status *stat)
>> +{
>> +    float32 result = float32_mul(op1, op1, stat);
>> +    if (!float32_is_any_nan(result)) {
>> +        result = float32_set_sign(result, op2 & 1);
>> +    }
>> +    return result;
>> +}
>> +
>> +static float64 float64_ftsmul(float64 op1, uint64_t op2, float_status *stat)
>> +{
>> +    float64 result = float64_mul(op1, op1, stat);
>> +    if (!float64_is_any_nan(result)) {
>> +        result = float64_set_sign(result, op2 & 1);
>> +    }
>> +    return result;
>> +}
>> +
>> +#define DO_3OP(NAME, FUNC, TYPE) \
>> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
>> +{                                                                          \
>> +    intptr_t i, oprsz = simd_oprsz(desc);                                  \
>> +    TYPE *d = vd, *n = vn, *m = vm;                                        \
>> +    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
>> +        d[i] = FUNC(n[i], m[i], stat);                                     \
>> +    }                                                                      \
>> +}
>> +
>> +DO_3OP(gvec_fadd_h, float16_add, float16)
>> +DO_3OP(gvec_fadd_s, float32_add, float32)
>> +DO_3OP(gvec_fadd_d, float64_add, float64)
>> +
>> +DO_3OP(gvec_fsub_h, float16_sub, float16)
>> +DO_3OP(gvec_fsub_s, float32_sub, float32)
>> +DO_3OP(gvec_fsub_d, float64_sub, float64)
>> +
>> +DO_3OP(gvec_fmul_h, float16_mul, float16)
>> +DO_3OP(gvec_fmul_s, float32_mul, float32)
>> +DO_3OP(gvec_fmul_d, float64_mul, float64)
>> +
>> +DO_3OP(gvec_ftsmul_h, float16_ftsmul, float16)
>> +DO_3OP(gvec_ftsmul_s, float32_ftsmul, float32)
>> +DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
>> +
>> +#ifdef TARGET_AARCH64
> 
> This seems a bit odd given SVE is AArch64-only anyway...

Ah right.

The thing to notice here is that the helpers have been placed such that the
helpers can be shared with AA32 and AA64 AdvSIMD.  One call to one of these
would replace the 2-8 calls that we currently generate for such an operation.

I thought it better to plan ahead for that cleanup as opposed to moving them later.

Here you see where AA64 differs from AA32 (and in particular where the scalar
operation is also conditionalized).


r~
