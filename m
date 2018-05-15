Received: from eggs.gnu.org ([208.118.235.92]:53959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYNv-0007tG-CC
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYNs-0002ks-LU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:51 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIYNs-0002jw-Eb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:48 -0400
Received: by mail-wm0-x233.google.com with SMTP id l1-v6so507565wmb.2
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:44:48 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-7-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 12:44:46 +0100
Message-ID: <87mux1f8i9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/28] fpu/softfloat: Introduce
 parts_is_snan_frac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat-specialize.h | 15 +++++++++++++++
>  fpu/softfloat.c            | 12 ++----------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index 4fc9ea4ac0..515cb12cfa 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -86,6 +86,21 @@ this code that are retained.
>  #define NO_SIGNALING_NANS 1
>  #endif
>
> +/*----------------------------------------------------------------------=
------
> +| For the deconstructed floating-point with fraction FRAC, return true
> +| if the fraction represents a signalling NaN; otherwise false.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static bool parts_is_snan_frac(uint64_t frac, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    return false;
> +#else
> +    flag msb =3D extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
> +    return msb =3D=3D status->snan_bit_is_one;
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated half-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 607c4a78d5..19f40d6932 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -331,16 +331,8 @@ static FloatParts canonicalize(FloatParts part, cons=
t FloatFmt *parm,
>              part.cls =3D float_class_inf;
>          } else {
>              part.frac <<=3D parm->frac_shift;
> -#ifdef NO_SIGNALING_NANS
> -            part.cls =3D float_class_qnan;
> -#else
> -            int64_t msb =3D part.frac << 2;
> -            if ((msb < 0) =3D=3D status->snan_bit_is_one) {
> -                part.cls =3D float_class_snan;
> -            } else {
> -                part.cls =3D float_class_qnan;
> -            }
> -#endif
> +            part.cls =3D (parts_is_snan_frac(part.frac, status)
> +                        ? float_class_snan : float_class_qnan);
>          }
>      } else if (part.exp =3D=3D 0) {
>          if (likely(part.frac =3D=3D 0)) {


--
Alex Benn=C3=A9e
