Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxYr-0007RD-U1
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxYo-0002Pr-Ra
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:42:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<1487262963-11519-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11d3c186-205b-d917-4e4f-884656ee417b@amsat.org>
Date: Mon, 17 Apr 2017 00:42:39 -0300
MIME-Version: 1.0
In-Reply-To: <1487262963-11519-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 07/13] armv7m: Remove unused
 armv7m_nvic_acknowledge_irq() return value
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
> Having armv7m_nvic_acknowledge_irq() return the new value of
> env->v7m.exception and its one caller assign the return value
> back to env->v7m.exception is pointless. Just make the return
> type void instead.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.h      | 2 +-
>  hw/intc/armv7m_nvic.c | 4 +---
>  target/arm/helper.c   | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 53299fa..ab46c0c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1351,7 +1351,7 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
>  }
>  #endif
>  void armv7m_nvic_set_pending(void *opaque, int irq);
> -int armv7m_nvic_acknowledge_irq(void *opaque);
> +void armv7m_nvic_acknowledge_irq(void *opaque);
>  void armv7m_nvic_complete_irq(void *opaque, int irq);
>
>  /* Interface for defining coprocessor registers.
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index d9b9a43..010bf92 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -412,7 +412,7 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
>  }
>
>  /* Make pending IRQ active.  */
> -int armv7m_nvic_acknowledge_irq(void *opaque)
> +void armv7m_nvic_acknowledge_irq(void *opaque)
>  {
>      NVICState *s = (NVICState *)opaque;
>      CPUARMState *env = &s->cpu->env;
> @@ -439,8 +439,6 @@ int armv7m_nvic_acknowledge_irq(void *opaque)
>      env->v7m.exception = s->vectpending;
>
>      nvic_irq_update(s);
> -
> -    return env->v7m.exception;
>  }
>
>  void armv7m_nvic_complete_irq(void *opaque, int irq)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index bac1718..050d8df 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6141,7 +6141,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
>          return;
>      case EXCP_IRQ:
> -        env->v7m.exception = armv7m_nvic_acknowledge_irq(env->nvic);
> +        armv7m_nvic_acknowledge_irq(env->nvic);
>          break;
>      case EXCP_EXCEPTION_EXIT:
>          do_v7m_exception_exit(env);
>
