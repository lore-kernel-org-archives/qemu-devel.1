Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euKTZ-0006Yv-Lu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euKTU-0005yy-UF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:02:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  9 Mar 2018 19:02:24 +0300
Message-Id: <20180309160224.78821-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180309160224.78821-1-vsementsov@virtuozzo.com>
References: <20180309160224.78821-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 2/2] qapi: add block latency histogram
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
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com

Set (and clear) histogram through new command
block-latency-histogram-set and show new statistics in
query-blockstats results.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/qapi.c         |  41 +++++++++++++++++++
 blockdev.c           |  43 ++++++++++++++++++++
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5c5921bfb7..b4dc9af45a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -451,6 +451,106 @@
            'status': 'DirtyBitmapStatus'} }
 
 ##
+# @XBlockLatencyHistogramInfo:
+#
+# Block latency histogram.
+#
+# @boundaries: list of interval boundary values in nanoseconds, all greater
+#              than zero and in ascending order.
+#              For example, the list [10, 50, 100] produces the following
+#              histogram intervals: [0, 10), [10, 50), [50, 100), [100, +inf).
+#
+# @bins: list of io request counts corresponding to histogram intervals.
+#        len(@bins) = len(@boundaries) + 1
+#        For the example above, @bins may be something like [3, 1, 5, 2],
+#        and corresponding histogram looks like:
+#
+#        5|           *
+#        4|           *
+#        3| *         *
+#        2| *         *    *
+#        1| *    *    *    *
+#         +------------------
+#             10   50   100
+#
+# Since: 2.12
+##
+{ 'struct': 'XBlockLatencyHistogramInfo',
+  'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
+
+##
+# @x-block-latency-histogram-set:
+#
+# Manage read, write and flush latency histograms for the device.
+#
+# If only @device parameter is specified, remove all present latency histograms
+# for the device. Otherwise, add/reset some of (or all) latency histograms.
+#
+# @device: device name to set latency histogram for.
+#
+# @boundaries: list of interval boundary values (see description in
+#              XBlockLatencyHistogramInfo definition). If specified, all
+#              latency histograms are removed, and empty ones created for all
+#              io types with intervals corresponding to @boundaries (except for
+#              io types, for which specific boundaries are set through the
+#              following parameters).
+#
+# @boundaries-read: list of interval boundary values for read latency
+#                   histogram. If specified, old read latency histogram is
+#                   removed, and empty one created with interavals
+#                   corresponding to @boundaries-read. The parameter has higher
+#                   priority then @boundaries.
+#
+# @boundaries-write: list of interaval boundary values for write latency
+#                    histogram.
+#
+# @boundaries-flush: list of interaval boundary values for flush latency
+#                    histogram.
+#
+# Returns: error if device is not found or @boundaries* arrays are invalid.
+#
+# Since: 2.12
+#
+# Example: set new histograms for all io types with intervals
+# [0, 10), [10, 50), [50, 100), [100, +inf):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0",
+#                     "boundaries": [10, 50, 100] } }
+# <- { "return": {} }
+#
+# Example: set new histogram only for write, other histograms will remain
+# not changed (or not created):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0",
+#                     "boundaries-write": [10, 50, 100] } }
+# <- { "return": {} }
+#
+# Example: set new histograms with the following intervals:
+#   read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
+#   write: [0, 1000), [1000, 5000), [5000, +inf)
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0",
+#                     "boundaries": [10, 50, 100],
+#                     "boundaries-write": [1000, 5000] } }
+# <- { "return": {} }
+#
+# Example: remove all latency histograms:
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "device": "drive0" } }
+# <- { "return": {} }
+##
+{ 'command': 'x-block-latency-histogram-set',
+  'data': {'device': 'str',
+           '*boundaries': ['uint64'],
+           '*boundaries-read': ['uint64'],
+           '*boundaries-write': ['uint64'],
+           '*boundaries-flush': ['uint64'] } }
+
+##
 # @BlockInfo:
 #
 # Block device information.  This structure describes a virtual device and
@@ -730,6 +830,12 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
+# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+#
+# @x_wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+#
+# @x_flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
@@ -742,7 +848,10 @@
            'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
            'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
-           'timed_stats': ['BlockDeviceTimedStats'] } }
+           'timed_stats': ['BlockDeviceTimedStats'],
+           '*x_rd_latency_histogram': 'XBlockLatencyHistogramInfo',
+           '*x_wr_latency_histogram': 'XBlockLatencyHistogramInfo',
+           '*x_flush_latency_histogram': 'XBlockLatencyHistogramInfo' } }
 
 ##
 # @BlockStats:
diff --git a/block/qapi.c b/block/qapi.c
index 1fdeb1ef2f..32bd0d45c4 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -394,6 +394,37 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
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
+static void bdrv_latency_histogram_stats(BlockLatencyHistogram *hist,
+                                         bool *not_null,
+                                         XBlockLatencyHistogramInfo **info)
+{
+    *not_null = hist->bins != NULL;
+    if (*not_null) {
+        *info = g_new0(XBlockLatencyHistogramInfo, 1);
+
+        (*info)->boundaries = uint64_list(hist->boundaries, hist->nbins - 1);
+        (*info)->bins = uint64_list(hist->bins, hist->nbins);
+    }
+}
+
 static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 {
     BlockAcctStats *stats = blk_get_stats(blk);
@@ -459,6 +490,16 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
         dev_stats->avg_wr_queue_depth =
             block_acct_queue_depth(ts, BLOCK_ACCT_WRITE);
     }
+
+    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_READ],
+                                 &ds->has_x_rd_latency_histogram,
+                                 &ds->x_rd_latency_histogram);
+    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_WRITE],
+                                 &ds->has_x_wr_latency_histogram,
+                                 &ds->x_wr_latency_histogram);
+    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
+                                 &ds->has_x_flush_latency_histogram,
+                                 &ds->x_flush_latency_histogram);
 }
 
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index 3fb1ca803c..8842d0aea2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4179,6 +4179,49 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
+void qmp_x_block_latency_histogram_set(
+    const char *device,
+    bool has_boundaries, uint64List *boundaries,
+    bool has_boundaries_read, uint64List *boundaries_read,
+    bool has_boundaries_write, uint64List *boundaries_write,
+    bool has_boundaries_flush, uint64List *boundaries_flush,
+    Error **errp)
+{
+    BlockBackend *blk = blk_by_name(device);
+    BlockAcctStats *stats;
+
+    if (!blk) {
+        error_setg(errp, "Device '%s' not found", device);
+        return;
+    }
+    stats = blk_get_stats(blk);
+
+    if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &&
+        !has_boundaries_flush)
+    {
+        block_latency_histograms_clear(stats);
+        return;
+    }
+
+    if (has_boundaries || has_boundaries_read) {
+        block_latency_histogram_set(
+            stats, BLOCK_ACCT_READ,
+            has_boundaries_read ? boundaries_read : boundaries);
+    }
+
+    if (has_boundaries || has_boundaries_write) {
+        block_latency_histogram_set(
+            stats, BLOCK_ACCT_WRITE,
+            has_boundaries_write ? boundaries_write : boundaries);
+    }
+
+    if (has_boundaries || has_boundaries_flush) {
+        block_latency_histogram_set(
+            stats, BLOCK_ACCT_FLUSH,
+            has_boundaries_flush ? boundaries_flush : boundaries);
+    }
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
-- 
2.11.1
