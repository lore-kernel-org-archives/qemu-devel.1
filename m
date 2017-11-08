Received: from eggs.gnu.org ([2001:4830:134:3::10]:37193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eCSVl-0004ri-Qr
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eCSVk-0007kY-6h
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:43:29 -0500
References: <20171108153245.20740-1-alex.bennee@linaro.org>
	<20171108153245.20740-3-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5e2690f9-b90e-d3ca-dee4-67c7bbc1fe4b@vivier.eu>
Date: Wed, 8 Nov 2017 16:42:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171108153245.20740-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/*helper: don't check retaddr
 before calling cpu_restore_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:S390" <qemu-s390x@nongnu.org>

Le 08/11/2017 à 16:32, Alex Bennée a écrit :
> cpu_restore_state officially supports being passed an address it can't
> resolve the state for. As a result the checks in the helpers are
> superfluous and can be removed. This makes the code consistent with
> other users of cpu_restore_state.
> 
> Of course this does nothing to address what to do if cpu_restore_state
> can't resolve the state but so far it seems this is handled elsewhere.
> 
> The change was made with included coccinelle script.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/coccinelle/cpu_restore_state.cocci | 12 ++++++++++++
>  target/alpha/mem_helper.c                  | 12 +++---------
>  target/arm/op_helper.c                     | 17 ++++-------------
>  target/i386/svm_helper.c                   |  4 +---
>  target/lm32/op_helper.c                    |  7 ++-----
>  target/m68k/op_helper.c                    |  7 ++-----
>  target/microblaze/op_helper.c              |  7 ++-----
>  target/moxie/helper.c                      |  4 +---
>  target/nios2/mmu.c                         |  7 ++-----
>  target/openrisc/mmu_helper.c               |  7 ++-----
>  target/s390x/excp_helper.c                 |  4 +---
>  target/tricore/op_helper.c                 | 11 +++--------
>  target/unicore32/op_helper.c               |  7 ++-----
>  13 files changed, 37 insertions(+), 69 deletions(-)
>  create mode 100644 scripts/coccinelle/cpu_restore_state.cocci
> 
> diff --git a/scripts/coccinelle/cpu_restore_state.cocci b/scripts/coccinelle/cpu_restore_state.cocci
> new file mode 100644
> index 0000000000..934a042382
> --- /dev/null
> +++ b/scripts/coccinelle/cpu_restore_state.cocci
> @@ -0,0 +1,12 @@
> +// Remove unneeded tests before calling cpu_restore_state
> +//
> +// spatch --macro-file scripts/cocci-macro-file.h \
> +//        --sp-file ./scripts/coccinelle/cpu_restore_state.cocci \
> +//        --keep-comments --in-place --use-gitgrep --dir target
> +@@
> +identifier A;
> +expression C;
> +@@
> +-if (A) {
> +     cpu_restore_state(C, A);
> +-}
> diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
> index 3c06baa93a..6cf9bba17e 100644
> --- a/target/alpha/mem_helper.c
> +++ b/target/alpha/mem_helper.c
> @@ -34,9 +34,7 @@ void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      uint64_t pc;
>      uint32_t insn;
>  
> -    if (retaddr) {
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>  
>      pc = env->pc;
>      insn = cpu_ldl_code(env, pc);
> @@ -58,9 +56,7 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>      AlphaCPU *cpu = ALPHA_CPU(cs);
>      CPUAlphaState *env = &cpu->env;
>  
> -    if (retaddr) {
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>  
>      env->trap_arg0 = addr;
>      env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
> @@ -80,9 +76,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>  
>      ret = alpha_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>      if (unlikely(ret != 0)) {
> -        if (retaddr) {
> -            cpu_restore_state(cs, retaddr);
> -        }
> +        cpu_restore_state(cs, retaddr);
>          /* Exception index and error code are already set */
>          cpu_loop_exit(cs);
>      }
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index a40a84ac24..504556a697 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -175,11 +175,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      if (unlikely(ret)) {
>          ARMCPU *cpu = ARM_CPU(cs);
>          uint32_t fsc;
> -
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +        /* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>  
>          if (fsr & (1 << 9)) {
>              /* LPAE format fault status register : bottom 6 bits are
> @@ -210,11 +207,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>      uint32_t fsr, fsc;
>      ARMMMUFaultInfo fi = {};
>      ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
> -
> -    if (retaddr) {
>          /* now we have a real cpu fault */
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>  
>      /* the DFSR for an alignment fault depends on whether we're using
>       * the LPAE long descriptor format, or the short descriptor format
> @@ -244,11 +238,8 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>      uint32_t fsr, fsc;
>      ARMMMUFaultInfo fi = {};
>      ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
> -
> -    if (retaddr) {
>          /* now we have a real cpu fault */
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>  
>      /* The EA bit in syndromes and fault status registers is an
>       * IMPDEF classification of external aborts. ARM implementations
> diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
> index f479239875..303106981c 100644
> --- a/target/i386/svm_helper.c
> +++ b/target/i386/svm_helper.c
> @@ -584,9 +584,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
>  {
>      CPUState *cs = CPU(x86_env_get_cpu(env));
>  
> -    if (retaddr) {
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>  
>      qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
>                    PRIx64 ", " TARGET_FMT_lx ")!\n",
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 2177c8ad12..7b800bbeab 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -150,11 +150,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      int ret;
>  
>      ret = lm32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> -    if (unlikely(ret)) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (unlikely(ret)) {/* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>          cpu_loop_exit(cs);
>      }
>  }
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 63089511cb..3079e04c7d 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -45,11 +45,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      int ret;
>  
>      ret = m68k_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> -    if (unlikely(ret)) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (unlikely(ret)) {/* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>          cpu_loop_exit(cs);
>      }
>  }
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 1e07e21c1c..3b862faaa1 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -39,11 +39,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      int ret;
>  
>      ret = mb_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> -    if (unlikely(ret)) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (unlikely(ret)) {/* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>          cpu_loop_exit(cs);
>      }
>  }
> diff --git a/target/moxie/helper.c b/target/moxie/helper.c
> index 330299f5a7..2ecee89f11 100644
> --- a/target/moxie/helper.c
> +++ b/target/moxie/helper.c
> @@ -36,9 +36,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>  
>      ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>      if (unlikely(ret)) {
> -        if (retaddr) {
> -            cpu_restore_state(cs, retaddr);
> -        }
> +        cpu_restore_state(cs, retaddr);
>      }
>      cpu_loop_exit(cs);
>  }
> diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
> index fe9298af50..6d66a5702d 100644
> --- a/target/nios2/mmu.c
> +++ b/target/nios2/mmu.c
> @@ -41,11 +41,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      int ret;
>  
>      ret = nios2_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> -    if (unlikely(ret)) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (unlikely(ret)) {/* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>          cpu_loop_exit(cs);
>      }
>  }
> diff --git a/target/openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
> index a44d0aa51a..47cd7775b6 100644
> --- a/target/openrisc/mmu_helper.c
> +++ b/target/openrisc/mmu_helper.c
> @@ -32,11 +32,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>  
>      ret = openrisc_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>  
> -    if (ret) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault.  */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (ret) {/* now we have a real cpu fault.  */
> +        cpu_restore_state(cs, retaddr);
>          /* Raise Exception.  */
>          cpu_loop_exit(cs);
>      }
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index e04b670663..8584ec43c1 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -554,9 +554,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      S390CPU *cpu = S390_CPU(cs);
>      CPUS390XState *env = &cpu->env;
>  
> -    if (retaddr) {
> -        cpu_restore_state(cs, retaddr);
> -    }
> +    cpu_restore_state(cs, retaddr);
>      program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
>  }
>  
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index 7af202c8c0..b0307de1ea 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -31,9 +31,7 @@ raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
>  {
>      CPUState *cs = CPU(tricore_env_get_cpu(env));
>      /* in case we come from a helper-call we need to restore the PC */
> -    if (pc) {
> -        cpu_restore_state(cs, pc);
> -    }
> +    cpu_restore_state(cs, pc);
>  
>      /* Tin is loaded into d[15] */
>      env->gpr_d[15] = tin;
> @@ -2804,11 +2802,8 @@ static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
>      CPUState *cs = CPU(tricore_env_get_cpu(env));
>      cs->exception_index = exception;
>      env->error_code = error_code;
> -
> -    if (pc) {
> -        /* now we have a real cpu fault */
> -        cpu_restore_state(cs, pc);
> -    }
> +    /* now we have a real cpu fault */
> +    cpu_restore_state(cs, pc);
>  
>      cpu_loop_exit(cs);
>  }
> diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
> index 0872c29faa..5a826b0e31 100644
> --- a/target/unicore32/op_helper.c
> +++ b/target/unicore32/op_helper.c
> @@ -250,11 +250,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      int ret;
>  
>      ret = uc32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> -    if (unlikely(ret)) {
> -        if (retaddr) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> +    if (unlikely(ret)) {/* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr);
>          cpu_loop_exit(cs);
>      }
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
