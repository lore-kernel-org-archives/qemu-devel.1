Received: from eggs.gnu.org ([2001:4830:134:3::10]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgjH-0002jS-S5
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgjG-00081W-Gs
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:11 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgjG-00081J-9y
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:10 -0500
Received: by mail-pg0-x243.google.com with SMTP id 194so16794624pgd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:53:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:54 -0800
Message-Id: <20170209045154.16868-23-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 22/22] target/openrisc: Tidy handling of
 delayed branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h        | 12 +++++-------
 target/openrisc/gdbstub.c    |  2 +-
 target/openrisc/interrupt.c  |  4 ++--
 target/openrisc/sys_helper.c |  2 +-
 target/openrisc/translate.c  | 40 ++++++++++++++++------------------------
 5 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b3d43e1..e3a7782 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -83,9 +83,6 @@ enum {
 /* Version Register */
 #define SPR_VR 0xFFFF003F
 
-/* Internal flags, delay slot flag */
-#define D_FLAG    1
-
 /* Interrupt */
 #define NR_IRQS  32
 
@@ -298,8 +295,7 @@ typedef struct CPUOpenRISCState {
     target_ulong lock_addr;
     target_ulong lock_value;
 
-    uint32_t flags;           /* cpu_flags, we only use it for exception
-                                 in solt so far.  */
+    uint32_t dflag;           /* In delay slot (boolean) */
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
@@ -392,14 +388,16 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 
 #include "exec/cpu-all.h"
 
+#define TB_FLAGS_DFLAG 1
+#define TB_FLAGS_OVE   SR_OVE
+
 static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
                                         target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
-    /* D_FLAG -- branch instruction exception, OVE overflow trap enable.  */
-    *flags = (env->flags & D_FLAG) | (env->sr & SR_OVE);
+    *flags = env->dflag | (env->sr & SR_OVE);
 }
 
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 2a4821f..b18c7e9 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -73,7 +73,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
                also clear delayed branch status.  */
             if (env->pc != tmp) {
                 env->pc = tmp;
-                env->flags = 0;
+                env->dflag = 0;
             }
             break;
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 042506f..a2eec6f 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -34,8 +34,8 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     CPUOpenRISCState *env = &cpu->env;
 
     env->epcr = env->pc;
-    if (env->flags & D_FLAG) {
-        env->flags &= ~D_FLAG;
+    if (env->dflag) {
+        env->dflag = 0;
         env->sr |= SR_DSX;
         env->epcr -= 4;
     } else {
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 0968901..60c3193 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
            when "jumping" to the current instruction.  */
         if (env->pc != rb) {
             env->pc = rb;
-            env->flags = 0;
+            env->dflag = 0;
             cpu_loop_exit(cs);
         }
         break;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 10f0633..313dae2 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -40,11 +40,11 @@
 typedef struct DisasContext {
     TranslationBlock *tb;
     target_ulong pc;
-    uint32_t tb_flags, synced_flags, flags;
     uint32_t is_jmp;
     uint32_t mem_idx;
-    int singlestep_enabled;
+    uint32_t tb_flags;
     uint32_t delayed_branch;
+    bool singlestep_enabled;
 } DisasContext;
 
 static TCGv_env cpu_env;
@@ -60,7 +60,7 @@ static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
-static TCGv_i32 env_flags;
+static TCGv_i32 cpu_dflag;
 #include "exec/gen-icount.h"
 
 void openrisc_translate_init(void)
@@ -77,9 +77,9 @@ void openrisc_translate_init(void)
     tcg_ctx.tcg_env = cpu_env;
     cpu_sr = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, sr), "sr");
-    env_flags = tcg_global_mem_new_i32(cpu_env,
-                                       offsetof(CPUOpenRISCState, flags),
-                                       "flags");
+    cpu_dflag = tcg_global_mem_new_i32(cpu_env,
+                                       offsetof(CPUOpenRISCState, dflag),
+                                       "dflag");
     cpu_pc = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, pc), "pc");
     cpu_ppc = tcg_global_mem_new(cpu_env,
@@ -111,15 +111,6 @@ void openrisc_translate_init(void)
     }
 }
 
-static inline void gen_sync_flags(DisasContext *dc)
-{
-    /* Sync the tb dependent flag between translate and runtime.  */
-    if ((dc->tb_flags ^ dc->synced_flags) & D_FLAG) {
-        tcg_gen_movi_tl(env_flags, dc->tb_flags & D_FLAG);
-        dc->synced_flags = dc->tb_flags;
-    }
-}
-
 static void gen_exception(DisasContext *dc, unsigned int excp)
 {
     TCGv_i32 tmp = tcg_const_i32(excp);
@@ -230,8 +221,6 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     }
 
     dc->delayed_branch = 2;
-    dc->tb_flags |= D_FLAG;
-    gen_sync_flags(dc);
 }
 
 static void gen_ove_cy(DisasContext *dc)
@@ -1512,10 +1501,9 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
 
     dc->is_jmp = DISAS_NEXT;
     dc->pc = pc_start;
-    dc->flags = cpu->env.cpucfgr;
     dc->mem_idx = cpu_mmu_index(&cpu->env, false);
-    dc->synced_flags = dc->tb_flags = tb->flags;
-    dc->delayed_branch = (dc->tb_flags & D_FLAG) != 0;
+    dc->tb_flags = tb->flags;
+    dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
     dc->singlestep_enabled = cs->singlestep_enabled;
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
@@ -1539,7 +1527,8 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     gen_tb_start(tb);
 
     do {
-        tcg_gen_insn_start(dc->pc, num_insns != 0);
+        tcg_gen_insn_start(dc->pc, (dc->delayed_branch ? 1 : 0)
+			   | (num_insns ? 2 : 0));
         num_insns++;
 
         if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
@@ -1564,8 +1553,6 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
         if (dc->delayed_branch) {
             dc->delayed_branch--;
             if (!dc->delayed_branch) {
-                dc->tb_flags &= ~D_FLAG;
-                gen_sync_flags(dc);
                 tcg_gen_mov_tl(cpu_pc, jmp_pc);
                 tcg_gen_discard_tl(jmp_pc);
                 dc->is_jmp = DISAS_UPDATE;
@@ -1583,6 +1570,10 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
         gen_io_end();
     }
 
+    if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
+        tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
+    }
+
     tcg_gen_movi_tl(cpu_ppc, dc->pc - 4);
     if (dc->is_jmp == DISAS_NEXT) {
         dc->is_jmp = DISAS_UPDATE;
@@ -1641,7 +1632,8 @@ void restore_state_to_opc(CPUOpenRISCState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->pc = data[0];
-    if (data[1]) {
+    env->dflag = data[1] & 1;
+    if (data[1] & 2) {
         env->ppc = env->pc - 4;
     }
 }
-- 
2.9.3
