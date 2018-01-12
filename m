Received: from eggs.gnu.org ([2001:4830:134:3::10]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea24x-0005WR-3Y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea24t-0002Dz-Ix
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:21:15 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea24t-0002D0-Bx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:21:11 -0500
Received: by mail-qt0-x244.google.com with SMTP id e2so6643895qti.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:21:11 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
Date: Fri, 12 Jan 2018 13:21:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-11-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="dg6KoPtbwn3pYcO50EienmiRd43OB3gF8"
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dg6KoPtbwn3pYcO50EienmiRd43OB3gF8
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
References: <20180109122252.17670-1-alex.bennee@linaro.org>
 <20180109122252.17670-11-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex, Richard,

On 01/09/2018 09:22 AM, Alex Benn=C3=A9e wrote:
> These structures pave the way for generic softfloat helper routines
> that will operate on fully decomposed numbers.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 59afe81d06..fcba28d3f8 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -83,7 +83,7 @@ this code that are retained.
>   * target-dependent and needs the TARGET_* macros.
>   */
>  #include "qemu/osdep.h"
> -
> +#include "qemu/bitops.h"
>  #include "fpu/softfloat.h"
> =20
>  /* We only need stdlib for abort() */
> @@ -186,6 +186,74 @@ static inline flag extractFloat64Sign(float64 a)
>      return float64_val(a) >> 63;
>  }
> =20
> +/*--------------------------------------------------------------------=
--------
> +| Classify a floating point number.
> +*---------------------------------------------------------------------=
-------*/
> +
> +typedef enum {
> +    float_class_unclassified,
> +    float_class_zero,
> +    float_class_normal,
> +    float_class_inf,
> +    float_class_qnan,
> +    float_class_snan,
> +    float_class_dnan,
> +    float_class_msnan, /* maybe silenced */
> +} float_class;
> +
> +/*--------------------------------------------------------------------=
--------
> +| Structure holding all of the decomposed parts of a float.
> +| The exponent is unbiased and the fraction is normalized.
> +*---------------------------------------------------------------------=
-------*/
> +
> +typedef struct {
> +    uint64_t frac   : 64;

I think this does not work on LLP64/IL32P64 model.

Should we add a check in ./configure and refuse to build on IL32P64
model? This would be safer IMHO.

> +    int exp         : 32;
> +    float_class cls : 8;
> +    int             : 23;
> +    bool sign       : 1;

checking on "ISO/IEC 14882:1998" 9.6 Bit-fields:

Alignment of bit-fields is implementation-defined. Bit-fields are packed
into some addressable allocation unit. [Note: bit-fields straddle
allocation units on some machines and not on others. Bit-fields are
assigned right-to-left on some machines, left-to-right on others. ]

I'd still write it:

      int             :23, sign :1;

> +} decomposed_parts;
> +
> +#define DECOMPOSED_BINARY_POINT    (64 - 2)
> +#define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
> +#define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
> +
> +/* Structure holding all of the relevant parameters for a format.  */
> +typedef struct {
> +    int exp_bias;
> +    int exp_max;
> +    int frac_shift;
> +    uint64_t frac_lsb;
> +    uint64_t frac_lsbm1;
> +    uint64_t round_mask;
> +    uint64_t roundeven_mask;
> +} decomposed_params;
> +
> +#define FRAC_PARAMS(F)                     \
> +    .frac_shift     =3D F,                   \
> +    .frac_lsb       =3D 1ull << (F),         \
> +    .frac_lsbm1     =3D 1ull << ((F) - 1),   \
> +    .round_mask     =3D (1ull << (F)) - 1,   \
> +    .roundeven_mask =3D (2ull << (F)) - 1
> +
> +static const decomposed_params float16_params =3D {
> +    .exp_bias       =3D 0x0f,
> +    .exp_max        =3D 0x1f,
> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 10)
> +};
> +
> +static const decomposed_params float32_params =3D {
> +    .exp_bias       =3D 0x7f,
> +    .exp_max        =3D 0xff,
> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 23)
> +};
> +
> +static const decomposed_params float64_params =3D {
> +    .exp_bias       =3D 0x3ff,
> +    .exp_max        =3D 0x7ff,
> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 52)
> +};
> +
>  /*--------------------------------------------------------------------=
--------
>  | Takes a 64-bit fixed-point value `absZ' with binary point between bi=
ts 6
>  | and 7, and returns the properly rounded 32-bit integer corresponding=
 to the
>=20


--dg6KoPtbwn3pYcO50EienmiRd43OB3gF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpY4G8ACgkQ4+MsLN6t
wN6TuQ/3eEMe4PuRX2Nvz8zQeDk44hufehBHXUU4OSXmpewxH5drLXUtyS6KnAIn
kfQG55S6LM84KitsDJH5M+fLm5R6lcun1t9AgtfG5yJ8SHEHUEg0FMijJT85Mo5o
M4/MLCpNaZzKDpI2h1lz7Hk8wi0IaO51OAB622MLSgo2q0wDrOjhO7JGqEv499Zu
WEt9zjRtPFbYvbX3U4fHWYi+vjKwmAozhZwC8NuGiSeeqBwgSr9iLpdUsoWZixJP
jLobT1RA0L3EI+v3hFXC2TjQSaGB25yag4yCySZcz7UQfZN1k+CLCm5wSIMSCCkq
LAU7bcvggRNbvr+/1R2p/x9fZgAE8OLl6XEvxVR+nIhFYXVP3JzZC13kOf3sebQ2
7HQ70ee/QkcB9Kgn/hKh4967EXutd9Qf7GleOwBar06EsVePylZNfa6T+XDDmBaH
rlJXoOmNvRFp4NONULDE1XhximaR/9yOAmHqJlNSV+ZkSR5f+ngc3+0/e2kPEXDX
NeUwW1PpYegZeK6jxWsajAnN/kt9gRU18SjzpzqvnUtuM38fSz35e7pB1bFhgjsq
Zt7MwvXxRhiiz9TKT9UHUnu4I5obKgYtUR3hvL8JdlujA5VBh7RP6cjGS0LEcSgT
yzlJbQFyfnKZ2RJ2jumkoXj3KjiSgQq/xogfJLwIACJK/8K7Yg==
=GtiK
-----END PGP SIGNATURE-----

--dg6KoPtbwn3pYcO50EienmiRd43OB3gF8--
