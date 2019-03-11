Received: from eggs.gnu.org ([209.51.188.92]:56384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2b-0005Ps-Ou
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2a-00084m-6K
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 11:12:01 +0300
Message-Id: <20190311081202.13079-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190311081202.13079-1-vsementsov@virtuozzo.com>
References: <20190311081202.13079-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/2] qapi: move to QOM path for
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 14 +++++++-------
 blockdev.c           | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 919d0530b2..9a72e3ee5f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -547,10 +547,10 @@
 #
 # Manage read, write and flush latency histograms for the device.
 #
-# If only @device parameter is specified, remove all present latency histograms
+# If only @id parameter is specified, remove all present latency histograms
 # for the device. Otherwise, add/reset some of (or all) latency histograms.
 #
-# @device: device name to set latency histogram for.
+# @id: The name or QOM path of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
 #              BlockLatencyHistogramInfo definition). If specified, all
@@ -579,7 +579,7 @@
 # [0, 10), [10, 50), [50, 100), [100, +inf):
 #
 # -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "device": "drive0",
+#      "arguments": { "id": "drive0",
 #                     "boundaries": [10, 50, 100] } }
 # <- { "return": {} }
 #
@@ -587,7 +587,7 @@
 # not changed (or not created):
 #
 # -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "device": "drive0",
+#      "arguments": { "id": "drive0",
 #                     "boundaries-write": [10, 50, 100] } }
 # <- { "return": {} }
 #
@@ -596,7 +596,7 @@
 #   write: [0, 1000), [1000, 5000), [5000, +inf)
 #
 # -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "device": "drive0",
+#      "arguments": { "id": "drive0",
 #                     "boundaries": [10, 50, 100],
 #                     "boundaries-write": [1000, 5000] } }
 # <- { "return": {} }
@@ -604,11 +604,11 @@
 # Example: remove all latency histograms:
 #
 # -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "device": "drive0" } }
+#      "arguments": { "id": "drive0" } }
 # <- { "return": {} }
 ##
 { 'command': 'x-block-latency-histogram-set',
-  'data': {'device': 'str',
+  'data': {'id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
            '*boundaries-write': ['uint64'],
diff --git a/blockdev.c b/blockdev.c
index 871966ca13..850fb34c52 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4453,21 +4453,21 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
 }
 
 void qmp_x_block_latency_histogram_set(
-    const char *device,
+    const char *id,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
     bool has_boundaries_write, uint64List *boundaries_write,
     bool has_boundaries_flush, uint64List *boundaries_flush,
     Error **errp)
 {
-    BlockBackend *blk = blk_by_name(device);
+    BlockBackend *blk = qmp_get_blk(NULL, id, errp);
     BlockAcctStats *stats;
     int ret;
 
     if (!blk) {
-        error_setg(errp, "Device '%s' not found", device);
         return;
     }
+
     stats = blk_get_stats(blk);
 
     if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &&
@@ -4482,7 +4482,7 @@ void qmp_x_block_latency_histogram_set(
             stats, BLOCK_ACCT_READ,
             has_boundaries_read ? boundaries_read : boundaries);
         if (ret) {
-            error_setg(errp, "Device '%s' set read boundaries fail", device);
+            error_setg(errp, "Device '%s' set read boundaries fail", id);
             return;
         }
     }
@@ -4492,7 +4492,7 @@ void qmp_x_block_latency_histogram_set(
             stats, BLOCK_ACCT_WRITE,
             has_boundaries_write ? boundaries_write : boundaries);
         if (ret) {
-            error_setg(errp, "Device '%s' set write boundaries fail", device);
+            error_setg(errp, "Device '%s' set write boundaries fail", id);
             return;
         }
     }
@@ -4502,7 +4502,7 @@ void qmp_x_block_latency_histogram_set(
             stats, BLOCK_ACCT_FLUSH,
             has_boundaries_flush ? boundaries_flush : boundaries);
         if (ret) {
-            error_setg(errp, "Device '%s' set flush boundaries fail", device);
+            error_setg(errp, "Device '%s' set flush boundaries fail", id);
             return;
         }
     }
-- 
2.18.0
