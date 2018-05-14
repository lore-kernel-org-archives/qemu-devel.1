Received: from eggs.gnu.org ([2001:4830:134:3::10]:55223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEj2-0005Vk-Mi
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEj1-0005jc-Bx
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:45:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEj1-0005jS-4W
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:45:19 -0400
Received: by mail-oi0-x243.google.com with SMTP id t27-v6so10895344oij.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:45:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-25-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:44:57 +0100
Message-ID: <CAFEAcA-XuyMiKXOC1D=UJ1JSQsnc0h_-Ygb8y5OrHA__EJ-djg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 24/27] fpu/softfloat: Specialize on
 snan_bit_is_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> Only MIPS requires snan_bit_is_one to be variable.  While we are
> specializing softfloat behaviour, allow other targets to eliminate
> this runtime check.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h    | 68 ++++++++++++++++++++++-------------
>  include/fpu/softfloat-types.h |  1 +
>  include/fpu/softfloat.h       |  4 ---
>  target/mips/cpu.h             |  4 +--
>  target/hppa/cpu.c             |  1 -
>  target/mips/translate_init.c  |  4 +--
>  target/ppc/fpu_helper.c       |  1 -
>  target/sh4/cpu.c              |  1 -
>  target/unicore32/cpu.c        |  2 --
>  9 files changed, 48 insertions(+), 38 deletions(-)


> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 69f4dbc4db..e72cc9525d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -125,10 +125,6 @@ static inline void set_default_nan_mode(flag val, float_status *status)
>  {
>      status->default_nan_mode = val;
>  }
> -static inline void set_snan_bit_is_one(flag val, float_status *status)
> -{
> -    status->snan_bit_is_one = val;
> -}
>  static inline int get_float_detect_tininess(float_status *status)
>  {
>      return status->float_detect_tininess;
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index cfe1735e0e..2abce47ea3 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -755,8 +755,8 @@ target_ulong exception_resume_pc (CPUMIPSState *env);
>
>  static inline void restore_snan_bit_mode(CPUMIPSState *env)
>  {
> -    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0,
> -                        &env->active_fpu.fp_status);
> +    env->active_fpu.fp_status.snan_bit_is_one
> +        = (env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0;
>  }
>
>  static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
>
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
> index c7ba6ee5f9..5e40d6a198 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -878,6 +878,6 @@ static void msa_reset(CPUMIPSState *env)
>      /* clear float_status nan mode */
>      set_default_nan_mode(0, &env->active_tc.msa_fp_status);
>
> -    /* set proper signanling bit meaning ("1" means "quiet") */
> -    set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
> +    /* set proper signaling bit meaning ("1" means "quiet") */
> +    env->active_tc.msa_fp_status.snan_bit_is_one = 0;
>  }

Why remove the set_snan_bit_is_one() helper and require mips
to manually look inside the float_status struct?

> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 9ae418a577..d31a933cbb 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -3382,7 +3382,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
>              xt.f128 = xb.f128;
>          } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128)) {
>              float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
> -            set_snan_bit_is_one(0, &env->fp_status);
>              xt.f128 = float128_default_nan(&env->fp_status);
>          }
>      }

This one's weird -- why were we setting the snan_bit_is_one field
in the middle of handling a square root instruction? Is this a
bug where this was intended to be doing something else? David,
do you remember?  (change added in commit a4a68476def684f2f).

thanks
-- PMM
