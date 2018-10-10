Received: from eggs.gnu.org ([2001:4830:134:3::10]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhX-0005pY-Vb
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhQ-0007Ek-Vl
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:40588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAKhO-0007DY-8B
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id 1-v6so3030044plv.7
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:13 -0700 (PDT)
Date: Wed, 10 Oct 2018 13:03:11 -0700 (PDT)
In-Reply-To: <c5c4c65332bdfedc34f3b916233f5e3e61225e93.1539023064.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2f532a3a-1ddf-448d-aa5f-88528c542e6f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] RISC-V: Move non-ops from op_helper
 to cpu_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, alistair23@gmail.com, Alistair.Francis@wdc.com

On Mon, 08 Oct 2018 11:25:27 PDT (-0700), Alistair.Francis@wdc.com wrote:
> From: Michael Clark <mjc@sifive.com>
>
> This patch makes op_helper.c contain only instruction
> operation helpers used by translate.c and moves any
> unrelated cpu helpers into cpu_helper.c. No logic is
> changed by this patch.
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/Makefile.objs              |  2 +-
>  target/riscv/{helper.c => cpu_helper.c} | 35 ++++++++++++++++++++++++-
>  target/riscv/op_helper.c                | 34 ------------------------
>  3 files changed, 35 insertions(+), 36 deletions(-)
>  rename target/riscv/{helper.c => cpu_helper.c} (95%)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index abd0a7cde3..fcc5d34c1f 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1 +1 @@
> -obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
> diff --git a/target/riscv/helper.c b/target/riscv/cpu_helper.c
> similarity index 95%
> rename from target/riscv/helper.c
> rename to target/riscv/cpu_helper.c
> index 63b3386b76..86f9f4730c 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1,5 +1,5 @@
>  /*
> - * RISC-V emulation helpers for qemu.
> + * RISC-V CPU helpers for qemu.
>   *
>   * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
>   * Copyright (c) 2017-2018 SiFive, Inc.
> @@ -72,6 +72,39 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  
>  #if !defined(CONFIG_USER_ONLY)
>  
> +/* iothread_mutex must be held */
> +uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint32_t old, new, cmp = atomic_read(&env->mip);
> +
> +    do {
> +        old = cmp;
> +        new = (old & ~mask) | (value & mask);
> +        cmp = atomic_cmpxchg(&env->mip, old, new);
> +    } while (old != cmp);
> +
> +    if (new && !old) {
> +        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> +    } else if (!new && old) {
> +        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> +    }
> +
> +    return old;
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
>  /* get_physical_address - get the physical address for this virtual address
>   *
>   * Do a page table walk to obtain the physical address corresponding to a
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index d0883d329b..495390ab1c 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -654,39 +654,6 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>  
>  #ifndef CONFIG_USER_ONLY
>  
> -/* iothread_mutex must be held */
> -uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
> -{
> -    CPURISCVState *env = &cpu->env;
> -    uint32_t old, new, cmp = atomic_read(&env->mip);
> -
> -    do {
> -        old = cmp;
> -        new = (old & ~mask) | (value & mask);
> -        cmp = atomic_cmpxchg(&env->mip, old, new);
> -    } while (old != cmp);
> -
> -    if (new && !old) {
> -        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> -    } else if (!new && old) {
> -        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> -    }
> -
> -    return old;
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
>  target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  {
>      if (!(env->priv >= PRV_S)) {
> @@ -737,7 +704,6 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      return retpc;
>  }
>  
> -
>  void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
> -- 
> 2.17.1
