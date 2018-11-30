Received: from eggs.gnu.org ([2001:4830:134:3::10]:60325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4r-0005PB-GZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4p-00043N-IJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:33 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:27 +0000
Message-ID: <20181130144705.77454-10-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json      | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   |  9 +++++++++
 block/file-posix.c        | 32 ++++++++++++++++++++++++++++++++
 block/qapi.c              |  5 +++++
 6 files changed, 86 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 959358ccc4..b100e852c7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -877,6 +877,41 @@
            '*x_wr_latency_histogram': 'BlockLatencyHistogramInfo',
            '*x_flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
=20
+##
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
+# Since: 4.0
+##
+{ 'struct': 'BlockStatsSpecificFile',
+  'data': {
+      'discard-nb-ok': 'int',
+      'discard-nb-failed': 'int',
+      'discard-bytes-ok': 'int' } }
+
+##
+# @BlockStatsSpecific:
+#
+# Block driver specific statistics
+#
+# Since: 4.0
+##
+{ 'union': 'BlockStatsSpecific',
+  'base': { 'driver': 'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+      'file': 'BlockStatsSpecificFile',
+      'host_device': 'BlockStatsSpecificFile' } }
+
 ##
 # @BlockStats:
 #
@@ -892,6 +927,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-specific: Optional driver-specific stats. (Since 4.0)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -905,6 +942,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-specific': 'BlockStatsSpecific',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
=20
diff --git a/include/block/block.h b/include/block/block.h
index 7f5453b45b..d6ee3e99c9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -478,6 +478,7 @@ const char *bdrv_get_device_or_node_name(const BlockDri=
verState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..236d4aceef 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,7 @@ struct BlockDriver {
                                   Error **errp);
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
=20
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 811239ca23..5540f4f187 100644
--- a/block.c
+++ b/block.c
@@ -4327,6 +4327,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDrive=
rState *bs)
     return NULL;
 }
=20
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs)
+{
+    BlockDriver *drv =3D bs->drv;
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
index 1589dbf3ab..9c686961bc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2660,6 +2660,36 @@ static int raw_get_info(BlockDriverState *bs, BlockD=
riverInfo *bdi)
     return 0;
 }
=20
+static BlockStatsSpecificFile get_blockstats_specific_file(BlockDriverStat=
e *bs)
+{
+    BDRVRawState *s =3D bs->opaque;
+    return (BlockStatsSpecificFile) {
+        .discard_nb_ok =3D s->stats.discard_nb_ok,
+        .discard_nb_failed =3D s->stats.discard_nb_failed,
+        .discard_bytes_ok =3D s->stats.discard_bytes_ok,
+    };
+}
+
+static BlockStatsSpecific *raw_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats =3D g_new(BlockStatsSpecific, 1);
+
+    stats->driver =3D BLOCKDEV_DRIVER_FILE;
+    stats->u.file =3D get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
+static BlockStatsSpecific *hdev_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats =3D g_new(BlockStatsSpecific, 1);
+
+    stats->driver =3D BLOCKDEV_DRIVER_HOST_DEVICE;
+    stats->u.host_device =3D get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
 static QemuOptsList raw_create_opts =3D {
     .name =3D "raw-create-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(raw_create_opts.head),
@@ -2771,6 +2801,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_get_info =3D raw_get_info,
     .bdrv_get_allocated_file_size
                         =3D raw_get_allocated_file_size,
+    .bdrv_get_specific_stats =3D raw_get_specific_stats,
     .bdrv_check_perm =3D raw_check_perm,
     .bdrv_set_perm   =3D raw_set_perm,
     .bdrv_abort_perm_update =3D raw_abort_perm_update,
@@ -3255,6 +3286,7 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_get_info =3D raw_get_info,
     .bdrv_get_allocated_file_size
                         =3D raw_get_allocated_file_size,
+    .bdrv_get_specific_stats =3D hdev_get_specific_stats,
     .bdrv_check_perm =3D raw_check_perm,
     .bdrv_set_perm   =3D raw_set_perm,
     .bdrv_abort_perm_update =3D raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index df31f351d2..74f762ea6c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -535,6 +535,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverSta=
te *bs,
=20
     s->stats->wr_highest_offset =3D stat64_get(&bs->wr_highest_offset);
=20
+    s->driver_specific =3D bdrv_get_specific_stats(bs);
+    if (s->driver_specific) {
+        s->has_driver_specific =3D true;
+    }
+
     if (bs->file) {
         s->has_parent =3D true;
         s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
--=20
2.17.1
