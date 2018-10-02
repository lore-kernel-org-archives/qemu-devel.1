Received: from eggs.gnu.org ([2001:4830:134:3::10]:56112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivq-0005ZQ-HF
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivk-00017j-Lv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Oct 2018 14:33:24 +0300
Message-Id: <20181002113325.12911-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181002113325.12911-1-vsementsov@virtuozzo.com>
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] qapi: support device id for
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
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

Support modern way of device selecting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 6 ++++--
 blockdev.c           | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ac3b48ee54..4efd60d8ab 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -489,7 +489,9 @@
 # If only @device parameter is specified, remove all present latency histograms
 # for the device. Otherwise, add/reset some of (or all) latency histograms.
 #
-# @device: device name to set latency histogram for.
+# @device: device name to set latency histogram for (better use @id).
+#
+# @id: The name or QOM path of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
 #              BlockLatencyHistogramInfo definition). If specified, all
@@ -547,7 +549,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'x-block-latency-histogram-set',
-  'data': {'device': 'str',
+  'data': {'*device': 'str', '*id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
            '*boundaries-write': ['uint64'],
diff --git a/blockdev.c b/blockdev.c
index a8755bd908..87f4ab3316 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4368,20 +4368,22 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
 }
 
 void qmp_x_block_latency_histogram_set(
-    const char *device,
+    bool has_device, const char *device,
+    bool has_id, const char *id,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
     bool has_boundaries_write, uint64List *boundaries_write,
     bool has_boundaries_flush, uint64List *boundaries_flush,
     Error **errp)
 {
-    BlockBackend *blk = blk_by_name(device);
+    BlockBackend *blk;
     BlockAcctStats *stats;
 
+    blk = qmp_get_blk(has_device ? device : NULL, has_id ? id : NULL, errp);
     if (!blk) {
-        error_setg(errp, "Device '%s' not found", device);
         return;
     }
+
     stats = blk_get_stats(blk);
 
     if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &&
-- 
2.18.0
