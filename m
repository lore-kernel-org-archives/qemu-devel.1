Received: from eggs.gnu.org ([2001:4830:134:3::10]:46361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I7C-0000X9-Ca
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I78-0000Ok-1K
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I77-0000OE-MC
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:41 -0400
Received: by mail-wm0-x241.google.com with SMTP id u138so627318wmu.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:34 +0200
Message-Id: <20171025093535.10175-51-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 50/51] tcg: Initialize cpu_env generically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is identical for each target.  So, move the initialization to
common code.  Move the variable itself out of tcg_ctx and name it
cpu_env to minimize changes within targets.

This also means we can remove tcg_global_reg_new_{ptr,i32,i64},
since there are no longer global-register temps created by targets.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h     | 10 ++++------
 target/arm/translate.h        |  1 -
 tcg/tcg.h                     |  9 +--------
 target/alpha/translate.c      |  4 ----
 target/arm/translate.c        |  4 ----
 target/cris/translate.c       |  3 ---
 target/cris/translate_v10.c   |  2 --
 target/hppa/translate.c       |  4 ----
 target/i386/translate.c       |  3 ---
 target/lm32/translate.c       |  4 ----
 target/m68k/translate.c       |  5 -----
 target/microblaze/translate.c |  4 ----
 target/mips/translate.c       |  4 ----
 target/moxie/translate.c      |  3 ---
 target/nios2/translate.c      |  4 ----
 target/openrisc/translate.c   |  3 ---
 target/ppc/translate.c        |  4 ----
 target/s390x/translate.c      |  6 ------
 target/sh4/translate.c        |  4 ----
 target/sparc/translate.c      |  4 ----
 target/tilegx/translate.c     |  3 ---
 target/tricore/translate.c    |  4 ----
 target/unicore32/translate.c  |  4 ----
 target/xtensa/translate.c     |  3 ---
 tcg/tcg-op.c                  | 30 +++++++++++++++---------------
 tcg/tcg.c                     | 32 ++++++++------------------------
 26 files changed, 28 insertions(+), 133 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index fe80176462..049bba86e9 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -18,7 +18,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         count = tcg_temp_new_i32();
     }
 
