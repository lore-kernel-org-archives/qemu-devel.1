Received: from eggs.gnu.org ([2001:4830:134:3::10]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czy9B-0001Jo-Ji
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czy98-0006Hl-Ba
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:20:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
	<1491844419-12485-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3dd852ae-3ff9-0b53-11f1-ea4e2a3ed59c@amsat.org>
Date: Mon, 17 Apr 2017 01:20:06 -0300
MIME-Version: 1.0
In-Reply-To: <1491844419-12485-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] arm: Track M profile handler mode
 state in TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 04/10/2017 02:13 PM, Peter Maydell wrote:
> For M profile exception-return handling we'd like to generate different
> code for some instructions depending on whether we are in Handler
> mode or Thread mode. This isn't the same as "are we privileged
> or user", so we need an extra bit in the TB flags to distinguish.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 9 +++++++++
>  target/arm/translate.h | 1 +
>  target/arm/translate.c | 1 +
>  3 files changed, 11 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e6f05e2..7d26357 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2291,6 +2291,9 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>  #define ARM_TBFLAG_NS_MASK          (1 << ARM_TBFLAG_NS_SHIFT)
>  #define ARM_TBFLAG_BE_DATA_SHIFT    20
>  #define ARM_TBFLAG_BE_DATA_MASK     (1 << ARM_TBFLAG_BE_DATA_SHIFT)
> +/* For M profile only, Handler (ie not Thread) mode */
> +#define ARM_TBFLAG_HANDLER_SHIFT    21
> +#define ARM_TBFLAG_HANDLER_MASK     (1 << ARM_TBFLAG_HANDLER_SHIFT)
>
>  /* Bit usage when in AArch64 state */
>  #define ARM_TBFLAG_TBI0_SHIFT 0        /* TBI0 for EL0/1 or TBI for EL2/3 */
> @@ -2327,6 +2330,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>      (((F) & ARM_TBFLAG_NS_MASK) >> ARM_TBFLAG_NS_SHIFT)
>  #define ARM_TBFLAG_BE_DATA(F) \
>      (((F) & ARM_TBFLAG_BE_DATA_MASK) >> ARM_TBFLAG_BE_DATA_SHIFT)
> +#define ARM_TBFLAG_HANDLER(F) \
> +    (((F) & ARM_TBFLAG_HANDLER_MASK) >> ARM_TBFLAG_HANDLER_SHIFT)
>  #define ARM_TBFLAG_TBI0(F) \
>      (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
>  #define ARM_TBFLAG_TBI1(F) \
> @@ -2517,6 +2522,10 @@ static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>      }
>      *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
>
> +    if (env->v7m.exception != 0) {
> +        *flags |= ARM_TBFLAG_HANDLER_MASK;
> +    }
> +
>      *cs_base = 0;
>  }
>
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index abb0760..f955174 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -31,6 +31,7 @@ typedef struct DisasContext {
>      bool vfp_enabled; /* FP enabled via FPSCR.EN */
>      int vec_len;
>      int vec_stride;
> +    bool handler; /* v7M Handler mode */

What about a more descriptive name like 'is_v7m_handler_mode' or 
'v7m_mode_handler'? It makes your next patch easier to understand:

     if (s->handler && arm_dc_feature(s, ARM_FEATURE_M)) {

>      /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
>       * so that top level loop can generate correct syndrome information.
>       */
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index f28c4ca..f980cda 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11780,6 +11780,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>      dc->vec_len = ARM_TBFLAG_VECLEN(tb->flags);
>      dc->vec_stride = ARM_TBFLAG_VECSTRIDE(tb->flags);
>      dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(tb->flags);
> +    dc->handler = ARM_TBFLAG_HANDLER(tb->flags);
>      dc->cp_regs = cpu->cp_regs;
>      dc->features = env->features;
>
>
