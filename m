Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzM0-0002fI-IZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLx-0008IW-Sp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:56 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLx-0008Hy-KO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:53 -0400
Received: by mail-pg0-x241.google.com with SMTP id q14-v6so7184903pgt.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:53 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:57 +0900
Message-Id: <20180702135806.7087-17-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 16/25] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

The code in cpu_mmu_index does not properly honor SR_DME.
This bug has workarounds elsewhere in that we flush the
tlb more often than necessary, on the state changes that
should be reflected in a change of mmu_index.

Fixing this means that we can respect the mmu_index that
is given to tlb_flush.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.h              | 23 +++++++++++++--------
 target/openrisc/interrupt.c        |  4 ----
 target/openrisc/interrupt_helper.c | 15 +++-----------
 target/openrisc/mmu.c              | 33 +++++++++++++++++++++++++++---
 target/openrisc/sys_helper.c       |  4 ----
 target/openrisc/translate.c        |  2 +-
 6 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index eaf6cdd40e..c3a968ec4d 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -385,9 +385,12 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 
 #include "exec/cpu-all.h"
 
-#define TB_FLAGS_DFLAG 1
-#define TB_FLAGS_R0_0  2
+#define TB_FLAGS_SM    SR_SM
+#define TB_FLAGS_DME   SR_DME
+#define TB_FLAGS_IME   SR_IME
 #define TB_FLAGS_OVE   SR_OVE
+#define TB_FLAGS_DFLAG 2      /* reuse SR_TEE */
+#define TB_FLAGS_R0_0  4      /* reuse SR_IEE */
 
 static inline uint32_t cpu_get_gpr(const CPUOpenRISCState *env, int i)
 {
@@ -405,17 +408,21 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->dflag
-              | (cpu_get_gpr(env, 0) == 0 ? TB_FLAGS_R0_0 : 0)
-              | (env->sr & SR_OVE));
+    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
+           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
+           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
 {
-    if (!(env->sr & SR_IME)) {
-        return MMU_NOMMU_IDX;
+    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
+
+    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
+        /* The mmu is enabled; test supervisor state.  */
+        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
     }
-    return (env->sr & SR_SM) == 0 ? MMU_USER_IDX : MMU_SUPERVISOR_IDX;
+
+    return ret;
 }
 
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 23abcf29ed..138ad17f00 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -51,10 +51,6 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         env->eear = env->pc;
     }
 
-    /* For machine-state changed between user-mode and supervisor mode,
-       we need flush TLB when we enter&exit EXCP.  */
-    tlb_flush(cs);
-
     env->esr = cpu_get_sr(env);
     env->sr &= ~SR_DME;
     env->sr &= ~SR_IME;
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index a2e9003969..9c5489f5f7 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -25,16 +25,7 @@
 
 void HELPER(rfe)(CPUOpenRISCState *env)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-#ifndef CONFIG_USER_ONLY
-    int need_flush_tlb = (cpu->env.sr & (SR_SM | SR_IME | SR_DME)) ^
-                         (cpu->env.esr & (SR_SM | SR_IME | SR_DME));
-    if (need_flush_tlb) {
-        CPUState *cs = CPU(cpu);
-        tlb_flush(cs);
-    }
-#endif
-    cpu->env.pc = cpu->env.epcr;
-    cpu->env.lock_addr = -1;
-    cpu_set_sr(&cpu->env, cpu->env.esr);
+    env->pc = env->epcr;
+    env->lock_addr = -1;
+    cpu_set_sr(env, env->esr);
 }
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 856969a7f2..b293b64e98 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -246,9 +246,36 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret = openrisc_cpu_handle_mmu_fault(cs, addr, size,
-                                            access_type, mmu_idx);
-    if (ret) {
+    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+    int ret, prot = 0;
+    hwaddr physical = 0;
+
+    if (mmu_idx == MMU_NOMMU_IDX) {
+        ret = get_phys_nommu(&physical, &prot, addr);
+    } else {
+        bool super = mmu_idx == MMU_SUPERVISOR_IDX;
+        if (access_type == MMU_INST_FETCH) {
+            ret = get_phys_code(cpu, &physical, &prot, addr, 2, super);
+        } else {
+            ret = get_phys_data(cpu, &physical, &prot, addr,
+                                access_type == MMU_DATA_STORE, super);
+        }
+    }
+
+    if (ret == TLBRET_MATCH) {
+        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
+                     physical & TARGET_PAGE_MASK, prot,
+                     mmu_idx, TARGET_PAGE_SIZE);
+    } else if (ret < 0) {
+        int rw;
+        if (access_type == MMU_INST_FETCH) {
+            rw = 2;
+        } else if (access_type == MMU_DATA_STORE) {
+            rw = 1;
+        } else {
+            rw = 0;
+        }
+        cpu_openrisc_raise_mmu_exception(cpu, addr, rw, ret);
         /* Raise Exception.  */
         cpu_loop_exit_restore(cs, retaddr);
     }
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index c9702cd26c..852b219f9b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -56,10 +56,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         break;
 
     case TO_SPR(0, 17): /* SR */
-        if ((env->sr & (SR_IME | SR_DME | SR_SM)) ^
-            (rb & (SR_IME | SR_DME | SR_SM))) {
-            tlb_flush(cs);
-        }
         cpu_set_sr(env, rb);
         break;
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 64b5e84630..a271cd3903 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -55,7 +55,7 @@ static inline bool is_user(DisasContext *dc)
 #ifdef CONFIG_USER_ONLY
     return true;
 #else
-    return dc->mem_idx == MMU_USER_IDX;
+    return !(dc->tb_flags & TB_FLAGS_SM);
 #endif
 }
 
-- 
2.17.0
