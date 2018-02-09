Received: from eggs.gnu.org ([2001:4830:134:3::10]:56947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCt7-00080A-VT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCt4-0007te-Ti
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:55:06 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:37446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekCt4-0007sx-Lk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:55:02 -0500
Received: by mail-pg0-x22b.google.com with SMTP id o1so4084987pgn.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 09:55:02 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5093f9e-23b3-3d04-7a5b-038619d89d63@linaro.org>
Date: Fri, 9 Feb 2018 09:54:58 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 23/32] arm/helper.c: re-factor recpe and
 add recepe_f16
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
> +float16 HELPER(recpe_f16)(float16 input, void *fpstp)
> +{
> +    float_status *fpst = fpstp;
> +    float16 f16 = float16_squash_input_denormal(input, fpst);
> +    uint32_t f16_val = float16_val(f16);
> +    uint32_t f16_sign = float16_is_neg(f16);
> +    int f16_exp = extract32(f16_val, 10, 5);
> +    uint32_t f16_frac = extract32(f16_val, 0, 10);
> +    uint64_t f64_frac;
> +
> +    if (float16_is_any_nan(f16)) {
> +        float16 nan = f16;
> +        if (float16_is_signaling_nan(f16, fpst)) {
> +            float_raise(float_flag_invalid, fpst);
> +            nan = float16_maybe_silence_nan(f16, fpst);
> +        }
> +        if (fpst->default_nan_mode) {
> +            nan =  float16_default_nan(fpst);
> +        }
> +        return nan;
> +    } else if (float16_is_infinity(f16)) {
> +        return float16_set_sign(float16_zero, float16_is_neg(f16));
> +    } else if (float16_is_zero(f16)) {
> +        float_raise(float_flag_divbyzero, fpst);
> +        return float16_set_sign(float16_infinity, float16_is_neg(f16));
> +    } else if (float16_abs(f16) < (1 << 8)) {
> +        /* Abs(value) < 2.0^-14 */

The pseudocode I'm looking at says 2.0^-16.  But I think the code is right --
this is checking for two zero bits at the top of a denormal, so that is
2.0^(-14-2).


> +        float_raise(float_flag_overflow | float_flag_inexact, fpst);
> +        if (round_to_inf(fpst, f16_sign)) {
> +            return float16_set_sign(float16_infinity, f16_sign);
> +        } else {
> +            return float16_set_sign(float16_maxnorm, f16_sign);
> +        }
> +        /* FP16 has it's own flag FZ16 flag which is in a separate fpst*/
> +    } else if (f16_exp >= 14 && fpst->flush_to_zero) {

(1) The comment is confusing.
    (a) It's placement within the previous IF is not helpful,
    (b) Why mention the separate fpst, begging the question of
        where it is?  We're using it, of course, so...

(2) The exponent is still biased, so this isn't 2.0^14 you're testing.

>      } else if (f32_exp >= 253 && fpst->flush_to_zero) {

E.g. the single-precision version tests (2^)126 + (bias)127.


r~
