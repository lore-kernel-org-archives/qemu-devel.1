Received: from eggs.gnu.org ([2001:4830:134:3::10]:41840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P6-0003Kr-Ol
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P1-0007bn-NI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:52 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1P1-0007bS-G5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:47 -0400
Received: by mail-pf0-x236.google.com with SMTP id g13so718624pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:19:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:19:38 -0700
Message-Id: <20170907181938.3948-5-richard.henderson@linaro.org>
In-Reply-To: <20170907181938.3948-1-richard.henderson@linaro.org>
References: <20170907181938.3948-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 4/4] target/alpha: Switch to
 do_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

Switch the alpha target from the old unassigned_access hook
to the new do_transaction_failed hook. This allows us to
resolve a ??? in the old hook implementation.

The only part of the alpha target that does physical
memory accesses is reading the page table -- add a
TODO comment there to the effect that we should handle
bus faults on page table walks. (Since the palcode
doesn't actually do anything useful on a bus fault anyway
it's a bit moot for now.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c        |  2 +-
 target/alpha/cpu.h        |  8 +++++---
 target/alpha/helper.c     |  8 ++++++++
 target/alpha/mem_helper.c | 19 ++++++++++---------
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1ea597b9dd..e6c6aabdf0 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -297,7 +297,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
 #else
-    cc->do_unassigned_access = alpha_cpu_unassigned_access;
+    cc->do_transaction_failed = alpha_cpu_do_transaction_failed;
     cc->do_unaligned_access = alpha_cpu_do_unaligned_access;
     cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_alpha_cpu;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 0738e97d6d..6ae240969b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -486,9 +486,11 @@ void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val);
 uint64_t cpu_alpha_load_gr(CPUAlphaState *env, unsigned reg);
 void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);
 #ifndef CONFIG_USER_ONLY
-QEMU_NORETURN void alpha_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                               bool is_write, bool is_exec,
-                                               int unused, unsigned size);
+void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 #endif
 
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 34121f4cad..36407f77f5 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -163,6 +163,14 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     pt = env->ptbr;
 
+    /* TODO: rather than using ldq_phys() to read the page table we should
+     * use address_space_ldq() so that we can handle the case when
+     * the page table read gives a bus fault, rather than ignoring it.
+     * For the existing code the zero data that ldq_phys will return for
+     * an access to invalid memory will result in our treating the page
+     * table as invalid, which may even be the right behaviour.
+     */
+
     /* L1 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
     L1pte = ldq_phys(cs->as, pt + index*8);
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 78a7d45590..3c06baa93a 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -49,22 +49,23 @@ void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit(cs);
 }
 
-void alpha_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                 bool is_write, bool is_exec, int unused,
-                                 unsigned size)
+void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
 
+    if (retaddr) {
+        cpu_restore_state(cs, retaddr);
+    }
+
     env->trap_arg0 = addr;
-    env->trap_arg1 = is_write ? 1 : 0;
+    env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
     cs->exception_index = EXCP_MCHK;
     env->error_code = 0;
-
-    /* ??? We should cpu_restore_state to the faulting insn, but this hook
-       does not have access to the retaddr value from the original helper.
-       It's all moot until the QEMU PALcode grows an MCHK handler.  */
-
     cpu_loop_exit(cs);
 }
 
-- 
2.13.5
