Received: from eggs.gnu.org ([2001:4830:134:3::10]:49586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d6YDe-0000M0-QW
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d6YDZ-00006G-UA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:04:06 -0400
From: jemmy858585@gmail.com
Date: Fri,  5 May 2017 16:03:49 +0800
Message-Id: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v4] migration/block: move bdrv_is_allocated()
 into bb's AioContext
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

when block migration with high-speed, mig_save_device_bulk hold the
BQL and invoke bdrv_is_allocated frequently. This patch moves
bdrv_is_allocated() into bb's AioContext. It will execute without
blocking other I/O activity.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
     v4 changelog:
          Use the prototype code written by Stefan and fix some bug.
          moves bdrv_is_allocated() into bb's AioContext.
---
 migration/block.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 060087f..c871361 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -263,6 +263,30 @@ static void blk_mig_read_cb(void *opaque, int ret)
     blk_mig_unlock();
 }
 
+typedef struct {
+    int64_t *total_sectors;
+    int64_t *cur_sector;
+    BlockBackend *bb;
+    QemuEvent event;
+} MigNextAllocatedClusterData;
+
+static void coroutine_fn mig_next_allocated_cluster(void *opaque)
+{
+    MigNextAllocatedClusterData *data = opaque;
+    int nr_sectors;
+
+    /* Skip unallocated sectors; intentionally treats failure as
+     * an allocated sector */
+    while (*data->cur_sector < *data->total_sectors &&
+           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
+                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
+        *data->cur_sector += nr_sectors;
+    }
+
+    bdrv_dec_in_flight(blk_bs(data->bb));
+    qemu_event_set(&data->event);
+}
+
 /* Called with no lock taken.  */
 
 static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
@@ -274,17 +298,23 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     int nr_sectors;
 
     if (bmds->shared_base) {
+        AioContext *bb_ctx;
+        Coroutine *co;
+        MigNextAllocatedClusterData data = {
+            .cur_sector = &cur_sector,
+            .total_sectors = &total_sectors,
+            .bb = bb,
+        };
+        qemu_event_init(&data.event, false);
+
         qemu_mutex_lock_iothread();
-        aio_context_acquire(blk_get_aio_context(bb));
-        /* Skip unallocated sectors; intentionally treats failure as
-         * an allocated sector */
-        while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector,
-                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
-            cur_sector += nr_sectors;
-        }
-        aio_context_release(blk_get_aio_context(bb));
+        bdrv_inc_in_flight(blk_bs(bb));
+        bb_ctx = blk_get_aio_context(bb);
+        co = qemu_coroutine_create(mig_next_allocated_cluster, &data);
+        aio_co_schedule(bb_ctx, co);
         qemu_mutex_unlock_iothread();
+
+        qemu_event_wait(&data.event);
     }
 
     if (cur_sector >= total_sectors) {
-- 
1.8.3.1
