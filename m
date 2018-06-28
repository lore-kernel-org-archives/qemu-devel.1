Received: from eggs.gnu.org ([2001:4830:134:3::10]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAN-00072q-4v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAL-0008QF-KL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:19 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAK-0008NG-Ux
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:17 -0400
Received: by mail-wr0-x244.google.com with SMTP id p1-v6so6688307wrs.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:16 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:12 +0200
Message-Id: <1530216310-52873-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/60] move public invalidate APIs out of
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

Place them in exec.c, exec-all.h and ram_addr.h.  This removes
knowledge of translate-all.h (which is an internal header) from
several files outside accel/tcg and removes knowledge of
AddressSpace from translate-all.c (as it only operates on ram_addr_t).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 28 ++++++----------------------
 accel/tcg/translate-all.h |  1 -
 exec.c                    | 29 +++++++++++++++++++++++++----
 include/exec/exec-all.h   |  8 ++++----
 include/exec/ram_addr.h   |  2 ++
 linux-user/mmap.c         |  1 -
 target/xtensa/op_helper.c |  9 +--------
 trace/control-target.c    |  1 -
 8 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f0c3fd4..4b601bd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -46,7 +46,7 @@
 #endif
 #endif
 #else
-#include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
 #endif
 
 #include "exec/cputlb.h"
@@ -1934,7 +1934,11 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
  *
  * Called with mmap_lock held for user-mode emulation.
  */
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
+#ifdef CONFIG_SOFTMMU
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end)
+#else
+void tb_invalidate_phys_range(target_ulong start, target_ulong end)
+#endif
 {
     struct page_collection *pages;
     tb_page_addr_t next;
@@ -2073,26 +2077,6 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 }
 #endif
 
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
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
-    rcu_read_unlock();
-}
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 /* user-mode: call with mmap_lock held */
 void tb_check_watchpoint(CPUState *cpu)
 {
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index e6cb963..08e2f23 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -30,7 +30,6 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
                                   tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/exec.c b/exec.c
index 9f35e34..610d0c0 100644
--- a/exec.c
+++ b/exec.c
@@ -1028,13 +1028,36 @@ const char *parse_cpu_model(const char *cpu_model)
 }
 
 #if defined(CONFIG_USER_ONLY)
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
-    tb_invalidate_phys_page_range(pc, pc + 1, 0);
+    tb_invalidate_phys_page_range(addr, addr + 1, 0);
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
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
+    rcu_read_unlock();
+}
+
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     MemTxAttrs attrs;
@@ -3146,9 +3169,7 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
-        mmap_lock();
         tb_invalidate_phys_range(addr, addr + length);
-        mmap_unlock();
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
     }
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 25a6f28..6a7e7a8 100644
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
index 33c361c..cf4ce06 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -93,6 +93,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
+
 static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
                                                  ram_addr_t length,
                                                  unsigned client)
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9168a20..d0c50e4 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -20,7 +20,6 @@
 
 #include "qemu.h"
 #include "qemu-common.h"
-#include "translate-all.h"
 
 //#define DEBUG_MMAP
 
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 8a8c763..bbbbb33 100644
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
index 706b2ce..ceb55c7 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -11,7 +11,6 @@
 #include "cpu.h"
 #include "trace-root.h"
 #include "trace/control.h"
-#include "translate-all.h"
 
 
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
-- 
1.8.3.1
