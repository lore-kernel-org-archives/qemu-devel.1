Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3Fe-000422-V6
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3Fa-00086L-5D
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:47:02 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:19 +0300
Message-Id: <1534844779-118784-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json       | 39 +++++++++++++++++++++++++++++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 +++++++++
 block/file-posix.c         | 17 +++++++++++++++++
 block/qapi.c               |  5 +++++
 tests/qemu-iotests/227.out | 18 ++++++++++++++++++
 7 files changed, 90 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 19d4743..9cac2aa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -878,6 +878,42 @@
            '*x_flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
 
 ##
+# @BlockStatsSpecificFile:
+#
+# File driver statistics
+#
+# @discard-nb-ok: The number of succeeded discard operations performed by
+#                 the driver.
+#
+# @discard-nb-failed: The number of failed discard operations performed by
+#                     the driver.
+#
+# @discard-bytes-ok: The number of bytes discarded by the driver.
+#
+# Since 3.1
+##
+{ 'struct': 'BlockStatsSpecificFile',
+  'data': {
+      'discard-nb-ok': 'int',
+      'discard-nb-failed': 'int',
+      'discard-bytes-ok': 'int'
+  } }
+
+##
+# @BlockStatsSpecific:
+#
+# Block driver specific statistics
+#
+# Since: 3.1
+##
+{ 'union': 'BlockStatsSpecific',
+  'base': { 'driver': 'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+      'file': 'BlockStatsSpecificFile'
+  } }
+
+##
 # @BlockStats:
 #
 # Statistics of a virtual block device or a block backing device.
@@ -892,6 +928,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-specific: Optional driver-specific stats. (Since 3.1)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -905,6 +943,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-specific': 'BlockStatsSpecific',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
 
diff --git a/include/block/block.h b/include/block/block.h
index 4e0871a..cbfd831 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -478,6 +478,7 @@ const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 903b9c1..3ffe2e1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,7 @@ struct BlockDriver {
                                   Error **errp);
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 6161dbe..0ce4f4d 100644
--- a/block.c
+++ b/block.c
@@ -4200,6 +4200,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs)
     return NULL;
 }
 
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv || !drv->bdrv_get_specific_stats) {
+        return NULL;
+    }
+    return drv->bdrv_get_specific_stats(bs);
+}
+
 void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 {
     if (!bs || !bs->drv || !bs->drv->bdrv_debug_event) {
diff --git a/block/file-posix.c b/block/file-posix.c
index c420f76..cc46ef8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2623,6 +2623,21 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static BlockStatsSpecific *raw_get_specific_stats(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+    BlockStatsSpecific *stats = g_new(BlockStatsSpecific, 1);
+
+    stats->driver = BLOCKDEV_DRIVER_FILE;
+    stats->u.file = (BlockStatsSpecificFile){
+        .discard_nb_ok = s->stats.discard_nb_ok,
+        .discard_nb_failed = s->stats.discard_nb_failed,
+        .discard_bytes_ok = s->stats.discard_bytes_ok,
+    };
+
+    return stats;
+}
+
 static QemuOptsList raw_create_opts = {
     .name = "raw-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(raw_create_opts.head),
@@ -2734,6 +2749,7 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -3219,6 +3235,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index df31f35..74f762e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -535,6 +535,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 
     s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
 
+    s->driver_specific = bdrv_get_specific_stats(bs);
+    if (s->driver_specific) {
+        s->has_driver_specific = true;
+    }
+
     if (bs->file) {
         s->has_parent = true;
         s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index 736f2e3..62a9dba 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -15,6 +15,8 @@ Testing: -drive driver=null-co,if=virtio
         {
             "device": "virtio0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -24,13 +26,17 @@ Testing: -drive driver=null-co,if=virtio
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -73,6 +79,8 @@ Testing: -drive driver=null-co,if=none
         {
             "device": "none0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -82,13 +90,17 @@ Testing: -drive driver=null-co,if=none
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -160,6 +172,8 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,i
         {
             "device": "",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -169,13 +183,17 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,i
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": false,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": false,
                 "rd_operations": 0,
-- 
2.7.4
