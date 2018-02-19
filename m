Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ennvD-0005OD-Pl
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ennv9-00064A-NF
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:04:07 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:40216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ennv9-00063m-Ew
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:04:03 -0500
Received: by mail-wr0-x232.google.com with SMTP id o76so10148726wrb.7
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 08:04:03 -0800 (PST)
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-14-alex.bennee@linaro.org>
	<CAFEAcA_+hYx=-CPaLe3ZVGs8KF2zkb=dRta+A=C6jDteu--EcA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_+hYx=-CPaLe3ZVGs8KF2zkb=dRta+A=C6jDteu--EcA@mail.gmail.com>
Date: Mon, 19 Feb 2018 16:04:00 +0000
Message-ID: <87po519dan.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 13/22] fpu/softfloat: re-factor mul
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

> On 6 February 2018 at 16:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> We can now add float16_mul and use the common decompose and
>> canonicalize functions to have a single implementation for
>> float16/32/64 versions.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> v3
>
>> +/*
>> + * Returns the result of multiplying the floating-point values `a' and
>> + * `b'. The operation is performed according to the IEC/IEEE Standard
>> + * for Binary Floating-Point Arithmetic.
>> + */
>> +
>> +static FloatParts mul_floats(FloatParts a, FloatParts b, float_status *=
s)
>> +{
>> +    bool sign =3D a.sign ^ b.sign;
>> +
>> +    if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_nor=
mal) {
>> +        uint64_t hi, lo;
>> +        int exp =3D a.exp + b.exp;
>> +
>> +        mul64To128(a.frac, b.frac, &hi, &lo);
>
> It seems a shame that we previously were able to use a
> 32x32->64 multiply for the float32 case, and now we have to
> do an expensive 64x64->128 multiply regardless...

Actually for mul the hit isn't too bad. When we do a div however you do
notice a bit of a gulf:

 https://i.imgur.com/KMWceo8.png

We could start passing &floatN_params to the functions much like the
sqrt function and be a bit smarter when we do our multiply and let the
compiler figure it out as we go.

Another avenue worth exploring is ensuring we use native Int128 support
where we can so these wide operations can use wide registers where
available.

However both of these things for future optimisations given it doesn't
show up in dbt-bench timings.

>
> Regardless
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
