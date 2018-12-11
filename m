Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWfkf-0004N3-3g
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWfkd-0001q4-Ei
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:58:57 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 10:47:13 +0000
Message-ID: <1544525238-3527-14-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 13/18] xen: purge 'blk' and 'ioreq' from
 function names in dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is a purely cosmetic patch that purges remaining use of 'blk' and
'ioreq' in local function names, and then makes sure all functions are
prefixed with 'xen_block_'.

No functional change.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

v2:
 - Add 'xen_block_' prefix
---
 hw/block/dataplane/xen-block.c | 90 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 426e83c..8c451ae 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -73,7 +73,7 @@ struct XenBlockDataPlane {
     AioContext *ctx;
 };
 
-static void ioreq_reset(XenBlockRequest *request)
+static void reset_request(XenBlockRequest *request)
 {
     memset(&request->req, 0, sizeof(request->req));
     request->status = 0;
@@ -92,7 +92,7 @@ static void ioreq_reset(XenBlockRequest *request)
     qemu_iovec_reset(&request->v);
 }
 
-static XenBlockRequest *ioreq_start(XenBlockDataPlane *dataplane)
+static XenBlockRequest *xen_block_start_request(XenBlockDataPlane *dataplane)
 {
     XenBlockRequest *request = NULL;
 
@@ -117,7 +117,7 @@ out:
     return request;
 }
 
-static void ioreq_finish(XenBlockRequest *request)
+static void xen_block_finish_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
@@ -127,12 +127,12 @@ static void ioreq_finish(XenBlockRequest *request)
     dataplane->requests_finished++;
 }
 
-static void ioreq_release(XenBlockRequest *request, bool finish)
+static void xen_block_release_request(XenBlockRequest *request, bool finish)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
     QLIST_REMOVE(request, list);
-    ioreq_reset(request);
+    reset_request(request);
     request->dataplane = dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
     if (finish) {
@@ -146,7 +146,7 @@ static void ioreq_release(XenBlockRequest *request, bool finish)
  * translate request into iovec + start offset
  * do sanity checks along the way
  */
-static int ioreq_parse(XenBlockRequest *request)
+static int xen_block_parse_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
     size_t len;
@@ -207,7 +207,7 @@ err:
     return -1;
 }
 
-static int ioreq_grant_copy(XenBlockRequest *request)
+static int xen_block_copy_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
     XenDevice *xendev = dataplane->xendev;
@@ -253,9 +253,9 @@ static int ioreq_grant_copy(XenBlockRequest *request)
     return 0;
 }
 
-static int ioreq_runio_qemu_aio(XenBlockRequest *request);
+static int xen_block_do_aio(XenBlockRequest *request);
 
-static void qemu_aio_complete(void *opaque, int ret)
+static void xen_block_complete_aio(void *opaque, int ret)
 {
     XenBlockRequest *request = opaque;
     XenBlockDataPlane *dataplane = request->dataplane;
@@ -272,7 +272,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     request->aio_inflight--;
     if (request->presync) {
         request->presync = 0;
-        ioreq_runio_qemu_aio(request);
+        xen_block_do_aio(request);
         goto done;
     }
     if (request->aio_inflight > 0) {
@@ -283,7 +283,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     case BLKIF_OP_READ:
         /* in case of failure request->aio_errors is increased */
         if (ret == 0) {
-            ioreq_grant_copy(request);
+            xen_block_copy_request(request);
         }
         qemu_vfree(request->buf);
         break;
@@ -299,7 +299,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     }
 
     request->status = request->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    ioreq_finish(request);
+    xen_block_finish_request(request);
 
     switch (request->req.operation) {
     case BLKIF_OP_WRITE:
@@ -324,9 +324,9 @@ done:
     aio_context_release(dataplane->ctx);
 }
 
-static bool blk_split_discard(XenBlockRequest *request,
-                              blkif_sector_t sector_number,
-                              uint64_t nr_sectors)
+static bool xen_block_split_discard(XenBlockRequest *request,
+                                    blkif_sector_t sector_number,
+                                    uint64_t nr_sectors)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
     int64_t byte_offset;
@@ -349,7 +349,7 @@ static bool blk_split_discard(XenBlockRequest *request,
         byte_chunk = byte_remaining > limit ? limit : byte_remaining;
         request->aio_inflight++;
         blk_aio_pdiscard(dataplane->blk, byte_offset, byte_chunk,
-                         qemu_aio_complete, request);
+                         xen_block_complete_aio, request);
         byte_remaining -= byte_chunk;
         byte_offset += byte_chunk;
     } while (byte_remaining > 0);
