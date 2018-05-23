Received: from eggs.gnu.org ([2001:4830:134:3::10]:39524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLdbj-0006yL-DW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLdbh-0002tm-RZ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:55:51 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLdbh-0002tP-IL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:55:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id f8-v6so228170wmc.4
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 16:55:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-6-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-6-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 May 2018 16:55:17 -0700
Message-ID: <CAKmqyKO+X4WWP0d=n-dzs7-Mrp+yq10ByHq6A-fQp1cAU4fHxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 05/30] RISC-V: Allow setting and
 clearing multiple irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:14 PM, Michael Clark <mjc@sifive.com> wrote:
> Change the API of riscv_set_local_interrupt to take a
> write mask and value to allow setting and clearing of
> multiple local interrupts atomically in a single call.
> Rename the new function to riscv_cpu_update_mip.
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_clint.c  |  8 ++++----
>  hw/riscv/sifive_plic.c   |  4 ++--
>  target/riscv/cpu.h       | 22 +++++++++++++---------
>  target/riscv/op_helper.c | 24 +++++++++++++++---------
>  4 files changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index 7cc606e06546..0d2fd52487e6 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -47,12 +47,12 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
>      if (cpu->env.timecmp <= rtc_r) {
>          /* if we're setting an MTIMECMP value in the "past",
>             immediately raise the timer interrupt */
> -        riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
> +        riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(1));
>          return;
>      }
>
>      /* otherwise, set up the future timer interrupt */
> -    riscv_set_local_interrupt(cpu, MIP_MTIP, 0);
> +    riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(0));
>      diff = cpu->env.timecmp - rtc_r;
>      /* back to ns (note args switched in muldiv64) */
>      next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> @@ -67,7 +67,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
>  static void sifive_clint_timer_cb(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
> -    riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
> +    riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(1));
>  }
>
>  /* CPU wants to read rtc or timecmp register */
> @@ -132,7 +132,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>          if (!env) {
>              error_report("clint: invalid timecmp hartid: %zu", hartid);
>          } else if ((addr & 0x3) == 0) {
> -            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MSIP, value != 0);
> +            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MSIP, BOOL_TO_MASK(value));
>          } else {
>              error_report("clint: invalid sip write: %08x", (uint32_t)addr);
>          }
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 1af23c76e603..b267ff88902d 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -142,10 +142,10 @@ static void sifive_plic_update(SiFivePLICState *plic)
>          int level = sifive_plic_irqs_pending(plic, addrid);
>          switch (mode) {
>          case PLICMode_M:
> -            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MEIP, level);
> +            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
>              break;
>          case PLICMode_S:
> -            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_SEIP, level);
> +            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
>              break;
>          default:
>              break;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e0608e6d5f08..c5d485769cde 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -126,13 +126,18 @@ struct CPURISCVState {
>
>      target_ulong mhartid;
>      target_ulong mstatus;
> +
>      /*
>       * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> -     * by I/O threads and other vCPUs, so hold the iothread mutex before
> -     * operating on it.  CPU_INTERRUPT_HARD should be in effect iff this is
> -     * non-zero.  Use riscv_cpu_set_local_interrupt.
> +     * by I/O threads. It should be read with atomic_read. It should be updated
> +     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
> +     * mutex must be held because mip must be consistent with the CPU inturrept
> +     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
> +     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
> +     * mip is 32-bits to allow atomic_read on 32-bit hosts.
>       */
> -    uint32_t mip;        /* allow atomic_read for >= 32-bit hosts */
> +    uint32_t mip;
> +
>      target_ulong mie;
>      target_ulong mideleg;
>
> @@ -247,7 +252,6 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                      uintptr_t retaddr);
>  int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
>                                int rw, int mmu_idx);
> -
>  char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>
> @@ -256,6 +260,10 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  #define cpu_list riscv_cpu_list
>  #define cpu_mmu_index riscv_cpu_mmu_index
>
> +#ifndef CONFIG_USER_ONLY
> +uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
> +#define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> +#endif
>  void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
>
>  void riscv_translate_init(void);
> @@ -286,10 +294,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>          target_ulong csrno);
>  target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
>
> -#ifndef CONFIG_USER_ONLY
> -void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value);
> -#endif
> -
>  #include "exec/cpu-all.h"
>
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 3abf52453cfc..5a02795bf931 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -171,10 +171,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>           */
>          qemu_mutex_lock_iothread();
>          RISCVCPU *cpu = riscv_env_get_cpu(env);
> -        riscv_set_local_interrupt(cpu, MIP_SSIP,
> -                                  (val_to_write & MIP_SSIP) != 0);
> -        riscv_set_local_interrupt(cpu, MIP_STIP,
> -                                  (val_to_write & MIP_STIP) != 0);
> +        riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
> +                                  (val_to_write & (MIP_SSIP | MIP_STIP)));
>          /*
>           * csrs, csrc on mip.SEIP is not decomposable into separate read and
>           * write steps, so a different implementation is needed
> @@ -655,16 +653,24 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>  #ifndef CONFIG_USER_ONLY
>
>  /* iothread_mutex must be held */
> -void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value)
> +uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
>  {
> -    target_ulong old_mip = cpu->env.mip;
> -    cpu->env.mip = (old_mip & ~mask) | (value ? mask : 0);
> +    CPURISCVState *env = &cpu->env;
> +    uint32_t old, new, cmp = atomic_read(&env->mip);
>
> -    if (cpu->env.mip && !old_mip) {
> +    do {
> +        old = cmp;
> +        new = (old & ~mask) | (value & mask);
> +        cmp = atomic_cmpxchg(&env->mip, old, new);
> +    } while (old != cmp);
> +
> +    if (new && !old) {
>          cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> -    } else if (!cpu->env.mip && old_mip) {
> +    } else if (!new && old) {
>          cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
>      }
> +
> +    return old;
>  }
>
>  void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
> --
> 2.7.0
>
>
