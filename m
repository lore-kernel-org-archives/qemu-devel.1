Received: from eggs.gnu.org ([2001:4830:134:3::10]:40900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvHf-0005K0-8r
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvHe-0002jJ-5C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:09:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180320134114.30418-1-peter.maydell@linaro.org>
	<20180320134114.30418-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <899fd41e-46cf-44e8-2df5-24d9e705e264@amsat.org>
Date: Wed, 21 Mar 2018 23:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180320134114.30418-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 2/4] target/arm: Factor
 out code to calculate FSR for debug exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Hi Peter,

This patch might be split in 2.

On 03/20/2018 02:41 PM, Peter Maydell wrote:
> When a debug exception is taken to AArch32, it appears as a Prefetch
> Abort, and the Instruction Fault Status Register (IFSR) must be set.
> The IFSR has two possible formats, depending on whether LPAE is in

^ intro

> use. Factor out the code in arm_debug_excp_handler() which picks
> an FSR value into its own utility function, update it to use
> arm_fi_to_lfsc() and arm_fi_to_sfsc() rather than hard-coded constants,

^ part 1 (refactor):
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> and use the correct condition to select long or short format.

^ part 2 (fix) looks correct:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> In particular this fixes a bug where we could select the short
> format because we're at EL0 and the EL1 translation regime is
> not using LPAE, but then route the debug exception to EL2 because
> of MDCR_EL2.TDE and hand EL2 the wrong format FSR.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 25 +++++++++++++++++++++++++
>  target/arm/op_helper.c | 12 ++----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 47cc224a46..8ce944b7a0 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -763,4 +763,29 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>      }
>  }
>  
> +/* Return the FSR value for a debug exception (watchpoint, hardware
> + * breakpoint or BKPT insn) targeting the specified exception level.
> + */
> +static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
> +{
> +    ARMMMUFaultInfo fi = { .type = ARMFault_Debug };
> +    int target_el = arm_debug_target_el(env);
> +    bool using_lpae = false;
> +
> +    if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
> +        using_lpae = true;
> +    } else {
> +        if (arm_feature(env, ARM_FEATURE_LPAE) &&
> +            (env->cp15.tcr_el[target_el].raw_tcr & TTBCR_EAE)) {
> +            using_lpae = true;
> +        }
> +    }

This looks pretty similar to regime_using_lpae_format() but for
ARMFault_Debug.

> +
> +    if (using_lpae) {
> +        return arm_fi_to_lfsc(&fi);
> +    } else {
> +        return arm_fi_to_sfsc(&fi);
> +    }
> +}
> +
>  #endif
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 4b123d2bd6..75efff9edf 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -1330,11 +1330,7 @@ void arm_debug_excp_handler(CPUState *cs)
>  
>              cs->watchpoint_hit = NULL;
>  
> -            if (extended_addresses_enabled(env)) {
> -                env->exception.fsr = (1 << 9) | 0x22;
> -            } else {
> -                env->exception.fsr = 0x2;
> -            }
> +            env->exception.fsr = arm_debug_exception_fsr(env);
>              env->exception.vaddress = wp_hit->hitaddr;
>              raise_exception(env, EXCP_DATA_ABORT,
>                      syn_watchpoint(same_el, 0, wnr),
> @@ -1354,11 +1350,7 @@ void arm_debug_excp_handler(CPUState *cs)
>              return;
>          }
>  
> -        if (extended_addresses_enabled(env)) {
> -            env->exception.fsr = (1 << 9) | 0x22;
> -        } else {
> -            env->exception.fsr = 0x2;
> -        }
> +        env->exception.fsr = arm_debug_exception_fsr(env);
>          /* FAR is UNKNOWN, so doesn't need setting */
>          raise_exception(env, EXCP_PREFETCH_ABORT,
>                          syn_breakpoint(same_el),
> 
