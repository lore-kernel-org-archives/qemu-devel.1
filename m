Received: from eggs.gnu.org ([2001:4830:134:3::10]:33099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fCBwG-00033C-3h
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fCBwE-0006SW-TW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:34:00 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fCBwE-0006M8-Kn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:33:58 -0400
Received: by mail-lf0-x241.google.com with SMTP id w8-v6so4777078lfe.3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 15:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-24-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-24-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Apr 2018 22:33:31 +0000
Message-ID: <CAKmqyKMXXd+-7KkrU0g-4TQn6RGbxQ4Zjku4d3_KfQE9YcfrQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 23/35] RISC-V: Simplify
 riscv_cpu_local_irqs_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Wed, Apr 25, 2018 at 4:56 PM Michael Clark <mjc@sifive.com> wrote:

> This commit is intended to improve readability.
> There is no change to the logic.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/helper.c | 34 ++++++++++++----------------------
>   1 file changed, 12 insertions(+), 22 deletions(-)

> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 3b57e13..47d116e 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -35,28 +35,18 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool
ifetch)
>   }

>   #ifndef CONFIG_USER_ONLY
> -/*
> - * Return RISC-V IRQ number if an interrupt should be taken, else -1.
> - * Used in cpu-exec.c
> - *
> - * Adapted from Spike's processor_t::take_interrupt()
> - */
> -static int riscv_cpu_hw_interrupts_pending(CPURISCVState *env)
> +static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>   {
> -    target_ulong pending_interrupts = atomic_read(&env->mip) & env->mie;
> -
> -    target_ulong mie = get_field(env->mstatus, MSTATUS_MIE);
> -    target_ulong m_enabled = env->priv < PRV_M || (env->priv == PRV_M &&
mie);
> -    target_ulong enabled_interrupts = pending_interrupts &
> -                                      ~env->mideleg & -m_enabled;
> -
> -    target_ulong sie = get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong s_enabled = env->priv < PRV_S || (env->priv == PRV_S &&
sie);
> -    enabled_interrupts |= pending_interrupts & env->mideleg &
> -                          -s_enabled;
> -
> -    if (enabled_interrupts) {
> -        return ctz64(enabled_interrupts); /* since non-zero */
> +    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> +    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> +    target_ulong pending = atomic_read(&env->mip) & env->mie;
> +    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M &&
mstatus_mie);
> +    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S &&
mstatus_sie);
> +    target_ulong irqs = (pending & ~env->mideleg & -mie) |
> +                        (pending &  env->mideleg & -sie);
> +
> +    if (irqs) {
> +        return ctz64(irqs); /* since non-zero */
>       } else {
>           return EXCP_NONE; /* indicates no pending interrupt */
>       }
> @@ -69,7 +59,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int
interrupt_request)
>       if (interrupt_request & CPU_INTERRUPT_HARD) {
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
> -        int interruptno = riscv_cpu_hw_interrupts_pending(env);
> +        int interruptno = riscv_cpu_local_irq_pending(env);
>           if (interruptno >= 0) {
>               cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
>               riscv_cpu_do_interrupt(cs);
> --
> 2.7.0
