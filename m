Received: from eggs.gnu.org ([2001:4830:134:3::10]:58009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0O3-0001S0-Ek
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0O0-00069N-Ax
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:16:51 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ce0O0-000693-4A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:16:48 -0500
Received: by mail-wm0-x230.google.com with SMTP id 196so20900070wmm.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:16:48 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-8-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1486065742-28639-8-git-send-email-peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 14:16:45 +0000
Message-ID: <87fujfv8s2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/9] armv7m: Remove unused
 armv7m_nvic_acknowledge_irq() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Having armv7m_nvic_acknowledge_irq() return the new value of
> env->v7m.exception and its one caller assign the return value
> back to env->v7m.exception is pointless. Just make the return
> type void instead.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h      | 2 +-
>  hw/intc/armv7m_nvic.c | 4 +---
>  target/arm/helper.c   | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ac20a56..36cccfc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1344,7 +1344,7 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
>  }
>  #endif
>  void armv7m_nvic_set_pending(void *opaque, int irq);
> -int armv7m_nvic_acknowledge_irq(void *opaque);
> +void armv7m_nvic_acknowledge_irq(void *opaque);
>  void armv7m_nvic_complete_irq(void *opaque, int irq);
>
>  /* Interface for defining coprocessor registers.
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 2eaac3d..7b61fe6 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -394,7 +394,7 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
>  }
>
>  /* Make pending IRQ active.  */
> -int armv7m_nvic_acknowledge_irq(void *opaque)
> +void armv7m_nvic_acknowledge_irq(void *opaque)
>  {
>      NVICState *s = (NVICState *)opaque;
>      CPUARMState *env = &s->cpu->env;
> @@ -421,8 +421,6 @@ int armv7m_nvic_acknowledge_irq(void *opaque)
>      env->v7m.exception = s->vectpending;
>
>      nvic_irq_update(s);
> -
> -    return env->v7m.exception;
>  }
>
>  void armv7m_nvic_complete_irq(void *opaque, int irq)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6c86eac..78bf9ab 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6103,7 +6103,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
>          return;
>      case EXCP_IRQ:
> -        env->v7m.exception = armv7m_nvic_acknowledge_irq(env->nvic);
> +        armv7m_nvic_acknowledge_irq(env->nvic);
>          break;
>      case EXCP_EXCEPTION_EXIT:
>          do_v7m_exception_exit(env);


--
Alex Bennée
