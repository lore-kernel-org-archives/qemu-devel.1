Received: from eggs.gnu.org ([209.51.188.92]:48622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp6-0002qx-Q5
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp5-0008JO-Br
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWp5-0008Ii-0K
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:23 -0400
Received: by mail-pf1-x442.google.com with SMTP id 188so7431706pfd.8
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:42 +0700
Message-Id: <20190403034358.21999-11-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/26] target/microblaze: Convert to
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |   5 +-
 target/microblaze/cpu.c       |   5 +-
 target/microblaze/helper.c    | 142 +++++++++++++++++-----------------
 target/microblaze/op_helper.c |  19 -----
 4 files changed, 78 insertions(+), 93 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 792bbc97c7..8660c7673b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -375,8 +375,9 @@ static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                            int mmu_idx);
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5596cd5485..0ea549910b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -304,9 +304,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = mb_cpu_set_pc;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = mb_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = mb_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_transaction_failed = mb_cpu_transaction_failed;
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
 #endif
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index bc753793ec..2d1d10e6cf 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -26,7 +26,78 @@
 
 #define D(x)
 
-#if defined(CONFIG_USER_ONLY)
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = &cpu->env;
+
+#ifndef CONFIG_USER_ONLY
+    uint32_t vaddr, paddr;
+    struct microblaze_mmu_lookup lu;
+    unsigned int hit;
+    int prot;
+
+    if (mmu_idx == MMU_NOMMU_IDX) {
+        /* MMU disabled or not available.  */
+        address &= TARGET_PAGE_MASK;
+        prot = PAGE_BITS;
+        tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+
+    hit = mmu_translate(&env->mmu, &lu, address, access_type, mmu_idx);
+    if (likely(hit)) {
+        vaddr = address & TARGET_PAGE_MASK;
+        paddr = lu.paddr + vaddr - lu.vaddr;
+
+        qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
+                      mmu_idx, vaddr, paddr, lu.prot);
+        tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+
+    /* TLB miss.  */
+    if (probe) {
+        return false;
+    }
+
+    qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
+                  mmu_idx, address);
+
+    switch (lu.err) {
+    case ERR_PROT:
+        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
+        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        break;
+    case ERR_MISS:
+        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 19 : 18;
+        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (cs->exception_index == EXCP_MMU) {
+        cpu_abort(cs, "recursive faults\n");
+    }
+#endif
+
+    env->sregs[SR_EAR] = address;
+    cs->exception_index = EXCP_MMU;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    mb_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
+
+#ifdef CONFIG_USER_ONLY
 
 void mb_cpu_do_interrupt(CPUState *cs)
 {
@@ -38,74 +109,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->regs[14] = env->sregs[SR_PC];
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                            int mmu_idx)
-{
-    cs->exception_index = 0xaa;
-    cpu_dump_state(cs, stderr, fprintf, 0);
-    return 1;
-}
-
-#else /* !CONFIG_USER_ONLY */
-
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                            int mmu_idx)
-{
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
-    unsigned int hit;
-    int r = 1;
-    int prot;
-
-    /* Translate if the MMU is available and enabled.  */
-    if (mmu_idx != MMU_NOMMU_IDX) {
-        uint32_t vaddr, paddr;
-        struct microblaze_mmu_lookup lu;
-
-        hit = mmu_translate(&env->mmu, &lu, address, rw, mmu_idx);
-        if (hit) {
-            vaddr = address & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
-
-            qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
-                    mmu_idx, vaddr, paddr, lu.prot);
-            tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
-            r = 0;
-        } else {
-            env->sregs[SR_EAR] = address;
-            qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
-                                        mmu_idx, address);
-
-            switch (lu.err) {
-                case ERR_PROT:
-                    env->sregs[SR_ESR] = rw == 2 ? 17 : 16;
-                    env->sregs[SR_ESR] |= (rw == 1) << 10;
-                    break;
-                case ERR_MISS:
-                    env->sregs[SR_ESR] = rw == 2 ? 19 : 18;
-                    env->sregs[SR_ESR] |= (rw == 1) << 10;
-                    break;
-                default:
-                    abort();
-                    break;
-            }
-
-            if (cs->exception_index == EXCP_MMU) {
-                cpu_abort(cs, "recursive faults\n");
-            }
-
-            /* TLB miss.  */
-            cs->exception_index = EXCP_MMU;
-        }
-    } else {
-        /* MMU disabled or not available.  */
-        address &= TARGET_PAGE_MASK;
-        prot = PAGE_BITS;
-        tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
-        r = 0;
-    }
-    return r;
-}
+#else
 
 void mb_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index e23dcfdc20..b5dbb90d05 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -28,25 +28,6 @@
 
 #define D(x)
 
-#if !defined(CONFIG_USER_ONLY)
-
-/* Try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = mb_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-#endif
-
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
 {
     int test = ctrl & STREAM_TEST;
-- 
2.17.1
