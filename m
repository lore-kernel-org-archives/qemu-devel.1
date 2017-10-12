Received: from eggs.gnu.org ([2001:4830:134:3::10]:42835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2XDE-0006VU-WA
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2XDB-0000PP-R8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:43:21 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:39414)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e2XDB-0000LC-2I
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:43:17 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20171010214540.30970-1-richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 09:43:03 +0300
In-Reply-To: <20171010214540.30970-1-richard.henderson@linaro.org> (Richard
	Henderson's message of "Tue, 10 Oct 2017 14:45:40 -0700")
Message-ID: <87k200sw7c.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize cpu_env generically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Richard Henderson writes:

> This is identical for each target.  So, move the initialization to
> common code.  Move the variable itself out of tcg_ctx and name it
> cpu_env to minimize changes within targets.

> This also means we can remove tcg_global_reg_new_{ptr,i32,i64},
> since there are no longer global-register temps created by targets.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/gen-icount.h     |  8 ++++----
>  target/arm/translate.h        |  1 -
>  tcg/tcg.h                     |  9 +--------
>  target/alpha/translate.c      |  4 ----
>  target/arm/translate.c        |  4 ----
>  target/cris/translate.c       |  3 ---
>  target/cris/translate_v10.c   |  2 --
>  target/hppa/translate.c       |  4 ----
>  target/i386/translate.c       |  3 ---
>  target/lm32/translate.c       |  4 ----
>  target/m68k/translate.c       |  5 -----
>  target/microblaze/translate.c |  4 ----
>  target/mips/translate.c       |  4 ----
>  target/moxie/translate.c      |  7 ++-----
>  target/nios2/translate.c      |  3 ---
>  target/openrisc/translate.c   |  3 ---
>  target/ppc/translate.c        | 10 +++-------
>  target/s390x/translate.c      |  6 ------
>  target/sh4/translate.c        |  7 +------
>  target/sparc/translate.c      |  4 ----
>  target/tilegx/translate.c     |  3 ---
>  target/tricore/translate.c    |  6 ++----
>  target/unicore32/translate.c  |  4 ----
>  target/xtensa/translate.c     |  3 ---
>  tcg/tcg-op.c                  | 30 +++++++++++++++---------------
>  tcg/tcg.c                     | 31 +++++++------------------------
>  26 files changed, 35 insertions(+), 137 deletions(-)

> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 9b3cb14dfa..de52a67ee8 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
>          count = tcg_temp_new_i32();
>      }
 
