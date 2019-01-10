Received: from eggs.gnu.org ([209.51.188.92]:58546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghb5L-0006cH-0m
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1gharK-0002Km-7G
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:58:58 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:12008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1gharJ-0001xV-Vr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:58:58 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 10 Jan 2019 13:49:17 +0000
Message-ID: <20190110134917.16425-26-anthony.perard@citrix.com>
In-Reply-To: <20190110134917.16425-1-anthony.perard@citrix.com>
References: <20190110134917.16425-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 25/25] xen-block: avoid repeated memory
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Tim Smith <tim.smith@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>

From: Tim Smith <tim.smith@citrix.com>

The xen-block dataplane currently allocates memory to hold the data for
each request as that request is used, and frees it afterwards. Because
it requires page-aligned blocks, this interacts poorly with non-page-
aligned allocations and balloons the heap.

Instead, allocate the maximum possible buffer size required for the
protocol, which is BLKIF_MAX_SEGMENTS_PER_REQUEST (currently 11) pages
when the request structure is created, and keep that buffer until it is
destroyed. Since the requests are re-used via a free list, this should
actually improve memory usage.

Signed-off-by: Tim Smith <tim.smith@citrix.com>

Re-based and commit comment adjusted.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 35bfccfba7..d0d8905a33 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -70,7 +70,6 @@ static void reset_request(XenBlockRequest *request)
     memset(&request->req, 0, sizeof(request->req));
     request->status = 0;
     request->start = 0;
-    request->buf = NULL;
     request->size = 0;
     request->presync = 0;
 
@@ -95,6 +94,14 @@ static XenBlockRequest *xen_block_start_request(XenBlockDataPlane *dataplane)
         /* allocate new struct */
         request = g_malloc0(sizeof(*request));
         request->dataplane = dataplane;
+        /*
+         * We cannot need more pages per requests than this, and since we
+         * re-use requests, allocate the memory once here. It will be freed
+         * xen_block_dataplane_destroy() when the request list is freed.
+         */
+        request->buf = qemu_memalign(XC_PAGE_SIZE,
+                                     BLKIF_MAX_SEGMENTS_PER_REQUEST *
+                                     XC_PAGE_SIZE);
         dataplane->requests_total++;
         qemu_iovec_init(&request->v, 1);
     } else {
@@ -272,14 +279,12 @@ static void xen_block_complete_aio(void *opaque, int ret)
         if (ret == 0) {
             xen_block_copy_request(request);
         }
-        qemu_vfree(request->buf);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
         if (!request->req.nr_segments) {
             break;
         }
-        qemu_vfree(request->buf);
         break;
     default:
         break;
@@ -360,12 +365,10 @@ static int xen_block_do_aio(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
-    request->buf = qemu_memalign(XC_PAGE_SIZE, request->size);
     if (request->req.nr_segments &&
         (request->req.operation == BLKIF_OP_WRITE ||
          request->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
         xen_block_copy_request(request)) {
-        qemu_vfree(request->buf);
         goto err;
     }
 
@@ -665,6 +668,7 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
         request = QLIST_FIRST(&dataplane->freelist);
         QLIST_REMOVE(request, list);
         qemu_iovec_destroy(&request->v);
+        qemu_vfree(request->buf);
         g_free(request);
     }
 
-- 
Anthony PERARD
