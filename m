Received: from eggs.gnu.org ([2001:4830:134:3::10]:46433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcOP-0001CZ-Go
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcOO-0007K6-Oe
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:21:13 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:47038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcOO-0007Jz-Ia
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:21:12 -0500
Received: by mail-ot0-x244.google.com with SMTP id w10so4052390ote.13
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:21:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-14-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-14-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:20:51 +0000
Message-ID: <CAFEAcA_+hYx=-CPaLe3ZVGs8KF2zkb=dRta+A=C6jDteu--EcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 6 February 2018 at 16:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> We can now add float16_mul and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 versions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v3

> +/*
> + * Returns the result of multiplying the floating-point values `a' and
> + * `b'. The operation is performed according to the IEC/IEEE Standard
> + * for Binary Floating-Point Arithmetic.
> + */
> +
> +static FloatParts mul_floats(FloatParts a, FloatParts b, float_status *s=
)
> +{
> +    bool sign =3D a.sign ^ b.sign;
> +
> +    if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_norm=
al) {
> +        uint64_t hi, lo;
> +        int exp =3D a.exp + b.exp;
> +
> +        mul64To128(a.frac, b.frac, &hi, &lo);

It seems a shame that we previously were able to use a
32x32->64 multiply for the float32 case, and now we have to
do an expensive 64x64->128 multiply regardless...

Regardless
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
