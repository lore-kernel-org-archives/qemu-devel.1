Received: from eggs.gnu.org ([209.51.188.92]:48570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp0-0002lM-PU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWoz-0008CA-FK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:45149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWoz-0008An-5e
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id y3so7573902pgk.12
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:39 +0700
Message-Id: <20190403034358.21999-8-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/26] target/i386: Convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

We do not support probing, but we do not need it yet either.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h         |  5 ++--
 target/i386/cpu.c         |  5 ++--
 target/i386/excp_helper.c | 61 +++++++++++++++++++++++++--------------
 target/i386/mem_helper.c  | 21 --------------
 4 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 83fb522554..1ce070ceb9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1655,8 +1655,9 @@ void host_cpuid(uint32_t function, uint32_t count,
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
-int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr, int size,
-                             int is_write, int mmu_idx);
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..237bd88710 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5866,9 +5866,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = x86_cpu_gdb_write_register;
     cc->get_arch_id = x86_cpu_get_arch_id;
     cc->get_paging_enabled = x86_cpu_get_paging_enabled;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = x86_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = x86_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
     cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 49231f6b69..6f59b7bafc 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -137,26 +137,7 @@ void raise_exception_ra(CPUX86State *env, int exception_index, uintptr_t retaddr
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
 
-#if defined(CONFIG_USER_ONLY)
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
-                             int is_write, int mmu_idx)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    /* user mode only emulation */
-    is_write &= 1;
-    env->cr[2] = addr;
-    env->error_code = (is_write << PG_ERROR_W_BIT);
-    env->error_code |= PG_ERROR_U_MASK;
-    cs->exception_index = EXCP0E_PAGE;
-    env->exception_is_int = 0;
-    env->exception_next_eip = -1;
-    return 1;
-}
-
-#else
-
+#if !defined(CONFIG_USER_ONLY)
 static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
                         int *prot)
 {
@@ -365,8 +346,8 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
  * 0  = nothing more to do
  * 1  = generate PF fault
  */
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
-                             int is_write1, int mmu_idx)
+static int handle_mmu_fault(CPUState *cs, vaddr addr, int size,
+                            int is_write1, int mmu_idx)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -691,3 +672,39 @@ do_check_protect_pse36:
     return 1;
 }
 #endif
+
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+#ifdef CONFIG_USER_ONLY
+    /* user mode only emulation */
+    env->cr[2] = addr;
+    env->error_code = (access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT;
+    env->error_code |= PG_ERROR_U_MASK;
+    cs->exception_index = EXCP0E_PAGE;
+    env->exception_is_int = 0;
+    env->exception_next_eip = -1;
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    env->retaddr = retaddr;
+    if (handle_mmu_fault(cs, addr, size, access_type, mmu_idx)) {
+        /* FIXME: On error in get_hphys we have already jumpped out.  */
+        g_assert(!probe);
+        raise_exception_err_ra(env, cs->exception_index,
+                               env->error_code, retaddr);
+    }
+    return true;
+#endif
+}
+
+#if !defined(CONFIG_USER_ONLY)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    x86_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 6cc53bcb40..1885df29d2 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
         raise_exception_ra(env, EXCP05_BOUND, GETPC());
     }
 }
-
-#if !defined(CONFIG_USER_ONLY)
-/* try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    int ret;
-
-    env->retaddr = retaddr;
-    ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        raise_exception_err_ra(env, cs->exception_index, env->error_code, retaddr);
-    }
-}
-#endif
-- 
2.17.1
