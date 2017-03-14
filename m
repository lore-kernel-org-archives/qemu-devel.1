Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnbgk-0007hu-S9
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnbgg-000811-Ao
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:55:50 -0400
Received: from [59.151.112.132] (port=54519 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnbgf-0007xV-G9
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:55:46 -0400
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 09:55:07 +0800
Message-ID: <20170314015507.13350-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] Change the method to calculate
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Chao Fan <fanc.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

In function cpu_physical_memory_sync_dirty_bitmap, file
include/exec/ram_addr.h:

if (src[idx][offset]) {
    unsigned long bits = atomic_xchg(&src[idx][offset], 0);
    unsigned long new_dirty;
    new_dirty = ~dest[k];
    dest[k] |= bits;
    new_dirty &= bits;
    num_dirty += ctpopl(new_dirty);
}

After these codes executed, only the pages not dirtied in bitmap(dest),
but dirtied in dirty_memory[DIRTY_MEMORY_MIGRATION] will be calculated.
For example:
When ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] = 0b00001111,
and atomic_rcu_read(&migration_bitmap_rcu)->bmap = 0b00000011,
the new_dirty will be 0b00001100, and this function will return 2 but not
4 which is expected.
the dirty pages in dirty_memory[DIRTY_MEMORY_MIGRATION] are all new,
so these should be calculated also.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
v2: Remove the parameter 'num_dirty_pages_init'
    Fix incoming parameters of trace_migration_bitmap_sync_end
---
 include/exec/ram_addr.h |  5 ++++-
 migration/ram.c         | 12 +++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index cd432e7..b05dc84 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -355,7 +355,8 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
                                                ram_addr_t start,
-                                               ram_addr_t length)
+                                               ram_addr_t length,
+                                               int64_t *real_dirty_pages)
 {
     ram_addr_t addr;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
@@ -379,6 +380,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
             if (src[idx][offset]) {
                 unsigned long bits = atomic_xchg(&src[idx][offset], 0);
                 unsigned long new_dirty;
+                *real_dirty_pages += ctpopl(bits);
                 new_dirty = ~dest[k];
                 dest[k] |= bits;
                 new_dirty &= bits;
@@ -398,6 +400,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
                         start + addr,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
+                *real_dirty_pages += 1;
                 long k = (start + addr) >> TARGET_PAGE_BITS;
                 if (!test_and_set_bit(k, dest)) {
                     num_dirty++;
diff --git a/migration/ram.c b/migration/ram.c
index 719425b..de1e0a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -576,18 +576,18 @@ static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
     return ret;
 }
 
+static int64_t num_dirty_pages_period;
 static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
 {
     unsigned long *bitmap;
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    migration_dirty_pages +=
-        cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
+    migration_dirty_pages += cpu_physical_memory_sync_dirty_bitmap(bitmap,
+                             start, length, &num_dirty_pages_period);
 }
 
 /* Fix me: there are too many global variables used in migration process. */
 static int64_t start_time;
 static int64_t bytes_xfer_prev;
-static int64_t num_dirty_pages_period;
 static uint64_t xbzrle_cache_miss_prev;
 static uint64_t iterations_prev;
 
@@ -620,7 +620,6 @@ uint64_t ram_pagesize_summary(void)
 static void migration_bitmap_sync(void)
 {
     RAMBlock *block;
-    uint64_t num_dirty_pages_init = migration_dirty_pages;
     MigrationState *s = migrate_get_current();
     int64_t end_time;
     int64_t bytes_xfer_now;
@@ -646,9 +645,8 @@ static void migration_bitmap_sync(void)
     rcu_read_unlock();
     qemu_mutex_unlock(&migration_bitmap_mutex);
 
-    trace_migration_bitmap_sync_end(migration_dirty_pages
-                                    - num_dirty_pages_init);
-    num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;
+    trace_migration_bitmap_sync_end(num_dirty_pages_period);
+
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     /* more than 1 second = 1000 millisecons */
-- 
2.9.3
