Received: from eggs.gnu.org ([2001:4830:134:3::10]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhn-0002i1-4v
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhm-00054y-2c
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:63832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhl-00054f-O2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:26 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:44 +0800
Message-Id: <1484124524-481-7-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 6/6] migration: skip unused pages
 during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

After sending out the request for unused pages, live migration
process will start without waiting for the unused page bitmap is
ready. If the unused page bitmap is not ready when doing the 1st
migration_bitmap_sync() after ram_save_setup(), the unused page
bitmap will be ignored, this means the unused pages will not be
filtered out in this case.
The current implementation can not work with post copy, if post
copy is enabled, we simply ignore the unused pages. Will make it
work later.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 migration/ram.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a1c8089..f029512 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,6 +44,8 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "sysemu/balloon.h"
+#include "sysemu/kvm.h"
 
 #ifdef DEBUG_MIGRATION_RAM
 #define DPRINTF(fmt, ...) \
@@ -229,6 +231,8 @@ static QemuMutex migration_bitmap_mutex;
 static uint64_t migration_dirty_pages;
 static uint32_t last_version;
 static bool ram_bulk_stage;
+static bool ignore_unused_page;
+static uint64_t unused_page_req_id;
 
 /* used by the search for pages to send */
 struct PageSearchStatus {
@@ -245,6 +249,7 @@ static struct BitmapRcu {
     struct rcu_head rcu;
     /* Main migration bitmap */
     unsigned long *bmap;
+    unsigned long *unused_page_bmap;
     /* bitmap of pages that haven't been sent even once
      * only maintained and used in postcopy at the moment
      * where it's used to send the dirtymap at the start
@@ -637,6 +642,7 @@ static void migration_bitmap_sync(void)
     rcu_read_unlock();
     qemu_mutex_unlock(&migration_bitmap_mutex);
 
+    ignore_unused_page = true;
     trace_migration_bitmap_sync_end(migration_dirty_pages
                                     - num_dirty_pages_init);
     num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;
@@ -1483,6 +1489,76 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
     }
 }
 
+static void filter_out_unused_pages(unsigned long *raw_bmap, long nbits)
+{
+    long i, page_count = 0, len;
+    unsigned long *new_bmap;
+
+    tighten_guest_free_page_bmap(raw_bmap);
+    qemu_mutex_lock(&migration_bitmap_mutex);
+    new_bmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    slow_bitmap_complement(new_bmap, raw_bmap, nbits);
+
+    len = (last_ram_offset() >> TARGET_PAGE_BITS) / BITS_PER_LONG;
+    for (i = 0; i < len; i++) {
+        page_count += hweight_long(new_bmap[i]);
+    }
+
+    migration_dirty_pages = page_count;
+    qemu_mutex_unlock(&migration_bitmap_mutex);
+}
+
+static void ram_get_unused_pages(unsigned long *bmap, unsigned long max_pfn)
+{
+    BalloonReqStatus status;
+
+    unused_page_req_id++;
+    status = balloon_get_unused_pages(bmap, max_pfn / BITS_PER_BYTE,
+                                      unused_page_req_id);
+    if (status == REQ_START) {
+        ignore_unused_page = false;
+    }
+}
+
+static void ram_handle_unused_page(void)
+{
+    unsigned long nbits, req_id = 0;
+    RAMBlock *pc_ram_block;
+    BalloonReqStatus status;
+
+    status = balloon_unused_page_ready(&req_id);
+    switch (status) {
+    case REQ_DONE:
+        if (req_id != unused_page_req_id) {
+            return;
+        }
+        rcu_read_lock();
+        pc_ram_block = QLIST_FIRST_RCU(&ram_list.blocks);
+        nbits = pc_ram_block->used_length >> TARGET_PAGE_BITS;
+        filter_out_unused_pages(migration_bitmap_rcu->unused_page_bmap, nbits);
+        rcu_read_unlock();
+
+        qemu_mutex_lock_iothread();
+        migration_bitmap_sync();
+        qemu_mutex_unlock_iothread();
+        /*
+         * bulk stage assumes in (migration_bitmap_find_and_reset_dirty) that
+         * every page is dirty, that's no longer ture at this point.
+         */
+        ram_bulk_stage = false;
+        last_seen_block = NULL;
+        last_sent_block = NULL;
+        last_offset = 0;
+        break;
+    case REQ_ERROR:
+        ignore_unused_page = true;
+        error_report("failed to get unused page");
+        break;
+    default:
+        break;
+    }
+}
+
 /*
  * 'expected' is the value you expect the bitmap mostly to be full
  * of; it won't bother printing lines that are all this value.
@@ -1962,8 +2038,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
          }
     }
 
-    rcu_read_lock();
+    if (balloon_unused_pages_support() && !migrate_postcopy_ram()) {
+        unsigned long max_pfn = get_guest_max_pfn();
+        migration_bitmap_rcu->unused_page_bmap = bitmap_new(max_pfn);
+        ram_get_unused_pages(migration_bitmap_rcu->unused_page_bmap, max_pfn);
+    }
 
+    rcu_read_lock();
     qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
@@ -2004,6 +2085,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     while ((ret = qemu_file_rate_limit(f)) == 0) {
         int pages;
 
+        if (!ignore_unused_page) {
+            ram_handle_unused_page();
+        }
         pages = ram_find_and_save_block(f, false, &bytes_transferred);
         /* no more pages to sent */
         if (pages == 0) {
-- 
1.9.1
