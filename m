Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4QK-0001fE-Dn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4QH-0007IY-8P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO4QH-0007IR-2V
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:05 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 May 2018 18:58:02 +0200
Message-Id: <20180530165802.13146-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] move public invalidate APIs out of
 translate-all.{c, h}, clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Place them in exec.c, exec-all.h and ram_addr.h.  This removes
knowledge of translate-all.h (which is an internal header) from
several files outside accel/tcg and removes knowledge of
AddressSpace from translate-all.c (as it only operates on ram_addr_t).

Locking becomes simpler, too, because the functions no longer have to
be called with tb_lock held.  The mmap_lock assertions are removed while
moving tb_invalidate_phys_range to exec.c, but I think that is okay
because the assertion is still there in tb_invalidate_phys_page_range;
it's only a small documentation loss.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        Patch on top of Peter's MemTxAttrs/IOMMU series.

 accel/tcg/translate-all.c | 58 +--------------------------------------
 accel/tcg/translate-all.h |  1 -
 exec.c                    | 52 ++++++++++++++++++++++++++++++++---
 include/exec/exec-all.h   |  8 +++---
 include/exec/ram_addr.h   |  2 ++
 linux-user/mmap.c         |  1 -
 target/xtensa/op_helper.c |  9 +-----
 trace/control-target.c    |  1 -
 8 files changed, 56 insertions(+), 76 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d48b56ca38..5b26d6c0c7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1396,40 +1396,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     return tb;
 }
 
-/*
- * Invalidate all TBs which intersect with the target physical address range
- * [start;end[. NOTE: start and end may refer to *different* physical pages.
- * 'is_cpu_write_access' should be true if called from a real cpu write
- * access: the virtual CPU will exit the current TB if code is modified inside
- * this TB.
- *
- * Called with mmap_lock held for user-mode emulation, grabs tb_lock
- * Called with tb_lock held for system-mode emulation
- */
-static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
-{
-    while (start < end) {
-        tb_invalidate_phys_page_range(start, end, 0);
-        start &= TARGET_PAGE_MASK;
-        start += TARGET_PAGE_SIZE;
-    }
-}
-
-#ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_tb_locked();
-    tb_invalidate_phys_range_1(start, end);
-}
-#else
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_memory_lock();
-    tb_lock();
-    tb_invalidate_phys_range_1(start, end);
-    tb_unlock();
-}
-#endif
 /*
  * Invalidate all TBs which intersect with the target physical address range
  * [start;end[. NOTE: start and end must refer to the *same* physical page.
@@ -1668,28 +1634,6 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
     return g_tree_lookup(tb_ctx.tb_tree, &s);
 }
 
-#if !defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
-{
-    ram_addr_t ram_addr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-
-    rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
-    if (!(memory_region_is_ram(mr)
-          || memory_region_is_romd(mr))) {
-        rcu_read_unlock();
-        return;
-    }
-    ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_lock();
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
-    tb_unlock();
-    rcu_read_unlock();
-}
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 /* Called with tb_lock held.  */
 void tb_check_watchpoint(CPUState *cpu)
 {
@@ -1710,7 +1654,7 @@ void tb_check_watchpoint(CPUState *cpu)
 
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         addr = get_page_addr_code(env, pc);
-        tb_invalidate_phys_range(addr, addr + 1);
+        tb_invalidate_phys_page_range(addr, addr + 1, 0);
     }
 }
 
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index ba8e4d63c4..4d51739d6c 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -26,7 +26,6 @@
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/exec.c b/exec.c
index d314c7cc39..f4b5fe8b08 100644
--- a/exec.c
+++ b/exec.c
@@ -880,16 +880,62 @@ const char *parse_cpu_model(const char *cpu_model)
     return cpu_type;
 }
 
+/*
+ * Invalidate all TBs which intersect with the target physical address range
+ * [start;end[. NOTE: start and end may refer to *different* physical pages.
+ * 'is_cpu_write_access' should be true if called from a real cpu write
+ * access: the virtual CPU will exit the current TB if code is modified inside
+ * this TB.
+ *
+ * Grabs tb_lock.
+ * Called with mmap_lock held for user-mode emulation.
+ */
+void tb_invalidate_phys_range(target_ulong start, target_ulong end)
+{
+    tb_lock();
+    while (start < end) {
+        tb_invalidate_phys_page_range(start, end, 0);
+        start &= TARGET_PAGE_MASK;
+        start += TARGET_PAGE_SIZE;
+    }
+    tb_unlock();
+}
+
 #if defined(CONFIG_USER_ONLY)
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
     tb_lock();
-    tb_invalidate_phys_page_range(pc, pc + 1, 0);
+    tb_invalidate_phys_page_range(addr, addr + 1, 0);
     tb_unlock();
     mmap_unlock();
 }
+
+static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+{
+    tb_invalidate_phys_addr(pc);
+}
 #else
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
+{
+    ram_addr_t ram_addr;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+
+    rcu_read_lock();
+    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
+    if (!(memory_region_is_ram(mr)
+          || memory_region_is_romd(mr))) {
+        rcu_read_unlock();
+        return;
+    }
+    ram_addr = memory_region_get_ram_addr(mr) + addr;
+    tb_lock();
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
+    tb_unlock();
+    rcu_read_unlock();
+}
+
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     MemTxAttrs attrs;
@@ -3024,9 +3070,7 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
-        tb_lock();
         tb_invalidate_phys_range(addr, addr + length);
-        tb_unlock();
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
     }
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4d09eaba72..f08d4759a2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -299,14 +299,14 @@ static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
 static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
 {
 }
+
 static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
-static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr,
-                                           MemTxAttrs attrs)
-{
-}
+
+void tb_invalidate_phys_addr(target_ulong addr);
+void tb_invalidate_phys_range(target_ulong start, target_ulong end);
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index cf2446a176..a1e8bdba1f 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -94,6 +94,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
+
 static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
                                                  ram_addr_t length,
                                                  unsigned client)
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9168a2051c..d0c50e4888 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -20,7 +20,6 @@
 
 #include "qemu.h"
 #include "qemu-common.h"
-#include "translate-all.h"
 
 //#define DEBUG_MMAP
 
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 8a8c763c63..bbbbb33f3c 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -36,11 +36,6 @@
 #include "qemu/timer.h"
 #include "fpu/softfloat.h"
 
-#ifdef CONFIG_USER_ONLY
-/* tb_invalidate_phys_range */
-#include "accel/tcg/translate-all.h"
-#endif
-
 #ifndef CONFIG_USER_ONLY
 
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
@@ -114,9 +109,7 @@ static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
 
 static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
 {
-    mmap_lock();
-    tb_invalidate_phys_range(vaddr, vaddr + 1);
-    mmap_unlock();
+    tb_invalidate_phys_addr(vaddr);
 }
 
 #endif
diff --git a/trace/control-target.c b/trace/control-target.c
index 706b2cee9d..ceb55c70ce 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -11,7 +11,6 @@
 #include "cpu.h"
 #include "trace-root.h"
 #include "trace/control.h"
-#include "translate-all.h"
 
 
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
-- 
2.17.0
