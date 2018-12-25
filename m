Received: from eggs.gnu.org ([208.118.235.92]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkgn-0002dd-Nh
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkgk-0004bg-AR
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:15:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkgk-0004b8-0U
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:15:54 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so13453240wrx.9
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 03:15:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181225070305.18221-1-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eae6d6d4-a076-e949-37c5-9acd6104d206@amsat.org>
Date: Tue, 25 Dec 2018 12:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181225070305.18221-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: enforce softfloat if the
 host's FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Hi Emilio,

On 12/25/18 8:03 AM, Emilio G. Cota wrote:
> The added branch to the FMA ops is marked as unlikely and therefore
> its impact on performance (measured with fp-bench) is within noise range
> when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

Did you forget to write here the result of your measurements?

> 
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2: drop the cpuid bits, since that work (1) is only a performance
> optimization, not a correctness fix and (2) requires additional
> consolidation work that I do not have time to do right now.
> 
>  fpu/softfloat.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 59eac97d10..9132d7a0b0 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1542,6 +1542,8 @@ soft_f64_muladd(float64 a, float64 b, float64 c, int flags,
>      return float64_round_pack_canonical(pr, status);
>  }
>  
> +static bool force_soft_fma;
> +
>  float32 QEMU_FLATTEN
>  float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
>  {
> @@ -1562,6 +1564,11 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
>      if (unlikely(!f32_is_zon3(ua, ub, uc))) {
>          goto soft;
>      }
> +
> +    if (unlikely(force_soft_fma)) {
> +        goto soft;
> +    }
> +
>      /*
>       * When (a || b) == 0, there's no need to check for under/over flow,
>       * since we know the addend is (normal || 0) and the product is 0.
> @@ -1623,6 +1630,11 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
>      if (unlikely(!f64_is_zon3(ua, ub, uc))) {
>          goto soft;
>      }
> +
> +    if (unlikely(force_soft_fma)) {
> +        goto soft;
> +    }
> +
>      /*
>       * When (a || b) == 0, there's no need to check for under/over flow,
>       * since we know the addend is (normal || 0) and the product is 0.
> @@ -7974,3 +7986,24 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
>                                           , status);
>  
>  }
> +
> +static void __attribute__((constructor)) softfloat_init(void)
> +{
> +    union_float64 ua, ub, uc, ur;
> +
> +    if (QEMU_NO_HARDFLOAT) {
> +        return;
> +    }
> +    /*
> +     * Test that the host's FMA is not obviously broken. For example,
> +     * glibc < 2.23 can perform an incorrect FMA on certain hosts; see
> +     *   https://sourceware.org/bugzilla/show_bug.cgi?id=13304
> +     */
> +    ua.s = 0x0020000000000001ULL;
> +    ub.s = 0x3ca0000000000000ULL;
> +    uc.s = 0x0020000000000000ULL;
> +    ur.h = fma(ua.h, ub.h, uc.h);
> +    if (ur.s != 0x0020000000000001ULL) {
> +        force_soft_fma = true;
> +    }
> +}
> 
