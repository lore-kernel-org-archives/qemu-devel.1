Received: from eggs.gnu.org ([208.118.235.92]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYNC-0007Tf-0W
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYN8-0002Gc-Su
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:06 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIYN8-0002GN-M6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:44:02 -0400
Received: by mail-wr0-x241.google.com with SMTP id p4-v6so15698750wrh.3
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:44:02 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-6-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 12:44:00 +0100
Message-ID: <87o9hhf8jj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/28] fpu/softfloat: Canonicalize NaN
 fraction
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

> Shift the NaN fraction to a canonical position, much like we
> do for the fraction of normal numbers.  This will facilitate
> manipulation of NaNs within the shared code paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 0d17027379..607c4a78d5 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -330,10 +330,11 @@ static FloatParts canonicalize(FloatParts part, con=
st FloatFmt *parm,
>          if (part.frac =3D=3D 0) {
>              part.cls =3D float_class_inf;
>          } else {
> +            part.frac <<=3D parm->frac_shift;
>  #ifdef NO_SIGNALING_NANS
>              part.cls =3D float_class_qnan;
>  #else
> -            int64_t msb =3D part.frac << (parm->frac_shift + 2);
> +            int64_t msb =3D part.frac << 2;
>              if ((msb < 0) =3D=3D status->snan_bit_is_one) {
>                  part.cls =3D float_class_snan;
>              } else {
> @@ -480,6 +481,7 @@ static FloatParts round_canonical(FloatParts p, float=
_status *s,
>      case float_class_qnan:
>      case float_class_snan:
>          exp =3D exp_max;
> +        frac >>=3D parm->frac_shift;
>          break;
>
>      default:
> @@ -503,6 +505,7 @@ static float16 float16_round_pack_canonical(FloatPart=
s p, float_status *s)
>      case float_class_dnan:
>          return float16_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>=3D float16_params.frac_shift;
>          return float16_maybe_silence_nan(float16_pack_raw(p), s);
>      default:
>          p =3D round_canonical(p, s, &float16_params);
> @@ -521,6 +524,7 @@ static float32 float32_round_pack_canonical(FloatPart=
s p, float_status *s)
>      case float_class_dnan:
>          return float32_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>=3D float32_params.frac_shift;
>          return float32_maybe_silence_nan(float32_pack_raw(p), s);
>      default:
>          p =3D round_canonical(p, s, &float32_params);
> @@ -539,6 +543,7 @@ static float64 float64_round_pack_canonical(FloatPart=
s p, float_status *s)
>      case float_class_dnan:
>          return float64_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>=3D float64_params.frac_shift;
>          return float64_maybe_silence_nan(float64_pack_raw(p), s);
>      default:
>          p =3D round_canonical(p, s, &float64_params);


--
Alex Benn=C3=A9e
