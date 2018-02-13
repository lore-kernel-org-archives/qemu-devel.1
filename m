Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcPq-0002S6-Tx
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcPq-0007qR-0e
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:42 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcPp-0007q9-RA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:41 -0500
Received: by mail-ot0-x241.google.com with SMTP id s4so17574016oth.7
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-15-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-15-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:22:20 +0000
Message-ID: <CAFEAcA9kAVMu97RYvs4z0b+tBZ6M2NUCskGy3bHdsdBq54C8FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/22] fpu/softfloat: re-factor div
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
> We can now add float16_div and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 versions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s=
)
> +{
> +    bool sign =3D a.sign ^ b.sign;
> +
> +    if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_norm=
al) {
> +        uint64_t temp_lo, temp_hi;
> +        int exp =3D a.exp - b.exp;
> +        if (a.frac < b.frac) {
> +            exp -=3D 1;
> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1,
> +                              &temp_hi, &temp_lo);
> +        } else {
> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT,
> +                              &temp_hi, &temp_lo);
> +        }
> +        /* LSB of quot is set if inexact which roundandpack will use
> +         * to set flags. Yet again we re-use a for the result */
> +        a.frac =3D div128To64(temp_lo, temp_hi, b.frac);

...and this is even worse as a cost increase for the float32
and float16 cases. Still:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
