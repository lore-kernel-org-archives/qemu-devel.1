Received: from eggs.gnu.org ([2001:4830:134:3::10]:39998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXZD-0003Ca-LO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXZC-0002Ez-JX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:27 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXZC-0002Ej-ED
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:26 -0400
Received: by mail-ot0-x242.google.com with SMTP id 15-v6so17881347otn.12
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:52:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-14-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:52:05 +0100
Message-ID: <CAFEAcA-D67=kOYvGXaU_uRdvhSwJCZhk_7MSw1QLw3a_VCiN_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/28] fpu/softfloat: Partial support
 for ARM Alternative half-precision
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

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> For float16 ARM supports an alternative half-precision format which
> sacrifices the ability to represent NaN/Inf in return for a higher
> dynamic range.  The new FloatFmt flag, arm_althp, is then used to
> modify the behaviour of canonicalize and round_canonical with respect
> to representation and exception raising.
>
> Usage of this new flag waits until we re-factor float-to-float conversion=
s.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v3
>   - squash NaN to 0 if destination is AHP F16
> v4
>   - handle inf -> ahp max in float_to_float not round_canonical
>   - assert no nan and inf for ahp in round_canonical
>   - check ahp before snan in float_to_float
> v5
>   - split out canonicalize and round_canonical changes from the rest
> ---
>  fpu/softfloat.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 41253c6749..55d0d01ec3 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -220,8 +220,10 @@ typedef struct {
>   *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_=
POINT
>   * The following are computed based the size of fraction
>   *   frac_lsb: least significant bit of fraction
> - *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
> + *   frac_lsbm1: the bit bellow the least significant bit (for rounding)

"below"

>   *   round_mask/roundeven_mask: masks used for rounding
> + * The following optional modifiers are available:
> + *   arm_althp: handle ARM Alternative Half Precision
>   */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
