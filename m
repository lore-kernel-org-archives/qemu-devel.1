Received: from eggs.gnu.org ([2001:4830:134:3::10]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VJ-0006p8-Aq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VI-0003BZ-6R
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:37 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 12 Dec 2018 11:16:25 +0000
Message-ID: <1544613386-22045-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
References: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/3] xen-block: improve response latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Tim Smith <tim.smith@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Tim Smith <tim.smith@citrix.com>

If the I/O ring is full, the guest cannot send any more requests
until some responses are sent. Only sending all available responses
just before checking for new work does not leave much time for the
guest to supply new work, so this will cause stalls if the ring gets
full. Also, not completing reads as soon as possible adds latency
to the guest.

To alleviate that, complete IO requests as soon as they come back.
xen_block_send_response() already returns a value indicating whether
a notify should be sent, which is all the batching we need.

Signed-off-by: Tim Smith <tim.smith@citrix.com>

Re-based and commit comment adjusted.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c | 56 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index db17ab5..b4ff2e3 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -55,11 +55,9 @@ struct XenBlockDataPlane {
     blkif_back_rings_t rings;
     int more_work;
     QLIST_HEAD(inflight_head, XenBlockRequest) inflight;
-    QLIST_HEAD(finished_head, XenBlockRequest) finished;
     QLIST_HEAD(freelist_head, XenBlockRequest) freelist;
     int requests_total;
     int requests_inflight;
-    int requests_finished;
     unsigned int max_requests;
     BlockBackend *blk;
     QEMUBH *bh;
@@ -116,12 +114,10 @@ static void xen_block_finish_request(XenBlockRequest *request)
     XenBlockDataPlane *dataplane = request->dataplane;
 
     QLIST_REMOVE(request, list);
-    QLIST_INSERT_HEAD(&dataplane->finished, request, list);
     dataplane->requests_inflight--;
-    dataplane->requests_finished++;
 }
 
-static void xen_block_release_request(XenBlockRequest *request, bool finish)
+static void xen_block_release_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
@@ -129,11 +125,7 @@ static void xen_block_release_request(XenBlockRequest *request, bool finish)
     reset_request(request);
     request->dataplane = dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
-    if (finish) {
-        dataplane->requests_finished--;
-    } else {
-        dataplane->requests_inflight--;
-    }
+    dataplane->requests_inflight--;
 }
 
 /*
@@ -248,6 +240,7 @@ static int xen_block_copy_request(XenBlockRequest *request)
 }
 
 static int xen_block_do_aio(XenBlockRequest *request);
+static int xen_block_send_response(XenBlockRequest *request);
 
 static void xen_block_complete_aio(void *opaque, int ret)
 {
@@ -312,6 +305,18 @@ static void xen_block_complete_aio(void *opaque, int ret)
     default:
         break;
     }
+    if (xen_block_send_response(request)) {
+        Error *local_err = NULL;
+
+        xen_device_notify_event_channel(dataplane->xendev,
+                                        dataplane->event_channel,
+                                        &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
+    xen_block_release_request(request);
+
     qemu_bh_schedule(dataplane->bh);
 
 done:
@@ -419,7 +424,7 @@ err:
     return -1;
 }
 
-static int xen_block_send_response_one(XenBlockRequest *request)
+static int xen_block_send_response(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
     int send_notify = 0;
@@ -474,29 +479,6 @@ static int xen_block_send_response_one(XenBlockRequest *request)
     return send_notify;
 }
 
-/* walk finished list, send outstanding responses, free requests */
-static void xen_block_send_response_all(XenBlockDataPlane *dataplane)
-{
-    XenBlockRequest *request;
-    int send_notify = 0;
-
-    while (!QLIST_EMPTY(&dataplane->finished)) {
-        request = QLIST_FIRST(&dataplane->finished);
-        send_notify += xen_block_send_response_one(request);
-        xen_block_release_request(request, true);
-    }
-    if (send_notify) {
-        Error *local_err = NULL;
-
-        xen_device_notify_event_channel(dataplane->xendev,
-                                        dataplane->event_channel,
-                                        &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    }
-}
-
 static int xen_block_get_request(XenBlockDataPlane *dataplane,
                                  XenBlockRequest *request, RING_IDX rc)
 {
@@ -547,7 +529,6 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
     rp = dataplane->rings.common.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    xen_block_send_response_all(dataplane);
     /*
      * If there was more than IO_PLUG_THRESHOLD requests in flight
      * when we got here, this is an indication that there the bottleneck
@@ -591,7 +572,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
                 break;
             };
 
-            if (xen_block_send_response_one(request)) {
+            if (xen_block_send_response(request)) {
                 Error *local_err = NULL;
 
                 xen_device_notify_event_channel(dataplane->xendev,
@@ -601,7 +582,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
                     error_report_err(local_err);
                 }
             }
-            xen_block_release_request(request, false);
+            xen_block_release_request(request);
             continue;
         }
 
@@ -657,7 +638,6 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     dataplane->file_size = blk_getlength(dataplane->blk);
 
     QLIST_INIT(&dataplane->inflight);
-    QLIST_INIT(&dataplane->finished);
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
-- 
2.1.4
