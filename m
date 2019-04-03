Received: from eggs.gnu.org ([209.51.188.92]:48812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpU-0003Bn-G8
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpT-0000K7-2X
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:48 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpS-0000Iw-Pe
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:47 -0400
Received: by mail-pg1-x531.google.com with SMTP id u9so7575717pgo.7
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:53 +0700
Message-Id: <20190403034358.21999-22-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/26] target/tricore: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.h       |  6 +++---
 target/tricore/cpu.c       |  1 +
 target/tricore/helper.c    | 27 +++++++++++++++++++--------
 target/tricore/op_helper.c | 26 --------------------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 00e69dc154..5c0b8cb94c 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -418,8 +418,8 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
-int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
-                                 int rw, int mmu_idx);
-#define cpu_handle_mmu_fault cpu_tricore_handle_mmu_fault
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          bool probe, uintptr_t retaddr);
 
 #endif /* TRICORE_CPU_H */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e8d37e4040..ea1199d27e 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -166,6 +166,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
     cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
     cc->tcg_initialize = tricore_tcg_init;
+    cc->tlb_fill = tricore_cpu_tlb_fill;
 }
 
 #define DEFINE_TRICORE_CPU_TYPE(cpu_model, initfn) \
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 0769046993..3c99a8c22b 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -49,8 +49,9 @@ static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
 {
 }
 
-int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
-                                 int rw, int mmu_idx)
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                          MMUAccessType rw, int mmu_idx,
+                          bool probe, uintptr_t retaddr)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     CPUTriCoreState *env = &cpu->env;
@@ -63,20 +64,30 @@ int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
     access_type = ACCESS_INT;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, access_type);
-    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, physical, prot);
+
+    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical "
+                  TARGET_FMT_plx " prot %d\n",
+                  __func__, (target_ulong)address, ret, physical, prot);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        ret = 0;
-    } else if (ret < 0) {
+        return true;
+    } else {
+        assert(ret < 0);
+        if (probe) {
+            return false;
+        }
         raise_mmu_exception(env, address, rw, ret);
-        ret = 1;
+        cpu_loop_exit_restore(cs, retaddr);
     }
+}
 
-    return ret;
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    tricore_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ed9dc0c83e..601e92f92a 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2793,29 +2793,3 @@ uint32_t helper_psw_read(CPUTriCoreState *env)
 {
     return psw_read(env);
 }
-
-
-static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
-                                                        uint32_t exception,
-                                                        int error_code,
-                                                        uintptr_t pc)
-{
-    CPUState *cs = CPU(tricore_env_get_cpu(env));
-    cs->exception_index = exception;
-    env->error_code = error_code;
-    /* now we have a real cpu fault */
-    cpu_loop_exit_restore(cs, pc);
-}
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-    ret = cpu_tricore_handle_mmu_fault(cs, addr, access_type, mmu_idx);
-    if (ret) {
-        TriCoreCPU *cpu = TRICORE_CPU(cs);
-        CPUTriCoreState *env = &cpu->env;
-        do_raise_exception_err(env, cs->exception_index,
-                               env->error_code, retaddr);
-    }
-}
-- 
2.17.1
