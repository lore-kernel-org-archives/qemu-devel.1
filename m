Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cTJzQ-00081P-K1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cTJzM-0006r4-Hx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:16 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cTJzM-0006pc-9e
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:12 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so15160915pfa.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 18:59:10 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 16 Jan 2017 18:58:43 -0800
Message-Id: <1484621923-2636-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target-xtensa: implement RER/WER instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

RER and WER are privileged instructions for accessing external
registers. External register address space is local to processor core.
There's no alignment requirements, addressable units are 32-bit wide
registers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c          |  6 ++++++
 target/xtensa/cpu.h          |  7 +++++++
 target/xtensa/helper.h       |  3 +++
 target/xtensa/op_helper.c    | 12 ++++++++++++
 target/xtensa/overlay_tool.h |  7 ++++++-
 target/xtensa/translate.c    | 12 ++++++++++--
 6 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 811d878..cd7f958 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -127,6 +127,12 @@ static void xtensa_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     env->config = xcc->config;
 
+    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
+    env->system_er = g_malloc(sizeof(*env->system_er));
+    memory_region_init_io(env->system_er, NULL, NULL, env, "er",
+                          UINT64_C(0x100000000));
+    address_space_init(env->address_space_er, env->system_er, "ER");
+
     if (tcg_enabled() && !tcg_inited) {
         tcg_inited = true;
         xtensa_translate_init();
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 9a130bd..7e7131a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -103,6 +103,7 @@ enum {
     XTENSA_OPTION_PROCESSOR_ID,
     XTENSA_OPTION_DEBUG,
     XTENSA_OPTION_TRACE_PORT,
+    XTENSA_OPTION_EXTERN_REGS,
 };
 
 enum {
@@ -393,6 +394,8 @@ typedef struct CPUXtensaState {
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
     unsigned autorefill_idx;
     bool runstall;
+    AddressSpace *address_space_er;
+    MemoryRegion *system_er;
     int pending_irq_level; /* level of last raised IRQ */
     void **irq_inputs;
     XtensaCcompareTimer ccompare[MAX_NCCOMPARE];
@@ -488,6 +491,10 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
 void reset_mmu(CPUXtensaState *env);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env);
 void debug_exception_env(CPUXtensaState *new_env, uint32_t cause);
+static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
+{
+    return env->system_er;
+}
 
 static inline void xtensa_select_static_vectors(CPUXtensaState *env,
                                                 unsigned n)
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 7e14741..db3c9c5 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -58,3 +58,6 @@ DEF_HELPER_4(olt_s, void, env, i32, f32, f32)
 DEF_HELPER_4(ult_s, void, env, i32, f32, f32)
 DEF_HELPER_4(ole_s, void, env, i32, f32, f32)
 DEF_HELPER_4(ule_s, void, env, i32, f32, f32)
+
+DEF_HELPER_2(rer, i32, env, i32)
+DEF_HELPER_3(wer, void, env, i32, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 989578a..b456c2e 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -1027,3 +1027,15 @@ void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
     int v = float32_compare_quiet(a, b, &env->fp_status);
     set_br(env, v != float_relation_greater, br);
 }
+
+uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
+{
+    return address_space_ldl(env->address_space_er, addr,
+                             (MemTxAttrs){0}, NULL);
+}
+
+void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
+{
+    address_space_stl(env->address_space_er, addr, data,
+                      (MemTxAttrs){0}, NULL);
+}
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index bf36b5c..38e9be9 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -63,6 +63,10 @@
 #define XCHAL_LOOP_BUFFER_SIZE 0
 #endif
 
+#ifndef XCHAL_HAVE_EXTERN_REGS
+#define XCHAL_HAVE_EXTERN_REGS 0
+#endif
+
 #define XCHAL_OPTION(xchal, qemu) ((xchal) ? XTENSA_OPTION_BIT(qemu) : 0)
 
 #define XTENSA_OPTIONS ( \
@@ -115,7 +119,8 @@
     XCHAL_OPTION(XCHAL_HAVE_DEBUG, XTENSA_OPTION_DEBUG) |\
     XCHAL_OPTION(XCHAL_NUM_MISC_REGS > 0, XTENSA_OPTION_MISC_SR) | \
     XCHAL_OPTION(XCHAL_HAVE_THREADPTR, XTENSA_OPTION_THREAD_POINTER) | \
-    XCHAL_OPTION(XCHAL_HAVE_PRID, XTENSA_OPTION_PROCESSOR_ID))
+    XCHAL_OPTION(XCHAL_HAVE_PRID, XTENSA_OPTION_PROCESSOR_ID) | \
+    XCHAL_OPTION(XCHAL_HAVE_EXTERN_REGS, XTENSA_OPTION_EXTERN_REGS))
 
 #ifndef XCHAL_WINDOW_OF4_VECOFS
 #define XCHAL_WINDOW_OF4_VECOFS         0x00000000
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index c541b59..c0408a0 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1420,11 +1420,19 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                     break;
 
                 case 6: /*RER*/
-                    TBD();
+                    HAS_OPTION(XTENSA_OPTION_EXTERN_REGS);
+                    if (gen_check_privilege(dc) &&
+                        gen_window_check2(dc, RRR_S, RRR_T)) {
+                        gen_helper_rer(cpu_R[RRR_T], cpu_env, cpu_R[RRR_S]);
+                    }
                     break;
 
                 case 7: /*WER*/
-                    TBD();
+                    HAS_OPTION(XTENSA_OPTION_EXTERN_REGS);
+                    if (gen_check_privilege(dc) &&
+                        gen_window_check2(dc, RRR_S, RRR_T)) {
+                        gen_helper_wer(cpu_env, cpu_R[RRR_T], cpu_R[RRR_S]);
+                    }
                     break;
 
                 case 8: /*ROTWw*/
-- 
2.1.4
