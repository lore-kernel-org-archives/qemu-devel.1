Received: from eggs.gnu.org ([2001:4830:134:3::10]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpIA-0002jV-Kc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpI5-0003tR-Vu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:30 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 20 Nov 2017 19:51:04 +0300
Message-Id: <1511196664-85304-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 7/7] qapi: query-blockstat: add driver specific
 file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json      | 37 +++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   |  9 +++++++++
 block/file-posix.c        | 21 +++++++++++++++++++++
 block/qapi.c              |  5 +++++
 6 files changed, 74 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ba2705d..aefccf6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -765,6 +765,40 @@
            'timed_stats': ['BlockDeviceTimedStats'] } }
 
 ##
+# @BlockDriverStatsFile:
+#
+# File driver statistics
+#
+# @discard_nb_ok: The number of succeeded discard operations performed by
+#                 the driver.
+#
+# @discard_nb_failed: The number of failed discard operations performed by
+#                     the driver.
+#
+# @discard_bytes_ok: The number of bytes discarded by the driver.
+#
+# Since 2.12
+##
+{ 'struct': 'BlockDriverStatsFile',
+  'data': {
+      'discard_nb_ok': 'int',
+      'discard_nb_failed': 'int',
+      'discard_bytes_ok': 'int'
+  } }
+
+##
+# @BlockDriverStats:
+#
+# Statistics of a block driver (driver-specific)
+#
+# Since: 2.12
+##
+{ 'union': 'BlockDriverStats',
+  'data': {
+      'file': 'BlockDriverStatsFile'
+  } }
+
+##
 # @BlockStats:
 #
 # Statistics of a virtual block device or a block backing device.
@@ -776,6 +810,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-stats: Optional driver-specific statistics. (Since 2.12)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -789,6 +825,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-stats': 'BlockDriverStats',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
 
diff --git a/include/block/block.h b/include/block/block.h
index c05cac5..e6baead 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -473,6 +473,7 @@ const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
+BlockDriverStats *bdrv_get_driver_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a548277..a127861 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -269,6 +269,7 @@ struct BlockDriver {
                                   Error **errp);
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
+    BlockDriverStats *(*bdrv_get_stats)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 6c8ef98..7e5822f 100644
--- a/block.c
+++ b/block.c
@@ -4016,6 +4016,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs)
     return NULL;
 }
 
+BlockDriverStats *bdrv_get_driver_stats(BlockDriverState *bs)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv || !drv->bdrv_get_stats) {
+        return NULL;
+    }
+    return drv->bdrv_get_stats(bs);
+}
+
 void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 {
     if (!bs || !bs->drv || !bs->drv->bdrv_debug_event) {
diff --git a/block/file-posix.c b/block/file-posix.c
index 544ae58..3ab92e6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2240,6 +2240,25 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static BlockDriverStats *raw_get_stats(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+    BlockDriverStats *stats = g_new(BlockDriverStats, 1);
+
+    *stats = (BlockDriverStats){
+        .type  = BLOCK_DRIVER_STATS_KIND_FILE,
+        .u.file.data = g_new(BlockDriverStatsFile, 1),
+    };
+
+    *stats->u.file.data = (BlockDriverStatsFile){
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
@@ -2312,6 +2331,7 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_stats  = raw_get_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -2790,6 +2810,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_stats  = raw_get_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index 6e110f2..4191e6c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -489,6 +489,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 
     s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
 
+    s->driver_stats = bdrv_get_driver_stats(bs);
+    if (s->driver_stats) {
+        s->has_driver_stats = true;
+    }
+
     if (bs->file) {
         s->has_parent = true;
         s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
-- 
2.7.4
