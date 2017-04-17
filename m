Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxaX-000859-8h
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxaU-0003FI-72
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:44:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<1487262963-11519-9-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d200ef8-b4d7-f7e4-c0af-f0f741ff7a0f@amsat.org>
Date: Mon, 17 Apr 2017 00:44:21 -0300
MIME-Version: 1.0
In-Reply-To: <1487262963-11519-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 08/13] armv7m: Simpler and
 faster exception start
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

On 02/16/2017 01:35 PM, Peter Maydell wrote:
> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> All the places in armv7m_cpu_do_interrupt() which pend an
> exception in the NVIC are doing so for synchronous
> exceptions. We know that we will always take some
> exception in this case, so we can just acknowledge it
> immediately, rather than returning and then immediately
> being called again because the NVIC has raised its outbound
> IRQ line.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: tweaked commit message; added DEBUG to the set of
> exceptions we handle immediately, since it is synchronous
> when it results from the BKPT instruction]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 050d8df..1844852 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6109,22 +6109,22 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>      case EXCP_UDEF:
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>          env->v7m.cfsr |= R_V7M_CFSR_UNDEFINSTR_MASK;
> -        return;
> +        break;
>      case EXCP_NOCP:
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>          env->v7m.cfsr |= R_V7M_CFSR_NOCP_MASK;
> -        return;
> +        break;
>      case EXCP_SWI:
>          /* The PC already points to the next instruction.  */
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC);
> -        return;
> +        break;
>      case EXCP_PREFETCH_ABORT:
>      case EXCP_DATA_ABORT:
>          /* TODO: if we implemented the MPU registers, this is where we
>           * should set the MMFAR, etc from exception.fsr and exception.vaddress.
>           */
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
> -        return;
> +        break;
>      case EXCP_BKPT:
>          if (semihosting_enabled()) {
>              int nr;
> @@ -6139,9 +6139,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>              }
>          }
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
> -        return;
> +        break;
>      case EXCP_IRQ:
> -        armv7m_nvic_acknowledge_irq(env->nvic);
>          break;
>      case EXCP_EXCEPTION_EXIT:
>          do_v7m_exception_exit(env);
> @@ -6151,6 +6150,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          return; /* Never happens.  Keep compiler happy.  */
>      }
>
> +    armv7m_nvic_acknowledge_irq(env->nvic);
> +
> +    qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
> +
>      /* Align stack pointer if the guest wants that */
>      if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
>          env->regs[13] -= 4;
>
