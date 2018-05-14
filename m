Received: from eggs.gnu.org ([2001:4830:134:3::10]:39521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAlN-0004Wm-Tx
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAlN-00047f-1W
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:31:29 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAlM-00047T-U1
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:31:28 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so13643435oth.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:31:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-8-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:31:07 +0100
Message-ID: <CAFEAcA-5dWB3DhZCfg5vmBXr-+_BAm8-Uh-O0TSY-yMNYXQ4cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/27] fpu/softfloat: Introduce
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
> +/*----------------------------------------------------------------------------
> +| For the deconstructed floating-point with fraction FRAC, return true
> +| if the fraction represents a signalling NaN; otherwise false.
> +*----------------------------------------------------------------------------*/
> +
> +static bool parts_is_snan_frac(uint64_t frac, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    return false;
> +#else
> +    flag msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
> +    return msb == status->snan_bit_is_one;
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------------
>  | The pattern for a default generated half-precision NaN.
>  *----------------------------------------------------------------------------*/
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index a56d3d975b..cb68f2eb20 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -331,16 +331,8 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
>              part.cls = float_class_inf;
>          } else {
>              part.frac <<= parm->frac_shift;
> -#ifdef NO_SIGNALING_NANS
> -            part.cls = float_class_qnan;
> -#else
> -            int64_t msb = part.frac << 2;
> -            if ((msb < 0) == status->snan_bit_is_one) {
> -                part.cls = float_class_snan;
> -            } else {
> -                part.cls = float_class_qnan;
> -            }
> -#endif
> +            part.cls = (parts_is_snan_frac(part.frac, status)
> +                        ? float_class_snan : float_class_qnan);
>          }
>      } else if (part.exp == 0) {
>          if (likely(part.frac == 0)) {
> --
> 2.17.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
