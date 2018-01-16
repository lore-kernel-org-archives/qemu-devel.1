Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebOHs-0004c3-0D
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebOHm-0003CQ-0V
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:16:11 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebOHl-0003Bi-PD
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:16:05 -0500
Received: by mail-wm0-x242.google.com with SMTP id r78so7453233wme.0
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 02:16:05 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-13-alex.bennee@linaro.org>
	<CAFEAcA_DiOa8jkpRcm5yytR+L=UL7xR74nRwWvPNt6dkMdWh+g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_DiOa8jkpRcm5yytR+L=UL7xR74nRwWvPNt6dkMdWh+g@mail.gmail.com>
Date: Tue, 16 Jan 2018 10:16:02 +0000
Message-ID: <87fu76nm71.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/20] fpu/softfloat: re-factor mul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>> We can now add float16_mul and use the common decompose and
>> canonicalize functions to have a single implementation for
>> float16/32/64 versions.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat.c         | 207 ++++++++++++++++++-----------------------=
-------
>>  include/fpu/softfloat.h |   1 +
>>  2 files changed, 80 insertions(+), 128 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index f89e47e3ef..6e9d4c172c 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -730,6 +730,85 @@ float64 float64_sub(float64 a, float64 b, float_sta=
tus *status)
>>      return float64_round_pack_canonical(pr, status);
>>  }
>>
>> +/*
>> + * Returns the result of multiplying the floating-point values `a' and
>> + * `b'. The operation is performed according to the IEC/IEEE Standard
>> + * for Binary Floating-Point Arithmetic.
>> + */
>> +
>> +static decomposed_parts mul_decomposed(decomposed_parts a, decomposed_p=
arts b,
>> +                                       float_status *s)
>> +{
>> +    bool sign =3D a.sign ^ b.sign;
>> +
>> +    if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_nor=
mal) {
>> +        uint64_t hi, lo;
>> +        int exp =3D a.exp + b.exp;
>> +
>> +        mul64To128(a.frac, b.frac, &hi, &lo);
>> +        shift128RightJamming(hi, lo, DECOMPOSED_BINARY_POINT, &hi, &lo);
>> +        if (lo & DECOMPOSED_OVERFLOW_BIT) {
>> +            shift64RightJamming(lo, 1, &lo);
>> +            exp +=3D 1;
>> +        }
>> +
>> +        /* Re-use a */
>> +        a.exp =3D exp;
>> +        a.sign =3D sign;
>> +        a.frac =3D lo;
>> +        return a;
>> +    }
>> +    /* handle all the NaN cases */
>> +    if (a.cls >=3D float_class_qnan || b.cls >=3D float_class_qnan) {
>> +        return pick_nan_parts(a, b, s);
>> +    }
>> +    /* Inf * Zero =3D=3D NaN */
>> +    if (((1 << a.cls) | (1 << b.cls)) =3D=3D
>> +        ((1 << float_class_inf) | (1 << float_class_zero))) {
>
> This is kinda confusing...

Yeah it's a bit of a shortcut to:

  if ((a.cls =3D=3D float_class_inf && b.cls =3D=3D float_class_zero)
     ||
      (a.cls =3D=3D float_class_zero && b.cls =3D=3D float_class_inf))

Would you prefer it long hand or tidied away to a helper?

  if (cls_combination(a, b, float_class_inf, float_class_zero))

?

>
>> +        s->float_exception_flags |=3D float_flag_invalid;
>> +        a.cls =3D float_class_dnan;
>> +        a.sign =3D sign;
>> +        return a;
>> +    }
>> +    /* Multiply by 0 or Inf */
>> +    if (a.cls =3D=3D float_class_inf || a.cls =3D=3D float_class_zero) {
>> +        a.sign =3D sign;
>> +        return a;
>> +    }
>> +    if (b.cls =3D=3D float_class_inf || b.cls =3D=3D float_class_zero) {
>> +        b.sign =3D sign;
>> +        return b;
>> +    }
>> +    g_assert_not_reached();
>> +}
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
