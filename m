Received: from eggs.gnu.org ([2001:4830:134:3::10]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VK-0006qm-PN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VJ-0003L9-Mu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:38 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 12 Dec 2018 11:16:24 +0000
Message-ID: <1544613386-22045-2-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
References: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/3] xen-block: improve batching behaviour
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

When I/O consists of many small requests, performance is improved by
batching them together in a single io_submit() call. When there are
relatively few requests, the extra overhead is not worth it. This
introduces a check to start batching I/O requests via blk_io_plug()/
blk_io_unplug() in an amount proportional to the number which were
already in flight at the time we started reading the ring.

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
 hw/block/dataplane/xen-block.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 80df7da..db17ab5 100644
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
2.1.4
