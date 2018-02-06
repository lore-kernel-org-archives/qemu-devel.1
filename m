Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uG-0003As-UK
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uB-0004FN-07
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:32 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  6 Feb 2018 17:07:22 +0300
Message-Id: <20180206140722.10110-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180206140722.10110-1-vsementsov@virtuozzo.com>
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: add block latency histogram interface
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
 qapi/block-core.json | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/qapi.c         | 31 ++++++++++++++++++++++++++
 blockdev.c           | 15 +++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8225308904..4706a934d9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -451,6 +451,63 @@
            'status': 'DirtyBitmapStatus'} }
 
 ##
+# @BlockLatencyHistogramInfo:
+#
+# Block latency histogram.
+#
+# @latency: list of latency points in microseconds. Equals to @latency parameter
+#           of last called block-latency-histogram-set.
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
+# Add latency histogram to block device. If latency histogram alredy exists for
+# the device it will be removed and a new one created. Latency histogram may be
+# quered through query-blockstats.
+#
+# @device: device name to set latency histogram for.
+#
+# @latency: list of latency points in microseconds. The sequcence must be
+#           ascending, elements must be greater than zero. Histogram latency
+#           regions would be
+#           [0, @latency[0]), ..., [@latency[i], @latency[i+1]), ...,
+#           [@latency.last_element, +inf)
+#
+# Returns: error if device is not found.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0",
+#                     "latency": [500000, 1000000, 2000000] } }
+# <- { "return": {} }
+##
+{ 'command': 'block-latency-histogram-set',
+  'data': {'device': 'str', 'latency': ['uint64'] } }
+
+##
 # @BlockInfo:
 #
 # Block device information.  This structure describes a virtual device and
@@ -730,6 +787,8 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
+# @latency-histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
@@ -742,7 +801,8 @@
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
index 8e977eef11..dbf17aca0c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4176,6 +4176,21 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
+void qmp_block_latency_histogram_set(const char *device, uint64List *latency,
+                                     Error **errp)
+{
+    BlockBackend *blk = blk_by_name(device);
+    if (!blk) {
+        error_setg(errp, "Device '%s' not found", device);
+        return;
+    }
+
+    if (block_latency_histogram_set(blk_get_stats(blk), latency) < 0) {
+        error_setg(errp, "Invalid latency array");
+        return;
+    }
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
-- 
2.11.1
