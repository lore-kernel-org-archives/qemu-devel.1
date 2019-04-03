Received: from eggs.gnu.org ([209.51.188.92]:48471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWor-0002cK-1w
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWop-0007sc-QD
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWop-0007ob-HH
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id y3so7573750pgk.12
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:07 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:34 +0700
Message-Id: <20190403034358.21999-3-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/26] tcg: Add CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This hook will replace the (user-only mode specific) handle_mmu_fault
hook, and the (system mode specific) tlb_fill function.

The handle_mmu_fault hook was written as if there was a valid
way to recover from an mmu fault, and had 3 possible return states.
In reality, the only valid action is to raise an exception,
return to the main loop, and delver the SIGSEGV to the guest.

Using the hook for system mode requires that all targets be converted,
so for now the hook is (optionally) used only from user-only mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h     |  9 +++++++++
 accel/tcg/user-exec.c | 42 ++++++++++++++----------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1d6099e5d4..7e96a0aed3 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -119,6 +119,12 @@ struct TranslationBlock;
  *       will need to do more. If this hook is not implemented then the
  *       default is to call @set_pc(tb->pc).
  * @handle_mmu_fault: Callback for handling an MMU fault.
+ * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
+ *       address fault.  For system mode, if the access is valid, call
+ *       tlb_set_page and return true; if the access is invalid, and
+ *       probe is true, return false; otherwise raise an exception and
+ *       do not return.  For user-only mode, always raise an exception
+ *       and do not return.
  * @get_phys_page_debug: Callback for obtaining a physical address.
  * @get_phys_page_attrs_debug: Callback for obtaining a physical address and the
  *       associated memory transaction attributes to use for the access.
@@ -194,6 +200,9 @@ typedef struct CPUClass {
     void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
     int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_index);
+    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr);
     hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index fa9380a380..f13c0b2b67 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -65,6 +65,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     CPUClass *cc;
     int ret;
     unsigned long address = (unsigned long)info->si_addr;
+    MMUAccessType access_type;
 
     /* We must handle PC addresses from two different sources:
      * a call return address and a signal frame address.
@@ -151,40 +152,25 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
 #if TARGET_LONG_BITS == 32 && HOST_LONG_BITS == 64
     g_assert(h2g_valid(address));
 #endif
-
-    /* Convert forcefully to guest address space, invalid addresses
-       are still valid segv ones */
     address = h2g_nocheck(address);
 
-    cc = CPU_GET_CLASS(cpu);
-    /* see if it is an MMU fault */
-    g_assert(cc->handle_mmu_fault);
-    ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
-
-    if (ret == 0) {
-        /* The MMU fault was handled without causing real CPU fault.
-         *  Retain helper_retaddr for a possible second fault.
-         */
-        return 1;
-    }
-
-    /* All other paths lead to cpu_exit; clear helper_retaddr
-     * for next execution.
+    /*
+     * There is no way the target can handle this other than raising
+     * an exception.  Undo signal and retaddr state prior to longjmp.
      */
+    sigprocmask(SIG_SETMASK, old_set, NULL);
     helper_retaddr = 0;
 
-    if (ret < 0) {
-        return 0; /* not an MMU fault */
+    cc = CPU_GET_CLASS(cpu);
+    if (cc->tlb_fill) {
+        access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
+        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
+        g_assert_not_reached();
+    } else {
+        ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
+        g_assert(ret > 0);
+        cpu_loop_exit_restore(cpu, pc);
     }
-
-    /* Now we have a real cpu fault.  */
-    cpu_restore_state(cpu, pc, true);
-
-    sigprocmask(SIG_SETMASK, old_set, NULL);
-    cpu_loop_exit(cpu);
-
-    /* never comes here */
-    return 1;
 }
 
 #if defined(__i386__)
-- 
2.17.1
