Received: from eggs.gnu.org ([209.51.188.92]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grj32-0001K0-E3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grj31-00058F-N7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:44:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grj31-00056s-Fd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:44:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id v13so11392861wrw.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 04:44:54 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-31-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-31-cota@braap.org>
Date: Thu, 07 Feb 2019 12:44:51 +0000
Message-ID: <87sgwzn4xo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 30/73] cpu-exec: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cpu-exec.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6c4a33262f..e3d72897e8 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -425,14 +425,21 @@ static inline TranslationBlock *tb_find(CPUState *c=
pu,
>      return tb;
>  }
>
> -static inline bool cpu_handle_halt(CPUState *cpu)
> +static inline bool cpu_handle_halt_locked(CPUState *cpu)
>  {
> -    if (cpu->halted) {
> +    g_assert(cpu_mutex_locked(cpu));
> +
> +    if (cpu_halted(cpu)) {
>  #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
>          if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
>              && replay_interrupt()) {
>              X86CPU *x86_cpu =3D X86_CPU(cpu);
> +
> +            /* prevent deadlock; cpu_mutex must be acquired _after_ the =
BQL */
> +            cpu_mutex_unlock(cpu);
>              qemu_mutex_lock_iothread();
> +            cpu_mutex_lock(cpu);
> +

*sigh* this is still fugly code I wish we could abstract out of the
common code path. But I guess x86 wants to be special....

Nevertheless:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>              apic_poll_irq(x86_cpu->apic_state);
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>              qemu_mutex_unlock_iothread();
> @@ -442,12 +449,22 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>              return true;
>          }
>
> -        cpu->halted =3D 0;
> +        cpu_halted_set(cpu, 0);
>      }
>
>      return false;
>  }
>
> +static inline bool cpu_handle_halt(CPUState *cpu)
> +{
> +    bool ret;
> +
> +    cpu_mutex_lock(cpu);
> +    ret =3D cpu_handle_halt_locked(cpu);
> +    cpu_mutex_unlock(cpu);
> +    return ret;
> +}
> +
>  static inline void cpu_handle_debug_exception(CPUState *cpu)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
> @@ -546,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          } else if (interrupt_request & CPU_INTERRUPT_HALT) {
>              replay_interrupt();
>              cpu->interrupt_request &=3D ~CPU_INTERRUPT_HALT;
> -            cpu->halted =3D 1;
> +            cpu_halted_set(cpu, 1);
>              cpu->exception_index =3D EXCP_HLT;
>              qemu_mutex_unlock_iothread();
>              return true;


--
Alex Benn=C3=A9e
