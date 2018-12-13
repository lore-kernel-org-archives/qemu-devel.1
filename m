Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXasT-0000UQ-TT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXasP-00077J-Sj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:58:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:37791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gXasP-000743-IG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:58:45 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2018 10:58:02 +1100
Message-Id: <20181213235804.14956-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] memory_ldst: Add atomic ops for PTE updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On some architectures, PTE updates for dirty and changed bits need
to be performed atomically. This adds a couple of address_space_cmpxchg*
helpers for that purpose.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/exec/memory_ldst.inc.h |  6 +++
 memory_ldst.inc.c              | 78 ++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.inc.h
index 272c20f02e..f3cfa7e9a6 100644
--- a/include/exec/memory_ldst.inc.h
+++ b/include/exec/memory_ldst.inc.h
@@ -28,6 +28,12 @@ extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
+    MemTxResult *result);
+extern uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
+    MemTxResult *result);
 extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index acf865b900..7ab6de37ba 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -320,6 +320,84 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
+/* This is meant to be used for atomic PTE updates under MT-TCG */
+uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 4;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+
+    /* Must test result */
+    assert(result);
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < 4 || !memory_access_is_direct(mr, true)) {
+        r = MEMTX_ERROR;
+    } else {
+        uint32_t orig = old;
+
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+        old = atomic_cmpxchg(ptr, orig, new);
+
+        if (old == orig) {
+            dirty_log_mask = memory_region_get_dirty_log_mask(mr);
+            dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+            cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+                                                4, dirty_log_mask);
+        }
+        r = MEMTX_OK;
+    }
+    *result = r;
+    RCU_READ_UNLOCK();
+
+    return old;
+}
+
+#ifdef CONFIG_ATOMIC64
+/* This is meant to be used for atomic PTE updates under MT-TCG */
+uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 8;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+
+    /* Must test result */
+    assert(result);
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < 8 || !memory_access_is_direct(mr, true)) {
+        r = MEMTX_ERROR;
+    } else {
+        uint32_t orig = old;
+
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+        old = atomic_cmpxchg(ptr, orig, new);
+
+        if (old == orig) {
+            dirty_log_mask = memory_region_get_dirty_log_mask(mr);
+            dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+            cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+                                                8, dirty_log_mask);
+        }
+        r = MEMTX_OK;
+    }
+    *result = r;
+    RCU_READ_UNLOCK();
+
+    return old;
+}
+#endif /* CONFIG_ATOMIC64 */
+
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
-- 
2.19.2
