Received: from eggs.gnu.org ([2001:4830:134:3::10]:33458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHAtp-0005FM-BW
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHAtm-00038H-7t
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:28:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fHAtm-00037w-0k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:28:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so5911772wrc.7
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:28:01 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180511004345.26708-5-richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:26:58 +0100
Message-ID: <87bmdmupil.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/19] fpu/softfloat: Canonicalize NaN
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

> Shift the NaN fraction to a canonical position, much like we do
> for the fraction of normal numbers.  Immediately, this simplifies
> the float-to-float conversion.  Later, this will facilitate
> manipulation of NaNs within the shared code paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 5e4982b035..df377b6314 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -329,10 +329,11 @@ static FloatParts canonicalize(FloatParts part, con=
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
> @@ -498,6 +499,7 @@ static FloatParts round_canonical(FloatParts p, float=
_status *s,
>      case float_class_qnan:
>      case float_class_snan:
>          exp =3D exp_max;
> +        frac >>=3D parm->frac_shift;

Unfortunately we now miss this step when we handle:

    case float_class_msnan:
        return float64_maybe_silence_nan(float64_pack_raw(p), s);

This seems to fix that:

recanonicalise frac before packing and sending

1 file changed, 3 insertions(+)
fpu/softfloat.c | 3 +++

modified   fpu/softfloat.c
@@ -532,6 +532,7 @@ static float16 float16a_round_pack_canonical(const Floa=
tFmt *params,
     case float_class_dnan:
         return float16_default_nan(s);
     case float_class_msnan:
+        p.frac >>=3D params->frac_shift;
         return float16_maybe_silence_nan(float16_pack_raw(p), s);
     default:
         p =3D round_canonical(p, s, params);
@@ -555,6 +556,7 @@ static float32 float32_round_pack_canonical(FloatParts =
p, float_status *s)
     case float_class_dnan:
         return float32_default_nan(s);
     case float_class_msnan:
+        p.frac >>=3D float32_params.frac_shift;
         return float32_maybe_silence_nan(float32_pack_raw(p), s);
     default:
         p =3D round_canonical(p, s, &float32_params);
@@ -573,6 +575,7 @@ static float64 float64_round_pack_canonical(FloatParts =
p, float_status *s)
     case float_class_dnan:
         return float64_default_nan(s);
     case float_class_msnan:
+        p.frac >>=3D float64_params.frac_shift;
         return float64_maybe_silence_nan(float64_pack_raw(p), s);
     default:
         p =3D round_canonical(p, s, &float64_params);

--
Alex Benn=C3=A9e
