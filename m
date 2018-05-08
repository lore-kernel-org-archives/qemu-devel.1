Received: from eggs.gnu.org ([2001:4830:134:3::10]:42319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG04H-0004SA-IP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG04G-0002Bq-J8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:42:01 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:33923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG04G-0002BX-DI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:42:00 -0400
Received: by mail-ot0-x229.google.com with SMTP id i5-v6so23827221otf.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:42:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zi1okbdo.fsf@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
	<20180221110523.859-19-alex.bennee@linaro.org>
	<CAFEAcA_5WHS5_J4vMFjyZX=Dp404bzSpmwwENs_MYKtG07p22w@mail.gmail.com>
	<87zi1okbdo.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 11:41:39 +0100
Message-ID: <CAFEAcA_FOADyf8wxXRiZHb34j+5YmPTX5XTh0wX5x2Q1UP0M3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 18/22] fpu/softfloat: re-factor int/uint to
 float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>

On 27 April 2018 at 14:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 21 February 2018 at 11:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>> +/*
>>> + * Integer to float conversions
>>> + *
>>> + * Returns the result of converting the two's complement integer `a'
>>> + * to the floating-point format. The conversion is performed according
>>> + * to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
>>> + */
>>> +
>>> +static FloatParts int_to_float(int64_t a, float_status *status)
>>> +{
>>> +    FloatParts r;
>>> +    if (a =3D=3D 0) {
>>> +        r.cls =3D float_class_zero;
>>> +        r.sign =3D false;
>>> +    } else if (a =3D=3D (1ULL << 63)) {
>>> +        r.cls =3D float_class_normal;
>>> +        r.sign =3D true;
>>> +        r.frac =3D DECOMPOSED_IMPLICIT_BIT;
>>> +        r.exp =3D 63;
>>> +    } else {
>>> +        uint64_t f;
>>> +        if (a < 0) {
>>> +            f =3D -a;
>>> +            r.sign =3D true;
>>> +        } else {
>>> +            f =3D a;
>>> +            r.sign =3D false;
>>> +        }
>>> +        int shift =3D clz64(f) - 1;
>>> +        r.cls =3D float_class_normal;
>>> +        r.exp =3D (DECOMPOSED_BINARY_POINT - shift);
>>> +        r.frac =3D f << shift;
>>> +    }
>>> +
>>> +    return r;
>>> +}
>>
>> Hi -- Coverity complains about this function (CID1390635) because
>> there's a code path through it that doesn't fully initialize
>> the struct (the a =3D=3D 0 case doesn't set r.frac), and it thinks
>> that "return r" is a 'use' of all fields in the structure.
>> I don't know why it doesn't complain about r.exp.
>>
>> Should we initialize all of r's fields anyway to shut it up,
>> or mark it as a Coverity false-positive?
>
> Hmm tricky - because in some cases we don't want to mess with it. The
> fcvt patch for example manually messed with the frac portion to deal
> with conversion. But it's done outside of the main canonicalize/pack
> routines.

Hmm? The problem is only in this specific function, which
currently returns an entirely uninitialized 'frac' field,
and could be made to return a zeroed field. There aren't
many other functions that create a FloatParts struct themselves
rather than modifying an existing one:
 * unpack_raw() sets all the fields
 * uint_to_float() has "FloatParts r =3D { .sign =3D false};"
   which implicitly sets all the other parts to 0

It doesn't seem too unreasonable to me to either have this
function start "FloatParts r =3D {};" or to init both exp
and frac in the "zero" case.

thanks
-- PMM
