Received: from eggs.gnu.org ([2001:4830:134:3::10]:43624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT0E-0008Iu-HC
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT0A-0000oq-JY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:36:26 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT0A-0000oO-Dy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:36:22 -0400
Received: by mail-qk0-x233.google.com with SMTP id s12-v6so7588209qke.0
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:36:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-17-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c7c97ef-f41e-b91e-cca9-e29c5ac14a3b@amsat.org>
Date: Wed, 23 May 2018 09:36:17 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-17-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 16/30] RISC-V: Use riscv prefix
 consistently on cpu helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 09:15 PM, Michael Clark wrote:
> * Add riscv prefix to raise_exception function
> * Add riscv prefix to CSR read/write functions
> * Add riscv prefix to signal handler function
> * Add riscv prefix to get fflags function
> * Remove redundant declaration of riscv_cpu_init
>   and rename cpu_riscv_init to riscv_cpu_init
> * rename riscv_set_mode to riscv_cpu_set_mode
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  linux-user/riscv/signal.c |  4 ++--
>  target/riscv/cpu.h        | 21 ++++++++++-----------
>  target/riscv/cpu_helper.c | 10 +++++-----
>  target/riscv/csr.c        |  8 ++++----
>  target/riscv/fpu_helper.c |  6 +++---
>  target/riscv/op_helper.c  | 28 ++++++++++++++--------------
>  6 files changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index ef599e319a10..f03bc7212b49 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -84,7 +84,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
>          __put_user(env->fpr[i], &sc->fpr[i]);
>      }
>  
> -    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
> +    uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
>      __put_user(fcsr, &sc->fcsr);
>  }
>  
> @@ -160,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
>  
>      uint32_t fcsr;
>      __get_user(fcsr, &sc->fcsr);
> -    csr_write_helper(env, fcsr, CSR_FCSR);
> +    riscv_csr_write(env, CSR_FCSR, fcsr);
>  }
>  
>  static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1ade90d23bbc..d6bb3136db18 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -257,7 +257,7 @@ char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
> -#define cpu_signal_handler cpu_riscv_signal_handler
> +#define cpu_signal_handler riscv_cpu_signal_handler
>  #define cpu_list riscv_cpu_list
>  #define cpu_mmu_index riscv_cpu_mmu_index
>  
> @@ -265,16 +265,15 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
>  #endif
> -void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
>  
>  void riscv_translate_init(void);
> -RISCVCPU *cpu_riscv_init(const char *cpu_model);
> -int cpu_riscv_signal_handler(int host_signum, void *pinfo, void *puc);
> -void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
> -                                          uint32_t exception, uintptr_t pc);
> +int riscv_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
> +void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
> +                                         uint32_t exception, uintptr_t pc);
>  
> -target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
> -void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
> +target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
> +void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>  
>  #define TB_FLAGS_MMU_MASK   3
>  #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
> @@ -294,13 +293,13 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>                  target_ulong new_value, target_ulong write_mask);
>  
> -static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
> -                                    int csrno)
> +static inline void riscv_csr_write(CPURISCVState *env, int csrno,
> +                                   target_ulong val)
>  {
>      riscv_csrrw(env, csrno, NULL, val, -1);
>  }
>  
> -static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
> +static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
>  {
>      target_ulong val = 0;
>      riscv_csrrw(env, csrno, &val, 0, 0);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 69592c037042..b4bbf7a9fa0a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -93,7 +93,7 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
>      return old;
>  }
>  
> -void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>  {
>      if (newpriv > PRV_M) {
>          g_assert_not_reached();
> @@ -366,7 +366,7 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>          g_assert_not_reached();
>      }
>      env->badaddr = addr;
> -    do_raise_exception_err(env, cs->exception_index, retaddr);
> +    riscv_raise_exception(env, cs->exception_index, retaddr);
>  }
>  
>  /* called by qemu's softmmu to fill the qemu tlb */
> @@ -378,7 +378,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>      if (ret == TRANSLATE_FAIL) {
>          RISCVCPU *cpu = RISCV_CPU(cs);
>          CPURISCVState *env = &cpu->env;
> -        do_raise_exception_err(env, cs->exception_index, retaddr);
> +        riscv_raise_exception(env, cs->exception_index, retaddr);
>      }
>  }
>  
> @@ -530,7 +530,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s = set_field(s, MSTATUS_SPP, env->priv);
>          s = set_field(s, MSTATUS_SIE, 0);
>          env->mstatus = s;
> -        riscv_set_mode(env, PRV_S);
> +        riscv_cpu_set_mode(env, PRV_S);
>      } else {
>          /* No need to check MTVEC for misaligned - lower 2 bits cannot be set */
>          env->pc = env->mtvec;
> @@ -555,7 +555,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s = set_field(s, MSTATUS_MPP, env->priv);
>          s = set_field(s, MSTATUS_MIE, 0);
>          env->mstatus = s;
> -        riscv_set_mode(env, PRV_M);
> +        riscv_cpu_set_mode(env, PRV_M);
>      }
>      /* TODO yield load reservation  */
>  #endif
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0f886e04b130..45e33d876034 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -95,7 +95,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>          return -1;
>      }
>  #endif
> -    *val = cpu_riscv_get_fflags(env);
> +    *val = riscv_cpu_get_fflags(env);
>      return 0;
>  }
>  
> @@ -107,7 +107,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>      }
>      env->mstatus |= MSTATUS_FS;
>  #endif
> -    cpu_riscv_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
> +    riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
>      return 0;
>  }
>  
> @@ -141,7 +141,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>          return -1;
>      }
>  #endif
> -    *val = (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
> +    *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>          | (env->frm << FSR_RD_SHIFT);
>      return 0;
>  }
> @@ -155,7 +155,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>      env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
> -    cpu_riscv_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
> +    riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>      return 0;
>  }
>  
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index fdb87d8d82cb..1452a153f261 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -23,7 +23,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  
> -target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
> +target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>  {
>      int soft = get_float_exception_flags(&env->fp_status);
>      target_ulong hard = 0;
> @@ -37,7 +37,7 @@ target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
>      return hard;
>  }
>  
> -void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
> +void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
>  {
>      int soft = 0;
>  
> @@ -74,7 +74,7 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>          softrm = float_round_ties_away;
>          break;
>      default:
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>  
>      set_float_rounding_mode(softrm, &env->fp_status);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 77c79ba36e0b..b7dc18a41e21 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -25,7 +25,7 @@
>  #include "exec/helper-proto.h"
>  
>  /* Exceptions processing helpers */
> -void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
> +void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
>                                            uint32_t exception, uintptr_t pc)

