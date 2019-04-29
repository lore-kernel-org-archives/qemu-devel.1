Received: from eggs.gnu.org ([209.51.188.92]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7SF-0007VT-SH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7S6-0006CC-PM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7S6-0006BG-3p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id n15so2750237ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-31-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:40:05 +0100
Message-ID: <CAFEAcA_0wTL0K8nJw+LQK4-y6_qJ+Lj7nEL=xuU6vXQPW4YEqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 30/36] cpu: Introduce
 cpu_set_cpustate_pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Consolidate some boilerplate from foo_cpu_initfn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>
>  int cpu_exec(CPUState *cpu);
>
> +/**
> + * cpu_set_cpustate_pointers(cpu)
> + * @cpu: The cpu object
> + *
> + * Set the generic pointers in CPUState into the outer object.
> + */
> +static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
> +{
> +    cpu->parent_obj.env_ptr = &cpu->env;
> +}
> +
>  /**
>   * env_archcpu(env)
>   * @env: The architecture environment
> @@ -392,5 +403,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
>  {
>      return &env_archcpu(env)->parent_obj;
>  }
> -

Stray blank line deletion.

>  #endif /* CPU_ALL_H */

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 698dd9cb82..790670ebeb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -282,17 +282,18 @@ static void s390_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
>      S390CPU *cpu = S390_CPU(obj);
> -    CPUS390XState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
>      s390_cpu_model_register_props(obj);
>  #if !defined(CONFIG_USER_ONLY)
> -    env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> -    env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
> +    cpu->env.tod_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> +    cpu->env.cpu_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>  #endif

I would have left the local variable so that we didn't
need to change these lines, but whatever.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
