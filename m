Received: from eggs.gnu.org ([2001:4830:134:3::10]:44641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtP-0002EI-I4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtO-0002p2-Hi
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:35 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:46161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtO-0002ey-8Y
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:34 -0400
From: Tim Smith <tim.smith@citrix.com>
Date: Fri, 7 Sep 2018 11:21:25 +0100
Message-ID: <153631568573.32214.15572432320859976670.stgit@dhcp-3-135.uk.xensource.com>
In-Reply-To: <153631568068.32214.13361287430751567885.stgit@dhcp-3-135.uk.xensource.com>
References: <153631568068.32214.13361287430751567885.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] Improve xen_disk response latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the I/O ring is full, the guest cannot send any more requests
until some responses are sent. Only sending all available responses
just before checking for new work does not leave much time for the
guest to supply new work, so this will cause stalls if the ring gets
full. Also, not completing reads as soon as possible adds latency
to the guest.

To alleviate that, complete IO requests as soon as they come back.
blk_send_response() already returns a value indicating whether
a notify should be sent, which is all the batching we need.

Signed-off-by: Tim Smith <tim.smith@citrix.com>
---
 hw/block/xen_disk.c |   43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 6cb40d66fa..c11cd21d37 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -83,11 +83,9 @@ struct XenBlkDev {
 
     /* request lists */
     QLIST_HEAD(inflight_head, ioreq) inflight;
-    QLIST_HEAD(finished_head, ioreq) finished;
     QLIST_HEAD(freelist_head, ioreq) freelist;
     int                 requests_total;
     int                 requests_inflight;
-    int                 requests_finished;
     unsigned int        max_requests;
 
     gboolean            feature_discard;
@@ -104,6 +102,9 @@ struct XenBlkDev {
 /* Threshold of in-flight requests above which we will start using
  * blk_io_plug()/blk_io_unplug() to batch requests */
 #define IO_PLUG_THRESHOLD 1
+
+static int blk_send_response(struct ioreq *ioreq);
+
 /* ------------------------------------------------------------- */
 
 static void ioreq_reset(struct ioreq *ioreq)
@@ -155,12 +156,10 @@ static void ioreq_finish(struct ioreq *ioreq)
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
     QLIST_REMOVE(ioreq, list);
-    QLIST_INSERT_HEAD(&blkdev->finished, ioreq, list);
     blkdev->requests_inflight--;
-    blkdev->requests_finished++;
 }
 
-static void ioreq_release(struct ioreq *ioreq, bool finish)
+static void ioreq_release(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
@@ -168,11 +167,7 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
     ioreq_reset(ioreq);
     ioreq->blkdev = blkdev;
     QLIST_INSERT_HEAD(&blkdev->freelist, ioreq, list);
-    if (finish) {
-        blkdev->requests_finished--;
-    } else {
-        blkdev->requests_inflight--;
-    }
+    blkdev->requests_inflight--;
 }
 
 /*
@@ -351,6 +346,10 @@ static void qemu_aio_complete(void *opaque, int ret)
     default:
         break;
     }
+    if (blk_send_response(ioreq)) {
+        xen_pv_send_notify(&blkdev->xendev);
+    }
+    ioreq_release(ioreq);
     qemu_bh_schedule(blkdev->bh);
 
 done:
@@ -455,7 +454,7 @@ err:
     return -1;
 }
 
-static int blk_send_response_one(struct ioreq *ioreq)
+static int blk_send_response(struct ioreq *ioreq)
 {
     struct XenBlkDev  *blkdev = ioreq->blkdev;
     int               send_notify   = 0;
@@ -504,22 +503,6 @@ static int blk_send_response_one(struct ioreq *ioreq)
     return send_notify;
 }
 
-/* walk finished list, send outstanding responses, free requests */
-static void blk_send_response_all(struct XenBlkDev *blkdev)
-{
-    struct ioreq *ioreq;
-    int send_notify = 0;
-
-    while (!QLIST_EMPTY(&blkdev->finished)) {
-        ioreq = QLIST_FIRST(&blkdev->finished);
-        send_notify += blk_send_response_one(ioreq);
-        ioreq_release(ioreq, true);
-    }
-    if (send_notify) {
-        xen_pv_send_notify(&blkdev->xendev);
-    }
-}
-
 static int blk_get_request(struct XenBlkDev *blkdev, struct ioreq *ioreq, RING_IDX rc)
 {
     switch (blkdev->protocol) {
@@ -554,7 +537,6 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
     rp = blkdev->rings.common.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    blk_send_response_all(blkdev);
     /* If there was more than IO_PLUG_THRESHOLD ioreqs in flight
      * when we got here, this is an indication that there the bottleneck
      * is below us, so it's worth beginning to batch up I/O requests
@@ -597,10 +579,10 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
                 break;
             };
 
-            if (blk_send_response_one(ioreq)) {
+            if (blk_send_response(ioreq)) {
                 xen_pv_send_notify(&blkdev->xendev);
             }
-            ioreq_release(ioreq, false);
+            ioreq_release(ioreq);
             continue;
         }
 
@@ -645,7 +627,6 @@ static void blk_alloc(struct XenDevice *xendev)
     trace_xen_disk_alloc(xendev->name);
 
     QLIST_INIT(&blkdev->inflight);
-    QLIST_INIT(&blkdev->finished);
     QLIST_INIT(&blkdev->freelist);
 
     blkdev->iothread = iothread_create(xendev->name, &err);