You forgot to remove an extra space to align arguments.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
> @@ -36,7 +36,7 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
>  
>  void helper_raise_exception(CPURISCVState *env, uint32_t exception)
>  {
> -    do_raise_exception_err(env, exception, 0);
> +    riscv_raise_exception(env, exception, 0);
>  }
>  
>  target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
> @@ -44,7 +44,7 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
>  {
>      target_ulong val = 0;
>      if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>      return val;
>  }
> @@ -54,7 +54,7 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
>  {
>      target_ulong val = 0;
>      if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>      return val;
>  }
> @@ -64,7 +64,7 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>  {
>      target_ulong val = 0;
>      if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>      return val;
>  }
> @@ -74,17 +74,17 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>  target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  {
>      if (!(env->priv >= PRV_S)) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>  
>      target_ulong retpc = env->sepc;
>      if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>  
>      if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
>          get_field(env->mstatus, MSTATUS_TSR)) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>  
>      target_ulong mstatus = env->mstatus;
> @@ -95,7 +95,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          get_field(mstatus, MSTATUS_SPIE));
>      mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
> -    riscv_set_mode(env, prev_priv);
> +    riscv_cpu_set_mode(env, prev_priv);
>      env->mstatus = mstatus;
>  
>      return retpc;
> @@ -104,12 +104,12 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  {
>      if (!(env->priv >= PRV_M)) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>  
>      target_ulong retpc = env->mepc;
>      if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>  
>      target_ulong mstatus = env->mstatus;
> @@ -120,7 +120,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          get_field(mstatus, MSTATUS_MPIE));
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
> -    riscv_set_mode(env, prev_priv);
> +    riscv_cpu_set_mode(env, prev_priv);
>      env->mstatus = mstatus;
>  
>      return retpc;
> @@ -133,7 +133,7 @@ void helper_wfi(CPURISCVState *env)
>      if (env->priv == PRV_S &&
>          env->priv_ver >= PRIV_VERSION_1_10_0 &&
>          get_field(env->mstatus, MSTATUS_TW)) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          cs->halted = 1;
>          cs->exception_index = EXCP_HLT;
> @@ -148,7 +148,7 @@ void helper_tlb_flush(CPURISCVState *env)
>      if (env->priv == PRV_S &&
>          env->priv_ver >= PRIV_VERSION_1_10_0 &&
>          get_field(env->mstatus, MSTATUS_TVM)) {
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          tlb_flush(cs);
>      }
> 
