Received: from eggs.gnu.org ([209.51.188.92]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpD-0002w3-Ma
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpC-0008QO-45
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpB-0008Po-PM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id 9so7415718pfj.13
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:45 +0700
Message-Id: <20190403034358.21999-14-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/26] target/nios2: Convert to
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
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h    |   5 +-
 target/nios2/cpu.c    |   5 +-
 target/nios2/helper.c | 181 ++++++++++++++++++++----------------------
 target/nios2/mmu.c    |  12 ---
 4 files changed, 92 insertions(+), 111 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 047f3764b7..b3e9595457 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -251,8 +251,9 @@ static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address, int size,
-                               int rw, int mmu_idx);
+bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 
 static inline int cpu_interrupts_enabled(CPUNios2State *env)
 {
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..186af4913d 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -200,9 +200,8 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = nios2_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = nios2_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = nios2_cpu_do_unaligned_access;
     cc->get_phys_page_debug = nios2_cpu_get_phys_page_debug;
 #endif
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index a8b8ec662a..d075ef1965 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -36,17 +36,6 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     env->regs[R_EA] = env->regs[R_PC] + 4;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    cs->exception_index = 0xaa;
-    /* Page 0x1000 is kuser helper */
-    if (address < 0x1000 || address >= 0x2000) {
-        cpu_dump_state(cs, stderr, fprintf, 0);
-    }
-    return 1;
-}
-
 #else /* !CONFIG_USER_ONLY */
 
 void nios2_cpu_do_interrupt(CPUState *cs)
@@ -190,89 +179,6 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-static int cpu_nios2_handle_virtual_page(
-    CPUState *cs, target_ulong address, int rw, int mmu_idx)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-    target_ulong vaddr, paddr;
-    Nios2MMULookup lu;
-    unsigned int hit;
-    hit = mmu_translate(env, &lu, address, rw, mmu_idx);
-    if (hit) {
-        vaddr = address & TARGET_PAGE_MASK;
-        paddr = lu.paddr + vaddr - lu.vaddr;
-
-        if (((rw == 0) && (lu.prot & PAGE_READ)) ||
-            ((rw == 1) && (lu.prot & PAGE_WRITE)) ||
-            ((rw == 2) && (lu.prot & PAGE_EXEC))) {
-
-            tlb_set_page(cs, vaddr, paddr, lu.prot,
-                         mmu_idx, TARGET_PAGE_SIZE);
-            return 0;
-        } else {
-            /* Permission violation */
-            cs->exception_index = (rw == 0) ? EXCP_TLBR :
-                                               ((rw == 1) ? EXCP_TLBW :
-                                                            EXCP_TLBX);
-        }
-    } else {
-        cs->exception_index = EXCP_TLBD;
-    }
-
-    if (rw == 2) {
-        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
-    } else {
-        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
-    }
-    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
-    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
-    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
-    env->regs[CR_BADADDR] = address;
-    return 1;
-}
-
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-
-    if (cpu->mmu_present) {
-        if (MMU_SUPERVISOR_IDX == mmu_idx) {
-            if (address >= 0xC0000000) {
-                /* Kernel physical page - TLB bypassed */
-                address &= TARGET_PAGE_MASK;
-                tlb_set_page(cs, address, address, PAGE_BITS,
-                             mmu_idx, TARGET_PAGE_SIZE);
-            } else if (address >= 0x80000000) {
-                /* Kernel virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            } else {
-                /* User virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            }
-        } else {
-            if (address >= 0x80000000) {
-                /* Illegal access from user mode */
-                cs->exception_index = EXCP_SUPERA;
-                env->regs[CR_BADADDR] = address;
-                return 1;
-            } else {
-                /* User virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            }
-        }
-    } else {
-        /* No MMU */
-        address &= TARGET_PAGE_MASK;
-        tlb_set_page(cs, address, address, PAGE_BITS,
-                     mmu_idx, TARGET_PAGE_SIZE);
-    }
-
-    return 0;
-}
-
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
@@ -308,4 +214,91 @@ void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     env->regs[CR_EXCEPTION] = EXCP_UNALIGN << 2;
     helper_raise_exception(env, EXCP_UNALIGN);
 }
+#endif /* CONFIG_USER_ONLY */
+
+bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    unsigned int excp = EXCP_TLBD;
+
+#ifndef CONFIG_USER_ONLY
+    target_ulong vaddr, paddr;
+    Nios2MMULookup lu;
+    unsigned int hit;
+
+    if (!cpu->mmu_present) {
+        /* No MMU */
+        address &= TARGET_PAGE_MASK;
+        tlb_set_page(cs, address, address, PAGE_BITS,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+
+    if (MMU_SUPERVISOR_IDX == mmu_idx) {
+        if (address >= 0xC0000000) {
+            /* Kernel physical page - TLB bypassed */
+            address &= TARGET_PAGE_MASK;
+            tlb_set_page(cs, address, address, PAGE_BITS,
+                         mmu_idx, TARGET_PAGE_SIZE);
+            return true;
+        }
+    } else {
+        if (address >= 0x80000000) {
+            /* Illegal access from user mode */
+            if (probe) {
+                return false;
+            }
+            cs->exception_index = EXCP_SUPERA;
+            env->regs[CR_BADADDR] = address;
+            cpu_loop_exit_restore(cs, retaddr);
+        }
+    }
+
+    /* Virtual page.  */
+    hit = mmu_translate(env, &lu, address, access_type, mmu_idx);
+    if (hit) {
+        vaddr = address & TARGET_PAGE_MASK;
+        paddr = lu.paddr + vaddr - lu.vaddr;
+
+        if (((access_type == MMU_DATA_LOAD) && (lu.prot & PAGE_READ)) ||
+            ((access_type == MMU_DATA_STORE) && (lu.prot & PAGE_WRITE)) ||
+            ((access_type == MMU_INST_FETCH) && (lu.prot & PAGE_EXEC))) {
+            tlb_set_page(cs, vaddr, paddr, lu.prot,
+                         mmu_idx, TARGET_PAGE_SIZE);
+            return true;
+        }
+
+        /* Permission violation */
+        excp = (access_type == MMU_DATA_LOAD ? EXCP_TLBR :
+                access_type == MMU_DATA_STORE ? EXCP_TLBW : EXCP_TLBX);
+    }
+
+    if (probe) {
+        return false;
+    }
+
+    if (access_type == MMU_INST_FETCH) {
+        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
+    } else {
+        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
+    }
+    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
+    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
+    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
 #endif /* !CONFIG_USER_ONLY */
+
+    cs->exception_index = excp;
+    env->regs[CR_BADADDR] = address;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    nios2_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 69b71cba4a..db85c8b7c4 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -35,18 +35,6 @@
 #define MMU_LOG(x)
 #endif
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = nios2_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 void mmu_read_debug(CPUNios2State *env, uint32_t rn)
 {
     switch (rn) {
-- 
2.17.1
