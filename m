Received: from eggs.gnu.org ([209.51.188.92]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQZm-000478-9G
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQSN-00034v-4N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:57:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQSM-00034Z-UV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:57:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id n15so5413775ota.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-12-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:57:39 +0100
Message-ID: <CAFEAcA8ezBN_=9UCfnvsYDfGCK7w1SL3Rpg0wg=6V5-deMuJUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/26] target/mips: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 3 Apr 2019 at 04:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Note that env->active_tc.PC is removed from the qemu_log as that value
> is garbage.  The PC isn't recovered until cpu_restore_state, called from
> cpu_loop_exit_restore, called from do_raise_exception_err.
>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/internal.h  |   5 +-
>  target/mips/cpu.c       |   5 +-
>  target/mips/helper.c    | 115 +++++++++++++++++++---------------------
>  target/mips/op_helper.c |  15 ------
>  4 files changed, 61 insertions(+), 79 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 8f6fc919d5..5ec9d0bd65 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -203,8 +203,9 @@ void cpu_mips_start_count(CPUMIPSState *env);
>  void cpu_mips_stop_count(CPUMIPSState *env);
>
>  /* helper.c */
> -int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                              int mmu_idx);
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr);
>
>  /* op_helper.c */
>  uint32_t float_class_s(uint32_t arg, float_status *fst);
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index e217fb3e36..ebdb834b97 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -197,9 +197,8 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
>      cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
>      cc->gdb_read_register = mips_cpu_gdb_read_register;
>      cc->gdb_write_register = mips_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault = mips_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill = mips_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->do_unassigned_access = mips_cpu_unassigned_access;
>      cc->do_unaligned_access = mips_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..7fe0ba4754 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -874,85 +874,82 @@ refill:
>  #endif
>  #endif
>
> -int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      MIPSCPU *cpu = MIPS_CPU(cs);
>      CPUMIPSState *env = &cpu->env;
> -#if !defined(CONFIG_USER_ONLY)
> +    int ret = TLBRET_NOMATCH;
> +
> +#ifndef CONFIG_USER_ONLY
>      hwaddr physical;
>      int prot;
> -    int access_type;
> -#endif
> -    int ret = 0;
> +    int mips_access_type = ACCESS_INT;
>
> -#if 0
> -    log_cpu_state(cs, 0);
> -#endif
>      qemu_log_mask(CPU_LOG_MMU,
> -              "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> -              __func__, env->active_tc.PC, address, rw, mmu_idx);
> +                  "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> +                  __func__, address, access_type, mmu_idx);
>
>      /* data access */
> -#if !defined(CONFIG_USER_ONLY)
>      /* XXX: put correct access by using cpu_restore_state() correctly */
> -    access_type = ACCESS_INT;
> -    ret = get_physical_address(env, &physical, &prot,
> -                               address, rw, access_type, mmu_idx);
> -    switch (ret) {
> -    case TLBRET_MATCH:
> +    ret = get_physical_address(env, &physical, &prot, address,
> +                               access_type, mips_access_type, mmu_idx);
> +    if (ret == TLBRET_MATCH) {
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s address=%" VADDR_PRIx " physical " TARGET_FMT_plx
>                        " prot %d\n", __func__, address, physical, prot);
> -        break;
> -    default:
> -        qemu_log_mask(CPU_LOG_MMU,
> -                      "%s address=%" VADDR_PRIx " ret %d\n", __func__, address,
> -                      ret);
> -        break;
> -    }
> -    if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>                       mmu_idx, TARGET_PAGE_SIZE);
> -        ret = 0;
> -    } else if (ret < 0)
> -#endif
> -    {
> -#if !defined(CONFIG_USER_ONLY)
> -#if !defined(TARGET_MIPS64)
> -        if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> -            /*
> -             * Memory reads during hardware page table walking are performed
> -             * as if they were kernel-mode load instructions.
> -             */
> -            int mode = (env->hflags & MIPS_HFLAG_KSU);
> -            bool ret_walker;
> -            env->hflags &= ~MIPS_HFLAG_KSU;
> -            ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
> -            env->hflags |= mode;
> -            if (ret_walker) {
> -                ret = get_physical_address(env, &physical, &prot,
> -                                           address, rw, access_type, mmu_idx);
> -                if (ret == TLBRET_MATCH) {
> -                    tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                            mmu_idx, TARGET_PAGE_SIZE);
> -                    ret = 0;
> -                    return ret;
> -                }
> -            }
> -        }
> -#endif
> -#endif
> -        raise_mmu_exception(env, address, rw, ret);
> -        ret = 1;
> +        return true;
>      }
>
> -    return ret;
> +    qemu_log_mask(CPU_LOG_MMU, "%s address=%" VADDR_PRIx " ret %d\n",
> +                  __func__, address, ret);

I think this patch is right, but it was too awkward to
review because it's got a bunch of other changes mixed
up with the refactoring. For instance the old code
has a fairly straightforward "switch (ret) { ... }"
where it does a qemu_log_mask() either for the
TLBRET_MATCH case or for the failure case, whereas I
think this code now prints the failure case logging
of 'ret' in both cases. If you want to change the logging
can you do that as a separate patch so that the refactor
patch is a no-behaviour-change one ?

thanks
-- PMM
