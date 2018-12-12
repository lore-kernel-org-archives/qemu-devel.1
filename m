Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VK-0006q9-4k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VJ-0003HK-2X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:38 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 12 Dec 2018 11:16:26 +0000
Message-ID: <1544613386-22045-4-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
References: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/3] xen-block: avoid repeated memory
 allocation
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
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index b4ff2e3..21804d7 100644
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
2.1.4
