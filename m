Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpI3-0002f9-EF
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpHz-0003pg-34
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:23 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 20 Nov 2017 19:50:58 +0300
Message-Id: <1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/7] qapi: add unmap to BlockDeviceStats
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json       | 20 ++++++++++++++++++++
 include/block/accounting.h |  1 +
 block/qapi.c               |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 76bf50f..ba2705d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -730,6 +730,23 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #               intervals of time (Since 2.5)
 #
+# @unmap_bytes: The number of bytes unmapped by the device (Since 2.12)
+#
+# @unmap_operations: The number of unmap operations performed by the device
+#                    (Since 2.12)
+#
+# @unmap_total_time_ns: Total time spent on unmap operations in nano-seconds
+#                       (Since 2.12)
+#
+# @unmap_merged: Number of unmap requests that have been merged into another
+#                request (Since 2.12)
+#
+# @failed_unmap_operations: The number of failed unmap operations performed
+#                           by the device (Since 2.12)
+#
+# @invalid_unmap_operations: The number of invalid unmap operations performed
+#                            by the device (Since 2.12)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
@@ -741,6 +758,9 @@
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
            'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
            'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
+           'unmap_bytes' : 'int', 'unmap_operations': 'int',
+           'unmap_total_time_ns': 'int', 'unmap_merged': 'int',
+           'failed_unmap_operations': 'int', 'invalid_unmap_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'] } }
 
diff --git a/include/block/accounting.h b/include/block/accounting.h
index b833d26..4e53c4a 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -35,6 +35,7 @@ enum BlockAcctType {
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
+    BLOCK_ACCT_UNMAP,
     BLOCK_MAX_IOTYPE,
 };
 
diff --git a/block/qapi.c b/block/qapi.c
index fc10f0a..6e110f2 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -396,24 +396,30 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 
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
