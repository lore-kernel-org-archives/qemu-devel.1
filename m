Received: from eggs.gnu.org ([2001:4830:134:3::10]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FR-0003qr-2e
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FP-0007vF-24
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:48 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:13 +0300
Message-Id: <1534844779-118784-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/8] qapi: add unmap to BlockDeviceStats
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json       | 29 +++++++++++++++++++++++------
 include/block/accounting.h |  1 +
 block/qapi.c               |  6 ++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 44d992f..19d4743 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -777,6 +777,8 @@
 #
 # @wr_bytes:      The number of bytes written by the device.
 #
+# @unmap_bytes: The number of bytes unmapped by the device (Since 3.1)
+#
 # @rd_operations: The number of read operations performed by the device.
 #
 # @wr_operations: The number of write operations performed by the device.
@@ -784,6 +786,9 @@
 # @flush_operations: The number of cache flush operations performed by the
 #                    device (since 0.15.0)
 #
+# @unmap_operations: The number of unmap operations performed by the device
+#                    (Since 3.1)
+#
 # @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.15.0).
 #
 # @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.15.0).
@@ -791,6 +796,9 @@
 # @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
 #                       (since 0.15.0).
 #
+# @unmap_total_time_ns: Total time spent on unmap operations in nanoseconds
+#                       (Since 3.1)
+#
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is for
 #                     growable sparse files (like qcow2) that are used on top
@@ -802,6 +810,9 @@
 # @wr_merged: Number of write requests that have been merged into another
 #             request (Since 2.3).
 #
+# @unmap_merged: Number of unmap requests that have been merged into another
+#                request (Since 3.1)
+#
 # @idle_time_ns: Time since the last I/O operation, in
 #                nanoseconds. If the field is absent it means that
 #                there haven't been any operations yet (Since 2.5).
@@ -815,6 +826,9 @@
 # @failed_flush_operations: The number of failed flush operations
 #                           performed by the device (Since 2.5)
 #
+# @failed_unmap_operations: The number of failed unmap operations performed
+#                           by the device (Since 3.1)
+#
 # @invalid_rd_operations: The number of invalid read operations
 #                          performed by the device (Since 2.5)
 #
@@ -824,6 +838,9 @@
 # @invalid_flush_operations: The number of invalid flush operations
 #                            performed by the device (Since 2.5)
 #
+# @invalid_unmap_operations: The number of invalid unmap operations performed
+#                            by the device (Since 3.1)
+#
 # @account_invalid: Whether invalid operations are included in the
 #                   last access statistics (Since 2.5)
 #
@@ -842,18 +859,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'unmap_bytes' : 'int',
            'rd_operations': 'int', 'wr_operations': 'int',
-           'flush_operations': 'int',
+           'flush_operations': 'int', 'unmap_operations': 'int',
            'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'flush_total_time_ns': 'int',
+           'flush_total_time_ns': 'int', 'unmap_total_time_ns': 'int',
            'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int', 'unmap_merged': 'int',
            '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int',
+           'failed_flush_operations': 'int', 'failed_unmap_operations': 'int',
            'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int',
-           'invalid_flush_operations': 'int',
+           'invalid_flush_operations': 'int', 'invalid_unmap_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*x_rd_latency_histogram': 'BlockLatencyHistogramInfo',
diff --git a/include/block/accounting.h b/include/block/accounting.h
index d1f67b1..ba8b04d 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -36,6 +36,7 @@ enum BlockAcctType {
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
+    BLOCK_ACCT_UNMAP,
     BLOCK_MAX_IOTYPE,
 };
 
diff --git a/block/qapi.c b/block/qapi.c
index c66f949..df31f35 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -432,24 +432,30 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 
     ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
+    ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
     ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
     ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
+    ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
 
     ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
     ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
     ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
+    ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
 
     ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
     ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
     ds->invalid_flush_operations =
         stats->invalid_ops[BLOCK_ACCT_FLUSH];
+    ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
 
     ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
     ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
+    ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
     ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
     ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
     ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
     ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
+    ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
 
     ds->has_idle_time_ns = stats->last_access_time_ns > 0;
     if (ds->has_idle_time_ns) {
-- 
2.7.4
