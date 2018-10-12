Received: from eggs.gnu.org ([2001:4830:134:3::10]:60526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHv-0003IF-G5
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHk-0002F5-8L
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 12 Oct 2018 16:15:09 +0300
Message-Id: <20181012131509.16370-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181012131509.16370-1-vsementsov@virtuozzo.com>
References: <20181012131509.16370-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qapi: drop x- from
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
Cc: eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com

Drop x- and x_ prefixes for latency histograms and update version to
3.1

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 20 ++++++++++----------
 block/qapi.c         | 12 ++++++------
 blockdev.c           |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f4ae61e2e4..8b7c68c69d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -476,13 +476,13 @@
 #         +------------------
 #             10   50   100
 #
-# Since: 2.12
+# Since: 3.1
 ##
 { 'struct': 'BlockLatencyHistogramInfo',
   'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
 
 ##
-# @x-block-latency-histogram-set:
+# @block-latency-histogram-set:
 #
 # Manage read, write and flush latency histograms for the device.
 #
@@ -512,7 +512,7 @@
 #
 # Returns: error if device is not found or any boundary arrays are invalid.
 #
-# Since: 2.12
+# Since: 3.1
 #
 # Example: set new histograms for all io types with intervals
 # [0, 10), [10, 50), [50, 100), [100, +inf):
@@ -546,7 +546,7 @@
 #      "arguments": { "device": "drive0" } }
 # <- { "return": {} }
 ##
-{ 'command': 'x-block-latency-histogram-set',
+{ 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
@@ -833,11 +833,11 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
-# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 3.1)
 #
-# @x_wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 3.1)
 #
-# @x_flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 3.1)
 #
 # Since: 0.14.0
 ##
@@ -852,9 +852,9 @@
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
index c66f949db8..dc7508a06d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -492,14 +492,14 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
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
index 52e131f47b..5dd9b944f3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4367,7 +4367,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
-void qmp_x_block_latency_histogram_set(
+void qmp_block_latency_histogram_set(
     const char *id,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
-- 
2.18.0
