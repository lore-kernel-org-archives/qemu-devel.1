Received: from eggs.gnu.org ([2001:4830:134:3::10]:37275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDty-00009P-Cc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDtx-0007Zf-EM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:34 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIDtx-0007Z9-AL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:33 -0400
Received: by mail-ot0-x244.google.com with SMTP id 15-v6so14313801otn.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:52:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-12-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:52:12 +0100
Message-ID: <CAFEAcA9L+XykpU9E_BefPrF_Naw5DXCByAJtRdpbz-qUnjMn2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/27] fpu/softfloat: support ARM
 Alternative half-precision
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

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> For float16 ARM supports an alternative half-precision format which
> sacrifices the ability to represent NaN/Inf in return for a higher
> dynamic range. To support this I've added an additional
> FloatFmt (float16_params_ahp).
>
> The new FloatFmt flag (arm_althp) is then used to modify the behaviour
> of canonicalize and round_canonical with respect to representation and
> exception raising.
>
> Finally the float16_to_floatN and floatN_to_float16 conversion
> routines select the new alternative FloatFmt when !ieee.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

If we do this like this then we have a regression for the
alternate-halfprec conversions between the patch where we change
over the conversions functions and this one.

To fix that we could put the parts of this patch that change
existing-in-master code like round_canonical() first, and then
fold the parts that fix up the conversion functions into the
patch which is currently 10/27.

> ---
> v3
>   - squash NaN to 0 if destination is AHP F16
> v4
>   - handle inf -> ahp max in float_to_float not round_canonical
>   - assert no nan and inf for ahp in round_canonical
>   - check ahp before snan in float_to_float
> ---
>  fpu/softfloat.c | 95 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 81 insertions(+), 14 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index aa219223ff..15a272759d 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -211,8 +211,10 @@ typedef struct {
>   *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_=
POINT
>   * The following are computed based the size of fraction
>   *   frac_lsb: least significant bit of fraction
> - *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
> + *   frac_lsbm1: the bit bellow the least significant bit (for rounding)

"below" (I see this typo slipped past us the first time around)

thanks
-- PMM
