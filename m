Received: from eggs.gnu.org ([2001:4830:134:3::10]:55238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ntZ-0006sX-E6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ntY-0000zp-FN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:40:49 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5ntY-0000zM-Ah
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:40:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id l190-v6so10230573oig.9
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 00:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410055912.934-1-richard.henderson@linaro.org>
References: <20180410055912.934-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 08:40:27 +0100
Message-ID: <CAFEAcA-UQhSMe4p8zDqXgW6qS6sadrrZaJFP9W0bVaimgTi0vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] fpu: Fix rounding mode for
 floatN_to_uintM_round_to_zero
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

On 10 April 2018 at 06:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We incorrectly passed in the current rounding mode
> instead of float_round_to_zero.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Found while runnning SVE RISU tests; it should be visible with the
> right set of inputs to AdvSIMD RISU tests.
>
>
> r~
>
> ---
>  fpu/softfloat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 6e16284e66..b46dccc63e 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1486,8 +1486,8 @@ uint ## isz ## _t float ## fsz ## _to_uint ## isz ## _round_to_zero     \
>   (float ## fsz a, float_status *s)                                      \
>  {                                                                       \
>      FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
> -    return round_to_uint_and_pack(p, s->float_rounding_mode,            \
> -                                 UINT ## isz ## _MAX, s);               \
> +    return round_to_uint_and_pack(p, float_round_to_zero,               \
> +                                  UINT ## isz ## _MAX, s);              \
>  }
>
>  FLOAT_TO_UINT(16, 16)
> --
> 2.14.3

Would this be likely the fix for
https://bugs.launchpad.net/qemu/+bug/1761401
?

thanks
-- PMM