> -    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
> +    tcg_gen_ld_i32(count, cpu_env,
>                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
>      if (tb->cflags & CF_USE_ICOUNT) {
> @@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
>      tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
>      if (tb->cflags & CF_USE_ICOUNT) {
> -        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
> +        tcg_gen_st16_i32(count, cpu_env,
>                           -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
>      }
 
> @@ -62,7 +62,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
>  static inline void gen_io_start(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(1);
> -    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
> +    tcg_gen_st_i32(tmp, cpu_env,
>                     -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);
>  }
> @@ -70,7 +70,7 @@ static inline void gen_io_start(void)
>  static inline void gen_io_end(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(0);
> -    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
> +    tcg_gen_st_i32(tmp, cpu_env,
>                     -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);
>  }
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 3c96aec956..410ba79c0d 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -80,7 +80,6 @@ typedef struct DisasCompare {
>  } DisasCompare;
 
>  /* Share the TCG temporaries common between 32 and 64 bit modes.  */
> -extern TCGv_env cpu_env;
>  extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
>  extern TCGv_i64 cpu_exclusive_addr;
>  extern TCGv_i64 cpu_exclusive_val;
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b2d42e3136..da1fefd6f1 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -702,7 +702,6 @@ struct TCGContext {
 
>      /* Track which vCPU triggers events */
>      CPUState *cpu;                      /* *_trans */
> -    TCGv_env tcg_env;                   /* *_exec  */

I would rather keep it here instead of making a new global variable, since that
should make it easier in the future to have multiple translation contexts.


Thanks,
  Lluis

 
>      /* These structures are private to tcg-target.inc.c.  */
>  #ifdef TCG_TARGET_NEED_LDST_LABELS
> @@ -727,6 +726,7 @@ struct TCGContext {
>  };
 
>  extern TCGContext tcg_ctx;
> +extern TCGv_env cpu_env;
>  extern bool parallel_cpus;
 
>  static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
> @@ -783,9 +783,6 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
>  int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
 
> -TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
> -TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
> -
>  TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
>  TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
 
> @@ -904,8 +901,6 @@ do {\
>  #define TCGV_PTR_TO_NAT(n) MAKE_TCGV_I32(GET_TCGV_PTR(n))
 
>  #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i32((intptr_t)(V)))
> -#define tcg_global_reg_new_ptr(R, N) \
> -    TCGV_NAT_TO_PTR(tcg_global_reg_new_i32((R), (N)))
>  #define tcg_global_mem_new_ptr(R, O, N) \
>      TCGV_NAT_TO_PTR(tcg_global_mem_new_i32((R), (O), (N)))
>  #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i32())
> @@ -915,8 +910,6 @@ do {\
>  #define TCGV_PTR_TO_NAT(n) MAKE_TCGV_I64(GET_TCGV_PTR(n))
 
>  #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i64((intptr_t)(V)))
> -#define tcg_global_reg_new_ptr(R, N) \
> -    TCGV_NAT_TO_PTR(tcg_global_reg_new_i64((R), (N)))
>  #define tcg_global_mem_new_ptr(R, O, N) \
>      TCGV_NAT_TO_PTR(tcg_global_mem_new_i64((R), (O), (N)))
>  #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i64())
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index f32c95b9a1..bbfffc7173 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -78,7 +78,6 @@ struct DisasContext {
>  #define DISAS_PC_STALE            DISAS_TARGET_2
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static TCGv cpu_std_ir[31];
>  static TCGv cpu_fir[31];
>  static TCGv cpu_pc;
> @@ -132,9 +131,6 @@ void alpha_translate_init(void)
>      }
>      done_init = 1;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      for (i = 0; i < 31; i++) {
>          cpu_std_ir[i] = tcg_global_mem_new_i64(cpu_env,
>                                                 offsetof(CPUAlphaState, ir[i]),
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index fdc46cc525..722b66238a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -58,7 +58,6 @@
>  #define IS_USER(s) (s->user)
>  #endif
 
> -TCGv_env cpu_env;
>  /* We reuse the same 64-bit temporaries for efficiency.  */
>  static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
>  static TCGv_i32 cpu_R[16];
> @@ -81,9 +80,6 @@ void arm_translate_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      for (i = 0; i < 16; i++) {
>          cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
>                                            offsetof(CPUARMState, regs[i]),
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 38a999e6f1..2fb0b62cad 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -66,7 +66,6 @@
>  #define CC_MASK_NZVC 0xf
>  #define CC_MASK_RNZV 0x10e
 
> -static TCGv_env cpu_env;
>  static TCGv cpu_R[16];
>  static TCGv cpu_PR[16];
>  static TCGv cc_x;
> @@ -3368,8 +3367,6 @@ void cris_initialize_tcg(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cc_x = tcg_global_mem_new(cpu_env,
>                                offsetof(CPUCRISState, cc_x), "cc_x");
>      cc_src = tcg_global_mem_new(cpu_env,
> diff --git a/target/cris/translate_v10.c b/target/cris/translate_v10.c
> index 4a0b485d8e..fce78825cc 100644
> --- a/target/cris/translate_v10.c
> +++ b/target/cris/translate_v10.c
> @@ -1272,8 +1272,6 @@ void cris_initialize_crisv10_tcg(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cc_x = tcg_global_mem_new(cpu_env,
>                                offsetof(CPUCRISState, cc_x), "cc_x");
>      cc_src = tcg_global_mem_new(cpu_env,
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 26242f4b3c..acc3cef92b 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -83,7 +83,6 @@ typedef struct DisasInsn {
>  } DisasInsn;
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static TCGv cpu_gr[32];
>  static TCGv cpu_iaoq_f;
>  static TCGv cpu_iaoq_b;
> @@ -132,9 +131,6 @@ void hppa_translate_init(void)
>      }
>      done_init = 1;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      TCGV_UNUSED(cpu_gr[0]);
>      for (i = 1; i < 32; i++) {
>          cpu_gr[i] = tcg_global_mem_new(cpu_env,
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 5d61fa96ad..792a0b7662 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -72,7 +72,6 @@
>  //#define MACRO_TEST   1
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static TCGv cpu_A0;
>  static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2, cpu_cc_srcT;
>  static TCGv_i32 cpu_cc_op;
> @@ -8336,8 +8335,6 @@ void tcg_x86_init(void)
>      }
>      initialized = true;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cpu_cc_op = tcg_global_mem_new_i32(cpu_env,
>                                         offsetof(CPUX86State, cc_op), "cc_op");
>      cpu_cc_dst = tcg_global_mem_new(cpu_env, offsetof(CPUX86State, cc_dst),
> diff --git a/target/lm32/translate.c b/target/lm32/translate.c
> index 65bc9c0bf6..5d64db2da0 100644
> --- a/target/lm32/translate.c
> +++ b/target/lm32/translate.c
> @@ -53,7 +53,6 @@
>  #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
>  #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
> -static TCGv_env cpu_env;
>  static TCGv cpu_R[32];
>  static TCGv cpu_pc;
>  static TCGv cpu_ie;
> @@ -1208,9 +1207,6 @@ void lm32_translate_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
>          cpu_R[i] = tcg_global_mem_new(cpu_env,
>                            offsetof(CPULM32State, regs[i]),
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index d738f32f9c..4e95f38fda 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -44,8 +44,6 @@
>  static TCGv_i32 cpu_halted;
>  static TCGv_i32 cpu_exception_index;
 
> -static TCGv_env cpu_env;
> -
>  static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
>  static TCGv cpu_dregs[8];
>  static TCGv cpu_aregs[8];
> @@ -69,9 +67,6 @@ void m68k_tcg_init(void)
>      char *p;
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>  #define DEFO32(name, offset) \
>      QREG_##name = tcg_global_mem_new_i32(cpu_env, \
>          offsetof(CPUM68KState, offset), #name);
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 067b0878d6..821c628f00 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -53,7 +53,6 @@
>  #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
>  static TCGv env_debug;
> -static TCGv_env cpu_env;
>  static TCGv cpu_R[32];
>  static TCGv cpu_SR[18];
>  static TCGv env_imm;
> @@ -1855,9 +1854,6 @@ void mb_tcg_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      env_debug = tcg_global_mem_new(cpu_env,
>                      offsetof(CPUMBState, debug),
>                      "debug0");
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ac05f3aa09..a97a1425a3 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1376,7 +1376,6 @@ enum {
>  };
 
>  /* global register indices */
> -static TCGv_env cpu_env;
>  static TCGv cpu_gpr[32], cpu_PC;
>  static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
>  static TCGv cpu_dspctrl, btarget, bcond;
> @@ -20459,9 +20458,6 @@ void mips_tcg_init(void)
>      if (inited)
>          return;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      TCGV_UNUSED(cpu_gpr[0]);
>      for (i = 1; i < 32; i++)
>          cpu_gpr[i] = tcg_global_mem_new(cpu_env,
> diff --git a/target/moxie/translate.c b/target/moxie/translate.c
> index 3cfd232558..7e0e5928d0 100644
> --- a/target/moxie/translate.c
> +++ b/target/moxie/translate.c
> @@ -56,7 +56,6 @@ enum {
 
>  static TCGv cpu_pc;
>  static TCGv cpu_gregs[16];
> -static TCGv_env cpu_env;
>  static TCGv cc_a, cc_b;
 
>  #include "exec/gen-icount.h"
> @@ -105,8 +104,8 @@ void moxie_translate_init(void)
>      if (done_init) {
>          return;
>      }
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> +    done_init = 1;
> +
>      cpu_pc = tcg_global_mem_new_i32(cpu_env,
>                                      offsetof(CPUMoxieState, pc), "$pc");
>      for (i = 0; i < 16; i++)
> @@ -118,8 +117,6 @@ void moxie_translate_init(void)
>                                    offsetof(CPUMoxieState, cc_a), "cc_a");
>      cc_b = tcg_global_mem_new_i32(cpu_env,
>                                    offsetof(CPUMoxieState, cc_b), "cc_b");
> -
> -    done_init = 1;
>  }
 
>  static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index 6b0961837d..c8d1f3e724 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -789,7 +789,6 @@ static const char * const regnames[] = {
>      "rpc"
>  };
 
> -static TCGv_ptr cpu_env;
>  static TCGv cpu_R[NUM_CORE_REGS];
 
>  #include "exec/gen-icount.h"
> @@ -947,8 +946,6 @@ void nios2_tcg_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -
>      for (i = 0; i < NUM_CORE_REGS; i++) {
>          cpu_R[i] = tcg_global_mem_new(cpu_env,
>                                        offsetof(CPUNios2State, regs[i]),
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 112db1ad0f..59dd80d7f4 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -53,7 +53,6 @@ typedef struct DisasContext {
>      bool singlestep_enabled;
>  } DisasContext;
 
> -static TCGv_env cpu_env;
>  static TCGv cpu_sr;
>  static TCGv cpu_R[32];
>  static TCGv cpu_R0;
> @@ -80,8 +79,6 @@ void openrisc_translate_init(void)
>      };
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cpu_sr = tcg_global_mem_new(cpu_env,
>                                  offsetof(CPUOpenRISCState, sr), "sr");
>      cpu_dflag = tcg_global_mem_new_i32(cpu_env,
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 606b605ba0..f33667357a 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -51,7 +51,6 @@
>  /* Code translation helpers                                                  */
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static char cpu_reg_names[10*3 + 22*4 /* GPR */
>      + 10*4 + 22*5 /* SPE GPRh */
>      + 10*4 + 22*5 /* FPR */
> @@ -86,11 +85,10 @@ void ppc_translate_init(void)
>      size_t cpu_reg_names_size;
>      static int done_init = 0;
 
> -    if (done_init)
> +    if (done_init) {
>          return;
> -
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> +    }
> +    done_init = 1;
 
>      p = cpu_reg_names;
>      cpu_reg_names_size = sizeof(cpu_reg_names);
> @@ -191,8 +189,6 @@ void ppc_translate_init(void)
 
>      cpu_access_type = tcg_global_mem_new_i32(cpu_env,
>                                               offsetof(CPUPPCState, access_type), "access_type");
> -
> -    done_init = 1;
>  }
 
>  /* internal defines */
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 165d2cac3e..16d39073be 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -37,10 +37,6 @@
>  #include "qemu/log.h"
>  #include "qemu/host-utils.h"
>  #include "exec/cpu_ldst.h"
> -
> -/* global register indexes */
> -static TCGv_env cpu_env;
> -
>  #include "exec/gen-icount.h"
>  #include "exec/helper-proto.h"
>  #include "exec/helper-gen.h"
> @@ -112,8 +108,6 @@ void s390x_translate_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      psw_addr = tcg_global_mem_new_i64(cpu_env,
>                                        offsetof(CPUS390XState, psw.addr),
>                                        "psw_addr");
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 8db9fba26e..d41be4f122 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -65,7 +65,6 @@ enum {
>  };
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static TCGv cpu_gregs[32];
>  static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
>  static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
> @@ -103,9 +102,7 @@ void sh4_translate_init(void)
>      if (done_init) {
>          return;
>      }
> -
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> +    done_init = 1;
 
>      for (i = 0; i < 24; i++) {
>          cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,
> @@ -163,8 +160,6 @@ void sh4_translate_init(void)
>          cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
>                                                offsetof(CPUSH4State, fregs[i]),
>                                                fregnames[i]);
> -
> -    done_init = 1;
>  }
 
>  void superh_cpu_dump_state(CPUState *cs, FILE *f,
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 6290705b11..e6469634c0 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -41,7 +41,6 @@
>                           according to jump_pc[T2] */
 
>  /* global register indexes */
> -static TCGv_env cpu_env;
>  static TCGv_ptr cpu_regwptr;
>  static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
>  static TCGv_i32 cpu_cc_op;
> @@ -5923,9 +5922,6 @@ void gen_intermediate_code_init(CPUSPARCState *env)
>      }
>      inited = 1;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      cpu_regwptr = tcg_global_mem_new_ptr(cpu_env,
>                                           offsetof(CPUSPARCState, regwptr),
>                                           "regwptr");
> diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
> index ace2830a84..93fc2e8d2f 100644
> --- a/target/tilegx/translate.c
> +++ b/target/tilegx/translate.c
> @@ -33,7 +33,6 @@
 
>  #define FMT64X                          "%016" PRIx64
 
> -static TCGv_env cpu_env;
>  static TCGv cpu_pc;
>  static TCGv cpu_regs[TILEGX_R_COUNT];
 
> @@ -2445,8 +2444,6 @@ void tilegx_tcg_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cpu_pc = tcg_global_mem_new_i64(cpu_env, offsetof(CPUTLGState, pc), "pc");
>      for (i = 0; i < TILEGX_R_COUNT; i++) {
>          cpu_regs[i] = tcg_global_mem_new_i64(cpu_env,
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 4e4198e887..fac646eccc 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -47,8 +47,6 @@ static TCGv cpu_PSW_V;
>  static TCGv cpu_PSW_SV;
>  static TCGv cpu_PSW_AV;
>  static TCGv cpu_PSW_SAV;
> -/* CPU env */
> -static TCGv_env cpu_env;
 
>  #include "exec/gen-icount.h"
 
> @@ -8884,8 +8882,8 @@ void tricore_tcg_init(void)
>      if (inited) {
>          return;
>      }
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> +    inited = 1;
> +
>      /* reg init */
>      for (i = 0 ; i < 16 ; i++) {
>          cpu_gpr_a[i] = tcg_global_mem_new(cpu_env,
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index 6c094d59d7..a1c3d25285 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -54,7 +54,6 @@ typedef struct DisasContext {
>     conditional executions state has been updated.  */
>  #define DISAS_SYSCALL DISAS_TARGET_3
 
> -static TCGv_env cpu_env;
>  static TCGv_i32 cpu_R[32];
 
>  /* FIXME:  These should be removed.  */
> @@ -74,9 +73,6 @@ void uc32_translate_init(void)
>  {
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
> -
>      for (i = 0; i < 32; i++) {
>          cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
>                                  offsetof(CPUUniCore32State, regs[i]), regnames[i]);
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index d7bf07e8e6..37796642a8 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -77,7 +77,6 @@ typedef struct DisasContext {
>      unsigned cpenable;
>  } DisasContext;
 
> -static TCGv_env cpu_env;
>  static TCGv_i32 cpu_pc;
>  static TCGv_i32 cpu_R[16];
>  static TCGv_i32 cpu_FR[16];
> @@ -221,8 +220,6 @@ void xtensa_translate_init(void)
>      };
>      int i;
 
> -    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> -    tcg_ctx.tcg_env = cpu_env;
>      cpu_pc = tcg_global_mem_new_i32(cpu_env,
>              offsetof(CPUXtensaState, pc), "pc");
 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index d3c0e4799e..33eff03b07 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2592,7 +2592,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
>  {
>      if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
>          TCGv_ptr ptr = tcg_temp_new_ptr();
> -        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env);
> +        gen_helper_lookup_tb_ptr(ptr, cpu_env);
>          tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
>          tcg_temp_free_ptr(ptr);
>      } else {
> @@ -2678,7 +2678,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>  {
>      tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
>      memop = tcg_canonicalize_memop(memop, 0, 0);
> -    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
> +    trace_guest_mem_before_tcg(tcg_ctx.cpu, cpu_env,
>                                 addr, trace_mem_get_info(memop, 0));
>      gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
>  }
> @@ -2687,7 +2687,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>  {
>      tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
>      memop = tcg_canonicalize_memop(memop, 0, 1);
> -    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
> +    trace_guest_mem_before_tcg(tcg_ctx.cpu, cpu_env,
>                                 addr, trace_mem_get_info(memop, 1));
>      gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
>  }
> @@ -2706,7 +2706,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>      }
 
>      memop = tcg_canonicalize_memop(memop, 1, 0);
> -    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
> +    trace_guest_mem_before_tcg(tcg_ctx.cpu, cpu_env,
>                                 addr, trace_mem_get_info(memop, 0));
>      gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
>  }
> @@ -2720,7 +2720,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>      }
 
>      memop = tcg_canonicalize_memop(memop, 1, 1);
> -    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
> +    trace_guest_mem_before_tcg(tcg_ctx.cpu, cpu_env,
>                                 addr, trace_mem_get_info(memop, 1));
>      gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
>  }
> @@ -2836,11 +2836,11 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
>  #ifdef CONFIG_SOFTMMU
>          {
>              TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
> -            gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv, oi);
> +            gen(retv, cpu_env, addr, cmpv, newv, oi);
>              tcg_temp_free_i32(oi);
>          }
>  #else
> -        gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv);
> +        gen(retv, cpu_env, addr, cmpv, newv);
>  #endif
 
>          if (memop & MO_SIGN) {
> @@ -2881,14 +2881,14 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
>  #ifdef CONFIG_SOFTMMU
>          {
>              TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop, idx));
> -            gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv, oi);
> +            gen(retv, cpu_env, addr, cmpv, newv, oi);
>              tcg_temp_free_i32(oi);
>          }
>  #else
> -        gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv);
> +        gen(retv, cpu_env, addr, cmpv, newv);
>  #endif
>  #else
> -        gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        gen_helper_exit_atomic(cpu_env);
>          /* Produce a result, so that we have a well-formed opcode stream
>             with respect to uses of the result in the (dead) code following.  */
>          tcg_gen_movi_i64(retv, 0);
> @@ -2944,11 +2944,11 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
>  #ifdef CONFIG_SOFTMMU
>      {
>          TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
> -        gen(ret, tcg_ctx.tcg_env, addr, val, oi);
> +        gen(ret, cpu_env, addr, val, oi);
>          tcg_temp_free_i32(oi);
>      }
>  #else
> -    gen(ret, tcg_ctx.tcg_env, addr, val);
> +    gen(ret, cpu_env, addr, val);
>  #endif
 
>      if (memop & MO_SIGN) {
> @@ -2989,14 +2989,14 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>  #ifdef CONFIG_SOFTMMU
>          {
>              TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
> -            gen(ret, tcg_ctx.tcg_env, addr, val, oi);
> +            gen(ret, cpu_env, addr, val, oi);
>              tcg_temp_free_i32(oi);
>          }
>  #else
> -        gen(ret, tcg_ctx.tcg_env, addr, val);
> +        gen(ret, cpu_env, addr, val);
>  #endif
>  #else
> -        gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        gen_helper_exit_atomic(cpu_env);
>          /* Produce a result, so that we have a well-formed opcode stream
>             with respect to uses of the result in the (dead) code following.  */
>          tcg_gen_movi_i64(ret, 0);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b075749b68..4b89684c3a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -119,6 +119,7 @@ static bool tcg_out_ldst_finalize(TCGContext *s);
>  #define TCG_HIGHWATER 1024
 
>  TCGContext tcg_ctx = { };
> +TCGv_env cpu_env = 0;
>  static TCGRegSet tcg_target_available_regs[2];
>  static TCGRegSet tcg_target_call_clobber_regs;
 
> @@ -325,6 +326,8 @@ static GHashTable *helper_table;
 
>  static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
>  static void process_op_defs(TCGContext *s);
> +static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
> +                                       TCGReg reg, const char *name);
 
>  void tcg_context_init(TCGContext *s)
>  {
> @@ -383,6 +386,10 @@ void tcg_context_init(TCGContext *s)
>      for (; i < ARRAY_SIZE(tcg_target_reg_alloc_order); ++i) {
>          indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
>      }
> +
> +    tcg_debug_assert(!tcg_regset_test_reg(s->reserved_regs, TCG_AREG0));
> +    i = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, TCG_AREG0, "env");
> +    cpu_env = MAKE_TCGV_PTR(i);
>  }
 
>  /*
> @@ -525,30 +532,6 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
>      s-> frame_temp = &s->temps[idx];
>  }
 
> -TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
> -{
> -    TCGContext *s = &tcg_ctx;
> -    int idx;
> -
> -    if (tcg_regset_test_reg(s->reserved_regs, reg)) {
> -        tcg_abort();
> -    }
> -    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
> -    return MAKE_TCGV_I32(idx);
> -}
> -
> -TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
> -{
> -    TCGContext *s = &tcg_ctx;
> -    int idx;
> -
> -    if (tcg_regset_test_reg(s->reserved_regs, reg)) {
> -        tcg_abort();
> -    }
> -    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
> -    return MAKE_TCGV_I64(idx);
> -}
> -
>  int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>                                  intptr_t offset, const char *name)
>  {
> -- 
> 2.13.6
