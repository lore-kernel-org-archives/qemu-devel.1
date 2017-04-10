Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxZkv-0005bE-7Z
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxZks-0000K3-5m
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:53:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb111dba-c11a-80f5-e685-a9d6ca2cb8d9@amsat.org>
Date: Mon, 10 Apr 2017 10:53:13 -0300
MIME-Version: 1.0
In-Reply-To: <1491820793-5348-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 7/7] arm: Remove workarounds for
 old M-profile exception return implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 04/10/2017 07:39 AM, Peter Maydell wrote:
> Now that we've rewritten M-profile exception return so that the magic
> PC values are not visible to other parts of QEMU, we can delete the
> special casing of them elsewhere.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.c       | 43 ++-----------------------------------------
>  target/arm/translate.c |  8 --------
>  2 files changed, 2 insertions(+), 49 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 04b062c..b357aee 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -304,33 +304,6 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  }
>
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> -static void arm_v7m_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                      bool is_write, bool is_exec, int opaque,
> -                                      unsigned size)
> -{
> -    ARMCPU *arm = ARM_CPU(cpu);
> -    CPUARMState *env = &arm->env;
> -
> -    /* ARMv7-M interrupt return works by loading a magic value into the PC.
> -     * On real hardware the load causes the return to occur.  The qemu
> -     * implementation performs the jump normally, then does the exception
> -     * return by throwing a special exception when when the CPU tries to
> -     * execute code at the magic address.
> -     */
> -    if (env->v7m.exception != 0 && addr >= 0xfffffff0 && is_exec) {
> -        cpu->exception_index = EXCP_EXCEPTION_EXIT;
> -        cpu_loop_exit(cpu);
> -    }
> -
> -    /* In real hardware an attempt to access parts of the address space
> -     * with nothing there will usually cause an external abort.
> -     * However our QEMU board models are often missing device models where
> -     * the guest can boot anyway with the default read-as-zero/writes-ignored
> -     * behaviour that you get without a QEMU unassigned_access hook.
> -     * So just return here to retain that default behaviour.
> -     */
> -}
> -
>  static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cs);
> @@ -338,17 +311,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      CPUARMState *env = &cpu->env;
>      bool ret = false;
>
> -    /* ARMv7-M interrupt return works by loading a magic value
> -     * into the PC.  On real hardware the load causes the
> -     * return to occur.  The qemu implementation performs the
> -     * jump normally, then does the exception return when the
> -     * CPU tries to execute code at the magic address.
> -     * This will cause the magic PC value to be pushed to
> -     * the stack if an interrupt occurred at the wrong time.
> -     * We avoid this by disabling interrupts when
> -     * pc contains a magic address.
> -     *
> -     * ARMv7-M interrupt masking works differently than -A or -R.
> +    /* ARMv7-M interrupt masking works differently than -A or -R.
>       * There is no FIQ/IRQ distinction. Instead of I and F bits
>       * masking FIQ and IRQ interrupts, an exception is taken only
>       * if it is higher priority than the current execution priority
> @@ -356,8 +319,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       * currently active exception).
>       */
>      if (interrupt_request & CPU_INTERRUPT_HARD
> -        && (armv7m_nvic_can_take_pending_exception(env->nvic))
> -        && (env->regs[15] < 0xfffffff0)) {
> +        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
>          cs->exception_index = EXCP_IRQ;
>          cc->do_interrupt(cs);
>          ret = true;
> @@ -1091,7 +1053,6 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
>      cc->do_interrupt = arm_v7m_cpu_do_interrupt;
>  #endif
>
> -    cc->do_unassigned_access = arm_v7m_unassigned_access;
>      cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
>  }
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 156ab46..c85bc6c 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11914,14 +11914,6 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>              dc->is_jmp = DISAS_EXC;
>              break;
>          }
> -#else
> -        if (arm_dc_feature(dc, ARM_FEATURE_M)) {
> -            /* Branches to the magic exception-return addresses should
> -             * already have been caught via the arm_v7m_unassigned_access hook,
> -             * and never get here.
> -             */
> -            assert(dc->pc < 0xfffffff0);
> -        }
>  #endif
>
>          if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
>
