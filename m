Received: from eggs.gnu.org ([209.51.188.92]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h19ZT-00026i-5s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h19ZR-0006QE-U8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:53:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  5 Mar 2019 15:53:17 +0300
Message-Id: <20190305125317.607155-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190305125317.607155-1-vsementsov@virtuozzo.com>
References: <20190305125317.607155-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 2/2] qapi: drop x- from
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
index 8187de0836..636626dd70 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -528,13 +528,13 @@
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
@@ -564,7 +564,7 @@
 #
 # Returns: error if device is not found or any boundary arrays are invalid.
 #
-# Since: 2.12
+# Since: 4.0
 #
 # Example: set new histograms for all io types with intervals
 # [0, 10), [10, 50), [50, 100), [100, +inf):
@@ -598,7 +598,7 @@
 #      "arguments": { "device": "drive0" } }
 # <- { "return": {} }
 ##
-{ 'command': 'x-block-latency-histogram-set',
+{ 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
@@ -885,11 +885,11 @@
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
@@ -904,9 +904,9 @@
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
index f67132d4f8..6f0321a1ec 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4450,7 +4450,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
-void qmp_x_block_latency_histogram_set(
+void qmp_block_latency_histogram_set(
     const char *id,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
-- 
2.18.0
