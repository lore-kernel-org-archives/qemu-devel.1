Received: from eggs.gnu.org ([2001:4830:134:3::10]:52401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUR9-0001Y3-OA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUR5-0007cy-FR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:05 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:06 +0000
Message-ID: <20181121151211.15997-14-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 13/18] xen: purge 'blk' and 'ioreq' from
 function names in dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is a purely cosmetic patch that purges remaining use of 'blk' and
'ioreq' in local function names.

No functional change.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-qdisk.c | 86 +++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-qdisk.c
index 50a48b6f5f..94785eeff3 100644
--- a/hw/block/dataplane/xen-qdisk.c
+++ b/hw/block/dataplane/xen-qdisk.c
@@ -57,7 +57,7 @@ struct XenQdiskDataPlane {
     AioContext *ctx;
 };
 
-static void ioreq_reset(XenQdiskRequest *request)
+static void reset_request(XenQdiskRequest *request)
 {
     memset(&request->req, 0, sizeof(request->req));
     request->status = 0;
@@ -76,7 +76,7 @@ static void ioreq_reset(XenQdiskRequest *request)
     qemu_iovec_reset(&request->v);
 }
 
-static XenQdiskRequest *ioreq_start(XenQdiskDataPlane *dataplane)
+static XenQdiskRequest *start_request(XenQdiskDataPlane *dataplane)
 {
     XenQdiskRequest *request = NULL;
 
@@ -101,7 +101,7 @@ out:
     return request;
 }
 
-static void ioreq_finish(XenQdiskRequest *request)
+static void finish_request(XenQdiskRequest *request)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
 
@@ -111,12 +111,12 @@ static void ioreq_finish(XenQdiskRequest *request)
     dataplane->requests_finished++;
 }
 
-static void ioreq_release(XenQdiskRequest *request, bool finish)
+static void release_request(XenQdiskRequest *request, bool finish)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
 
     QLIST_REMOVE(request, list);
-    ioreq_reset(request);
+    reset_request(request);
     request->dataplane = dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
     if (finish) {
@@ -130,7 +130,7 @@ static void ioreq_release(XenQdiskRequest *request, bool finish)
  * translate request into iovec + start offset
  * do sanity checks along the way
  */
-static int ioreq_parse(XenQdiskRequest *request)
+static int parse_request(XenQdiskRequest *request)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
     size_t len;
@@ -191,7 +191,7 @@ err:
     return -1;
 }
 
-static int ioreq_grant_copy(XenQdiskRequest *request)
+static int copy_request(XenQdiskRequest *request)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
     XenDevice *xendev = dataplane->xendev;
@@ -240,9 +240,9 @@ static int ioreq_grant_copy(XenQdiskRequest *request)
     return 0;
 }
 
-static int ioreq_runio_qemu_aio(XenQdiskRequest *request);
+static int do_aio(XenQdiskRequest *request);
 
-static void qemu_aio_complete(void *opaque, int ret)
+static void complete_aio(void *opaque, int ret)
 {
     XenQdiskRequest *request = opaque;
     XenQdiskDataPlane *dataplane = request->dataplane;
@@ -259,7 +259,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     request->aio_inflight--;
     if (request->presync) {
         request->presync = 0;
-        ioreq_runio_qemu_aio(request);
+        do_aio(request);
         goto done;
     }
     if (request->aio_inflight > 0) {
@@ -270,7 +270,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     case BLKIF_OP_READ:
         /* in case of failure request->aio_errors is increased */
         if (ret == 0) {
-            ioreq_grant_copy(request);
+            copy_request(request);
         }
         qemu_vfree(request->buf);
         break;
@@ -286,7 +286,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     }
 
     request->status = request->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    ioreq_finish(request);
+    finish_request(request);
 
     switch (request->req.operation) {
     case BLKIF_OP_WRITE:
@@ -311,9 +311,8 @@ done:
     aio_context_release(dataplane->ctx);
 }
 
-static bool blk_split_discard(XenQdiskRequest *request,
-                              blkif_sector_t sector_number,
-                              uint64_t nr_sectors)
+static bool split_discard(XenQdiskRequest *request,
+                          blkif_sector_t sector_number, uint64_t nr_sectors)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
     int64_t byte_offset;
@@ -336,7 +335,7 @@ static bool blk_split_discard(XenQdiskRequest *request,
         byte_chunk = byte_remaining > limit ? limit : byte_remaining;
         request->aio_inflight++;
         blk_aio_pdiscard(dataplane->blk, byte_offset, byte_chunk,
-                         qemu_aio_complete, request);
+                         complete_aio, request);
         byte_remaining -= byte_chunk;
         byte_offset += byte_chunk;
     } while (byte_remaining > 0);
@@ -344,7 +343,7 @@ static bool blk_split_discard(XenQdiskRequest *request,
     return true;
 }
 
-static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
+static int do_aio(XenQdiskRequest *request)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
 
