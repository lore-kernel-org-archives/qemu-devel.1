Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPBW-0002GZ-Ol
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPBR-0008Pc-Sz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:50:46 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  7 Feb 2018 15:50:37 +0300
Message-Id: <20180207125037.13510-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180207125037.13510-1-vsementsov@virtuozzo.com>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qapi: add block latency histogram
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, vsementsov@virtuozzo.com

Set (and clear) histogram through new command
block-latency-histogram-set and show new statistics in
query-blockstats results.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/qapi.c         | 31 ++++++++++++++++++++++
 blockdev.c           | 19 ++++++++++++++
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8225308904..74fe3fe9c4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -451,6 +451,74 @@
            'status': 'DirtyBitmapStatus'} }
 
 ##
+# @BlockLatencyHistogramInfo:
+#
+# Block latency histogram.
+#
+# @latency: list of latency points in microseconds. Matches the @latency
+#           parameter from the last call to block-latency-histogram-set for the
+#           given device.
+#
+# @read: list of read-request counts corresponding to latency region.
+#        len(@read) = len(@latency) + 1
+#        @read[0] corresponds to latency region [0, @latency[0])
+#        for 0 < i < len(@latency): @read[i] corresponds to latency region
+#            [@latency[i-1], @latency[i])
+#        @read.last_element corresponds to latency region
+#            [@latency.last_element, +inf)
+#
+# @write: list of write-request counts (see @read semantics)
+#
+# @flush: list of flush-request counts (see @read semantics)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockLatencyHistogramInfo',
+  'data': {'latency': ['uint64'],
+           'read': ['uint64'],
+           'write': ['uint64'],
+           'flush': ['uint64'] } }
+
+##
+# @block-latency-histogram-set:
+#
+# Remove old latency histogram (if exist) and (optionally) create a new one.
+# Add a latency histogram to block device. If a latency histogram already
+# exists for the device it will be removed and a new one created. The latency
+# histogram may be queried through query-blockstats.
+# Set, restart or clear latency histogram.
+#
+# @device: device name to set latency histogram for.
+#
+# @latency: If unspecified, the latency histogram will be removed (if exists).
+#           Otherwise it should be list of latency points in microseconds. Old
+#           latency histogram will be removed (if exists) and a new one will be
+#           created. The sequence must be ascending, elements must be greater
+#           than zero. Histogram latency regions would be
+#           [0, @latency[0]), ..., [@latency[i], @latency[i+1]), ...,
+#           [@latency.last_element, +inf)
+#
+# Returns: error if device is not found or latency arrays is invalid.
+#
+# Since: 2.12
+#
+# Example (set new latency histogram):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0",
+#                     "latency": [500000, 1000000, 2000000] } }
+# <- { "return": {} }
+#
+# Example (remove latency histogram):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0" } }
+# <- { "return": {} }
+##
+{ 'command': 'block-latency-histogram-set',
+  'data': {'device': 'str', '*latency': ['uint64'] } }
+
+##
 # @BlockInfo:
 #
 # Block device information.  This structure describes a virtual device and
@@ -730,6 +798,8 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
+# @latency-histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
@@ -742,7 +812,8 @@
            'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
            'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
-           'timed_stats': ['BlockDeviceTimedStats'] } }
+           'timed_stats': ['BlockDeviceTimedStats'],
+           '*latency-histogram': 'BlockLatencyHistogramInfo' } }
 
 ##
 # @BlockStats:
diff --git a/block/qapi.c b/block/qapi.c
index fc10f0a565..715ed17a6b 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -389,6 +389,24 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
     qapi_free_BlockInfo(info);
 }
 
+static uint64List *uint64_list(uint64_t *list, int size)
+{
+    int i;
+    uint64List *out_list = NULL;
+    uint64List **pout_list = &out_list;
+
+    for (i = 0; i < size; i++) {
+        uint64List *entry = g_new(uint64List, 1);
+        entry->value = list[i];
+        *pout_list = entry;
+        pout_list = &entry->next;
+    }
+
+    *pout_list = NULL;
+
+    return out_list;
+}
+
 static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 {
     BlockAcctStats *stats = blk_get_stats(blk);
@@ -454,6 +472,19 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
         dev_stats->avg_wr_queue_depth =
             block_acct_queue_depth(ts, BLOCK_ACCT_WRITE);
     }
+
+    ds->has_latency_histogram = stats->latency_histogram.points != NULL;
+    if (ds->has_latency_histogram) {
+        BlockLatencyHistogramInfo *info = g_new0(BlockLatencyHistogramInfo, 1);
+        BlockLatencyHistogram *h = &stats->latency_histogram;
+
+        ds->latency_histogram = info;
+
+        info->latency = uint64_list(h->points, h->size - 1);
+        info->read = uint64_list(h->histogram[BLOCK_ACCT_READ], h->size);
+        info->write = uint64_list(h->histogram[BLOCK_ACCT_WRITE], h->size);
+        info->flush = uint64_list(h->histogram[BLOCK_ACCT_FLUSH], h->size);
+    }
 }
 
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index 8e977eef11..5fa3fafc8b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4176,6 +4176,25 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
+void qmp_block_latency_histogram_set(const char *device, bool has_latency,
+                                     uint64List *latency, Error **errp)
+{
+    BlockBackend *blk = blk_by_name(device);
+    if (!blk) {
+        error_setg(errp, "Device '%s' not found", device);
+        return;
+    }
+
+    if (has_latency) {
+        if (block_latency_histogram_set(blk_get_stats(blk), latency) < 0) {
+            error_setg(errp, "Invalid latency array");
+            return;
+        }
+    } else {
+        block_latency_histogram_clear(blk_get_stats(blk));
+    }
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
-- 
2.11.1