@@ -357,7 +357,7 @@ static bool blk_split_discard(XenBlockRequest *request,
     return true;
 }
 
-static int ioreq_runio_qemu_aio(XenBlockRequest *request)
+static int xen_block_do_aio(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
@@ -365,14 +365,15 @@ static int ioreq_runio_qemu_aio(XenBlockRequest *request)
     if (request->req.nr_segments &&
         (request->req.operation == BLKIF_OP_WRITE ||
          request->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
-        ioreq_grant_copy(request)) {
+        xen_block_copy_request(request)) {
         qemu_vfree(request->buf);
         goto err;
     }
 
     request->aio_inflight++;
     if (request->presync) {
-        blk_aio_flush(request->dataplane->blk, qemu_aio_complete, request);
+        blk_aio_flush(request->dataplane->blk, xen_block_complete_aio,
+                      request);
         return 0;
     }
 
@@ -383,7 +384,7 @@ static int ioreq_runio_qemu_aio(XenBlockRequest *request)
                          request->v.size, BLOCK_ACCT_READ);
         request->aio_inflight++;
         blk_aio_preadv(dataplane->blk, request->start, &request->v, 0,
-                       qemu_aio_complete, request);
+                       xen_block_complete_aio, request);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
@@ -398,12 +399,13 @@ static int ioreq_runio_qemu_aio(XenBlockRequest *request)
                          BLOCK_ACCT_WRITE : BLOCK_ACCT_FLUSH);
         request->aio_inflight++;
         blk_aio_pwritev(dataplane->blk, request->start, &request->v, 0,
-                        qemu_aio_complete, request);
+                        xen_block_complete_aio, request);
         break;
     case BLKIF_OP_DISCARD:
     {
         struct blkif_request_discard *req = (void *)&request->req;
-        if (!blk_split_discard(request, req->sector_number, req->nr_sectors)) {
+        if (!xen_block_split_discard(request, req->sector_number,
+                                     req->nr_sectors)) {
             goto err;
         }
         break;
@@ -413,17 +415,17 @@ static int ioreq_runio_qemu_aio(XenBlockRequest *request)
         goto err;
     }
 
-    qemu_aio_complete(request, 0);
+    xen_block_complete_aio(request, 0);
 
     return 0;
 
 err:
-    ioreq_finish(request);
+    xen_block_finish_request(request);
     request->status = BLKIF_RSP_ERROR;
     return -1;
 }
 
-static int blk_send_response_one(XenBlockRequest *request)
+static int xen_block_send_response_one(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
     int send_notify = 0;
@@ -479,15 +481,15 @@ static int blk_send_response_one(XenBlockRequest *request)
 }
 
 /* walk finished list, send outstanding responses, free requests */
-static void blk_send_response_all(XenBlockDataPlane *dataplane)
+static void xen_block_send_response_all(XenBlockDataPlane *dataplane)
 {
     XenBlockRequest *request;
     int send_notify = 0;
 
     while (!QLIST_EMPTY(&dataplane->finished)) {
         request = QLIST_FIRST(&dataplane->finished);
-        send_notify += blk_send_response_one(request);
-        ioreq_release(request, true);
+        send_notify += xen_block_send_response_one(request);
+        xen_block_release_request(request, true);
     }
     if (send_notify) {
         Error *local_err = NULL;
@@ -501,8 +503,8 @@ static void blk_send_response_all(XenBlockDataPlane *dataplane)
     }
 }
 
