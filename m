Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fgxr9-0006bt-5F
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 15:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fgxr4-000553-Ms
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 15:47:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c98b143-8b32-6095-3e6d-8987f8473e5c@amsat.org>
Date: Sat, 21 Jul 2018 16:47:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/4] target/arm: Improve
 exception-taken logging
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

On 07/20/2018 11:56 AM, Peter Maydell wrote:
> Improve the exception-taken logging by logging in
> v7m_exception_taken() the exception we're going to take
> and whether it is secure/nonsecure.
> 
> This requires us to move logging at many callsites from after the
> call to before it, so that the logging appears in a sensible order.
> 
> (This will make tail-chaining produce more useful logs; for the
> current callers of v7m_exception_taken() we know which exception

Thanks for this cleanup.

> we're going to take, so custom log messages at the callsite sufficed;
> for tail-chaining only v7m_exception_taken() knows the exception
> number that we're going to tail-chain to.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6f5bb198c3b..3ec6114599b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6840,6 +6840,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
>      bool push_failed = false;
>  
>      armv7m_nvic_get_pending_irq_info(env->nvic, &exc, &targets_secure);
> +    qemu_log_mask(CPU_LOG_INT, "...taking pending %s exception %d\n",
> +                  targets_secure ? "secure" : "nonsecure", exc);
>  
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
> @@ -6913,12 +6915,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
>           * we might now want to take a different exception which
>           * targets a different security state, so try again from the top.
>           */
> +        qemu_log_mask(CPU_LOG_INT,
> +                      "...derived exception on callee-saves register stacking");
>          v7m_exception_taken(cpu, lr, true, true);
>          return;
>      }
>  
>      if (!arm_v7m_load_vector(cpu, exc, targets_secure, &addr)) {
>          /* Vector load failed: derived exception */
> +        qemu_log_mask(CPU_LOG_INT, "...derived exception on vector table load");
>          v7m_exception_taken(cpu, lr, true, true);
>          return;
>      }
> @@ -7129,9 +7134,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>      if (sfault) {
>          env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
> -        v7m_exception_taken(cpu, excret, true, false);
>          qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
>                        "stackframe: failed EXC_RETURN.ES validity check\n");
> +        v7m_exception_taken(cpu, excret, true, false);
>          return;
>      }
>  
> @@ -7141,9 +7146,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>           */
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
> -        v7m_exception_taken(cpu, excret, true, false);
>          qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
>                        "stackframe: failed exception return integrity check\n");
> +        v7m_exception_taken(cpu, excret, true, false);
>          return;
>      }
>  
> @@ -7198,10 +7203,10 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>                  /* Take a SecureFault on the current stack */
>                  env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
>                  armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
> -                v7m_exception_taken(cpu, excret, true, false);
>                  qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
>                                "stackframe: failed exception return integrity "
>                                "signature check\n");
> +                v7m_exception_taken(cpu, excret, true, false);
>                  return;
>              }
>  
> @@ -7234,6 +7239,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>              /* v7m_stack_read() pended a fault, so take it (as a tail
>               * chained exception on the same stack frame)
>               */
> +            qemu_log_mask(CPU_LOG_INT, "...derived exception on unstacking\n");
>              v7m_exception_taken(cpu, excret, true, false);
>              return;
>          }
> @@ -7270,10 +7276,10 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>                  armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
>                                          env->v7m.secure);
>                  env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
> -                v7m_exception_taken(cpu, excret, true, false);
>                  qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
>                                "stackframe: failed exception return integrity "
>                                "check\n");
> +                v7m_exception_taken(cpu, excret, true, false);
>                  return;
>              }
>          }
> @@ -7309,9 +7315,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, false);
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
>          ignore_stackfaults = v7m_push_stack(cpu);
> -        v7m_exception_taken(cpu, excret, false, ignore_stackfaults);
>          qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
>                        "failed exception return integrity check\n");
> +        v7m_exception_taken(cpu, excret, false, ignore_stackfaults);
>          return;
>      }
>  
> @@ -7727,7 +7733,6 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>  
>      ignore_stackfaults = v7m_push_stack(cpu);
>      v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
> -    qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
>  }
>  
>  /* Function used to synchronize QEMU's AArch64 register set with AArch32
> 
