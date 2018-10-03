Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7dSY-0005E8-25
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7dSR-0003ai-OH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g7dSO-0003X2-LQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id y16so5298351wrw.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:28:34 -0700 (PDT)
References: <20181002195347.26712-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181002195347.26712-1-richard.henderson@linaro.org>
Date: Wed, 03 Oct 2018 10:28:31 +0100
Message-ID: <87ftxnl6ps.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> The __udiv_qrnnd primitive that we nicked from gmp requires its
> inputs to be normalized.  We were not doing that.  Because the
> inputs are nearly normalized already, finishing that is trivial.
> Inline div128to64 into its one user, because it is no longer a
> general-purpose routine.
>
> Fixes: cf07323d494
> Fixes: https://bugs.launchpad.net/qemu/+bug/1793119
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat-macros.h | 48 -----------------------
>  fpu/softfloat.c                | 72 ++++++++++++++++++++++++++++++----
>  2 files changed, 64 insertions(+), 56 deletions(-)
>
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
> index 35e1603a5e..f29426ac46 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -625,54 +625,6 @@ static inline uint64_t estimateDiv128To64(uint64_t a=
0, uint64_t a1, uint64_t b)
>
>  }
>
> -/* From the GNU Multi Precision Library - longlong.h __udiv_qrnnd
> - * (https://gmplib.org/repo/gmp/file/tip/longlong.h)
> - *
> - * Licensed under the GPLv2/LGPLv3
> - */
> -static inline uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
> -{
> -    uint64_t d0, d1, q0, q1, r1, r0, m;
> -
> -    d0 =3D (uint32_t)d;
> -    d1 =3D d >> 32;
> -
> -    r1 =3D n1 % d1;
> -    q1 =3D n1 / d1;
> -    m =3D q1 * d0;
> -    r1 =3D (r1 << 32) | (n0 >> 32);
> -    if (r1 < m) {
> -        q1 -=3D 1;
> -        r1 +=3D d;
> -        if (r1 >=3D d) {
> -            if (r1 < m) {
> -                q1 -=3D 1;
> -                r1 +=3D d;
> -            }
> -        }
> -    }
> -    r1 -=3D m;
> -
> -    r0 =3D r1 % d1;
> -    q0 =3D r1 / d1;
> -    m =3D q0 * d0;
> -    r0 =3D (r0 << 32) | (uint32_t)n0;
> -    if (r0 < m) {
> -        q0 -=3D 1;
> -        r0 +=3D d;
> -        if (r0 >=3D d) {
> -            if (r0 < m) {
> -                q0 -=3D 1;
> -                r0 +=3D d;
> -            }
> -        }
> -    }
> -    r0 -=3D m;
> -
> -    /* Return remainder in LSB */
> -    return (q1 << 32) | q0 | (r0 !=3D 0);
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns an approximation to the square root of the 32-bit significand =
given
>  | by `a'.  Considered as an integer, `a' must be at least 2^31.  If bit =
0 of
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 9405f12a03..93edc06996 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1112,19 +1112,75 @@ static FloatParts div_floats(FloatParts a, FloatP=
arts b, float_status *s)
>      bool sign =3D a.sign ^ b.sign;
>
>      if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_norm=
al) {
> -        uint64_t temp_lo, temp_hi;
> +        uint64_t n0, n1, d0, d1, q0, q1, r1, r0, m, d;
>          int exp =3D a.exp - b.exp;
> +
> +        /*
> +         * We want the 2*N / N-bit division to produce exactly an N-bit
> +         * result, so that we do not have to renormalize afterward.
> +         * If A < B, then division would produce an (N-1)-bit result;
> +         * shift A left by one to produce the an N-bit result, and
> +         * decrement the exponent to match.
> +         *
> +         * The udiv_qrnnd algorithm that we're using requires normalizat=
ion,
> +         * i.e. the msb of the denominator must be set.  Since we know t=
hat
> +         * DECOMPOSED_BINARY_POINT is msb-1, everything must be shifted =
left
> +         * by one more.
> +         */
>          if (a.frac < b.frac) {
>              exp -=3D 1;
> -            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1,
> -                              &temp_hi, &temp_lo);
> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 2, &n=
1, &n0);
>          } else {
> -            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT,
> -                              &temp_hi, &temp_lo);
> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1, &n=
1, &n0);
>          }
> -        /* LSB of quot is set if inexact which roundandpack will use
> -         * to set flags. Yet again we re-use a for the result */
> -        a.frac =3D div128To64(temp_lo, temp_hi, b.frac);
> +        d =3D b.frac << 1;
> +
> +        /*
> +         * From the GNU Multi Precision Library - longlong.h __udiv_qrnnd
> +         * (https://gmplib.org/repo/gmp/file/tip/longlong.h)
> +         * Licensed under the GPLv2/LGPLv3.
> +         */
> +        d0 =3D (uint32_t)d;
> +        d1 =3D d >> 32;
> +
> +        r1 =3D n1 % d1;
> +        q1 =3D n1 / d1;
> +        m =3D q1 * d0;
> +        r1 =3D (r1 << 32) | (n0 >> 32);
> +        if (r1 < m) {
> +            q1 -=3D 1;
> +            r1 +=3D d;
> +            if (r1 >=3D d) {
> +                if (r1 < m) {
> +                    q1 -=3D 1;
> +                    r1 +=3D d;
> +                }
> +            }
> +        }
> +        r1 -=3D m;
> +
> +        r0 =3D r1 % d1;
> +        q0 =3D r1 / d1;
> +        m =3D q0 * d0;
> +        r0 =3D (r0 << 32) | (uint32_t)n0;
> +        if (r0 < m) {
> +            q0 -=3D 1;
> +            r0 +=3D d;
> +            if (r0 >=3D d) {
> +                if (r0 < m) {
> +                    q0 -=3D 1;
> +                    r0 +=3D d;
> +                }
> +            }
> +        }
> +        r0 -=3D m;
> +        /* End of __udiv_qrnnd.  */
> +
> +        /* Adjust remainder for normalization step.  */
> +        r0 >>=3D 1;
> +
> +        /* Set lsb if there is a remainder, to set inexact.  */
> +        a.frac =3D (q1 << 32) | q0 | (r0 !=3D 0);
>          a.sign =3D sign;
>          a.exp =3D exp;
>          return a;

I guess if we get to the 80 bit stuff this will need to be commonised
again?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

With Emilio's fp-test the only non-special ext80 failures left seem to be
some flag setting in various flavours of mulAdd. For example:

10:27:23 [alex@zen:~/l/q/q/t/fp] testing/generic-op-tester 1 + ./fp-test f1=
6_mulAdd f32_mulAdd f64_mulAdd
>> Testing f16_mulAdd, rounding near_even, tininess before rounding
6133248 tests total.
Errors found in f16_mulAdd, rounding near_even, tininess before rounding:
+00.000  +1F.000  +1F.3DE  =3D> +1F.3DE .....  expected -1F.3FF v....
+00.000  +1F.000  +1F.3FF  =3D> +1F.3FF .....  expected -1F.3FF v....
+00.000  +1F.000  +1F.3FE  =3D> +1F.3FE .....  expected -1F.3FF v....
+00.000  +1F.000  -1F.3FF  =3D> -1F.3FF .....  expected -1F.3FF v....
+00.000  +1F.000  -1F.3FE  =3D> -1F.3FE .....  expected -1F.3FF v....


--
Alex Benn=C3=A9e