-    tcg_gen_ld_i32(count, tcg_ctx->tcg_env,
+    tcg_gen_ld_i32(count, cpu_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
@@ -36,7 +36,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, tcg_ctx->tcg_env,
+        tcg_gen_st16_i32(count, cpu_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     }
 
@@ -61,16 +61,14 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, tcg_ctx->tcg_env,
-                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, tcg_ctx->tcg_env,
-                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 3c96aec956..410ba79c0d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -80,7 +80,6 @@ typedef struct DisasCompare {
 } DisasCompare;
 
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
-extern TCGv_env cpu_env;
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
 extern TCGv_i64 cpu_exclusive_val;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 3d022e448b..cb7b329876 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -669,7 +669,6 @@ struct TCGContext {
 
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
-    TCGv_env tcg_env;                   /* *_exec  */
 
     /* These structures are private to tcg-target.inc.c.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
@@ -696,6 +695,7 @@ struct TCGContext {
 
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
+extern TCGv_env cpu_env;
 
 static inline size_t temp_idx(TCGTemp *ts)
 {
@@ -839,9 +839,6 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
                                      intptr_t, const char *);
 
-TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
-TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
-
 TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
 TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
 
@@ -960,8 +957,6 @@ static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i32 n) { return (TCGv_ptr)n; }
 static inline TCGv_i32 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i32)n; }
 
 #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i32((intptr_t)(V)))
-#define tcg_global_reg_new_ptr(R, N) \
-    TCGV_NAT_TO_PTR(tcg_global_reg_new_i32((R), (N)))
 #define tcg_global_mem_new_ptr(R, O, N) \
     TCGV_NAT_TO_PTR(tcg_global_mem_new_i32((R), (O), (N)))
 #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i32())
@@ -971,8 +966,6 @@ static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i64 n) { return (TCGv_ptr)n; }
 static inline TCGv_i64 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i64)n; }
 
 #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i64((intptr_t)(V)))
-#define tcg_global_reg_new_ptr(R, N) \
-    TCGV_NAT_TO_PTR(tcg_global_reg_new_i64((R), (N)))
 #define tcg_global_mem_new_ptr(R, O, N) \
     TCGV_NAT_TO_PTR(tcg_global_mem_new_i64((R), (O), (N)))
 #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i64())
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index f6247bf38d..cfd63d5c1f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -78,7 +78,6 @@ struct DisasContext {
 #define DISAS_PC_STALE            DISAS_TARGET_2
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static TCGv cpu_std_ir[31];
 static TCGv cpu_fir[31];
 static TCGv cpu_pc;
@@ -126,9 +125,6 @@ void alpha_translate_init(void)
 
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < 31; i++) {
         cpu_std_ir[i] = tcg_global_mem_new_i64(cpu_env,
                                                offsetof(CPUAlphaState, ir[i]),
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7873c03ae8..a252429e68 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -58,7 +58,6 @@
 #define IS_USER(s) (s->user)
 #endif
 
-TCGv_env cpu_env;
 /* We reuse the same 64-bit temporaries for efficiency.  */
 static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
 static TCGv_i32 cpu_R[16];
@@ -81,9 +80,6 @@ void arm_translate_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < 16; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
                                           offsetof(CPUARMState, regs[i]),
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 6687b838d5..aa95f6701a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -66,7 +66,6 @@
 #define CC_MASK_NZVC 0xf
 #define CC_MASK_RNZV 0x10e
 
-static TCGv_env cpu_env;
 static TCGv cpu_R[16];
 static TCGv cpu_PR[16];
 static TCGv cc_x;
@@ -3368,8 +3367,6 @@ void cris_initialize_tcg(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cc_x = tcg_global_mem_new(cpu_env,
                               offsetof(CPUCRISState, cc_x), "cc_x");
     cc_src = tcg_global_mem_new(cpu_env,
diff --git a/target/cris/translate_v10.c b/target/cris/translate_v10.c
index 5d489203f4..fce78825cc 100644
--- a/target/cris/translate_v10.c
+++ b/target/cris/translate_v10.c
@@ -1272,8 +1272,6 @@ void cris_initialize_crisv10_tcg(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cc_x = tcg_global_mem_new(cpu_env,
                               offsetof(CPUCRISState, cc_x), "cc_x");
     cc_src = tcg_global_mem_new(cpu_env,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9059812d4e..dbd4cd8615 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -83,7 +83,6 @@ typedef struct DisasInsn {
 } DisasInsn;
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static TCGv cpu_gr[32];
 static TCGv cpu_iaoq_f;
 static TCGv cpu_iaoq_b;
@@ -126,9 +125,6 @@ void hppa_translate_init(void)
 
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     TCGV_UNUSED(cpu_gr[0]);
     for (i = 1; i < 32; i++) {
         cpu_gr[i] = tcg_global_mem_new(cpu_env,
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 649004393d..7df9233ded 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -72,7 +72,6 @@
 //#define MACRO_TEST   1
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static TCGv cpu_A0;
 static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2, cpu_cc_srcT;
 static TCGv_i32 cpu_cc_op;
@@ -8367,8 +8366,6 @@ void tcg_x86_init(void)
     };
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cpu_cc_op = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUX86State, cc_op), "cc_op");
     cpu_cc_dst = tcg_global_mem_new(cpu_env, offsetof(CPUX86State, cc_dst),
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 6707967a2c..02ad3edad3 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -53,7 +53,6 @@
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
-static TCGv_env cpu_env;
 static TCGv cpu_R[32];
 static TCGv cpu_pc;
 static TCGv cpu_ie;
@@ -1208,9 +1207,6 @@ void lm32_translate_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
                           offsetof(CPULM32State, regs[i]),
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f6e902f2b6..e7eaf03e55 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -44,8 +44,6 @@
 static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
-static TCGv_env cpu_env;
-
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
@@ -69,9 +67,6 @@ void m68k_tcg_init(void)
     char *p;
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
 #define DEFO32(name, offset) \
     QREG_##name = tcg_global_mem_new_i32(cpu_env, \
         offsetof(CPUM68KState, offset), #name);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 22f8d6230b..e51821d6bd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -53,7 +53,6 @@
 #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 static TCGv env_debug;
-static TCGv_env cpu_env;
 static TCGv cpu_R[32];
 static TCGv cpu_SR[18];
 static TCGv env_imm;
@@ -1855,9 +1854,6 @@ void mb_tcg_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     env_debug = tcg_global_mem_new(cpu_env,
                     offsetof(CPUMBState, debug),
                     "debug0");
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7dfa94ab26..82622c550e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1376,7 +1376,6 @@ enum {
 };
 
 /* global register indices */
-static TCGv_env cpu_env;
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
 static TCGv cpu_dspctrl, btarget, bcond;
@@ -20454,9 +20453,6 @@ void mips_tcg_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     TCGV_UNUSED(cpu_gpr[0]);
     for (i = 1; i < 32; i++)
         cpu_gpr[i] = tcg_global_mem_new(cpu_env,
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 59c70b5cef..28b405f0e4 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -56,7 +56,6 @@ enum {
 
 static TCGv cpu_pc;
 static TCGv cpu_gregs[16];
-static TCGv_env cpu_env;
 static TCGv cc_a, cc_b;
 
 #include "exec/gen-icount.h"
@@ -101,8 +100,6 @@ void moxie_translate_init(void)
         "$r10", "$r11", "$r12", "$r13"
     };
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
                                     offsetof(CPUMoxieState, pc), "$pc");
     for (i = 0; i < 16; i++)
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index b91fd206fb..b5aaf56e86 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -789,7 +789,6 @@ static const char * const regnames[] = {
     "rpc"
 };
 
-static TCGv_ptr cpu_env;
 static TCGv cpu_R[NUM_CORE_REGS];
 
 #include "exec/gen-icount.h"
@@ -947,9 +946,6 @@ void nios2_tcg_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < NUM_CORE_REGS; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
                                       offsetof(CPUNios2State, regs[i]),
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index b031f2db97..c9cbd2319f 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -53,7 +53,6 @@ typedef struct DisasContext {
     bool singlestep_enabled;
 } DisasContext;
 
-static TCGv_env cpu_env;
 static TCGv cpu_sr;
 static TCGv cpu_R[32];
 static TCGv cpu_R0;
@@ -80,8 +79,6 @@ void openrisc_translate_init(void)
     };
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cpu_sr = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, sr), "sr");
     cpu_dflag = tcg_global_mem_new_i32(cpu_env,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0ad84a75e4..e7e4983cbf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -51,7 +51,6 @@
 /* Code translation helpers                                                  */
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static char cpu_reg_names[10*3 + 22*4 /* GPR */
     + 10*4 + 22*5 /* SPE GPRh */
     + 10*4 + 22*5 /* FPR */
@@ -85,9 +84,6 @@ void ppc_translate_init(void)
     char* p;
     size_t cpu_reg_names_size;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     p = cpu_reg_names;
     cpu_reg_names_size = sizeof(cpu_reg_names);
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2bf6f48089..55db8f3446 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -37,10 +37,6 @@
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
-
-/* global register indexes */
-static TCGv_env cpu_env;
-
 #include "exec/gen-icount.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -112,8 +108,6 @@ void s390x_translate_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     psw_addr = tcg_global_mem_new_i64(cpu_env,
                                       offsetof(CPUS390XState, psw.addr),
                                       "psw_addr");
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c13be851ba..c98f8d31e3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -65,7 +65,6 @@ enum {
 };
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static TCGv cpu_gregs[32];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
@@ -99,9 +98,6 @@ void sh4_translate_init(void)
         "FPR12_BANK1", "FPR13_BANK1", "FPR14_BANK1", "FPR15_BANK1",
     };
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < 24; i++) {
         cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,
                                               offsetof(CPUSH4State, gregs[i]),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index afef77976b..d5e866fe0d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -41,7 +41,6 @@
                          according to jump_pc[T2] */
 
 /* global register indexes */
-static TCGv_env cpu_env;
 static TCGv_ptr cpu_regwptr;
 static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
 static TCGv_i32 cpu_cc_op;
@@ -5911,9 +5910,6 @@ void sparc_tcg_init(void)
 
     unsigned int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     cpu_regwptr = tcg_global_mem_new_ptr(cpu_env,
                                          offsetof(CPUSPARCState, regwptr),
                                          "regwptr");
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index a744c38bb7..d55549dabc 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -33,7 +33,6 @@
 
 #define FMT64X                          "%016" PRIx64
 
-static TCGv_env cpu_env;
 static TCGv cpu_pc;
 static TCGv cpu_regs[TILEGX_R_COUNT];
 
@@ -2445,8 +2444,6 @@ void tilegx_tcg_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i64(cpu_env, offsetof(CPUTLGState, pc), "pc");
     for (i = 0; i < TILEGX_R_COUNT; i++) {
         cpu_regs[i] = tcg_global_mem_new_i64(cpu_env,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 590cbbee8b..18102e54cb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -47,8 +47,6 @@ static TCGv cpu_PSW_V;
 static TCGv cpu_PSW_SV;
 static TCGv cpu_PSW_AV;
 static TCGv cpu_PSW_SAV;
-/* CPU env */
-static TCGv_env cpu_env;
 
 #include "exec/gen-icount.h"
 
@@ -8881,8 +8879,6 @@ void tricore_tcg_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     /* reg init */
     for (i = 0 ; i < 16 ; i++) {
         cpu_gpr_a[i] = tcg_global_mem_new(cpu_env,
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 070653e2d1..de2a7ceee7 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -54,7 +54,6 @@ typedef struct DisasContext {
    conditional executions state has been updated.  */
 #define DISAS_SYSCALL DISAS_TARGET_3
 
-static TCGv_env cpu_env;
 static TCGv_i32 cpu_R[32];
 
 /* FIXME:  These should be removed.  */
@@ -74,9 +73,6 @@ void uc32_translate_init(void)
 {
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
-
     for (i = 0; i < 32; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
                                 offsetof(CPUUniCore32State, regs[i]), regnames[i]);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index ab96b77d88..32c4159949 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -77,7 +77,6 @@ typedef struct DisasContext {
     unsigned cpenable;
 } DisasContext;
 
-static TCGv_env cpu_env;
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_R[16];
 static TCGv_i32 cpu_FR[16];
@@ -221,8 +220,6 @@ void xtensa_translate_init(void)
     };
     int i;
 
-    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
             offsetof(CPUXtensaState, pc), "pc");
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ba603281d3..3cad30b1f2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2562,7 +2562,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
 {
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         TCGv_ptr ptr = tcg_temp_new_ptr();
-        gen_helper_lookup_tb_ptr(ptr, tcg_ctx->tcg_env);
+        gen_helper_lookup_tb_ptr(ptr, cpu_env);
         tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
@@ -2648,7 +2648,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 0));
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
 }
@@ -2657,7 +2657,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 1));
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
 }
@@ -2676,7 +2676,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 0));
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
 }
