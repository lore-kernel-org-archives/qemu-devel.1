Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLx2-0007mC-9F
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLwx-0003Pp-JM
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:22:56 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLwx-0003P9-EV
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:22:51 -0500
Received: by mail-qt0-x243.google.com with SMTP id a27so10698939qtd.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 06:22:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b961bf9-dc1e-c8a3-3e04-4539a2496ca8@amsat.org>
Date: Wed, 24 Jan 2018 11:22:42 -0300
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-12-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="cYi51EFMlBBQ3wYhCbqUxzTpqaw0TEm38"
Subject: Re: [Qemu-devel] [PATCH v3 11/22] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cYi51EFMlBBQ3wYhCbqUxzTpqaw0TEm38
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <3b961bf9-dc1e-c8a3-3e04-4539a2496ca8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 11/22] fpu/softfloat: define decompose
 structures
References: <20180124131315.30567-1-alex.bennee@linaro.org>
 <20180124131315.30567-12-alex.bennee@linaro.org>
In-Reply-To: <20180124131315.30567-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 10:13 AM, Alex Benn=C3=A9e wrote:
> These structures pave the way for generic softfloat helper routines
> that will operate on fully decomposed numbers.

I have to say this patch in particular is very elegant (seeing how it
simplify the later refactors). I suppose you had a long brainstorming
before...

Total-brain-hours-spent: 141
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>=20
> ---
> v3
>  - comment box style
>  - CamelCase structs
>  - hide DECOMPOSED_BINARY_POINT - frac in macro
>  - more comments
>  - add exp_size, frac_size to FloatFmt
>  - compute exp_bias and exp_max from FLOAT_PARAMS
>  - remove include bitops (in next patch)
> ---
>  fpu/softfloat.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
>=20
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 297e48f5c9..568d555595 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -83,7 +83,6 @@ this code that are retained.
>   * target-dependent and needs the TARGET_* macros.
>   */
>  #include "qemu/osdep.h"
> -
>  #include "fpu/softfloat.h"
> =20
>  /* We only need stdlib for abort() */
> @@ -186,6 +185,91 @@ static inline flag extractFloat64Sign(float64 a)
>      return float64_val(a) >> 63;
>  }
> =20
> +/*
> + * Classify a floating point number. Everything above float_class_qnan=

> + * is a NaN so cls >=3D float_class_qnan is any NaN.
> + */
> +
> +typedef enum __attribute__ ((__packed__)) {
> +    float_class_unclassified,
> +    float_class_zero,
> +    float_class_normal,
> +    float_class_inf,
> +    float_class_qnan,  /* all NaNs from here */
> +    float_class_snan,
> +    float_class_dnan,
> +    float_class_msnan, /* maybe silenced */
> +} FloatClass;
> +
> +/*
> + * Structure holding all of the decomposed parts of a float. The
> + * exponent is unbiased and the fraction is normalized. All
> + * calculations are done with a 64 bit fraction and then rounded as
> + * appropriate for the final format.
> + *
> + * Thanks to the packed FloatClass a decent compiler should be able to=

> + * fit the whole structure into registers and avoid using the stack
> + * for parameter passing.
> + */
> +
> +typedef struct {
> +    uint64_t frac;
> +    int32_t  exp;
> +    FloatClass cls;
> +    bool sign;
> +} FloatParts;
> +
> +#define DECOMPOSED_BINARY_POINT    (64 - 2)
> +#define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
> +#define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
> +
> +/* Structure holding all of the relevant parameters for a format.
> + *   exp_size: the size of the exponent field
> + *   exp_bias: the offset applied to the exponent field
> + *   exp_max: the maximum normalised exponent
> + *   frac_size: the size of the fraction field
> + *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINAR=
Y_POINT
> + * The following are computed based the size of fraction
> + *   frac_lsb: least significant bit of fraction
> + *   fram_lsbm1: the bit bellow the least significant bit (for roundin=
g)
> + *   round_mask/roundeven_mask: masks used for rounding
> + */
> +typedef struct {
> +    int exp_size;
> +    int exp_bias;
> +    int exp_max;
> +    int frac_size;
> +    int frac_shift;
> +    uint64_t frac_lsb;
> +    uint64_t frac_lsbm1;
> +    uint64_t round_mask;
> +    uint64_t roundeven_mask;
> +} FloatFmt;
> +
> +/* Expand fields based on the size of exponent and fraction */
> +#define FLOAT_PARAMS(E, F)                                           \=

> +    .exp_size       =3D E,                                            =
 \
> +    .exp_bias       =3D ((1 << E) - 1) >> 1,                          =
 \
> +    .exp_max        =3D (1 << E) - 1,                                 =
 \
> +    .frac_size      =3D F,                                            =
 \
> +    .frac_shift     =3D DECOMPOSED_BINARY_POINT - F,                  =
 \
> +    .frac_lsb       =3D 1ull << (DECOMPOSED_BINARY_POINT - F),        =
 \
> +    .frac_lsbm1     =3D 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),  =
 \
> +    .round_mask     =3D (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,  =
 \
> +    .roundeven_mask =3D (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
> +
> +static const FloatFmt float16_params =3D {
> +    FLOAT_PARAMS(5, 10)
> +};
> +
> +static const FloatFmt float32_params =3D {
> +    FLOAT_PARAMS(8, 23)
> +};
> +
> +static const FloatFmt float64_params =3D {
> +    FLOAT_PARAMS(11, 52)
> +};
> +
>  /*--------------------------------------------------------------------=
--------
>  | Takes a 64-bit fixed-point value `absZ' with binary point between bi=
ts 6
>  | and 7, and returns the properly rounded 32-bit integer corresponding=
 to the
>=20


--cYi51EFMlBBQ3wYhCbqUxzTpqaw0TEm38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpolrIACgkQ4+MsLN6t
wN7vahAAypVMEq81Phs01wZepoPz5ZM6FWO/4pVOaWgqWV3gwtNiJ9tl4d7s+eeD
1bjXj6cLLVbOK6SOGfsIylucSN4+UmMuydpCxLhL+s8gTTez0aVWEk80XievnpJM
ZYPhPYyy+0u1KTfHc2sp3KgIxYQqlLWMAPO/CFXrt/XDZLXM9X5k0WAx6sIpZtx2
wlW81VZuqmIFYaJlpDj9gy4pTeDXRIKvxJOsxLoLpl6EHOEXaKgXf83oUnSk/CsK
ABweuxU5a6jpijSgKM2bzvfN1EiVZK4h3ASV40iQxjmfbFmSJ4M3TBfWHVbKeE2h
EH5xvGz158xua+UB3zAaZ9jZvTV2VcJvix2sBwTgS5zHm/kqHplPPSgcpXA1biqy
GTetdkPdRf6OftVvWho50ZaVaHiRnEAyDAyUVsgbUewoSh+XTP8SlZAbEn7g10Mp
YsnD5D6EpW4SgCU0VVm/oVSndbkrgj+MklKeUcLz422FbKekdh5JyeWyCuEBFby7
iFyXAbYZciFDSVzAWw4iuI5yI21FrpMsdVDfScEDl//nPmgQ6LMrYzMS8cCVYnyQ
/yCVIIQqKeRFwfRxKQndN4N4CczSjuSexVUmsuuGm1h/oOLTzNIKQ0bCwGteyBgT
mL35fRgD5gA1R5+XHk53CJjwQlT/yPhsh9KXx7FmVbc8DGpm2Fo=
=WQo3
-----END PGP SIGNATURE-----

--cYi51EFMlBBQ3wYhCbqUxzTpqaw0TEm38--
