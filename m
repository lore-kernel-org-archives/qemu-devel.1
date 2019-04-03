Received: from eggs.gnu.org ([209.51.188.92]:48755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpM-00033P-H8
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpK-00009E-UN
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpK-00008M-LX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:38 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3so7586196pga.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:49 +0700
Message-Id: <20190403034358.21999-18-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/26] target/s390x: Convert to
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

Cc: qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |   5 +-
 target/s390x/cpu.c         |   5 +-
 target/s390x/excp_helper.c | 156 +++++++++++++++++++++----------------
 target/s390x/mem_helper.c  |  29 -------
 4 files changed, 94 insertions(+), 101 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 5f7901da5e..424e8ce406 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -263,8 +263,9 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
-int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 698dd9cb82..9dd94b1395 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -471,9 +471,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = s390_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = s390_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_s390_cpu;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index bc781c14c3..aeeaeb523d 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -74,20 +74,14 @@ void s390_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int rw, int mmu_idx)
-{
-    S390CPU *cpu = S390_CPU(cs);
-
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
-    /* On real machines this value is dropped into LowMem.  Since this
-       is userland, simply put this someplace that cpu_loop can find it.  */
-    cpu->env.__excp_addr = address;
-    return 1;
-}
-
 #else /* !CONFIG_USER_ONLY */
 
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    s390_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+
 static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
 {
     switch (mmu_idx) {
@@ -102,61 +96,6 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
-                              int rw, int mmu_idx)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    CPUS390XState *env = &cpu->env;
-    target_ulong vaddr, raddr;
-    uint64_t asc;
-    int prot;
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
-                  __func__, orig_vaddr, rw, mmu_idx);
-
-    vaddr = orig_vaddr;
-
-    if (mmu_idx < MMU_REAL_IDX) {
-        asc = cpu_mmu_idx_to_asc(mmu_idx);
-        /* 31-Bit mode */
-        if (!(env->psw.mask & PSW_MASK_64)) {
-            vaddr &= 0x7fffffff;
-        }
-        if (mmu_translate(env, vaddr, rw, asc, &raddr, &prot, true)) {
-            return 1;
-        }
-    } else if (mmu_idx == MMU_REAL_IDX) {
-        /* 31-Bit mode */
-        if (!(env->psw.mask & PSW_MASK_64)) {
-            vaddr &= 0x7fffffff;
-        }
-        if (mmu_translate_real(env, vaddr, rw, &raddr, &prot)) {
-            return 1;
-        }
-    } else {
-        abort();
-    }
-
-    /* check out of RAM access */
-    if (!address_space_access_valid(&address_space_memory, raddr,
-                                    TARGET_PAGE_SIZE, rw,
-                                    MEMTXATTRS_UNSPECIFIED)) {
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
-                      __func__, (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
-        return 1;
-    }
-
-    qemu_log_mask(CPU_LOG_MMU, "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
-            __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
-
-    tlb_set_page(cs, orig_vaddr & TARGET_PAGE_MASK, raddr, prot,
-                 mmu_idx, TARGET_PAGE_SIZE);
-
-    return 0;
-}
-
 static void do_program_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
@@ -577,3 +516,86 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 }
 
 #endif /* CONFIG_USER_ONLY */
+
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+#ifndef CONFIG_USER_ONLY
+    CPUS390XState *env = &cpu->env;
+    target_ulong vaddr, raddr;
+    uint64_t asc;
+    int prot, fail;
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
+                  __func__, address, access_type, mmu_idx);
+
+    vaddr = address;
+
+    if (mmu_idx < MMU_REAL_IDX) {
+        asc = cpu_mmu_idx_to_asc(mmu_idx);
+        /* 31-Bit mode */
+        if (!(env->psw.mask & PSW_MASK_64)) {
+            vaddr &= 0x7fffffff;
+        }
+        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
+    } else if (mmu_idx == MMU_REAL_IDX) {
+        /* 31-Bit mode */
+        if (!(env->psw.mask & PSW_MASK_64)) {
+            vaddr &= 0x7fffffff;
+        }
+        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
+    } else {
+        g_assert_not_reached();
+    }
+
+    /* check out of RAM access */
+    if (!fail &&
+        !address_space_access_valid(&address_space_memory, raddr,
+                                    TARGET_PAGE_SIZE, access_type,
+                                    MEMTXATTRS_UNSPECIFIED)) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
+                      __func__, (uint64_t)raddr, (uint64_t)ram_size);
+        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
+        fail = 1;
+    }
+
+    if (!fail) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
+                      __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
+        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
+#else
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
+    /*
+     * On real machines this value is dropped into LowMem.  Since this
+     * is userland, simply put this someplace that cpu_loop can find it.
+     */
+    cpu->env.__excp_addr = address;
+#endif
+
+    cpu_restore_state(cs, retaddr, true);
+
+    /*
+     * Note that handle_mmu_fault sets ilen to either 2 (for code)
+     * or AUTO (for data).  We can resolve AUTO now, as if it was
+     * set to UNWIND -- that will have been done via assignment
+     * in cpu_restore_state.  Otherwise re-examine access_type.
+     */
+    if (access_type == MMU_INST_FETCH) {
+        CPUS390XState *env = cs->env_ptr;
+        env->int_pgm_ilen = 2;
+    }
+
+    cpu_loop_exit(cs);
+}
+
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d54907696d..0c5ca36823 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -34,35 +34,6 @@
 
 /*****************************************************************************/
 /* Softmmu support */
-#if !defined(CONFIG_USER_ONLY)
-
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret = s390_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret != 0)) {
-        cpu_restore_state(cs, retaddr, true);
-
-        /*
-         * Note that handle_mmu_fault sets ilen to either 2 (for code)
-         * or AUTO (for data).  We can resolve AUTO now, as if it was
-         * set to UNWIND -- that will have been done via assignment
-         * in cpu_restore_state.  Otherwise re-examine access_type.
-         */
-        if (access_type == MMU_INST_FETCH) {
-            CPUS390XState *env = cs->env_ptr;
-            env->int_pgm_ilen = 2;
-        }
-
-        cpu_loop_exit(cs);
-    }
-}
-
-#endif
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
-- 
2.17.1
