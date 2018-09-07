Received: from eggs.gnu.org ([2001:4830:134:3::10]:44609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtK-0001tz-6M
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtF-0001vs-9l
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:30 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:46156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtF-0001fZ-04
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:25 -0400
From: Tim Smith <tim.smith@citrix.com>
Date: Fri, 7 Sep 2018 11:21:20 +0100
Message-ID: <153631568068.32214.13361287430751567885.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] Improve xen_disk batching behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When I/O consists of many small requests, performance is improved by
batching them together in a single io_submit() call. When there are
relatively few requests, the extra overhead is not worth it. This
introduces a check to start batching I/O requests via blk_io_plug()/
blk_io_unplug() in an amount proportional to the number which were
already in flight at the time we started reading the ring.

Signed-off-by: Tim Smith <tim.smith@citrix.com>
---
 hw/block/xen_disk.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 36eff94f84..6cb40d66fa 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -101,6 +101,9 @@ struct XenBlkDev {
     AioContext          *ctx;
 };
 
+/* Threshold of in-flight requests above which we will start using
+ * blk_io_plug()/blk_io_unplug() to batch requests */
+#define IO_PLUG_THRESHOLD 1
 /* ------------------------------------------------------------- */
 
 static void ioreq_reset(struct ioreq *ioreq)
@@ -542,6 +545,8 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
 {
     RING_IDX rc, rp;
     struct ioreq *ioreq;
+    int inflight_atstart = blkdev->requests_inflight;
+    int batched = 0;
 
     blkdev->more_work = 0;
 
@@ -550,6 +555,16 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
     blk_send_response_all(blkdev);
+    /* If there was more than IO_PLUG_THRESHOLD ioreqs in flight
+     * when we got here, this is an indication that there the bottleneck
+     * is below us, so it's worth beginning to batch up I/O requests
+     * rather than submitting them immediately. The maximum number
+     * of requests we're willing to batch is the number already in
+     * flight, so it can grow up to max_requests when the bottleneck
+     * is below us */
+    if (inflight_atstart > IO_PLUG_THRESHOLD) {
+        blk_io_plug(blkdev->blk);
+    }
     while (rc != rp) {
         /* pull request from ring */
         if (RING_REQUEST_CONS_OVERFLOW(&blkdev->rings.common, rc)) {
@@ -589,7 +604,21 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
             continue;
         }
 
+        if (inflight_atstart > IO_PLUG_THRESHOLD && batched >= inflight_atstart) {
+            blk_io_unplug(blkdev->blk);
+        }
         ioreq_runio_qemu_aio(ioreq);
+        if (inflight_atstart > IO_PLUG_THRESHOLD) {
+            if (batched >= inflight_atstart) {
+                blk_io_plug(blkdev->blk);
+                batched=0;
+            } else {
+                batched++;
+            }
+        }
+    }
+    if (inflight_atstart > IO_PLUG_THRESHOLD) {
+        blk_io_unplug(blkdev->blk);
     }
 
     if (blkdev->more_work && blkdev->requests_inflight < blkdev->max_requests) {
