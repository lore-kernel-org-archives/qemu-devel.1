Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMbS-0007YJ-QE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMbN-0008Ln-PY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:45:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-7-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a6b2c6cf-4cd0-cc99-daef-ab85f6a4b1a7@amsat.org>
Date: Tue, 5 Sep 2017 19:45:46 -0300
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/20] target/arm: Make BASEPRI
 register banked for v8M
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

On 08/22/2017 12:08 PM, Peter Maydell wrote:
> Make the BASEPRI register banked if v8M security extensions are enabled.
> 
> Note that we do not yet implement the functionality of the new
> AIRCR.PRIS bit (which allows the effect of the NS copy of BASEPRI to
> be restricted).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h      | 14 +++++++++++++-
>   hw/intc/armv7m_nvic.c |  4 ++--
>   target/arm/helper.c   | 10 ++++++----
>   target/arm/machine.c  |  3 ++-
>   4 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 436ca0d..0c28dfd 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -72,6 +72,18 @@
>   #define ARMV7M_EXCP_PENDSV  14
>   #define ARMV7M_EXCP_SYSTICK 15
>   
> +/* For M profile, some registers are banked secure vs non-secure;
> + * these are represented as a 2-element array where the first element
> + * is the non-secure copy and the second is the secure copy.
> + * When the CPU does not have implement the security extension then
> + * only the first element is used.
> + * This means that the copy for the current security state can be
> + * accessed via env->registerfield[env->v7m.secure] (whether the security
> + * extension is implemented or not).
> + */
> +#define M_REG_NS 0
> +#define M_REG_S 1

enum {
     M_REG_NS = 0,
     M_REG_S = 1,
     M_BANKED_SECURE_REG_COUNT = 2;
};

or directly this?

#define M_BANKED_SECURE_REG_COUNT 2

shorter nicer...

#define M_BANKED_SECURE_REGS 2

> +
>   /* ARM-specific interrupt pending bits.  */
>   #define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
>   #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
> @@ -409,7 +421,7 @@ typedef struct CPUARMState {
>       struct {
>           uint32_t other_sp;
>           uint32_t vecbase;
> -        uint32_t basepri;
> +        uint32_t basepri[2];

             uint32_t basepri[M_BANKED_SECURE_REGS];

(and following patches of this series...)

>           uint32_t control;
>           uint32_t ccr; /* Configuration and Control */
>           uint32_t cfsr; /* Configurable Fault Status */
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index c0dbbad..2a41e5d 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -171,8 +171,8 @@ static inline int nvic_exec_prio(NVICState *s)
>           running = -1;
>       } else if (env->v7m.primask) {
>           running = 0;
> -    } else if (env->v7m.basepri > 0) {
> -        running = env->v7m.basepri & nvic_gprio_mask(s);
> +    } else if (env->v7m.basepri[env->v7m.secure] > 0) {
> +        running = env->v7m.basepri[env->v7m.secure] & nvic_gprio_mask(s);
>       } else {
>           running = NVIC_NOEXC_PRIO; /* lower than any possible priority */
>       }
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1debebc..1087f19 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8838,7 +8838,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>           return env->v7m.primask;
>       case 17: /* BASEPRI */
>       case 18: /* BASEPRI_MAX */
> -        return env->v7m.basepri;
> +        return env->v7m.basepri[env->v7m.secure];
>       case 19: /* FAULTMASK */
>           return env->v7m.faultmask;
>       default:
> @@ -8898,12 +8898,14 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>           env->v7m.primask = val & 1;
>           break;
>       case 17: /* BASEPRI */
> -        env->v7m.basepri = val & 0xff;
> +        env->v7m.basepri[env->v7m.secure] = val & 0xff;
>           break;
>       case 18: /* BASEPRI_MAX */
>           val &= 0xff;
> -        if (val != 0 && (val < env->v7m.basepri || env->v7m.basepri == 0))
> -            env->v7m.basepri = val;
> +        if (val != 0 && (val < env->v7m.basepri[env->v7m.secure]
> +                         || env->v7m.basepri[env->v7m.secure] == 0)) {
> +            env->v7m.basepri[env->v7m.secure] = val;
> +        }
>           break;
>       case 19: /* FAULTMASK */
>           env->v7m.faultmask = val & 1;
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 745adae..8476efd 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -115,7 +115,7 @@ static const VMStateDescription vmstate_m = {
>       .needed = m_needed,
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
> -        VMSTATE_UINT32(env.v7m.basepri, ARMCPU),
> +        VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
>           VMSTATE_UINT32(env.v7m.control, ARMCPU),
>           VMSTATE_UINT32(env.v7m.ccr, ARMCPU),
>           VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
> @@ -250,6 +250,7 @@ static const VMStateDescription vmstate_m_security = {
>       .needed = m_security_needed,
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32(env.v7m.secure, ARMCPU),
> +        VMSTATE_UINT32(env.v7m.basepri[M_REG_S], ARMCPU),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> 
