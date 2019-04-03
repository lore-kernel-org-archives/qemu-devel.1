Received: from eggs.gnu.org ([209.51.188.92]:48774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpO-00035f-GS
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpM-0000B3-VD
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpM-0000AM-Jd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id cv12so7314086plb.9
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:50 +0700
Message-Id: <20190403034358.21999-19-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/26] target/sh4: Convert to CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h       |   5 +-
 target/sh4/cpu.c       |   5 +-
 target/sh4/helper.c    | 197 ++++++++++++++++++++---------------------
 target/sh4/op_helper.c |  12 ---
 4 files changed, 101 insertions(+), 118 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 775b5743bf..80a256e0be 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -244,8 +244,9 @@ void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 void sh4_translate_init(void);
 int cpu_sh4_signal_handler(int host_signum, void *pinfo,
                            void *puc);
-int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                                int mmu_idx);
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr);
 
 void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b9f393b7c7..886483caaa 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -238,9 +238,8 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = superh_cpu_synchronize_from_tb;
     cc->gdb_read_register = superh_cpu_gdb_read_register;
     cc->gdb_write_register = superh_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = superh_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = superh_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = superh_cpu_do_unaligned_access;
     cc->get_phys_page_debug = superh_cpu_get_phys_page_debug;
 #endif
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2ff0cf4060..1df1e02a14 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -27,43 +27,6 @@
 #include "hw/sh4/sh_intc.h"
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-
-void superh_cpu_do_interrupt(CPUState *cs)
-{
-    cs->exception_index = -1;
-}
-
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
-{
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
-
-    env->tea = address;
-    cs->exception_index = -1;
-    switch (rw) {
-    case 0:
-        cs->exception_index = 0x0a0;
-        break;
-    case 1:
-        cs->exception_index = 0x0c0;
-        break;
-    case 2:
-        cs->exception_index = 0x0a0;
-        break;
-    }
-    return 1;
-}
-
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
-{
-    /* For user mode, only U0 area is cacheable. */
-    return !(addr & 0x80000000);
-}
-
-#else /* !CONFIG_USER_ONLY */
-
 #define MMU_OK                   0
 #define MMU_ITLB_MISS            (-1)
 #define MMU_ITLB_MULTIPLE        (-2)
@@ -79,6 +42,21 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
 #define MMU_DADDR_ERROR_READ     (-12)
 #define MMU_DADDR_ERROR_WRITE    (-13)
 
+#if defined(CONFIG_USER_ONLY)
+
+void superh_cpu_do_interrupt(CPUState *cs)
+{
+    cs->exception_index = -1;
+}
+
+int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
+{
+    /* For user mode, only U0 area is cacheable. */
+    return !(addr & 0x80000000);
+}
+
+#else /* !CONFIG_USER_ONLY */
+
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -458,69 +436,6 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
     return get_mmu_address(env, physical, prot, address, rw, access_type);
 }
 
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
-{
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
-    target_ulong physical;
-    int prot, ret, access_type;
-
-    access_type = ACCESS_INT;
-    ret =
-	get_physical_address(env, &physical, &prot, address, rw,
-			     access_type);
-
-    if (ret != MMU_OK) {
-	env->tea = address;
-	if (ret != MMU_DTLB_MULTIPLE && ret != MMU_ITLB_MULTIPLE) {
-	    env->pteh = (env->pteh & PTEH_ASID_MASK) |
-		    (address & PTEH_VPN_MASK);
-	}
-	switch (ret) {
-	case MMU_ITLB_MISS:
-	case MMU_DTLB_MISS_READ:
-            cs->exception_index = 0x040;
-	    break;
-	case MMU_DTLB_MULTIPLE:
-	case MMU_ITLB_MULTIPLE:
-            cs->exception_index = 0x140;
-	    break;
-	case MMU_ITLB_VIOLATION:
-            cs->exception_index = 0x0a0;
-	    break;
-	case MMU_DTLB_MISS_WRITE:
-            cs->exception_index = 0x060;
-	    break;
-	case MMU_DTLB_INITIAL_WRITE:
-            cs->exception_index = 0x080;
-	    break;
-	case MMU_DTLB_VIOLATION_READ:
-            cs->exception_index = 0x0a0;
-	    break;
-	case MMU_DTLB_VIOLATION_WRITE:
-            cs->exception_index = 0x0c0;
-	    break;
-	case MMU_IADDR_ERROR:
-	case MMU_DADDR_ERROR_READ:
-            cs->exception_index = 0x0e0;
-	    break;
-	case MMU_DADDR_ERROR_WRITE:
-            cs->exception_index = 0x100;
-	    break;
-	default:
-            cpu_abort(cs, "Unhandled MMU fault");
-	}
-	return 1;
-    }
-
-    address &= TARGET_PAGE_MASK;
-    physical &= TARGET_PAGE_MASK;
-
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
-    return 0;
-}
-
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -745,7 +660,6 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
         if (needs_tlb_flush) {
             tlb_flush_page(CPU(sh_env_get_cpu(s)), vpn << 10);
         }
-        
     } else {
         int index = (addr & 0x00003f00) >> 8;
         tlb_t * entry = &s->utlb[index];
@@ -885,3 +799,84 @@ bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    CPUSH4State *env = &cpu->env;
+    int ret;
+
+#ifdef CONFIG_USER_ONLY
+    ret = (access_type == MMU_DATA_STORE ? MMU_DTLB_VIOLATION_WRITE :
+           access_type == MMU_INST_FETCH ? MMU_ITLB_VIOLATION :
+           MMU_DTLB_VIOLATION_READ);
+#else
+    target_ulong physical;
+    int prot, sh_access_type;
+
+    sh_access_type = ACCESS_INT;
+    ret = get_physical_address(env, &physical, &prot, address,
+                               access_type, sh_access_type);
+
+    if (ret == MMU_OK) {
+        address &= TARGET_PAGE_MASK;
+        physical &= TARGET_PAGE_MASK;
+        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
+
+    if (ret != MMU_DTLB_MULTIPLE && ret != MMU_ITLB_MULTIPLE) {
+        env->pteh = (env->pteh & PTEH_ASID_MASK) | (address & PTEH_VPN_MASK);
+    }
+#endif
+
+    env->tea = address;
+    switch (ret) {
+    case MMU_ITLB_MISS:
+    case MMU_DTLB_MISS_READ:
+        cs->exception_index = 0x040;
+        break;
+    case MMU_DTLB_MULTIPLE:
+    case MMU_ITLB_MULTIPLE:
+        cs->exception_index = 0x140;
+        break;
+    case MMU_ITLB_VIOLATION:
+        cs->exception_index = 0x0a0;
+        break;
+    case MMU_DTLB_MISS_WRITE:
+        cs->exception_index = 0x060;
+        break;
+    case MMU_DTLB_INITIAL_WRITE:
+        cs->exception_index = 0x080;
+        break;
+    case MMU_DTLB_VIOLATION_READ:
+        cs->exception_index = 0x0a0;
+        break;
+    case MMU_DTLB_VIOLATION_WRITE:
+        cs->exception_index = 0x0c0;
+        break;
+    case MMU_IADDR_ERROR:
+    case MMU_DADDR_ERROR_READ:
+        cs->exception_index = 0x0e0;
+        break;
+    case MMU_DADDR_ERROR_WRITE:
+        cs->exception_index = 0x100;
+        break;
+    default:
+        cpu_abort(cs, "Unhandled MMU fault");
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    superh_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4f825bae5a..599731966b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -41,18 +41,6 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = superh_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 #endif
 
 void helper_ldtlb(CPUSH4State *env)
-- 
2.17.1
