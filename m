Received: from eggs.gnu.org ([2001:4830:134:3::10]:60522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHv-0003ID-Ej
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHk-0002Ey-7M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 12 Oct 2018 16:15:08 +0300
Message-Id: <20181012131509.16370-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181012131509.16370-1-vsementsov@virtuozzo.com>
References: <20181012131509.16370-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: move to QOM path for
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

Move to way of device selecting, however fall back to device name if
path is not found.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |  4 ++--
 blockdev.c           | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cfb37f8c1d..f4ae61e2e4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -489,7 +489,7 @@
 # If only @device parameter is specified, remove all present latency histograms
 # for the device. Otherwise, add/reset some of (or all) latency histograms.
 #
-# @device: device name to set latency histogram for.
+# @id: The QOM path or name of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
 #              BlockLatencyHistogramInfo definition). If specified, all
@@ -547,7 +547,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'x-block-latency-histogram-set',
-  'data': {'device': 'str',
+  'data': {'id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
            '*boundaries-write': ['uint64'],
diff --git a/blockdev.c b/blockdev.c
index a8755bd908..52e131f47b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4368,20 +4368,28 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
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
     BlockAcctStats *stats;
+    Error *local_err = NULL;
+    BlockBackend *blk = blk_by_qdev_id(id, &local_err);
 
     if (!blk) {
-        error_setg(errp, "Device '%s' not found", device);
-        return;
+        blk = blk_by_name(id);
+        if (!blk) {
+            error_propagate(errp, local_err);
+            return;
+        } else {
+            error_free(local_err);
+            local_err = NULL;
+        }
     }
+
     stats = blk_get_stats(blk);
 
     if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &&
-- 
2.18.0
