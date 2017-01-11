Received: from eggs.gnu.org ([2001:4830:134:3::10]:45596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgp-0003XD-TO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgo-0003Xh-9L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:07 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:36391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgo-0003W2-00
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:06 -0500
Received: by mail-wj0-x243.google.com with SMTP id dh1so11694451wjb.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:36:05 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.36.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:36:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:22 +0100
Message-Id: <1484163327-111841-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/33] ramblock-notifier: new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This adds a notify interface of ram block additions and removals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                  |  5 ++++
 include/exec/memory.h   |  6 +----
 include/exec/ram_addr.h | 46 ++-----------------------------
 include/exec/ramlist.h  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 numa.c                  | 29 ++++++++++++++++++++
 xen-mapcache.c          |  3 +++
 6 files changed, 112 insertions(+), 49 deletions(-)
 create mode 100644 include/exec/ramlist.h

diff --git a/exec.c b/exec.c
index c95ae33..067c51b 100644
--- a/exec.c
+++ b/exec.c
@@ -1687,6 +1687,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DONTFORK);
+        ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
 
@@ -1817,6 +1818,10 @@ void qemu_ram_free(RAMBlock *block)
         return;
     }
 
+    if (block->host) {
+        ram_block_notify_remove(block->host, block->max_length);
+    }
+
     qemu_mutex_lock_ramlist();
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index bec9756..a10044f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -16,16 +16,12 @@
 
 #ifndef CONFIG_USER_ONLY
 
-#define DIRTY_MEMORY_VGA       0
-#define DIRTY_MEMORY_CODE      1
-#define DIRTY_MEMORY_MIGRATION 2
-#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
-
 #include "exec/cpu-common.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
 #include "exec/memattrs.h"
+#include "exec/ramlist.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
 #include "qemu/notify.h"
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 54d7108..3e79466 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,6 +21,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "hw/xen/xen.h"
+#include "exec/ramlist.h"
 
 struct RAMBlock {
     struct rcu_head rcu;
@@ -35,6 +36,7 @@ struct RAMBlock {
     char idstr[256];
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
+    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     size_t page_size;
 };
@@ -50,51 +52,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
     return (char *)block->host + offset;
 }
 
-/* The dirty memory bitmap is split into fixed-size blocks to allow growth
- * under RCU.  The bitmap for a block can be accessed as follows:
- *
- *   rcu_read_lock();
- *
- *   DirtyMemoryBlocks *blocks =
- *       atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
- *
- *   ram_addr_t idx = (addr >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
- *   unsigned long *block = blocks.blocks[idx];
- *   ...access block bitmap...
- *
- *   rcu_read_unlock();
- *
- * Remember to check for the end of the block when accessing a range of
- * addresses.  Move on to the next block if you reach the end.
- *
- * Organization into blocks allows dirty memory to grow (but not shrink) under
- * RCU.  When adding new RAMBlocks requires the dirty memory to grow, a new
- * DirtyMemoryBlocks array is allocated with pointers to existing blocks kept
- * the same.  Other threads can safely access existing blocks while dirty
- * memory is being grown.  When no threads are using the old DirtyMemoryBlocks
- * anymore it is freed by RCU (but the underlying blocks stay because they are
- * pointed to from the new DirtyMemoryBlocks).
- */
-#define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
-typedef struct {
-    struct rcu_head rcu;
-    unsigned long *blocks[];
-} DirtyMemoryBlocks;
-
-typedef struct RAMList {
-    QemuMutex mutex;
-    RAMBlock *mru_block;
-    /* RCU-enabled, writes protected by the ramlist lock. */
-    QLIST_HEAD(, RAMBlock) blocks;
-    DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
-    uint32_t version;
-} RAMList;
-extern RAMList ram_list;
-
 ram_addr_t last_ram_offset(void);
