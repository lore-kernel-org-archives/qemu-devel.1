Received: from eggs.gnu.org ([2001:4830:134:3::10]:43870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cvhEj-0004YB-Jv
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cvhEf-0004zi-Jf
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:28:21 -0400
From: jemmy858585@gmail.com
Date: Wed,  5 Apr 2017 17:27:58 +0800
Message-Id: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

when migration with high speed, mig_save_device_bulk invoke
bdrv_is_allocated too frequently, and cause vnc reponse slowly.
this patch limit the time used for bdrv_is_allocated.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/block.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..dbce931 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -39,6 +39,7 @@
 #define MAX_IS_ALLOCATED_SEARCH 65536
 
 #define MAX_INFLIGHT_IO 512
+#define BIG_DELAY 500000
 
 //#define DEBUG_BLK_MIGRATION
 
@@ -110,6 +111,7 @@ typedef struct BlkMigState {
     int transferred;
     int prev_progress;
     int bulk_completed;
+    int64_t time_ns_used;
 
     /* Lock must be taken _inside_ the iothread lock and any AioContexts.  */
     QemuMutex lock;
@@ -272,16 +274,32 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     BlockBackend *bb = bmds->blk;
     BlkMigBlock *blk;
     int nr_sectors;
+    uint64_t ts1, ts2;
+    int ret = 0;
+    bool timeout_flag = false;
 
     if (bmds->shared_base) {
         qemu_mutex_lock_iothread();
         aio_context_acquire(blk_get_aio_context(bb));
         /* Skip unallocated sectors; intentionally treats failure as
          * an allocated sector */
-        while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector,
-                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
-            cur_sector += nr_sectors;
+        while (cur_sector < total_sectors) {
+            ts1 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
+                                    MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
+            ts2 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+
+            block_mig_state.time_ns_used += ts2 - ts1;
+
+            if (!ret) {
+                cur_sector += nr_sectors;
+                if (block_mig_state.time_ns_used > BIG_DELAY) {
+                    timeout_flag = true;
+                    break;
+                }
+            } else {
+                break;
+            }
         }
         aio_context_release(blk_get_aio_context(bb));
         qemu_mutex_unlock_iothread();
@@ -292,6 +310,11 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
         return 1;
     }
 
+    if (timeout_flag) {
+        bmds->cur_sector = bmds->completed_sectors = cur_sector;
+        return 0;
+    }
+
     bmds->completed_sectors = cur_sector;
 
     cur_sector &= ~((int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK - 1);
@@ -756,6 +779,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     }
 
     blk_mig_reset_dirty_cursor();
+    block_mig_state.time_ns_used = 0;
 
     /* control the rate of transfer */
     blk_mig_lock();
@@ -764,7 +788,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
            qemu_file_get_rate_limit(f) &&
            (block_mig_state.submitted +
             block_mig_state.read_done) <
-           MAX_INFLIGHT_IO) {
+           MAX_INFLIGHT_IO &&
+           block_mig_state.time_ns_used <= BIG_DELAY) {
         blk_mig_unlock();
         if (block_mig_state.bulk_completed == 0) {
             /* first finish the bulk phase */
-- 
1.8.3.1
