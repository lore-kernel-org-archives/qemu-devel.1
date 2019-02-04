Received: from eggs.gnu.org ([209.51.188.92]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqbJU-0003WL-H4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqbJQ-0006HQ-Nm
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:17:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqbJO-0005rU-7t
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:17:11 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so12524712wmb.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:17:06 -0800 (PST)
References: <20190204052712.30833-1-richard.henderson@linaro.org>
	<20190204052712.30833-4-richard.henderson@linaro.org>
	<CABoDooOYVShpc+OAXVCnZ0CF2P1xqk=vEzOMsoxOiCzDjnkQjw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b84d3114-d046-ab9b-bb20-4098f7a5070e@linaro.org>
Date: Mon, 4 Feb 2019 10:17:02 +0000
MIME-Version: 1.0
In-Reply-To: <CABoDooOYVShpc+OAXVCnZ0CF2P1xqk=vEzOMsoxOiCzDjnkQjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/4/19 8:00 AM, Laurent Desnogues wrote:
> Hello,
> 
> On Mon, Feb 4, 2019 at 6:38 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h           | 10 +++++
>>  target/arm/helper.h        |  2 +
>>  target/arm/cpu.c           |  1 +
>>  target/arm/cpu64.c         |  2 +
>>  target/arm/op_helper.c     | 91 ++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-a64.c | 26 +++++++++++
>>  target/arm/translate.c     | 15 +++++++
>>  7 files changed, 147 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index a68bcc9fed..d2c2e2b0cf 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -3209,6 +3209,11 @@ static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
>>      return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
>>  }
>>
>> +static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
>> +}
>> +
>>  static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
>>  {
>>      return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
>> @@ -3287,6 +3292,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
>>      return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
>>  }
>>
>> +static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
>> +}
>> +
>>  static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
>>  {
>>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
>> diff --git a/target/arm/helper.h b/target/arm/helper.h
>> index 53a38188c6..6998f7e8d5 100644
>> --- a/target/arm/helper.h
>> +++ b/target/arm/helper.h
>> @@ -218,6 +218,8 @@ DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
>>  DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
>>  DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
>>
>> +DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
>> +
>>  /* neon_helper.c */
>>  DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
>>  DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 3874dc9875..2eb2ce6c8c 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1995,6 +1995,7 @@ static void arm_max_initfn(Object *obj)
>>              cpu->isar.id_isar5 = t;
>>
>>              t = cpu->isar.id_isar6;
>> +            t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
>>              t = FIELD_DP32(t, ID_ISAR6, DP, 1);
>>              cpu->isar.id_isar6 = t;
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 7107ec8d7e..43d8ff047c 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -311,6 +311,7 @@ static void aarch64_max_initfn(Object *obj)
>>          cpu->isar.id_aa64isar0 = t;
>>
>>          t = cpu->isar.id_aa64isar1;
>> +        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
>>          t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
>>          t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
>>          t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
>> @@ -340,6 +341,7 @@ static void aarch64_max_initfn(Object *obj)
>>          cpu->isar.id_isar5 = u;
>>
>>          u = cpu->isar.id_isar6;
>> +        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
>>          u = FIELD_DP32(u, ID_ISAR6, DP, 1);
>>          cpu->isar.id_isar6 = u;
>>
>> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
>> index c998eadfaa..a7259a7194 100644
>> --- a/target/arm/op_helper.c
>> +++ b/target/arm/op_helper.c
>> @@ -24,6 +24,7 @@
>>  #include "internals.h"
>>  #include "exec/exec-all.h"
>>  #include "exec/cpu_ldst.h"
>> +#include "fpu/softfloat.h"
>>
>>  #define SIGNBIT (uint32_t)0x80000000
>>  #define SIGNBIT64 ((uint64_t)1 << 63)
>> @@ -1376,3 +1377,93 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
>>          return ((uint32_t)x >> shift) | (x << (32 - shift));
>>      }
>>  }
>> +
>> +/*
>> + * Implement float64 to int32_t conversion without saturation;
>> + * the result is supplied modulo 2^32.
>> + */
>> +uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
>> +{
>> +    float_status *status = vstatus;
>> +    uint32_t result, exp, sign;
>> +    uint64_t frac;
>> +    uint32_t inexact; /* !Z */
>> +
>> +    sign = extract64(value, 63, 1);
>> +    exp = extract64(value, 52, 11);
>> +    frac = extract64(value, 0, 52);
>> +
>> +    if (exp == 0) {
>> +        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript.  */
>> +        inexact = sign;
>> +        result = 0;
>> +        if (frac != 0) {
>> +            if (status->flush_inputs_to_zero) {
>> +                float_raise(float_flag_input_denormal, status);
>> +            } else {
>> +                float_raise(float_flag_inexact, status);
>> +                inexact = 1;
>> +            }
>> +        }
>> +    } else if (exp == 0x7ff) {
>> +        if (frac == 0) {
>> +            /* Infinity.  */
>> +            result = 0;
>> +        } else {
>> +            /* NaN */
>> +            result = INT32_MAX;
>> +        }
> 
> The pseudo code asks for NaN inputs to return 0 since FPUnpack returns
> a value of 0 for NaN.
> 
> The rest looks correct.

So it does.  I apparently copied the INT_MAX thing from softfloat.c without
double-checking.

Thanks,


r~