-void qemu_mutex_lock_ramlist(void);
-void qemu_mutex_unlock_ramlist(void);
-
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
                                    Error **errp);
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
new file mode 100644
index 0000000..c59880d
--- /dev/null
+++ b/include/exec/ramlist.h
@@ -0,0 +1,72 @@
+#ifndef RAMLIST_H
+#define RAMLIST_H
+
+#include "qemu/queue.h"
+#include "qemu/thread.h"
+#include "qemu/rcu.h"
+
+typedef struct RAMBlockNotifier RAMBlockNotifier;
+
+#define DIRTY_MEMORY_VGA       0
+#define DIRTY_MEMORY_CODE      1
+#define DIRTY_MEMORY_MIGRATION 2
+#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
+
+/* The dirty memory bitmap is split into fixed-size blocks to allow growth
+ * under RCU.  The bitmap for a block can be accessed as follows:
+ *
+ *   rcu_read_lock();
+ *
+ *   DirtyMemoryBlocks *blocks =
+ *       atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
+ *
+ *   ram_addr_t idx = (addr >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+ *   unsigned long *block = blocks.blocks[idx];
+ *   ...access block bitmap...
+ *
+ *   rcu_read_unlock();
+ *
+ * Remember to check for the end of the block when accessing a range of
+ * addresses.  Move on to the next block if you reach the end.
+ *
+ * Organization into blocks allows dirty memory to grow (but not shrink) under
+ * RCU.  When adding new RAMBlocks requires the dirty memory to grow, a new
+ * DirtyMemoryBlocks array is allocated with pointers to existing blocks kept
+ * the same.  Other threads can safely access existing blocks while dirty
+ * memory is being grown.  When no threads are using the old DirtyMemoryBlocks
+ * anymore it is freed by RCU (but the underlying blocks stay because they are
+ * pointed to from the new DirtyMemoryBlocks).
+ */
+#define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
+typedef struct {
+    struct rcu_head rcu;
+    unsigned long *blocks[];
+} DirtyMemoryBlocks;
+
+typedef struct RAMList {
+    QemuMutex mutex;
+    RAMBlock *mru_block;
+    /* RCU-enabled, writes protected by the ramlist lock. */
+    QLIST_HEAD(, RAMBlock) blocks;
+    DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
+    uint32_t version;
+    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+} RAMList;
+extern RAMList ram_list;
+
+void qemu_mutex_lock_ramlist(void);
+void qemu_mutex_unlock_ramlist(void);
+
+struct RAMBlockNotifier {
+    void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size);
+    void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size);
+    QLIST_ENTRY(RAMBlockNotifier) next;
+};
+
+void ram_block_notifier_add(RAMBlockNotifier *n);
+void ram_block_notifier_remove(RAMBlockNotifier *n);
+void ram_block_notify_add(void *host, size_t size);
+void ram_block_notify_remove(void *host, size_t size);
+
+
+#endif /* RAMLIST_H */
diff --git a/numa.c b/numa.c
index 9c09e45..81f29f4 100644
--- a/numa.c
+++ b/numa.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
+#include "exec/ramlist.h"
 #include "qemu/bitmap.h"
 #include "qom/cpu.h"
 #include "qemu/error-report.h"
@@ -562,3 +563,31 @@ int numa_get_node_for_cpu(int idx)
     }
     return i;
 }
+
+void ram_block_notifier_add(RAMBlockNotifier *n)
+{
+    QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
+}
+
+void ram_block_notifier_remove(RAMBlockNotifier *n)
+{
+    QLIST_REMOVE(n, next);
+}
+
+void ram_block_notify_add(void *host, size_t size)
+{
+    RAMBlockNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
+        notifier->ram_block_added(notifier, host, size);
+    }
+}
+
+void ram_block_notify_remove(void *host, size_t size)
+{
+    RAMBlockNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
+        notifier->ram_block_removed(notifier, host, size);
+    }
+}
diff --git a/xen-mapcache.c b/xen-mapcache.c
index 8f3a592..31debdf 100644
--- a/xen-mapcache.c
+++ b/xen-mapcache.c
@@ -163,6 +163,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     err = g_malloc0(nb_pfn * sizeof (int));
 
     if (entry->vaddr_base != NULL) {
+        ram_block_notify_remove(entry->vaddr_base, entry->size);
         if (munmap(entry->vaddr_base, entry->size) != 0) {
             perror("unmap fails");
             exit(-1);
@@ -188,6 +189,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     entry->valid_mapping = (unsigned long *) g_malloc0(sizeof(unsigned long) *
             BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
 
+    ram_block_notify_add(entry->vaddr_base, entry->size);
     bitmap_zero(entry->valid_mapping, nb_pfn);
     for (i = 0; i < nb_pfn; i++) {
         if (!err[i]) {
@@ -397,6 +399,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     }
 
     pentry->next = entry->next;
+    ram_block_notify_remove(entry->vaddr_base, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
-- 
1.8.3.1
