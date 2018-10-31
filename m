Received: from eggs.gnu.org ([2001:4830:134:3::10]:53451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtde-0003vm-Sr
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtdd-000488-Lb
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:46:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtdd-00047I-Bo
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:46:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id g9-v6so17245835wrq.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:46:36 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-57-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-57-cota@braap.org>
Date: Wed, 31 Oct 2018 16:46:33 +0000
Message-ID: <87y3ae5aja.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 57/71] accel/tcg: convert to
 cpu_interrupt_request
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

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cpu-exec.c      | 15 ++++++++-------
>  accel/tcg/tcg-all.c       | 12 +++++++++---
>  accel/tcg/translate-all.c |  2 +-
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index f37c9b1e94..d590f1f6c0 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -428,7 +428,7 @@ static inline bool cpu_handle_halt_locked(CPUState *c=
pu)
>
>      if (cpu_halted(cpu)) {
>  #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
> -        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
> +        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL)
>              && replay_interrupt()) {
>              X86CPU *x86_cpu =3D X86_CPU(cpu);
>
> @@ -540,16 +540,17 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
>       */
>      atomic_mb_set(&cpu->icount_decr.u16.high, 0);
>
> -    if (unlikely(atomic_read(&cpu->interrupt_request))) {
> +    if (unlikely(cpu_interrupt_request(cpu))) {
>          int interrupt_request;
> +
>          qemu_mutex_lock_iothread();
> -        interrupt_request =3D cpu->interrupt_request;
> +        interrupt_request =3D cpu_interrupt_request(cpu);
>          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
>              /* Mask out external interrupts for this step. */
>              interrupt_request &=3D ~CPU_INTERRUPT_SSTEP_MASK;
>          }
>          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> -            cpu->interrupt_request &=3D ~CPU_INTERRUPT_DEBUG;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>              cpu->exception_index =3D EXCP_DEBUG;
>              qemu_mutex_unlock_iothread();
>              return true;
> @@ -558,7 +559,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              /* Do nothing */
>          } else if (interrupt_request & CPU_INTERRUPT_HALT) {
>              replay_interrupt();
> -            cpu->interrupt_request &=3D ~CPU_INTERRUPT_HALT;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>              cpu_halted_set(cpu, 1);
>              cpu->exception_index =3D EXCP_HLT;
>              qemu_mutex_unlock_iothread();
> @@ -595,10 +596,10 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
>              }
>              /* The target hook may have updated the 'cpu->interrupt_requ=
est';
>               * reload the 'interrupt_request' value */
> -            interrupt_request =3D cpu->interrupt_request;
> +            interrupt_request =3D cpu_interrupt_request(cpu);
>          }
>          if (interrupt_request & CPU_INTERRUPT_EXITTB) {
> -            cpu->interrupt_request &=3D ~CPU_INTERRUPT_EXITTB;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
>              /* ensure that no TB jump will be modified as
>                 the program flow was changed */
>              *last_tb =3D NULL;
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 3d25bdcc17..4e2fe70350 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -39,10 +39,16 @@ unsigned long tcg_tb_size;
>  static void tcg_handle_interrupt(CPUState *cpu, int mask)
>  {
>      int old_mask;
> -    g_assert(qemu_mutex_iothread_locked());
>
> -    old_mask =3D cpu->interrupt_request;
> -    cpu->interrupt_request |=3D mask;
> +    if (!cpu_mutex_locked(cpu)) {
> +        cpu_mutex_lock(cpu);
> +        old_mask =3D cpu_interrupt_request(cpu);
> +        cpu_interrupt_request_or(cpu, mask);
> +        cpu_mutex_unlock(cpu);
> +    } else {
> +        old_mask =3D cpu_interrupt_request(cpu);
> +        cpu_interrupt_request_or(cpu, mask);
> +    }
>
>      /*
>       * If called from iothread context, wake the target cpu in
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 356dcd0948..038d82fdb5 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2340,7 +2340,7 @@ void dump_opcount_info(FILE *f, fprintf_function cp=
u_fprintf)
>  void cpu_interrupt(CPUState *cpu, int mask)
>  {
>      g_assert(qemu_mutex_iothread_locked());
> -    cpu->interrupt_request |=3D mask;
> +    cpu_interrupt_request_or(cpu, mask);
>      atomic_set(&cpu->icount_decr.u16.high, -1);
>  }


--
Alex Benn=C3=A9e
