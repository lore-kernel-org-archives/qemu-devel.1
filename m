Received: from eggs.gnu.org ([2001:4830:134:3::10]:33392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyW1-000078-02
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVy-00074r-Ly
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:24 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVy-00074b-F6
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id t186so1003232qkf.2
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:36:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:55 -1000
Message-Id: <20170719233455.8740-15-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 14/14] tcg: Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Needed to implement a target-agnostic gen_intermediate_code()
in the future.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002025498.22386.18051908483085660588.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h       | 2 +-
 target/arm/translate.h        | 4 ++--
 accel/tcg/translate-all.c     | 2 +-
 target/alpha/translate.c      | 5 ++---
 target/arm/translate-a64.c    | 6 +++---
 target/arm/translate.c        | 6 +++---
 target/cris/translate.c       | 7 +++----
 target/hppa/translate.c       | 5 ++---
 target/i386/translate.c       | 5 ++---
 target/lm32/translate.c       | 4 ++--
 target/m68k/translate.c       | 5 ++---
 target/microblaze/translate.c | 4 ++--
 target/mips/translate.c       | 5 ++---
 target/moxie/translate.c      | 4 ++--
 target/nios2/translate.c      | 5 ++---
 target/openrisc/translate.c   | 4 ++--
 target/ppc/translate.c        | 5 ++---
 target/s390x/translate.c      | 5 ++---
 target/sh4/translate.c        | 5 ++---
 target/sparc/translate.c      | 5 ++---
 target/tilegx/translate.c     | 5 ++---
 target/tricore/translate.c    | 5 ++---
 target/unicore32/translate.c  | 5 ++---
 target/xtensa/translate.c     | 5 ++---
 24 files changed, 49 insertions(+), 64 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 87b1b74e3b..440fc31b37 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -66,7 +66,7 @@ typedef ram_addr_t tb_page_addr_t;
 
 #include "qemu/log.h"
 
-void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *tb);
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
                           target_ulong *data);
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 12fd79ba8e..2fe144baa9 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -149,7 +149,7 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
+void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
@@ -158,7 +158,7 @@ static inline void a64_translate_init(void)
 {
 }
 
-static inline void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
+static inline void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb)
 {
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 090ebad0a7..37ecafa931 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1280,7 +1280,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_func_start(&tcg_ctx);
 
     tcg_ctx.cpu = ENV_GET_CPU(env);
-    gen_intermediate_code(env, tb);
+    gen_intermediate_code(cpu, tb);
     tcg_ctx.cpu = NULL;
 
     trace_translate_block(tb, tb->pc, tb->tc_ptr);
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 744d8bbf12..f465752208 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2952,10 +2952,9 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     return ret;
 }
 
-void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    AlphaCPU *cpu = alpha_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUAlphaState *env = cs->env_ptr;
     DisasContext ctx, *ctxp = &ctx;
     target_ulong pc_start;
     target_ulong pc_mask;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5bb0f8ef22..883e9df0c2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11179,10 +11179,10 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     free_tmp_a64(s);
 }
 
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
+void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
 {
-    CPUState *cs = CPU(cpu);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cs->env_ptr;
+    ARMCPU *cpu = arm_env_get_cpu(env);
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
     target_ulong next_page_start;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d3003ae0d8..d1a5f56998 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11795,10 +11795,10 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
+    CPUARMState *env = cs->env_ptr;
     ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
     target_ulong next_page_start;
@@ -11812,7 +11812,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(cpu, tb);
+        gen_intermediate_code_a64(cs, tb);
         return;
     }
 
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..12b96eb68f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3080,10 +3080,9 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  */
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    CRISCPU *cpu = cris_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUCRISState *env = cs->env_ptr;
     uint32_t pc_start;
     unsigned int insn_len;
     struct DisasContext ctx;
@@ -3105,7 +3104,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
      * delayslot, like in real hw.
      */
     pc_start = tb->pc & ~1;