-static int blk_get_request(XenBlockDataPlane *dataplane,
-                           XenBlockRequest *request, RING_IDX rc)
+static int xen_block_get_request(XenBlockDataPlane *dataplane,
+                                 XenBlockRequest *request, RING_IDX rc)
 {
     switch (dataplane->protocol) {
     case BLKIF_PROTOCOL_NATIVE: {
@@ -532,7 +534,7 @@ static int blk_get_request(XenBlockDataPlane *dataplane,
     return 0;
 }
 
-static void blk_handle_requests(XenBlockDataPlane *dataplane)
+static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
 {
     RING_IDX rc, rp;
     XenBlockRequest *request;
@@ -543,23 +545,22 @@ static void blk_handle_requests(XenBlockDataPlane *dataplane)
     rp = dataplane->rings.common.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    blk_send_response_all(dataplane);
+    xen_block_send_response_all(dataplane);
     while (rc != rp) {
         /* pull request from ring */
         if (RING_REQUEST_CONS_OVERFLOW(&dataplane->rings.common, rc)) {
             break;
         }
-        request = ioreq_start(dataplane);
+        request = xen_block_start_request(dataplane);
         if (request == NULL) {
             dataplane->more_work++;
             break;
         }
-        blk_get_request(dataplane, request, rc);
+        xen_block_get_request(dataplane, request, rc);
         dataplane->rings.common.req_cons = ++rc;
 
         /* parse them */
-        if (ioreq_parse(request) != 0) {
-
+        if (xen_block_parse_request(request) != 0) {
             switch (request->req.operation) {
             case BLKIF_OP_READ:
                 block_acct_invalid(blk_get_stats(dataplane->blk),
@@ -576,7 +577,7 @@ static void blk_handle_requests(XenBlockDataPlane *dataplane)
                 break;
             };
 
-            if (blk_send_response_one(request)) {
+            if (xen_block_send_response_one(request)) {
                 Error *local_err = NULL;
 
                 xen_device_notify_event_channel(dataplane->xendev,
@@ -586,11 +587,11 @@ static void blk_handle_requests(XenBlockDataPlane *dataplane)
                     error_report_err(local_err);
                 }
             }
-            ioreq_release(request, false);
+            xen_block_release_request(request, false);
             continue;
         }
 
-        ioreq_runio_qemu_aio(request);
+        xen_block_do_aio(request);
     }
 
     if (dataplane->more_work &&
@@ -599,16 +600,16 @@ static void blk_handle_requests(XenBlockDataPlane *dataplane)
     }
 }
 
-static void blk_bh(void *opaque)
+static void xen_block_dataplane_bh(void *opaque)
 {
     XenBlockDataPlane *dataplane = opaque;
 
     aio_context_acquire(dataplane->ctx);
-    blk_handle_requests(dataplane);
+    xen_block_handle_requests(dataplane);
     aio_context_release(dataplane->ctx);
 }
 
-static void blk_event(void *opaque)
+static void xen_block_dataplane_event(void *opaque)
 {
     XenBlockDataPlane *dataplane = opaque;
 
@@ -637,7 +638,8 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
-    dataplane->bh = aio_bh_new(dataplane->ctx, blk_bh, dataplane);
+    dataplane->bh = aio_bh_new(dataplane->ctx, xen_block_dataplane_bh,
+                               dataplane);
 
     return dataplane;
 }
@@ -795,7 +797,7 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
 
     dataplane->event_channel =
         xen_device_bind_event_channel(xendev, event_channel,
-                                      blk_event, dataplane,
+                                      xen_block_dataplane_event, dataplane,
                                       &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.1.4
