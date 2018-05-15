Received: from eggs.gnu.org ([2001:4830:134:3::10]:58537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIa5t-0002hx-DS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIa5j-00085V-Ui
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:34:21 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIa5j-00085D-NL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:34:11 -0400
Received: by mail-wm0-x243.google.com with SMTP id t11-v6so1105367wmt.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:34:11 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-13-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 14:34:09 +0100
Message-ID: <87h8n9f3fy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 12/28] target/arm: Remove
 floatX_maybe_silence_nan from conversions
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

> This is now handled properly by the generic softfloat code.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper-a64.c |  1 -
>  target/arm/helper.c     | 12 ++----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 6f0eb83661..f92bdea732 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -466,7 +466,6 @@ float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMSta=
te *env)
>      set_float_rounding_mode(float_round_to_zero, &tstat);
>      set_float_exception_flags(0, &tstat);
>      r =3D float64_to_float32(a, &tstat);
> -    r =3D float32_maybe_silence_nan(r, &tstat);
>      exflags =3D get_float_exception_flags(&tstat);
>      if (exflags & float_flag_inexact) {
>          r =3D make_float32(float32_val(r) | 1);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e05c7230d4..db8bbe52a6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11348,20 +11348,12 @@ FLOAT_CONVS(ui, d, 64, u)
>  /* floating point conversion */
>  float64 VFP_HELPER(fcvtd, s)(float32 x, CPUARMState *env)
>  {
> -    float64 r =3D float32_to_float64(x, &env->vfp.fp_status);
> -    /* ARM requires that S<->D conversion of any kind of NaN generates
> -     * a quiet NaN by forcing the most significant frac bit to 1.
> -     */
> -    return float64_maybe_silence_nan(r, &env->vfp.fp_status);
> +    return float32_to_float64(x, &env->vfp.fp_status);
>  }
>
>  float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
>  {
> -    float32 r =3D  float64_to_float32(x, &env->vfp.fp_status);
> -    /* ARM requires that S<->D conversion of any kind of NaN generates
> -     * a quiet NaN by forcing the most significant frac bit to 1.
> -     */
> -    return float32_maybe_silence_nan(r, &env->vfp.fp_status);
> +    return float64_to_float32(x, &env->vfp.fp_status);
>  }
>
>  /* VFP3 fixed point conversion.  */


--
Alex Benn=C3=A9e