-    dc->cpu = cpu;
+    dc->cpu = cris_env_get_cpu(env);
     dc->tb = tb;
 
     dc->is_jmp = DISAS_NEXT;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e10abc5e04..900870cd5a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3740,10 +3740,9 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     return gen_illegal(ctx);
 }
 
-void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUHPPAState *env = cs->env_ptr;
     DisasContext ctx;
     ExitStatus ret;
     int num_insns, max_insns, i;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index ed3b896db4..cab9e32f91 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8378,10 +8378,9 @@ void tcg_x86_init(void)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUX86State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_ptr;
     uint32_t flags;
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f447..f68f372f15 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1044,10 +1044,10 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPULM32State *env = cs->env_ptr;
     LM32CPU *cpu = lm32_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e709e6cde2..ada2a91b64 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5518,10 +5518,9 @@ static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUM68KState *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
     int pc_offset;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index cb65d1e129..a24373c0be 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1625,10 +1625,10 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUMBState *env = cs->env_ptr;
     MicroBlazeCPU *cpu = mb_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index fe44f2f807..1fd18e9d2a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19888,10 +19888,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
-void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUMIPSState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     target_ulong next_page_start;
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44c08..3cfd232558 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -822,10 +822,10 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMoxieState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUMoxieState *env = cs->env_ptr;
     MoxieCPU *cpu = moxie_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5dfb..8b97d6585f 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -799,10 +799,9 @@ static void gen_exception(DisasContext *dc, uint32_t excp)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUNios2State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     int num_insns;
     int max_insns;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e893..a01413113b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1518,10 +1518,10 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
     }
 }
 
-void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUOpenRISCState *env = cs->env_ptr;
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index de271af52b..01233e8b6d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7196,10 +7196,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
 }
 
 /*****************************************************************************/
-void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    PowerPCCPU *cpu = ppc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = cs->env_ptr;
     DisasContext ctx, *ctxp = &ctx;
     opc_handler_t **table, *handler;
     target_ulong pc_start;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 1dffcee884..48b71f9604 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5853,10 +5853,9 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
     return ret;
 }
 
-void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUS390XState *env = cs->env_ptr;
     DisasContext dc;
     target_ulong pc_start;
     uint64_t next_page_start;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 498bb99dc1..10191073b2 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2230,10 +2230,9 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 }
 #endif
 
-void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    SuperHCPU *cpu = sh_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUSH4State *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d13173275f..3bde47be83 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5739,10 +5739,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
     }
 }
 
-void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 {
-    SPARCCPU *cpu = sparc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUSPARCState *env = cs->env_ptr;
     target_ulong pc_start, last_pc;
     DisasContext dc1, *dc = &dc1;
     int num_insns;
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b63d..ace2830a84 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2370,12 +2370,11 @@ static void translate_one_bundle(DisasContext *dc, uint64_t bundle)
     }
 }
 
-void gen_intermediate_code(CPUTLGState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    TileGXCPU *cpu = tilegx_env_get_cpu(env);
+    CPUTLGState *env = cs->env_ptr;
     DisasContext ctx;
     DisasContext *dc = &ctx;
-    CPUState *cs = CPU(cpu);
     uint64_t pc_start = tb->pc;
     uint64_t next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     int num_insns = 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd07dd..4e4198e887 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8782,10 +8782,9 @@ static void decode_opc(CPUTriCoreState *env, DisasContext *ctx, int *is_branch)
     }
 }
 
-void gen_intermediate_code(CPUTriCoreState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    TriCoreCPU *cpu = tricore_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUTriCoreState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a2016a8..8f30cff932 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1869,10 +1869,9 @@ static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUUniCore32State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
     uint32_t next_page_start;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 263002486c..f3f0ff589c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3117,10 +3117,9 @@ static void gen_ibreak_check(CPUXtensaState *env, DisasContext *dc)
     }
 }
 
-void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUXtensaState *env = cs->env_ptr;
     DisasContext dc;
     int insn_count = 0;
     int max_insns = tb->cflags & CF_COUNT_MASK;
-- 
2.13.3
