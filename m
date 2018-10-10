Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJpZ-0001py-Gv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJpW-0003uk-CH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:07:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAJpR-0003q8-1k
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:07:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so6612210wma.4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:07:22 -0700 (PDT)
References: <cover.1539023064.git.alistair.francis@wdc.com>
	<c5c4c65332bdfedc34f3b916233f5e3e61225e93.1539023064.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3896da13-bf7d-cd05-1840-9adb721653aa@redhat.com>
Date: Wed, 10 Oct 2018 21:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <c5c4c65332bdfedc34f3b916233f5e3e61225e93.1539023064.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 08/10/2018 20:25, Alistair Francis wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/riscv/Makefile.objs              |  2 +-
>  target/riscv/{helper.c => cpu_helper.c} | 35 ++++++++++++++++++++++++-
>  target/riscv/op_helper.c                | 34 ------------------------
>  3 files changed, 35 insertions(+), 36 deletions(-)
>  rename target/riscv/{helper.c => cpu_helper.c} (95%)
> 
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
> 
