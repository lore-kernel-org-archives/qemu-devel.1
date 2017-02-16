Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAaU-0002yl-RU
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAaU-0003y4-0F
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:10:22 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAaT-0003xi-PN
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:10:21 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so325807pge.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:10:21 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-7-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a9741f4b-fccf-1f99-b490-3359e187adf1@twiddle.net>
Date: Thu, 16 Feb 2017 12:10:11 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/16] target-m68k: add FPCR and FPSR
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
>  void HELPER(itrunc_FP0)(CPUM68KState *env)
>  {
>      floatx80 res;
>
> +    set_float_rounding_mode(float_round_to_zero, &env->fp_status);
>      res = floatx80_round_to_int(FP0_to_floatx80(env), &env->fp_status);
> +    restore_rounding_mode(env);

It would be better to save/restore the current rounding mode as opposed to 
recomputing from the fpcr.

>  void HELPER(cmp_FP0_FP1)(CPUM68KState *env)
>  {
>      floatx80 fp0 = FP0_to_floatx80(env);
>      floatx80 fp1 = FP1_to_floatx80(env);
> -    floatx80 res;
> +    int float_compare;
>
> -    res = floatx80_sub(fp0, fp1, &env->fp_status);
> -    if (floatx80_is_quiet_nan(res, &env->fp_status)) {
> -        /* +/-inf compares equal against itself, but sub returns nan.  */
> -        if (!floatx80_is_quiet_nan(fp0, &env->fp_status)
> -            && !floatx80_is_quiet_nan(fp1, &env->fp_status)) {
> -            res = floatx80_zero;
> -            if (floatx80_lt_quiet(fp0, res, &env->fp_status)) {
> -                res = floatx80_chs(res);
> -            }
> -        }
> -    }
> -
> -    floatx80_to_FP0(env, res);
> +    float_compare = floatx80_compare(fp1, fp0, &env->fp_status);
> +    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | float_comp_to_cc(float_compare);
>  }
>
> -uint32_t HELPER(compare_FP0)(CPUM68KState *env)
> +void HELPER(tst_FP0)(CPUM68KState *env)
>  {
> -    floatx80 fp0 = FP0_to_floatx80(env);
> -    return floatx80_compare_quiet(fp0, floatx80_zero, &env->fp_status);
> +    uint32_t fpsr = 0;
> +    floatx80 val = FP0_to_floatx80(env);
> +
> +    if (floatx80_is_neg(val)) {
> +        fpsr |= FPSR_CC_N;
> +    }
> +
> +    if (floatx80_is_any_nan(val)) {
> +        fpsr |= FPSR_CC_A;
> +    } else if (floatx80_is_infinity(val)) {
> +        fpsr |= FPSR_CC_I;
> +    } else if (floatx80_is_zero(val)) {
> +        fpsr |= FPSR_CC_Z;
> +    }
> +    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | fpsr;
>  }

It would be better to pass in the old FPSR value, returning the new FPSR value, 
so that the helper can be marked TCG_CALL_NO_RWG -- not reading or modifying 
TCG globals.

> +        gen_helper_tst_FP0(cpu_env);

Making this, e.g. gen_helper_tst_FP0(QREG_FPSR, cpu_env).  Which will also 
happen to leave the FPSR in a host register where it can be used if the next 
insn is a fp branch.


r~
