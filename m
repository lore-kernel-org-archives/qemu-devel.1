Received: from eggs.gnu.org ([209.51.188.92]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2b-0005Pq-IX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2a-00084P-2k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 11:12:02 +0300
Message-Id: <20190311081202.13079-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190311081202.13079-1-vsementsov@virtuozzo.com>
References: <20190311081202.13079-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 2/2] qapi: drop x- from
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

Drop x- and x_ prefixes for latency histograms and update version to
3.1

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 20 ++++++++++----------
 block/qapi.c         | 12 ++++++------
 blockdev.c           |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9a72e3ee5f..b612e3bc31 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -537,13 +537,13 @@
 #         +------------------
 #             10   50   100
 #
-# Since: 2.12
+# Since: 4.0
 ##
 { 'struct': 'BlockLatencyHistogramInfo',
   'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
 
 ##
-# @x-block-latency-histogram-set:
+# @block-latency-histogram-set:
 #
 # Manage read, write and flush latency histograms for the device.
 #
@@ -573,7 +573,7 @@
 #
 # Returns: error if device is not found or any boundary arrays are invalid.
 #
-# Since: 2.12
+# Since: 4.0
 #
 # Example: set new histograms for all io types with intervals
 # [0, 10), [10, 50), [50, 100), [100, +inf):
@@ -607,7 +607,7 @@
 #      "arguments": { "id": "drive0" } }
 # <- { "return": {} }
 ##
-{ 'command': 'x-block-latency-histogram-set',
+{ 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
@@ -894,11 +894,11 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
-# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
 #
-# @x_wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
 #
-# @x_flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
 #
 # Since: 0.14.0
 ##
@@ -913,9 +913,9 @@
            'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
-           '*x_rd_latency_histogram': 'BlockLatencyHistogramInfo',
-           '*x_wr_latency_histogram': 'BlockLatencyHistogramInfo',
-           '*x_flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
+           '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
+           '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
+           '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
 
 ##
 # @BlockStats:
diff --git a/block/qapi.c b/block/qapi.c
index 6002a768f8..21edab34fc 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -493,14 +493,14 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     }
 
     bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_READ],
-                                 &ds->has_x_rd_latency_histogram,
-                                 &ds->x_rd_latency_histogram);
+                                 &ds->has_rd_latency_histogram,
+                                 &ds->rd_latency_histogram);
     bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_WRITE],
-                                 &ds->has_x_wr_latency_histogram,
-                                 &ds->x_wr_latency_histogram);
+                                 &ds->has_wr_latency_histogram,
+                                 &ds->wr_latency_histogram);
     bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
-                                 &ds->has_x_flush_latency_histogram,
-                                 &ds->x_flush_latency_histogram);
+                                 &ds->has_flush_latency_histogram,
+                                 &ds->flush_latency_histogram);
 }
 
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index 850fb34c52..84dd678289 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4452,7 +4452,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
-void qmp_x_block_latency_histogram_set(
+void qmp_block_latency_histogram_set(
     const char *id,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
-- 
2.18.0
