Received: from eggs.gnu.org ([2001:4830:134:3::10]:38891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbiv-0007Sy-0g
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbiu-0004ay-11
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:27:41 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbit-0004ag-R9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:27:39 -0400
Date: Sat, 8 Jul 2017 00:27:37 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707222737.dqiwevnw6sxebzxo@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-27-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-27-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 26/27] target/sh4: Implement fsrra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:21, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/helper.h    |  1 +
>  target/sh4/op_helper.c | 16 ++++++++++++++++
>  target/sh4/translate.c |  2 ++
>  3 files changed, 19 insertions(+)
>
> diff --git a/target/sh4/helper.h b/target/sh4/helper.h
> index 6c6fa04..ea92dc0 100644
> --- a/target/sh4/helper.h
> +++ b/target/sh4/helper.h
> @@ -37,6 +37,7 @@ DEF_HELPER_FLAGS_3(fsub_FT, TCG_CALL_NO_WG, f32, env, f32, f32)
>  DEF_HELPER_FLAGS_3(fsub_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
>  DEF_HELPER_FLAGS_2(fsqrt_FT, TCG_CALL_NO_WG, f32, env, f32)
>  DEF_HELPER_FLAGS_2(fsqrt_DT, TCG_CALL_NO_WG, f64, env, f64)
> +DEF_HELPER_FLAGS_2(fsrra_FT, TCG_CALL_NO_WG, i32, env, i32)

That should be f32 instead of i32

>  DEF_HELPER_FLAGS_2(ftrc_FT, TCG_CALL_NO_WG, i32, env, f32)
>  DEF_HELPER_FLAGS_2(ftrc_DT, TCG_CALL_NO_WG, i32, env, f64)
>  DEF_HELPER_3(fipr, void, env, i32, i32)
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 8513f38..d798f23 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -406,6 +406,22 @@ float64 helper_fsqrt_DT(CPUSH4State *env, float64 t0)
>      return t0;
>  }
>  
> +float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
> +{
> +    set_float_exception_flags(0, &env->fp_status);
> +    /* "Approximate" 1/sqrt(x) via actual computation.  */
> +    t0 = float32_sqrt(t0, &env->fp_status);
> +    t0 = float32_div(float32_one, t0, &env->fp_status);
> +    /* Since this is supposed to be an approximation, an imprecision
> +       exception is required.  One supposes this also follows the usual
> +       IEEE rule that other exceptions take precidence.  */
> +    if (get_float_exception_flags(&env->fp_status) == 0) {
> +        set_float_exception_flags(float_flag_inexact, &env->fp_status);
> +    }
> +    update_fpscr(env, GETPC());
> +    return t0;
> +}
> +
>  float32 helper_fsub_FT(CPUSH4State *env, float32 t0, float32 t1)
>  {
>      set_float_exception_flags(0, &env->fp_status);
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 2b62e39..5fae872 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1753,6 +1753,8 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf07d: /* fsrra FRn */
>  	CHECK_FPU_ENABLED
> +        CHECK_FPSCR_PR_0
> +        gen_helper_fsrra_FT(FREG(B11_8), cpu_env, FREG(B11_8));
>  	break;
>      case 0xf08d: /* fldi0 FRn - FPSCR: R[PR] */
>  	CHECK_FPU_ENABLED

Otherwise it looks fine.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