@@ -2690,7 +2690,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 1));
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
 }
@@ -2806,11 +2806,11 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv, oi);
+            gen(retv, cpu_env, addr, cmpv, newv, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv);
+        gen(retv, cpu_env, addr, cmpv, newv);
 #endif
 
         if (memop & MO_SIGN) {
@@ -2851,14 +2851,14 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop, idx));
-            gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv, oi);
+            gen(retv, cpu_env, addr, cmpv, newv, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv);
+        gen(retv, cpu_env, addr, cmpv, newv);
 #endif
 #else
-        gen_helper_exit_atomic(tcg_ctx->tcg_env);
+        gen_helper_exit_atomic(cpu_env);
         /* Produce a result, so that we have a well-formed opcode stream
            with respect to uses of the result in the (dead) code following.  */
         tcg_gen_movi_i64(retv, 0);
@@ -2914,11 +2914,11 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 #ifdef CONFIG_SOFTMMU
     {
         TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-        gen(ret, tcg_ctx->tcg_env, addr, val, oi);
+        gen(ret, cpu_env, addr, val, oi);
         tcg_temp_free_i32(oi);
     }
 #else
-    gen(ret, tcg_ctx->tcg_env, addr, val);
+    gen(ret, cpu_env, addr, val);
 #endif
 
     if (memop & MO_SIGN) {
@@ -2959,14 +2959,14 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(ret, tcg_ctx->tcg_env, addr, val, oi);
+            gen(ret, cpu_env, addr, val, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(ret, tcg_ctx->tcg_env, addr, val);
+        gen(ret, cpu_env, addr, val);
 #endif
 #else
-        gen_helper_exit_atomic(tcg_ctx->tcg_env);
+        gen_helper_exit_atomic(cpu_env);
         /* Produce a result, so that we have a well-formed opcode stream
            with respect to uses of the result in the (dead) code following.  */
         tcg_gen_movi_i64(ret, 0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5574317736..683ff4abb7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -121,6 +121,7 @@ static bool tcg_out_ldst_finalize(TCGContext *s);
 
 static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
+TCGv_env cpu_env = 0;
 
 /*
  * We divide code_gen_buffer into equally-sized "regions" that TCG threads
@@ -657,6 +658,8 @@ static GHashTable *helper_table;
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
+static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
+                                            TCGReg reg, const char *name);
 
 void tcg_context_init(TCGContext *s)
 {
@@ -664,6 +667,7 @@ void tcg_context_init(TCGContext *s)
     TCGOpDef *def;
     TCGArgConstraint *args_ct;
     int *sorted_args;
+    TCGTemp *ts;
 
     memset(s, 0, sizeof(*s));
     s->nb_globals = 0;
@@ -729,6 +733,10 @@ void tcg_context_init(TCGContext *s)
 #else
     tcg_ctxs = g_new(TCGContext *, max_cpus);
 #endif
+
+    tcg_debug_assert(!tcg_regset_test_reg(s->reserved_regs, TCG_AREG0));
+    ts = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, TCG_AREG0, "env");
+    cpu_env = temp_tcgv_ptr(ts);
 }
 
 /*
@@ -871,30 +879,6 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
         = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
 }
 
-TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
-{
-    TCGContext *s = tcg_ctx;
-    TCGTemp *t;
-
-    if (tcg_regset_test_reg(s->reserved_regs, reg)) {
-        tcg_abort();
-    }
-    t = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
-    return temp_tcgv_i32(t);
-}
-
-TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
-{
-    TCGContext *s = tcg_ctx;
-    TCGTemp *t;
-
-    if (tcg_regset_test_reg(s->reserved_regs, reg)) {
-        tcg_abort();
-    }
-    t = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
-    return temp_tcgv_i64(t);
-}
-
 TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
                                      intptr_t offset, const char *name)
 {
-- 
2.13.6
