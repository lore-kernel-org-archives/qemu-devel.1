Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBo-00050K-I2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBn-0003ZD-Am
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:56:00 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 4 May 2018 14:55:33 +0100
Message-ID: <1525442134-20488-8-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
References: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 7/8] xen_disk: use a single entry iovec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Since xen_disk now always copies data to and from a guest there is no need
to maintain a vector entry corresponding to every page of a request.
This means there is less per-request state to maintain so the ioreq
structure can shrink significantly.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

v2:
 - Re-based
---
 hw/block/xen_disk.c | 71 ++++++++++++++---------------------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 28be8b6..230961f 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -46,13 +46,10 @@ struct ioreq {
     /* parsed request */
     off_t               start;
     QEMUIOVector        v;
+    void                *buf;
+    size_t              size;
     int                 presync;
 
-    /* grant mapping */
-    uint32_t            refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    void                *pages;
-
     /* aio status */
     int                 aio_inflight;
     int                 aio_errors;
@@ -110,12 +107,10 @@ static void ioreq_reset(struct ioreq *ioreq)
     memset(&ioreq->req, 0, sizeof(ioreq->req));
     ioreq->status = 0;
     ioreq->start = 0;
+    ioreq->buf = NULL;
+    ioreq->size = 0;
     ioreq->presync = 0;
 
-    memset(ioreq->refs, 0, sizeof(ioreq->refs));
-    memset(ioreq->page, 0, sizeof(ioreq->page));
-    ioreq->pages = NULL;
-
     ioreq->aio_inflight = 0;
     ioreq->aio_errors = 0;
 
@@ -138,7 +133,7 @@ static struct ioreq *ioreq_start(struct XenBlkDev *blkdev)
         ioreq = g_malloc0(sizeof(*ioreq));
         ioreq->blkdev = blkdev;
         blkdev->requests_total++;
-        qemu_iovec_init(&ioreq->v, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+        qemu_iovec_init(&ioreq->v, 1);
     } else {
         /* get one from freelist */
         ioreq = QLIST_FIRST(&blkdev->freelist);
@@ -183,7 +178,6 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
 static int ioreq_parse(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    uintptr_t mem;
     size_t len;
     int i;
 
@@ -230,13 +224,10 @@ static int ioreq_parse(struct ioreq *ioreq)
             goto err;
         }
 
-        ioreq->refs[i]   = ioreq->req.seg[i].gref;
-
-        mem = ioreq->req.seg[i].first_sect * blkdev->file_blk;
         len = (ioreq->req.seg[i].last_sect - ioreq->req.seg[i].first_sect + 1) * blkdev->file_blk;
-        qemu_iovec_add(&ioreq->v, (void*)mem, len);
+        ioreq->size += len;
     }
-    if (ioreq->start + ioreq->v.size > blkdev->file_size) {
+    if (ioreq->start + ioreq->size > blkdev->file_size) {
         xen_pv_printf(&blkdev->xendev, 0, "error: access beyond end of file\n");
         goto err;
     }
@@ -247,35 +238,6 @@ err:
     return -1;
 }
 
-static void ioreq_free_copy_buffers(struct ioreq *ioreq)
-{
-    int i;
-
-    for (i = 0; i < ioreq->v.niov; i++) {
-        ioreq->page[i] = NULL;
-    }
-
-    qemu_vfree(ioreq->pages);
-}
-
-static int ioreq_init_copy_buffers(struct ioreq *ioreq)
-{
-    int i;
-
-    if (ioreq->v.niov == 0) {
-        return 0;
-    }
-
-    ioreq->pages = qemu_memalign(XC_PAGE_SIZE, ioreq->v.niov * XC_PAGE_SIZE);
-
-    for (i = 0; i < ioreq->v.niov; i++) {
-        ioreq->page[i] = ioreq->pages + i * XC_PAGE_SIZE;
-        ioreq->v.iov[i].iov_base = ioreq->page[i];
-    }
-
-    return 0;
-}
-
 static int ioreq_grant_copy(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
@@ -284,6 +246,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
     int i, count, rc;
     int64_t file_blk = ioreq->blkdev->file_blk;
     bool to_domain = (ioreq->req.operation == BLKIF_OP_READ);
+    void *virt = ioreq->buf;
 
     if (ioreq->v.niov == 0) {
         return 0;
@@ -293,16 +256,17 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
 
     for (i = 0; i < count; i++) {
         if (to_domain) {
-            segs[i].dest.foreign.ref = ioreq->refs[i];
+            segs[i].dest.foreign.ref = ioreq->req.seg[i].gref;
             segs[i].dest.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
-            segs[i].source.virt = ioreq->v.iov[i].iov_base;
+            segs[i].source.virt = virt;
         } else {
-            segs[i].source.foreign.ref = ioreq->refs[i];
+            segs[i].source.foreign.ref = ioreq->req.seg[i].gref;
             segs[i].source.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
-            segs[i].dest.virt = ioreq->v.iov[i].iov_base;
+            segs[i].dest.virt = virt;
         }
         segs[i].len = (ioreq->req.seg[i].last_sect
                        - ioreq->req.seg[i].first_sect + 1) * file_blk;
+        virt += segs[i].len;
     }
 
     rc = xen_be_copy_grant_refs(xendev, to_domain, segs, count);
@@ -314,6 +278,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
         return -1;
     }
 
+    qemu_iovec_add(&ioreq->v, ioreq->buf, ioreq->size);
     return rc;
 }
 
@@ -348,14 +313,14 @@ static void qemu_aio_complete(void *opaque, int ret)
         if (ret == 0) {
             ioreq_grant_copy(ioreq);
         }
-        ioreq_free_copy_buffers(ioreq);
+        qemu_vfree(ioreq->buf);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
         if (!ioreq->req.nr_segments) {
             break;
         }
-        ioreq_free_copy_buffers(ioreq);
+        qemu_vfree(ioreq->buf);
         break;
     default:
         break;
@@ -423,12 +388,12 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
-    ioreq_init_copy_buffers(ioreq);
+    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
     if (ioreq->req.nr_segments &&
         (ioreq->req.operation == BLKIF_OP_WRITE ||
          ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
         ioreq_grant_copy(ioreq)) {
-        ioreq_free_copy_buffers(ioreq);
+        qemu_vfree(ioreq->buf);
         goto err;
     }
 
-- 
2.1.4
