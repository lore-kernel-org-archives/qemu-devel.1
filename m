Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epC1E-0004UX-53
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epC1B-0007id-4e
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:00:04 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epC1A-0007fm-Tc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:00:01 -0500
Received: by mail-wm0-x243.google.com with SMTP id h21so4201102wmd.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 04:00:00 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-12-alex.bennee@linaro.org>
	<da2bc012-1693-3335-eb5a-921d94e6015e@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <da2bc012-1693-3335-eb5a-921d94e6015e@linaro.org>
Date: Fri, 23 Feb 2018 11:59:58 +0000
Message-ID: <87d10vapc1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/32] arm/translate-a64: add FP16
 F[A]C[EQ/GE/GT] to simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 02/08/2018 09:31 AM, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/helper-a64.c    | 49 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>  target/arm/helper-a64.h    |  5 +++++
>>  target/arm/translate-a64.c | 15 ++++++++++++++
>>  3 files changed, 69 insertions(+)
>>
>> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
>> index 25e45121af..78eeda31d1 100644
>> --- a/target/arm/helper-a64.c
>> +++ b/target/arm/helper-a64.c
>> @@ -599,3 +599,52 @@ ADVSIMD_HALFOP(min)
>>  ADVSIMD_HALFOP(max)
>>  ADVSIMD_HALFOP(minnum)
>>  ADVSIMD_HALFOP(maxnum)
>> +
>> +/*
>> + * Floating point comparisons produce an integer result. Softfloat
>> + * routines return float_relation types which we convert to the 0/-1
>> + * Neon requires.
>> + */
>> +
>> +#define ADVSIMD_CMPRES(test) (test) ? 0xffff : 0
>> +
>> +uint32_t HELPER(advsimd_ceq_f16)(float16 a, float16 b, void *fpstp)
>> +{
>> +    float_status *fpst =3D fpstp;
>> +    int compare =3D float16_compare_quiet(a, b, fpst);
>> +    return ADVSIMD_CMPRES(compare =3D=3D float_relation_equal);
>
> Not using float16_eq etc?

These don't actually exist. But I guess we could make stubs for them
based on the generic float_compare support. But would it buy us much?

>
>> +}
>> +
>> +uint32_t HELPER(advsimd_cge_f16)(float16 a, float16 b, void *fpstp)
>> +{
>> +    float_status *fpst =3D fpstp;
>> +    int compare =3D float16_compare(a, b, fpst);
>> +    return ADVSIMD_CMPRES(compare =3D=3D float_relation_greater ||
>> +                          compare =3D=3D float_relation_equal);
>
> Especially float16_le(b, a, fpst).
>
> Otherwise,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
