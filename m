Received: from eggs.gnu.org ([209.51.188.92]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lp-0007Em-Gk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lo-0004vg-JK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:59:17 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:1402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lo-0004v3-BU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:59:16 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 14 Jan 2019 13:51:52 +0000
Message-ID: <20190114135154.16826-24-anthony.perard@citrix.com>
In-Reply-To: <20190114135154.16826-1-anthony.perard@citrix.com>
References: <20190114135154.16826-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 23/25] xen-block: improve batching behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

From: Tim Smith <tim.smith@citrix.com>

When I/O consists of many small requests, performance is improved by
batching them together in a single io_submit() call. When there are
relatively few requests, the extra overhead is not worth it. This
introduces a check to start batching I/O requests via blk_io_plug()/
blk_io_unplug() in an amount proportional to the number which were
already in flight at the time we started reading the ring.

Signed-off-by: Tim Smith <tim.smith@citrix.com>

Re-based and commit comment adjusted.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 8e3965e171..acd23a74a8 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -528,10 +528,18 @@ static int xen_block_get_request(XenBlockDataPlane *dataplane,
     return 0;
 }
 
+/*
+ * Threshold of in-flight requests above which we will start using
+ * blk_io_plug()/blk_io_unplug() to batch requests.
+ */
+#define IO_PLUG_THRESHOLD 1
+
 static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
 {
     RING_IDX rc, rp;
     XenBlockRequest *request;
+    int inflight_atstart = dataplane->requests_inflight;
+    int batched = 0;
 
     dataplane->more_work = 0;
 
@@ -540,6 +548,18 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
     xen_block_send_response_all(dataplane);
+    /*
+     * If there was more than IO_PLUG_THRESHOLD requests in flight
+     * when we got here, this is an indication that there the bottleneck
+     * is below us, so it's worth beginning to batch up I/O requests
+     * rather than submitting them immediately. The maximum number
+     * of requests we're willing to batch is the number already in
+     * flight, so it can grow up to max_requests when the bottleneck
+     * is below us.
+     */
+    if (inflight_atstart > IO_PLUG_THRESHOLD) {
+        blk_io_plug(dataplane->blk);
+    }
     while (rc != rp) {
         /* pull request from ring */
         if (RING_REQUEST_CONS_OVERFLOW(&dataplane->rings.common, rc)) {
@@ -585,7 +605,22 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
             continue;
         }
 
+        if (inflight_atstart > IO_PLUG_THRESHOLD &&
+            batched >= inflight_atstart) {
+            blk_io_unplug(dataplane->blk);
+        }
         xen_block_do_aio(request);
+        if (inflight_atstart > IO_PLUG_THRESHOLD) {
+            if (batched >= inflight_atstart) {
+                blk_io_plug(dataplane->blk);
+                batched = 0;
+            } else {
+                batched++;
+            }
+        }
+    }
+    if (inflight_atstart > IO_PLUG_THRESHOLD) {
+        blk_io_unplug(dataplane->blk);
     }
 
     if (dataplane->more_work &&
-- 
Anthony PERARD
