Received: from eggs.gnu.org ([2001:4830:134:3::10]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtEp-0003KQ-Ep
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtEo-0001fv-8D
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:56:11 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejtEo-0001fD-3V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:56:10 -0500
Received: by mail-io0-x241.google.com with SMTP id x188so724833iod.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:56:09 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc79bcf4-249a-0ae1-5099-7aeb78e97e04@linaro.org>
Date: Thu, 8 Feb 2018 12:56:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/32] arm/translate-a64: add FP16
 FMULA/X/S to simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper-a64.c    | 24 ++++++++++++++++++++++++
>  target/arm/helper-a64.h    |  2 ++
>  target/arm/translate-a64.c | 15 +++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 78eeda31d1..bdfcac111f 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -600,6 +600,30 @@ ADVSIMD_HALFOP(max)
>  ADVSIMD_HALFOP(minnum)
>  ADVSIMD_HALFOP(maxnum)
>  
> +/* Data processing - scalar floating-point and advanced SIMD */
> +float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
> +{
> +    float_status *fpst = fpstp;
> +
> +    a = float16_squash_input_denormal(a, fpst);
> +    b = float16_squash_input_denormal(b, fpst);
> +
> +    if ((float16_is_zero(a) && float16_is_infinity(b)) ||
> +        (float16_is_infinity(a) && float16_is_zero(b))) {
> +        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
> +        return make_float16((1U << 14) |
> +                            ((float16_val(a) ^ float16_val(b)) & (1U << 15)));

Since you diced all of the structures, are you going to dice all of the (now
pointless) make/val calls?

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