@@ -352,14 +351,14 @@ static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
     if (request->req.nr_segments &&
         (request->req.operation == BLKIF_OP_WRITE ||
          request->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
-        ioreq_grant_copy(request)) {
+        copy_request(request)) {
         qemu_vfree(request->buf);
         goto err;
     }
 
     request->aio_inflight++;
     if (request->presync) {
-        blk_aio_flush(request->dataplane->blk, qemu_aio_complete, request);
+        blk_aio_flush(request->dataplane->blk, complete_aio, request);
         return 0;
     }
 
@@ -370,7 +369,7 @@ static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
                          request->v.size, BLOCK_ACCT_READ);
         request->aio_inflight++;
         blk_aio_preadv(dataplane->blk, request->start, &request->v, 0,
-                       qemu_aio_complete, request);
+                       complete_aio, request);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
@@ -385,12 +384,12 @@ static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
                          BLOCK_ACCT_WRITE : BLOCK_ACCT_FLUSH);
         request->aio_inflight++;
         blk_aio_pwritev(dataplane->blk, request->start, &request->v, 0,
-                        qemu_aio_complete, request);
+                        complete_aio, request);
         break;
     case BLKIF_OP_DISCARD:
     {
         struct blkif_request_discard *req = (void *)&request->req;
-        if (!blk_split_discard(request, req->sector_number, req->nr_sectors)) {
+        if (!split_discard(request, req->sector_number, req->nr_sectors)) {
             goto err;
         }
         break;
@@ -400,17 +399,17 @@ static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
         goto err;
     }
 
-    qemu_aio_complete(request, 0);
+    complete_aio(request, 0);
 
     return 0;
 
 err:
-    ioreq_finish(request);
+    finish_request(request);
     request->status = BLKIF_RSP_ERROR;
     return -1;
 }
 
-static int blk_send_response_one(XenQdiskRequest *request)
+static int send_response_one(XenQdiskRequest *request)
 {
     XenQdiskDataPlane *dataplane = request->dataplane;
     int send_notify = 0;
@@ -466,15 +465,15 @@ static int blk_send_response_one(XenQdiskRequest *request)
 }
 
 /* walk finished list, send outstanding responses, free requests */
-static void blk_send_response_all(XenQdiskDataPlane *dataplane)
+static void send_response_all(XenQdiskDataPlane *dataplane)
 {
     XenQdiskRequest *request;
     int send_notify = 0;
 
     while (!QLIST_EMPTY(&dataplane->finished)) {
         request = QLIST_FIRST(&dataplane->finished);
-        send_notify += blk_send_response_one(request);
-        ioreq_release(request, true);
+        send_notify += send_response_one(request);
+        release_request(request, true);
     }
     if (send_notify) {
         xen_device_notify_event_channel(dataplane->xendev,
@@ -482,8 +481,8 @@ static void blk_send_response_all(XenQdiskDataPlane *dataplane)
     }
 }
 
-static int blk_get_request(XenQdiskDataPlane *dataplane,
-                           XenQdiskRequest *request, RING_IDX rc)
+static int get_request(XenQdiskDataPlane *dataplane,
+                       XenQdiskRequest *request, RING_IDX rc)
 {
     switch (dataplane->protocol) {
     case BLKIF_PROTOCOL_NATIVE: {
@@ -513,7 +512,7 @@ static int blk_get_request(XenQdiskDataPlane *dataplane,
     return 0;
 }
 
-static void blk_handle_requests(XenQdiskDataPlane *dataplane)
+static void handle_requests(XenQdiskDataPlane *dataplane)
 {
     RING_IDX rc, rp;
     XenQdiskRequest *request;
@@ -524,22 +523,22 @@ static void blk_handle_requests(XenQdiskDataPlane *dataplane)
     rp = dataplane->rings.common.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    blk_send_response_all(dataplane);
+    send_response_all(dataplane);
     while (rc != rp) {
         /* pull request from ring */
         if (RING_REQUEST_CONS_OVERFLOW(&dataplane->rings.common, rc)) {
             break;
         }
-        request = ioreq_start(dataplane);
+        request = start_request(dataplane);
         if (request == NULL) {
             dataplane->more_work++;
             break;
         }
-        blk_get_request(dataplane, request, rc);
+        get_request(dataplane, request, rc);
         dataplane->rings.common.req_cons = ++rc;
 
         /* parse them */
-        if (ioreq_parse(request) != 0) {
+        if (parse_request(request) != 0) {
 
             switch (request->req.operation) {
             case BLKIF_OP_READ:
@@ -557,15 +556,15 @@ static void blk_handle_requests(XenQdiskDataPlane *dataplane)
                 break;
             };
 
-            if (blk_send_response_one(request)) {
+            if (send_response_one(request)) {
                 xen_device_notify_event_channel(dataplane->xendev,
                                                 dataplane->event_channel);
             }
-            ioreq_release(request, false);
+            release_request(request, false);
             continue;
         }
 
-        ioreq_runio_qemu_aio(request);
+        do_aio(request);
     }
 
     if (dataplane->more_work &&
@@ -574,16 +573,16 @@ static void blk_handle_requests(XenQdiskDataPlane *dataplane)
     }
 }
 
-static void blk_bh(void *opaque)
+static void xen_qdisk_dataplane_bh(void *opaque)
 {
     XenQdiskDataPlane *dataplane = opaque;
 
     aio_context_acquire(dataplane->ctx);
-    blk_handle_requests(dataplane);
+    handle_requests(dataplane);
     aio_context_release(dataplane->ctx);
 }
 
-static void blk_event(void *opaque)
+static void xen_qdisk_dataplane_event(void *opaque)
 {
     XenQdiskDataPlane *dataplane = opaque;
 
@@ -612,7 +611,8 @@ XenQdiskDataPlane *xen_qdisk_dataplane_create(XenDevice *xendev,
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
-    dataplane->bh = aio_bh_new(dataplane->ctx, blk_bh, dataplane);
+    dataplane->bh = aio_bh_new(dataplane->ctx, xen_qdisk_dataplane_bh,
+                               dataplane);
 
     return dataplane;
 }
@@ -718,7 +718,7 @@ void xen_qdisk_dataplane_start(XenQdiskDataPlane *dataplane,
 
     dataplane->event_channel =
         xen_device_bind_event_channel(xendev, event_channel,
-                                      blk_event, dataplane,
+                                      xen_qdisk_dataplane_event, dataplane,
                                       &error_fatal);
 
     aio_context_acquire(dataplane->ctx);
-- 
2.11.0
