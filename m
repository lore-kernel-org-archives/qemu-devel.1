Received: from eggs.gnu.org ([209.51.188.92]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL71k-0006W5-Ny
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL71g-0001VX-GQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL71a-0001PL-LK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:12:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so14323322wmf.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:12:54 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab282c21-e2e5-9938-4588-7a01f9ae9f37@redhat.com>
Date: Mon, 29 Apr 2019 16:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190328230404.12909-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 16/36] target/mips: Use env_cpu,
 env_archcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 3/29/19 12:03 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/cpu.h                |  5 -----
>  hw/intc/mips_gic.c               |  2 +-
>  hw/mips/mips_int.c               |  2 +-
>  linux-user/mips/cpu_loop.c       |  2 +-
>  target/mips/helper.c             | 15 +++++----------
>  target/mips/op_helper.c          | 25 +++++++++++--------------
>  target/mips/translate.c          |  3 +--
>  target/mips/translate_init.inc.c |  4 +---
>  8 files changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index e7ad81becb..914cc26c21 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1051,11 +1051,6 @@ struct MIPSCPU {
>      CPUMIPSState env;
>  };
>  
> -static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
> -{
> -    return container_of(env, MIPSCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(MIPSCPU, env)
>  
>  void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
> diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
> index 15e6e40f9f..8f509493ea 100644
> --- a/hw/intc/mips_gic.c
> +++ b/hw/intc/mips_gic.c
> @@ -44,7 +44,7 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
>                        GIC_VP_MASK_CMP_SHF;
>      }
>      if (kvm_enabled())  {
> -        kvm_mips_set_ipi_interrupt(mips_env_get_cpu(gic->vps[vp].env),
> +        kvm_mips_set_ipi_interrupt(env_archcpu(gic->vps[vp].env),
>                                     pin + GIC_CPU_PIN_OFFSET,
>                                     ored_level);
>      } else {
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 5ddeb15848..f899f6ceb3 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -76,7 +76,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
>      qemu_irq *qi;
>      int i;
>  
> -    qi = qemu_allocate_irqs(cpu_mips_irq_request, mips_env_get_cpu(env), 8);
> +    qi = qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8);
>      for (i = 0; i < 8; i++) {
>          env->irq[i] = qi[i];
>      }
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 828137cd84..ac6c6d1504 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -425,7 +425,7 @@ static int do_break(CPUMIPSState *env, target_siginfo_t *info,
>  
>  void cpu_loop(CPUMIPSState *env)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_siginfo_t info;
>      int trapnr;
>      abi_long ret;
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..1fc0a4ce4b 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -336,10 +336,8 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
>  
>  void cpu_mips_tlb_flush(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> -
>      /* Flush qemu's TLB and discard all shadowed entries.  */
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>      env->tlb->tlb_in_use = env->tlb->nb_tlb;
>  }
>  
> @@ -401,7 +399,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
>  #if defined(TARGET_MIPS64)
>      if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
>          /* Access to at least one of the 64-bit segments has been disabled */
> -        tlb_flush(CPU(mips_env_get_cpu(env)));
> +        tlb_flush(env_cpu(env));
>      }
>  #endif
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> @@ -446,7 +444,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
>  static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
>                                  int rw, int tlb_error)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int exception = 0, error_code = 0;
>  
>      if (rw == MMU_INST_FETCH) {
> @@ -1400,8 +1398,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  #if !defined(CONFIG_USER_ONLY)
>  void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> -    CPUState *cs;
> +    CPUState *cs = env_cpu(env);
>      r4k_tlb_t *tlb;
>      target_ulong addr;
>      target_ulong end;
> @@ -1427,7 +1424,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
>      /* 1k pages are not supported. */
>      mask = tlb->PageMask | ~(TARGET_PAGE_MASK << 1);
>      if (tlb->V0) {
> -        cs = CPU(cpu);
>          addr = tlb->VPN & ~mask;
>  #if defined(TARGET_MIPS64)
>          if (addr >= (0xFFFFFFFF80000000ULL & env->SEGMask)) {
> @@ -1441,7 +1437,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
>          }
>      }
>      if (tlb->V1) {
> -        cs = CPU(cpu);
>          addr = (tlb->VPN & ~mask) | ((mask >> 1) + 1);
>  #if defined(TARGET_MIPS64)
>          if (addr >= (0xFFFFFFFF80000000ULL & env->SEGMask)) {
> @@ -1462,7 +1457,7 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
>                                            int error_code,
>                                            uintptr_t pc)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
>                    __func__, exception, error_code);
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0f272a5b93..0705e8c686 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -350,7 +350,7 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
>                                                        int rw, uintptr_t retaddr)
>  {
>      hwaddr paddr;
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      paddr = cpu_mips_translate_address(env, address, rw);
>  
> @@ -699,7 +699,7 @@ static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
>          return env;
>      }
>  
> -    cs = CPU(mips_env_get_cpu(env));
> +    cs = env_cpu(env);
>      vpe_idx = tc_idx / cs->nr_threads;
>      *tc = tc_idx % cs->nr_threads;
>      other_cs = qemu_get_cpu(vpe_idx);
> @@ -1298,7 +1298,7 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> +    MIPSCPU *cpu = env_archcpu(env);
>  
>      env->active_tc.CP0_TCHalt = arg1 & 0x1;
>  
> @@ -1314,7 +1314,7 @@ void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
>  {
>      int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
>      CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
> -    MIPSCPU *other_cpu = mips_env_get_cpu(other);
> +    MIPSCPU *other_cpu = env_archcpu(other);
>  
>      // TODO: Halt TC / Restart (if allocated+active) TC.
>  
> @@ -1427,7 +1427,7 @@ void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      env->CP0_SegCtl0 = arg1 & CP0SC0_MASK;
>      tlb_flush(cs);
> @@ -1435,7 +1435,7 @@ void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      env->CP0_SegCtl1 = arg1 & CP0SC1_MASK;
>      tlb_flush(cs);
> @@ -1443,7 +1443,7 @@ void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      env->CP0_SegCtl2 = arg1 & CP0SC2_MASK;
>      tlb_flush(cs);
> @@ -1666,7 +1666,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>      /* If the ASID changes, flush qemu's TLB.  */
>      if ((old & env->CP0_EntryHi_ASID_mask) !=
>          (val & env->CP0_EntryHi_ASID_mask)) {
> -        tlb_flush(CPU(mips_env_get_cpu(env)));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>  
> @@ -1686,7 +1686,6 @@ void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
>  
>  void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
>      uint32_t val, old;
>  
>      old = env->CP0_Status;
> @@ -1706,7 +1705,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
>          case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
>          case MIPS_HFLAG_KM: qemu_log("\n"); break;
>          default:
> -            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
> +            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
>              break;
>          }
>      }
> @@ -2485,8 +2484,6 @@ static void debug_pre_eret(CPUMIPSState *env)
>  
>  static void debug_post_eret(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> -
>      if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>          qemu_log("  =>  PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx,
>                  env->active_tc.PC, env->CP0_EPC);
> @@ -2502,7 +2499,7 @@ static void debug_post_eret(CPUMIPSState *env)
>          case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
>          case MIPS_HFLAG_KM: qemu_log("\n"); break;
>          default:
> -            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
> +            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
>              break;
>          }
>      }
> @@ -2633,7 +2630,7 @@ void helper_pmon(CPUMIPSState *env, int function)
>  
>  void helper_wait(CPUMIPSState *env)
>  {
> -    CPUState *cs = CPU(mips_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->halted = 1;
>      cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 364bd6dc4f..7ace8c3b96 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29911,8 +29911,7 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
>  
>  void cpu_state_reset(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>  
>      /* Reset registers to their default values */
>      env->CP0_PRid = env->cpu_model->CP0_PRid;
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index bf559aff08..50586a01a2 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -872,8 +872,6 @@ static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
>  
>  static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
>  {
> -    MIPSCPU *cpu = mips_env_get_cpu(env);
> -
>      env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
>  
>      switch (def->mmu_type) {
> @@ -890,7 +888,7 @@ static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
>          case MMU_TYPE_R6000:
>          case MMU_TYPE_R8000:
>          default:
> -            cpu_abort(CPU(cpu), "MMU type not supported\n");
> +            cpu_abort(env_cpu(env), "MMU type not supported\n");
>      }
>  }
>  #endif /* CONFIG_USER_ONLY */
> 
