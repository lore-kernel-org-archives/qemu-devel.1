Received: from eggs.gnu.org ([2001:4830:134:3::10]:59597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pO-0003Ry-3b
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pK-0007P4-NH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:45:02 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 13 Jun 2018 20:44:26 +0300
Message-Id: <1528911866-37489-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 8/8] qapi: query-blockstat: add driver
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json      | 39 +++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   |  9 +++++++++
 block/file-posix.c        | 17 +++++++++++++++++
 block/qapi.c              |  5 +++++
 6 files changed, 72 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a859011..800cf2c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -886,6 +886,42 @@
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
+# Since 3.0
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
+# Since: 3.0
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
@@ -897,6 +933,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-specific: Optional driver-specific stats. (Since 3.0)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -910,6 +948,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-specific': 'BlockStatsSpecific',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
 
diff --git a/include/block/block.h b/include/block/block.h
index e677080..b263d8a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -445,6 +445,7 @@ const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 327e478..2456723 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -317,6 +317,7 @@ struct BlockDriver {
                                   Error **errp);
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 5088708..46c91c8 100644
--- a/block.c
+++ b/block.c
@@ -4172,6 +4172,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs)
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
index 4a2e394..0bc2cb6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2518,6 +2518,21 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
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
@@ -2623,6 +2638,7 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -3104,6 +3120,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index 2ee90d4..29b7898 100644
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
-- 
2.7.4
