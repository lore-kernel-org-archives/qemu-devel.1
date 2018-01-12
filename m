Received: from eggs.gnu.org ([2001:4830:134:3::10]:58878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea0Eo-0000c8-Ov
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea0En-0004Hk-KH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:23:18 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea0En-0004HK-Do
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:23:17 -0500
Received: by mail-ot0-x242.google.com with SMTP id a24so5157426otd.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 06:23:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-11-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 14:22:56 +0000
Message-ID: <CAFEAcA_7BXf3=8iY52gjL3uz8Uqa5f-QwE1R_rPNr+06moEe8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> These structures pave the way for generic softfloat helper routines
> that will operate on fully decomposed numbers.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
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
>
>  /* We only need stdlib for abort() */
> @@ -186,6 +186,74 @@ static inline flag extractFloat64Sign(float64 a)
>      return float64_val(a) >> 63;
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Classify a floating point number.
> +*-----------------------------------------------------------------------=
-----*/
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
> +/*----------------------------------------------------------------------=
------
> +| Structure holding all of the decomposed parts of a float.
> +| The exponent is unbiased and the fraction is normalized.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +typedef struct {
> +    uint64_t frac   : 64;
> +    int exp         : 32;
> +    float_class cls : 8;
> +    int             : 23;

What is this unnamed 23 bit field for?

> +    bool sign       : 1;

Why are we using a bitfield struct here anyway? uint64_t is 64 bits,
int is 32 bits, we don't care how big the float_class enum is
represented as, and we're not trying to pack together lots of bools
so it doesn't matter much if we have a whole byte for the sign.

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

Why the '1' in the field name? Overall I think some brief
comments about what the fields mean would be helpful.

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

Maybe we should hide the DECOMPOSED_BINARY_POINT bit inside the macro?
Then the 10/23/52 are just the number of fraction bits in the format.

thanks
-- PMM
