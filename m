Received: from eggs.gnu.org ([209.51.188.92]:35306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Cj-0007SC-Sq
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Ci-0005Y1-Kk
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:20:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs4Ci-0005XG-DE
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:20:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id v16so3109761wrn.11
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:20:19 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-42-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-42-cota@braap.org>
Date: Fri, 08 Feb 2019 11:20:17 +0000
Message-ID: <87bm3mmsr2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 41/73] i386/hax-all: convert to
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

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/hax-all.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 518c6ff103..18da1808c6 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -284,7 +284,7 @@ int hax_vm_destroy(struct hax_vm *vm)
>
>  static void hax_handle_interrupt(CPUState *cpu, int mask)
>  {
> -    cpu->interrupt_request |=3D mask;
> +    cpu_interrupt_request_or(cpu, mask);
>
>      if (!qemu_cpu_is_self(cpu)) {
>          qemu_cpu_kick(cpu);
> @@ -418,7 +418,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
>       * Unlike KVM, HAX kernel check for the eflags, instead of qemu
>       */
>      if (ht->ready_for_interrupt_injection &&
> -        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
> +        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
>          int irq;
>
>          irq =3D cpu_get_pic_interrupt(env);
> @@ -432,7 +432,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
>       * interrupt, request an interrupt window exit.  This will
>       * cause a return to userspace as soon as the guest is ready to
>       * receive interrupts. */
> -    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
> +    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
>          ht->request_interrupt_window =3D 1;
>      } else {
>          ht->request_interrupt_window =3D 0;
> @@ -473,19 +473,19 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>
>      cpu_halted_set(cpu, 0);
>
> -    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
> +    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
>          cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          apic_poll_irq(x86_cpu->apic_state);
>      }
>
> -    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
> +    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) {
>          DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
>                  cpu->cpu_index);
>          do_cpu_init(x86_cpu);
>          hax_vcpu_sync_state(env, 1);
>      }
>
> -    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
> +    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SIPI) {
>          DPRINTF("hax_vcpu_hax_exec: handling SIPI for %d\n",
>                  cpu->cpu_index);
>          hax_vcpu_sync_state(env, 0);
> @@ -544,13 +544,17 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>              ret =3D -1;
>              break;
>          case HAX_EXIT_HLT:
> -            if (!(cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> -                !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
> -                /* hlt instruction with interrupt disabled is shutdown */
> -                env->eflags |=3D IF_MASK;
> -                cpu_halted_set(cpu, 1);
> -                cpu->exception_index =3D EXCP_HLT;
> -                ret =3D 1;
> +            {
> +                uint32_t interrupt_request =3D cpu_interrupt_request(cpu=
);
> +
> +                if (!(interrupt_request & CPU_INTERRUPT_HARD) &&
> +                    !(interrupt_request & CPU_INTERRUPT_NMI)) {
> +                    /* hlt instruction with interrupt disabled is shutdo=
wn */
> +                    env->eflags |=3D IF_MASK;
> +                    cpu_halted_set(cpu, 1);
> +                    cpu->exception_index =3D EXCP_HLT;
> +                    ret =3D 1;
> +                }
>              }
>              break;
>          /* these situations will continue to hax module */


--
Alex Benn=C3=A9e
