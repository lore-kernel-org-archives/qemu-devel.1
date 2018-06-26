Received: from eggs.gnu.org ([2001:4830:134:3::10]:53595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXlSy-0003Ga-JW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXlSx-0001pJ-Un
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:44:56 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXlSx-0001ox-OP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:44:55 -0400
Received: by mail-ot0-x242.google.com with SMTP id i17-v6so7627282otl.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:44:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-24-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 11:44:34 +0100
Message-ID: <CAFEAcA9R-FWVVsrYESi3Nqkfs3FCetcK4L2KVFghtqDLBxUMHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 23/35] target/arm: Implement SVE
 floating-point convert precision
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 13 +++++++++++++
>  target/arm/sve_helper.c    | 27 +++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 ++++++++
>  4 files changed, 78 insertions(+)

> +static inline float32 sve_f16_to_f32(float16 f, float_status *s)
> +{
> +    return float16_to_float32(f, true, s);
> +}
> +
> +static inline float64 sve_f16_to_f64(float16 f, float_status *s)
> +{
> +    return float16_to_float64(f, true, s);
> +}
> +
> +static inline float16 sve_f32_to_f16(float32 f, float_status *s)
> +{
> +    return float32_to_float16(f, true, s);
> +}
> +
> +static inline float16 sve_f64_to_f16(float64 f, float_status *s)
> +{
> +    return float64_to_float16(f, true, s);
> +}

A comment to the effect that the SVE fp-to-fp conversion
routines always use IEEE format halfprec (ie ignore FPCR.AHP)
would be helpful.

Are you sure we have the FPCR.FZ16 handling right here? That
is, do we need the same "use the not-fp16 fpstatus pointer,
and temporarily clear the flush flag for the fp16 end of
the conversion" behaviour that we have in vfp_fcvt_f16_to_f32
and friends ? The pseudocode FPConvertSVE() calls FPConvert(),
which is the "ignore FZ16" codepath I think. The test case would
be (eg) a conversion where the input f16 is denormal and
FPCR.FZ == 1: this should not do the flush-input-to-zero, right?

thanks
-- PMM
