Received: from eggs.gnu.org ([2001:4830:134:3::10]:44839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIB5V-0003Rj-6K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIB5U-0006St-DL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:52:17 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIB5U-0006SX-6N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:52:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id g7-v6so13704650otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:52:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-9-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:51:54 +0100
Message-ID: <CAFEAcA8MVRc_P2AvkRwJj1cNQd7yiXf7SdJ1rXGJuUMJrTDybA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 08/27] fpu/softfloat: Replace
 float_class_dnan with parts_default_nan
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
> With a canonical representation of NaNs, we can return the
> default nan directly rather than delay the expansion until
> the final format is known.
>
> Note one case where we uselessly assigned to a.sign, which was
> overwritten/ignored later when expanding float_class_dnan.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 37 +++++++++++++++++++++++++++++++++++++
>  fpu/softfloat.c            | 38 +++++++++++---------------------------
>  2 files changed, 48 insertions(+), 27 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index 515cb12cfa..0d3d81a52b 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -101,6 +101,43 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------------
> +| The pattern for a default generated deconstructed floating-point NaN.
> +*----------------------------------------------------------------------------*/
> +
> +static FloatParts parts_default_nan(float_status *status)
> +{
> +    bool sign = 0;
> +    uint64_t frac;
> +
> +#if defined(TARGET_SPARC) || defined(TARGET_M68K)
> +    frac = (1ULL << DECOMPOSED_BINARY_POINT) - 1;
> +#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
> +      defined(TARGET_S390X) || defined(TARGET_RISCV)
> +    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> +#elif defined(TARGET_HPPA)
> +    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
> +#else
> +    if (status->snan_bit_is_one) {
> +        frac = (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
> +    } else {
> +#if defined(TARGET_MIPS)
> +        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> +#else
> +        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
> +        sign = 1;
> +#endif
> +    }
> +#endif

We can probably clean this logic up later (for instance the MIPS
case is the same as the PPC/ARM/Alpha/S390/RISCV case, and it
would be helpful to specifically indicate who's using the
weird set-the-sign-bit case rather than having that be the
default), but this matches the current logic in float*_default_nan()
so it's easier to review this way.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
