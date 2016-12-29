Received: from eggs.gnu.org ([2001:4830:134:3::10]:46955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cMWpS-0001L1-TT
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cMWpP-0003fZ-Mc
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:16:54 -0500
Received: from [59.151.112.132] (port=9204 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cMWpO-0003bP-Pj
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:16:51 -0500
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date: Thu, 29 Dec 2016 17:16:19 +0800
Message-ID: <20161229091619.31049-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC] migration: set cpu throttle value by
 workload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, izumi.taku@jp.fujitsu.com, Chao Fan <fanc.fnst@cn.fujitsu.com>

This RFC PATCH is my demo about the new feature, here is my POC mail:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00646.html

When migration_bitmap_sync executed, get the time and read bitmap to
calculate how many dirty pages born between two sync.
Use inst_dirty_pages / (time_now - time_prev) / ram_size to get
inst_dirty_pages_rate. Then map from the inst_dirty_pages_rate
to cpu throttle value. I have no idea how to map it. So I just do
that in a simple way. The mapping way is just a guess and should
be improved.

This is just a demo. There are more methods.
1.In another file, calculate the inst_dirty_pages_rate every second
  or two seconds or another fixed time. Then set the cpu throttle
  value according to the inst_dirty_pages_rate
2.When inst_dirty_pages_rate gets a threshold, begin cpu throttle
  and set the throttle value.

Any comments will be welcome.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 include/qemu/bitmap.h | 17 +++++++++++++++++
 migration/ram.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0..dc99f9b 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -235,4 +235,21 @@ static inline unsigned long *bitmap_zero_extend(unsigned long *old,
     return new;
 }
 
+static inline unsigned long bitmap_weight(const unsigned long *src, long nbits)
+{
+    unsigned long i, count = 0, nlong = nbits / BITS_PER_LONG;
+
+    if (small_nbits(nbits)) {
+        return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
+    }
+    for (i = 0; i < nlong; i++) {
+        count += hweight_long(src[i]);
+    }
+    if (nbits % BITS_PER_LONG) {
+        count += hweight_long(src[i] & BITMAP_LAST_WORD_MASK(nbits));
+    }
+
+    return count;
+}
+
 #endif /* BITMAP_H */
diff --git a/migration/ram.c b/migration/ram.c
index a1c8089..f96e3e3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,6 +44,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "hw/boards.h"
 
 #ifdef DEBUG_MIGRATION_RAM
 #define DPRINTF(fmt, ...) \
@@ -599,6 +600,9 @@ static int64_t num_dirty_pages_period;
 static uint64_t xbzrle_cache_miss_prev;
 static uint64_t iterations_prev;
 
+static int64_t dirty_pages_time_prev;
+static int64_t dirty_pages_time_now;
+
 static void migration_bitmap_sync_init(void)
 {
     start_time = 0;
@@ -606,6 +610,49 @@ static void migration_bitmap_sync_init(void)
     num_dirty_pages_period = 0;
     xbzrle_cache_miss_prev = 0;
     iterations_prev = 0;
+
+    dirty_pages_time_prev = 0;
+    dirty_pages_time_now = 0;
+}
+
+static void migration_inst_rate(void)
+{
+    RAMBlock *block;
+    MigrationState *s = migrate_get_current();
+    int64_t inst_dirty_pages_rate, inst_dirty_pages = 0;
+    int64_t i;
+    unsigned long *num;
+    unsigned long len = 0;
+
+    dirty_pages_time_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (dirty_pages_time_prev != 0) {
+        rcu_read_lock();
+        DirtyMemoryBlocks *blocks = atomic_rcu_read(
+                         &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
+        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+            if (len == 0) {
+                len = block->offset;
+            }
+            len += block->used_length;
+        }
+        ram_addr_t idx = (len >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        if (((len >> TARGET_PAGE_BITS) % DIRTY_MEMORY_BLOCK_SIZE) != 0) {
+            idx++;
+        }
+        for (i = 0; i < idx; i++) {
+            num = blocks->blocks[i];
+            inst_dirty_pages += bitmap_weight(num, DIRTY_MEMORY_BLOCK_SIZE);
+        }
+        rcu_read_unlock();
+
+        inst_dirty_pages_rate = inst_dirty_pages * TARGET_PAGE_SIZE *
+                            1024 * 1024 * 1000 /
+                            (dirty_pages_time_now - dirty_pages_time_prev) /
+                            current_machine->ram_size;
+        s->parameters.cpu_throttle_initial = inst_dirty_pages_rate / 200;
+        s->parameters.cpu_throttle_increment = inst_dirty_pages_rate / 200;
+    }
+    dirty_pages_time_prev = dirty_pages_time_now;
 }
 
 static void migration_bitmap_sync(void)
@@ -629,6 +676,8 @@ static void migration_bitmap_sync(void)
     trace_migration_bitmap_sync_start();
     memory_global_dirty_log_sync();
 
+    migration_inst_rate();
+
     qemu_mutex_lock(&migration_bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-- 
2.9.3
