Received: from eggs.gnu.org ([209.51.188.92]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9FK-0005e5-Nn
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9FJ-00018j-Qe
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:31:54 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw9FH-0000z4-RY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:31:52 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so35640987otl.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-6-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 17:31:31 +0000
Message-ID: <CAFEAcA86sQBcQCBs15L_c9AgPhuOVkE-HAQKo3s=D208VxNJqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 5/8] target/arm: Add helpers for FMLAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Note that float16_to_float32 rightly squashes SNaN to QNaN.
> But of course pickNaNMulAdd, for ARM, selects SNaNs first.
> So we have to preserve SNaN long enough for the correct NaN
> to be selected.  Thus float16_to_float32_by_bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> +/*
> + * Convert float16 to float32, raising no exceptions and
> + * preserving exceptional values, including SNaN.
> + * This is effectively an unpack+repack operation.
> + */
> +static float32 float16_to_float32_by_bits(uint32_t f16)
> +{
> +    const int f16_bias = 15;
> +    const int f32_bias = 127;
> +    uint32_t sign = extract32(f16, 15, 1);
> +    uint32_t exp = extract32(f16, 10, 5);
> +    uint32_t frac = extract32(f16, 0, 10);
> +
> +    if (exp == 0x1f) {
> +        /* Inf or NaN */
> +        exp = 0xff;
> +    } else if (exp == 0) {
> +        /* Zero or denormal.  */
> +        if (frac != 0) {
> +            /*
> +             * Denormal; these are all normal float32.
> +             * Shift the fraction so that the msb is at bit 11,
> +             * then remove bit 11 as the implicit bit of the
> +             * normalized float32.  Note that we still go through
> +             * the shift for normal numbers below, to put the
> +             * float32 fraction at the right place.
> +             */
> +            int shift = clz32(frac) - 21;
> +            frac = (frac << shift) & 0x3ff;
> +            exp = f32_bias - f16_bias - shift + 1;
> +        }
> +    } else {
> +        /* Normal number; adjust the bias.  */
> +        exp += f32_bias - f16_bias;
> +    }
> +    sign <<= 31;
> +    exp <<= 23;
> +    frac <<= 23 - 10;
> +
> +    return sign | exp | frac;
> +}

Shouldn't we be observing FPCR.FZ16 here and flushing
denormal float16 inputs to zero if it's set ?
(In the pseudocode this happens in FPUnpackBase, called
from FPUnpack.)

NB: this might be awkward because for A64 we need to use the
fpstatus with FZ16 in it (vfp.fp_status_f16) for the float16
inputs, but the one with the normal FZ bit (vfp.fp_status)
for the float32 input.

thanks
-- PMM
