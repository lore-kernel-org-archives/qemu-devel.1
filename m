Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtP-0002E7-6k
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtN-0002lO-Uw
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:35 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:46161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=781850b12=tim.smith@citrix.com>)
	id 1fyDtN-0002ey-LK
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 06:21:33 -0400
From: Tim Smith <tim.smith@citrix.com>
Date: Fri, 7 Sep 2018 11:21:30 +0100
Message-ID: <153631569081.32214.17009673757832831029.stgit@dhcp-3-135.uk.xensource.com>
In-Reply-To: <153631568068.32214.13361287430751567885.stgit@dhcp-3-135.uk.xensource.com>
References: <153631568068.32214.13361287430751567885.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/3] Avoid repeated memory allocation in
 xen_disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

xen_disk currently allocates memory to hold the data for each ioreq
as that ioreq is used, and frees it afterwards. Because it requires
page-aligned blocks, this interacts poorly with non-page-aligned
allocations and balloons the heap.

Instead, allocate the maximum possible requirement, which is
BLKIF_MAX_SEGMENTS_PER_REQUEST pages (currently 11 pages) when
the ioreq is created, and keep that allocation until it is destroyed.
Since the ioreqs themselves are re-used via a free list, this
should actually improve memory usage.

Signed-off-by: Tim Smith <tim.smith@citrix.com>
---
 hw/block/xen_disk.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index c11cd21d37..67f894bba5 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -112,7 +112,6 @@ static void ioreq_reset(struct ioreq *ioreq)
     memset(&ioreq->req, 0, sizeof(ioreq->req));
     ioreq->status = 0;
     ioreq->start = 0;
-    ioreq->buf = NULL;
     ioreq->size = 0;
     ioreq->presync = 0;
 
@@ -137,6 +136,10 @@ static struct ioreq *ioreq_start(struct XenBlkDev *blkdev)
         /* allocate new struct */
         ioreq = g_malloc0(sizeof(*ioreq));
         ioreq->blkdev = blkdev;
+        /* We cannot need more pages per ioreq than this, and we do re-use ioreqs,
+         * so allocate the memory once here, to be freed in blk_free() when the
+         * ioreq is freed. */
+        ioreq->buf = qemu_memalign(XC_PAGE_SIZE, BLKIF_MAX_SEGMENTS_PER_REQUEST * XC_PAGE_SIZE);
         blkdev->requests_total++;
         qemu_iovec_init(&ioreq->v, 1);
     } else {
@@ -313,14 +316,12 @@ static void qemu_aio_complete(void *opaque, int ret)
         if (ret == 0) {
             ioreq_grant_copy(ioreq);
         }
-        qemu_vfree(ioreq->buf);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
         if (!ioreq->req.nr_segments) {
             break;
         }
-        qemu_vfree(ioreq->buf);
         break;
     default:
         break;
@@ -392,12 +393,10 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
-    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
     if (ioreq->req.nr_segments &&
         (ioreq->req.operation == BLKIF_OP_WRITE ||
          ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
         ioreq_grant_copy(ioreq)) {
-        qemu_vfree(ioreq->buf);
         goto err;
     }
 
@@ -989,6 +988,7 @@ static int blk_free(struct XenDevice *xendev)
         ioreq = QLIST_FIRST(&blkdev->freelist);
         QLIST_REMOVE(ioreq, list);
         qemu_iovec_destroy(&ioreq->v);
+        qemu_vfree(ioreq->buf);
         g_free(ioreq);
     }
 
