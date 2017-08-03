Received: from eggs.gnu.org ([2001:4830:134:3::10]:53716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddICR-0007TZ-La
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddICQ-0007GO-3Y
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:38:11 -0400
Date: Thu, 3 Aug 2017 17:38:00 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170803153800.GR4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/15] target/arm: Don't store M
 profile PRIMASK and FAULTMASK in daif
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Wed, Aug 02, 2017 at 05:43:55PM +0100, Peter Maydell wrote:
> We currently store the M profile CPU register state PRIMASK and
> FAULTMASK in the daif field of the CPU state in its I and F
> bits. This is a legacy from the original implementation, which
> tried to share the cpu_exec_interrupt code between A profile
> and M profile. We've since separated out the two cases because
> they are significantly different, so now there is no common
> code between M and A profile which looks at env->daif: all the
> uses are either in A-only or M-only code paths. Sharing the state
> fields now is just confusing, and will make things awkward
> when we implement v8M, where the PRIMASK and FAULTMASK
> registers are banked between security states.
> 
> Switch M profile over to using v7m.faultmask and v7m.primask
> fields for these registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c |  4 ++--
>  target/arm/cpu.c      |  5 -----
>  target/arm/cpu.h      |  4 +++-
>  target/arm/helper.c   | 18 +++++-------------
>  target/arm/machine.c  | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 2e8166a..343bc16 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -167,9 +167,9 @@ static inline int nvic_exec_prio(NVICState *s)
>      CPUARMState *env = &s->cpu->env;
>      int running;
>  
> -    if (env->daif & PSTATE_F) { /* FAULTMASK */
> +    if (env->v7m.faultmask) {
>          running = -1;
> -    } else if (env->daif & PSTATE_I) { /* PRIMASK */
> +    } else if (env->v7m.primask) {
>          running = 0;
>      } else if (env->v7m.basepri > 0) {
>          running = env->v7m.basepri & nvic_gprio_mask(s);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 05c038b..b241a63 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -185,11 +185,6 @@ static void arm_cpu_reset(CPUState *s)
>          uint32_t initial_pc; /* Loaded from 0x4 */
>          uint8_t *rom;
>  
> -        /* For M profile we store FAULTMASK and PRIMASK in the
> -         * PSTATE F and I bits; these are both clear at reset.
> -         */
> -        env->daif &= ~(PSTATE_I | PSTATE_F);
> -
>          /* The reset value of this bit is IMPDEF, but ARM recommends
>           * that it resets to 1, so QEMU always does that rather than making
>           * it dependent on CPU model.
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1f06de0..da90b7a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -418,6 +418,8 @@ typedef struct CPUARMState {
>          uint32_t bfar; /* BusFault Address */
>          unsigned mpu_ctrl; /* MPU_CTRL */
>          int exception;
> +        uint32_t primask;
> +        uint32_t faultmask;

It seems like these could be booleans?

Cheers,
Edgar


>      } v7m;
>  
>      /* Information associated with an exception about to be taken:
> @@ -2179,7 +2181,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
>           * we're in a HardFault or NMI handler.
>           */
>          if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
> -            || env->daif & PSTATE_F) {
> +            || env->v7m.faultmask) {
>              return arm_to_core_mmu_idx(ARMMMUIdx_MNegPri);
>          }
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f087d42..b64ddb1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6172,7 +6172,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>  
>      if (env->v7m.exception != ARMV7M_EXCP_NMI) {
>          /* Auto-clear FAULTMASK on return from other than NMI */
> -        env->daif &= ~PSTATE_F;
> +        env->v7m.faultmask = 0;
>      }
>  
>      switch (armv7m_nvic_complete_irq(env->nvic, env->v7m.exception)) {
> @@ -8718,12 +8718,12 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>          return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
>              env->regs[13] : env->v7m.other_sp;
>      case 16: /* PRIMASK */
> -        return (env->daif & PSTATE_I) != 0;
> +        return env->v7m.primask;
>      case 17: /* BASEPRI */
>      case 18: /* BASEPRI_MAX */
>          return env->v7m.basepri;
>      case 19: /* FAULTMASK */
> -        return (env->daif & PSTATE_F) != 0;
> +        return env->v7m.faultmask;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
>                                         " register %d\n", reg);
> @@ -8778,11 +8778,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>          }
>          break;
>      case 16: /* PRIMASK */
> -        if (val & 1) {
> -            env->daif |= PSTATE_I;
> -        } else {
> -            env->daif &= ~PSTATE_I;
> -        }
> +        env->v7m.primask = val & 1;
>          break;
>      case 17: /* BASEPRI */
>          env->v7m.basepri = val & 0xff;
> @@ -8793,11 +8789,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>              env->v7m.basepri = val;
>          break;
>      case 19: /* FAULTMASK */
> -        if (val & 1) {
> -            env->daif |= PSTATE_F;
> -        } else {
> -            env->daif &= ~PSTATE_F;
> -        }
> +        env->v7m.faultmask = val & 1;
>          break;
>      case 20: /* CONTROL */
>          /* Writing to the SPSEL bit only has an effect if we are in
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 1f66da4..2fb4b76 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -97,6 +97,17 @@ static bool m_needed(void *opaque)
>      return arm_feature(env, ARM_FEATURE_M);
>  }
>  
> +static const VMStateDescription vmstate_m_faultmask_primask = {
> +    .name = "cpu/m/faultmask-primask",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(env.v7m.faultmask, ARMCPU),
> +        VMSTATE_UINT32(env.v7m.primask, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_m = {
>      .name = "cpu/m",
>      .version_id = 4,
> @@ -115,6 +126,10 @@ static const VMStateDescription vmstate_m = {
>          VMSTATE_UINT32(env.v7m.mpu_ctrl, ARMCPU),
>          VMSTATE_INT32(env.v7m.exception, ARMCPU),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription*[]) {
> +        &vmstate_m_faultmask_primask,
> +        NULL
>      }
>  };
>  
> @@ -201,6 +216,24 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
>      CPUARMState *env = &cpu->env;
>      uint32_t val = qemu_get_be32(f);
>  
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        /* If the I or F bits are set then this is a migration from
> +         * an old QEMU which still stored the M profile FAULTMASK
> +         * and PRIMASK in env->daif. Set v7m.faultmask and v7m.primask
> +         * accordingly, and then clear the bits so they don't confuse
> +         * cpsr_write(). For a new QEMU, the bits here will always be
> +         * clear, and the data is transferred using the
> +         * vmstate_m_faultmask_primask subsection.
> +         */
> +        if (val & CPSR_F) {
> +            env->v7m.faultmask = 1;
> +        }
> +        if (val & CPSR_I) {
> +            env->v7m.primask = 1;
> +        }
> +        val &= ~(CPSR_F | CPSR_I);
> +    }
> +
>      env->aarch64 = ((val & PSTATE_nRW) == 0);
>  
>      if (is_a64(env)) {
> -- 
> 2.7.4
> 
> 
