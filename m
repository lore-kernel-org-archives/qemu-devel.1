Received: from eggs.gnu.org ([2001:4830:134:3::10]:49114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80b-0005Oe-DW
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80a-0000py-B8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:21 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 30 Apr 2018 13:01:38 +0100
Message-ID: <1525089699-13411-4-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] block/xen_disk: use a single entry iovec
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
---
 hw/block/xen_disk.c | 103 ++++++++++++++++------------------------------------
 1 file changed, 31 insertions(+), 72 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 8f4e229..6d737fd 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -46,13 +46,10 @@ struct ioreq {
     /* parsed request */
     off_t               start;
     QEMUIOVector        v;
+    void                *buf;
+    size_t              size;
     int                 presync;
 
-    uint32_t            domids[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    uint32_t            refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    void                *pages;
-
     /* aio status */
     int                 aio_inflight;
     int                 aio_errors;
@@ -110,13 +107,10 @@ static void ioreq_reset(struct ioreq *ioreq)
     memset(&ioreq->req, 0, sizeof(ioreq->req));
     ioreq->status = 0;
     ioreq->start = 0;
+    ioreq->buf = NULL;
+    ioreq->size = 0;
     ioreq->presync = 0;
 
-    memset(ioreq->domids, 0, sizeof(ioreq->domids));
-    memset(ioreq->refs, 0, sizeof(ioreq->refs));
-    memset(ioreq->page, 0, sizeof(ioreq->page));
-    ioreq->pages = NULL;
-
     ioreq->aio_inflight = 0;
     ioreq->aio_errors = 0;
 
@@ -139,7 +133,7 @@ static struct ioreq *ioreq_start(struct XenBlkDev *blkdev)
         ioreq = g_malloc0(sizeof(*ioreq));
         ioreq->blkdev = blkdev;
         blkdev->requests_total++;
-        qemu_iovec_init(&ioreq->v, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+        qemu_iovec_init(&ioreq->v, 1);
     } else {
         /* get one from freelist */
         ioreq = QLIST_FIRST(&blkdev->freelist);
@@ -184,7 +178,6 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
 static int ioreq_parse(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    uintptr_t mem;
     size_t len;
     int i;
 
@@ -231,14 +224,10 @@ static int ioreq_parse(struct ioreq *ioreq)
             goto err;
         }
 
-        ioreq->domids[i] = blkdev->xendev.dom;
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
@@ -249,85 +238,55 @@ err:
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
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+    xengnttab_handle *gnt = blkdev->xendev.gnttabdev;
+    void *virt = ioreq->buf;
     xengnttab_grant_copy_segment_t segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    int i, count, rc;
-    int64_t file_blk = ioreq->blkdev->file_blk;
-
-    if (ioreq->v.niov == 0) {
-        return 0;
-    }
+    int i, rc;
+    int64_t file_blk = blkdev->file_blk;
 
-    count = ioreq->v.niov;
-
-    for (i = 0; i < count; i++) {
+    for (i = 0; i < ioreq->req.nr_segments; i++) {
         if (ioreq->req.operation == BLKIF_OP_READ) {
             segs[i].flags = GNTCOPY_dest_gref;
-            segs[i].dest.foreign.ref = ioreq->refs[i];
-            segs[i].dest.foreign.domid = ioreq->domids[i];
+            segs[i].dest.foreign.ref = ioreq->req.seg[i].gref;
+            segs[i].dest.foreign.domid = blkdev->xendev.dom;
             segs[i].dest.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
-            segs[i].source.virt = ioreq->v.iov[i].iov_base;
+            segs[i].source.virt = virt;
         } else {
             segs[i].flags = GNTCOPY_source_gref;
-            segs[i].source.foreign.ref = ioreq->refs[i];
-            segs[i].source.foreign.domid = ioreq->domids[i];
+            segs[i].source.foreign.ref = ioreq->req.seg[i].gref;
+            segs[i].source.foreign.domid = blkdev->xendev.dom;
             segs[i].source.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
-            segs[i].dest.virt = ioreq->v.iov[i].iov_base;
+            segs[i].dest.virt = virt;
         }
         segs[i].len = (ioreq->req.seg[i].last_sect
                        - ioreq->req.seg[i].first_sect + 1) * file_blk;
+        virt += segs[i].len;
     }
 
-    rc = xengnttab_grant_copy(gnt, count, segs);
+    rc = xengnttab_grant_copy(gnt, ioreq->req.nr_segments, segs);
 
     if (rc) {
-        xen_pv_printf(&ioreq->blkdev->xendev, 0,
+        xen_pv_printf(&blkdev->xendev, 0,
                       "failed to copy data %d\n", rc);
         ioreq->aio_errors++;
         return -1;
     }
 
-    for (i = 0; i < count; i++) {
+    for (i = 0; i < ioreq->req.nr_segments; i++) {
         if (segs[i].status != GNTST_okay) {
-            xen_pv_printf(&ioreq->blkdev->xendev, 3,
+            xen_pv_printf(&blkdev->xendev, 3,
                           "failed to copy data %d for gref %d, domid %d\n",
-                          segs[i].status, ioreq->refs[i], ioreq->domids[i]);
+                          segs[i].status, ioreq->req.seg[i].gref,
+                          blkdev->xendev.dom);
             ioreq->aio_errors++;
             rc = -1;
         }
     }
 
+    qemu_iovec_add(&ioreq->v, ioreq->buf, ioreq->size);
     return rc;
 }
 
@@ -362,14 +321,14 @@ static void qemu_aio_complete(void *opaque, int ret)
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
@@ -437,12 +396,12 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
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
