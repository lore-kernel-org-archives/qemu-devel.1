Received: from eggs.gnu.org ([2001:4830:134:3::10]:43132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkuq-0003Bx-2o
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkuo-0002GR-Rk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:39928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBkuo-0002FZ-FQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id j193-v6so8970262lfg.6
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-26-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-26-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 17:42:15 +0000
Message-ID: <CAKmqyKPKdZccWNZKztGk9vEhm3X4aMdX=GhMtXALzNduArCE4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 25/35] RISC-V: Move non-ops from
 op_helper to cpu_helper
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

On Wed, Apr 25, 2018 at 5:13 PM Michael Clark <mjc@sifive.com> wrote:

> This patch makes op_helper.c contain only instruction
> operation helpers used by translate.c and moves any
> unrelated cpu helpers into cpu_helper.c. No logic is
> changed by this patch.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/Makefile.objs              |  2 +-
>   target/riscv/{helper.c => cpu_helper.c} | 34
++++++++++++++++++++++++++++++++-
>   target/riscv/op_helper.c                | 33
--------------------------------
>   3 files changed, 34 insertions(+), 35 deletions(-)
>   rename target/riscv/{helper.c => cpu_helper.c} (95%)

> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index abd0a7c..fcc5d34 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1 +1 @@
> -obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o
pmp.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o
gdbstub.o pmp.o
> diff --git a/target/riscv/helper.c b/target/riscv/cpu_helper.c
> similarity index 95%
> rename from target/riscv/helper.c
> rename to target/riscv/cpu_helper.c
> index 47d116e..fb3f7ef 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1,5 +1,5 @@
>   /*
> - * RISC-V emulation helpers for qemu.
> + * RISC-V CPU helpers for qemu.
>    *
>    * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
>    * Copyright (c) 2017-2018 SiFive, Inc.
> @@ -72,6 +72,38 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int
interrupt_request)

>   #if !defined(CONFIG_USER_ONLY)

> +/* iothread_mutex must be held */
> +uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t
value)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint32_t old_mip, new_mip;
> +
> +    do {
> +        old_mip = atomic_read(&env->mip);
> +        new_mip = (old_mip & ~mask) | (value & mask);
> +    } while (atomic_cmpxchg(&env->mip, old_mip, new_mip) != old_mip);
> +
> +    if (new_mip && !old_mip) {
> +        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> +    } else if (!new_mip && old_mip) {
> +        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> +    }
> +
> +    return old_mip;
> +}
> +
> +void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
> +{
> +    if (newpriv > PRV_M) {
> +        g_assert_not_reached();
> +    }
> +    if (newpriv == PRV_H) {
> +        newpriv = PRV_U;
> +    }
> +    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
> +    env->priv = newpriv;
> +}
> +
>   /* get_physical_address - get the physical address for this virtual
address
>    *
>    * Do a page table walk to obtain the physical address corresponding to a
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 2a7f045..4b4d62b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -640,38 +640,6 @@ target_ulong helper_csrrc(CPURISCVState *env,
target_ulong src,

>   #ifndef CONFIG_USER_ONLY

> -/* iothread_mutex must be held */
> -uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t
value)
> -{
> -    CPURISCVState *env = &cpu->env;
> -    uint32_t old_mip, new_mip;
> -
> -    do {
> -        old_mip = atomic_read(&env->mip);
> -        new_mip = (old_mip & ~mask) | (value & mask);
> -    } while (atomic_cmpxchg(&env->mip, old_mip, new_mip) != old_mip);
> -
> -    if (new_mip && !old_mip) {
> -        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> -    } else if (!new_mip && old_mip) {
> -        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> -    }
> -
> -    return old_mip;
> -}
> -
> -void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
> -{
> -    if (newpriv > PRV_M) {
> -        g_assert_not_reached();
> -    }
> -    if (newpriv == PRV_H) {
> -        newpriv = PRV_U;
> -    }
> -    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
> -    env->priv = newpriv;
> -}
> -
>   target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>   {
>       if (!(env->priv >= PRV_S)) {
> @@ -722,7 +690,6 @@ target_ulong helper_mret(CPURISCVState *env,
target_ulong cpu_pc_deb)
>       return retpc;
>   }

> -
>   void helper_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = CPU(riscv_env_get_cpu(env));
> --
> 2.7.0
