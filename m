Received: from eggs.gnu.org ([2001:4830:134:3::10]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAk1-0002wp-Su
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAk0-00035U-Uv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:30:05 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAk0-000359-QX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:30:04 -0400
Received: by mail-oi0-x243.google.com with SMTP id y15-v6so10169875oia.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:30:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-7-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:29:43 +0100
Message-ID: <CAFEAcA_eynaKKW0BJ1MuGnM1o27D1-QtxgTdMkunrqygw0pjNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/27] fpu/softfloat: Canonicalize NaN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> Shift the NaN fraction to a canonical position, much like we do
> for the fraction of normal numbers.  Immediately, this simplifies
> the float-to-float conversion.  Later, this will facilitate
> manipulation of NaNs within the shared code paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

The commit message says it simplifies the float-to-float codepath,
but the patch doesn't touch that: it's missing the part that was in
v1 of the series that removed the
        a.frac = a.frac << (64 - srcf->frac_size) >> (64 - dstf->frac_size);
line and updated the associated comment.

Isn't that change necessary in this patch if we're changing the
canonical representation of NaNs ?

> ---
>  fpu/softfloat.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 353893aaea..a56d3d975b 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -330,10 +330,11 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
>          if (part.frac == 0) {
>              part.cls = float_class_inf;
>          } else {
> +            part.frac <<= parm->frac_shift;
>  #ifdef NO_SIGNALING_NANS
>              part.cls = float_class_qnan;
>  #else
> -            int64_t msb = part.frac << (parm->frac_shift + 2);
> +            int64_t msb = part.frac << 2;
>              if ((msb < 0) == status->snan_bit_is_one) {
>                  part.cls = float_class_snan;
>              } else {
> @@ -480,6 +481,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
>      case float_class_qnan:
>      case float_class_snan:
>          exp = exp_max;
> +        frac >>= parm->frac_shift;
>          break;
>
>      default:
> @@ -503,6 +505,7 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
>      case float_class_dnan:
>          return float16_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>= float16_params.frac_shift;
>          return float16_maybe_silence_nan(float16_pack_raw(p), s);
>      default:
>          p = round_canonical(p, s, &float16_params);
> @@ -521,6 +524,7 @@ static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
>      case float_class_dnan:
>          return float32_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>= float32_params.frac_shift;
>          return float32_maybe_silence_nan(float32_pack_raw(p), s);
>      default:
>          p = round_canonical(p, s, &float32_params);
> @@ -539,6 +543,7 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
>      case float_class_dnan:
>          return float64_default_nan(s);
>      case float_class_msnan:
> +        p.frac >>= float64_params.frac_shift;
>          return float64_maybe_silence_nan(float64_pack_raw(p), s);
>      default:
>          p = round_canonical(p, s, &float64_params);
> --
> 2.17.0
>

thanks
-- PMM
