Received: from eggs.gnu.org ([2001:4830:134:3::10]:34593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAy1-0000vC-MA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAy0-0004Cr-QA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:34:41 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAy0-0004CU-K1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:34:40 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so377517pge.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:34:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-13-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <33f7c944-8c6f-ec23-f88f-2a7a4b27a55e@twiddle.net>
Date: Thu, 16 Feb 2017 12:34:27 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-13-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/16] target-m68k: add fscale, fgetman,
 fgetexp and fmod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h        |  1 +
>  target/m68k/fpu_helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/helper.h     |  4 ++++
>  target/m68k/translate.c  | 14 ++++++++++++
>  4 files changed, 75 insertions(+)
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 7985dc3..3042ab7 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -253,6 +253,7 @@ typedef enum {
>  /* Quotient */
>
>  #define FPSR_QT_MASK  0x00ff0000
> +#define FPSR_QT_SHIFT 16
>
>  /* Floating-Point Control Register */
>  /* Rounding mode */
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index d8145e0..42f5b5c 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -458,3 +458,59 @@ void HELPER(const_FP0)(CPUM68KState *env, uint32_t offset)
>      env->fp0l = fpu_rom[offset].low;
>      env->fp0h = fpu_rom[offset].high;
>  }
> +
> +void HELPER(getexp_FP0)(CPUM68KState *env)
> +{
> +    int32_t exp;
> +    floatx80 res;
> +
> +    res = FP0_to_floatx80(env);
> +    if (floatx80_is_zero_or_denormal(res) || floatx80_is_any_nan(res) ||
> +        floatx80_is_infinity(res)) {
> +        return;
> +    }
> +    exp = (env->fp0h & 0x7fff) - 0x3fff;
> +
> +    res = int32_to_floatx80(exp, &env->fp_status);
> +
> +    floatx80_to_FP0(env, res);

Failure to raise OPERR for infinities?

> +void HELPER(getman_FP0)(CPUM68KState *env)
> +{
> +    floatx80 res;
> +    res = int64_to_floatx80(env->fp0l, &env->fp_status);
> +    floatx80_to_FP0(env, res);
> +}

This seems completely wrong.  (1) NaN gets returned, (2) Inf raises OPERR, (3) 
Normal values return something in the range [1.0 ... 2.0).  Which means you 
should just force the exponent rather than convert the low part.

> +
> +void HELPER(scale_FP0_FP1)(CPUM68KState *env)
> +{
> +    int32_t scale;
> +    int32_t exp;
> +
> +    scale = floatx80_to_int32(FP0_to_floatx80(env), &env->fp_status);
> +
> +    exp = (env->fp1h & 0x7fff) + scale;
> +
> +    env->fp0h = (env->fp1h & 0x8000) | (exp & 0x7fff);
> +    env->fp0l = env->fp1l;
> +}

Missing handling for NaN, Inf, 0, denormal.


r~
