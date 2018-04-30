Received: from eggs.gnu.org ([2001:4830:134:3::10]:49189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80j-0005X3-KO
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80h-0000vp-UR
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:29 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 30 Apr 2018 13:01:37 +0100
Message-ID: <1525089699-13411-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] block/xen_disk: remove use of grant
 map/unmap
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

The grant copy operation was added to libxengnttab in Xen 4.8.0. If grant
copy is available then data from the guest will be copied rather than
mapped.
The xen_disk source can be significantly simplified by removing this now
redundant code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen_disk.c | 194 ++++++++--------------------------------------------
 1 file changed, 27 insertions(+), 167 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index b33611a..8f4e229 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -36,10 +36,6 @@
 
 /* ------------------------------------------------------------- */
 
-static int batch_maps   = 0;
-
-/* ------------------------------------------------------------- */
-
 #define BLOCK_SIZE  512
 #define IOCB_COUNT  (BLKIF_MAX_SEGMENTS_PER_REQUEST + 2)
 
@@ -51,12 +47,9 @@ struct ioreq {
     off_t               start;
     QEMUIOVector        v;
     int                 presync;
-    uint8_t             mapped;
 
-    /* grant mapping */
     uint32_t            domids[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     uint32_t            refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    int                 prot;
     void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     void                *pages;
 
@@ -89,7 +82,6 @@ struct XenBlkDev {
     int                 protocol;
     blkif_back_rings_t  rings;
     int                 more_work;
-    int                 cnt_map;
 
     /* request lists */
     QLIST_HEAD(inflight_head, ioreq) inflight;
@@ -119,11 +111,9 @@ static void ioreq_reset(struct ioreq *ioreq)
     ioreq->status = 0;
     ioreq->start = 0;
     ioreq->presync = 0;
-    ioreq->mapped = 0;
 
     memset(ioreq->domids, 0, sizeof(ioreq->domids));
     memset(ioreq->refs, 0, sizeof(ioreq->refs));
-    ioreq->prot = 0;
     memset(ioreq->page, 0, sizeof(ioreq->page));
     ioreq->pages = NULL;
 
@@ -204,7 +194,6 @@ static int ioreq_parse(struct ioreq *ioreq)
                   ioreq->req.handle, ioreq->req.id, ioreq->req.sector_number);
     switch (ioreq->req.operation) {
     case BLKIF_OP_READ:
-        ioreq->prot = PROT_WRITE; /* to memory */
         break;
     case BLKIF_OP_FLUSH_DISKCACHE:
         ioreq->presync = 1;
@@ -213,7 +202,6 @@ static int ioreq_parse(struct ioreq *ioreq)
         }
         /* fall through */
     case BLKIF_OP_WRITE:
-        ioreq->prot = PROT_READ; /* from memory */
         break;
     case BLKIF_OP_DISCARD:
         return 0;
@@ -261,88 +249,6 @@ err:
     return -1;
 }
 
-static void ioreq_unmap(struct ioreq *ioreq)
-{
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
-    int i;
-
-    if (ioreq->v.niov == 0 || ioreq->mapped == 0) {
-        return;
-    }
-    if (batch_maps) {
-        if (!ioreq->pages) {
-            return;
-        }
-        if (xengnttab_unmap(gnt, ioreq->pages, ioreq->v.niov) != 0) {
-            xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                          "xengnttab_unmap failed: %s\n",
-                          strerror(errno));
-        }
-        ioreq->blkdev->cnt_map -= ioreq->v.niov;
-        ioreq->pages = NULL;
-    } else {
-        for (i = 0; i < ioreq->v.niov; i++) {
-            if (!ioreq->page[i]) {
-                continue;
-            }
-            if (xengnttab_unmap(gnt, ioreq->page[i], 1) != 0) {
-                xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                              "xengnttab_unmap failed: %s\n",
-                              strerror(errno));
-            }
-            ioreq->blkdev->cnt_map--;
-            ioreq->page[i] = NULL;
-        }
-    }
-    ioreq->mapped = 0;
-}
-
-static int ioreq_map(struct ioreq *ioreq)
-{
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
-    int i;
-
-    if (ioreq->v.niov == 0 || ioreq->mapped == 1) {
-        return 0;
-    }
-    if (batch_maps) {
-        ioreq->pages = xengnttab_map_grant_refs
-            (gnt, ioreq->v.niov, ioreq->domids, ioreq->refs, ioreq->prot);
-        if (ioreq->pages == NULL) {
-            xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                          "can't map %d grant refs (%s, %d maps)\n",
-                          ioreq->v.niov, strerror(errno),
-                          ioreq->blkdev->cnt_map);
-            return -1;
-        }
-        for (i = 0; i < ioreq->v.niov; i++) {
-            ioreq->v.iov[i].iov_base = ioreq->pages + i * XC_PAGE_SIZE +
-                (uintptr_t)ioreq->v.iov[i].iov_base;
-        }
-        ioreq->blkdev->cnt_map += ioreq->v.niov;
-    } else  {
-        for (i = 0; i < ioreq->v.niov; i++) {
-            ioreq->page[i] = xengnttab_map_grant_ref
-                (gnt, ioreq->domids[i], ioreq->refs[i], ioreq->prot);
-            if (ioreq->page[i] == NULL) {
-                xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                              "can't map grant ref %d (%s, %d maps)\n",
-                              ioreq->refs[i], strerror(errno),
-                              ioreq->blkdev->cnt_map);
-                ioreq->mapped = 1;
-                ioreq_unmap(ioreq);
-                return -1;
-            }
-            ioreq->v.iov[i].iov_base = ioreq->page[i] +
-                (uintptr_t)ioreq->v.iov[i].iov_base;
-        }
-    }
-    ioreq->mapped = 1;
-    return 0;
-}
-
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40800
-
 static void ioreq_free_copy_buffers(struct ioreq *ioreq)
 {
     int i;
@@ -424,22 +330,6 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
 
     return rc;
 }
-#else
-static void ioreq_free_copy_buffers(struct ioreq *ioreq)
-{
-    abort();
-}
-
-static int ioreq_init_copy_buffers(struct ioreq *ioreq)
-{
-    abort();
-}
-
-static int ioreq_grant_copy(struct ioreq *ioreq)
-{
-    abort();
-}
-#endif
 
 static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
 
@@ -466,32 +356,28 @@ static void qemu_aio_complete(void *opaque, int ret)
         goto done;
     }
 
-    if (xen_feature_grant_copy) {
-        switch (ioreq->req.operation) {
-        case BLKIF_OP_READ:
-            /* in case of failure ioreq->aio_errors is increased */
-            if (ret == 0) {
-                ioreq_grant_copy(ioreq);
-            }
-            ioreq_free_copy_buffers(ioreq);
-            break;
-        case BLKIF_OP_WRITE:
-        case BLKIF_OP_FLUSH_DISKCACHE:
-            if (!ioreq->req.nr_segments) {
-                break;
-            }
-            ioreq_free_copy_buffers(ioreq);
-            break;
-        default:
+    switch (ioreq->req.operation) {
+    case BLKIF_OP_READ:
+        /* in case of failure ioreq->aio_errors is increased */
+        if (ret == 0) {
+            ioreq_grant_copy(ioreq);
+        }
+        ioreq_free_copy_buffers(ioreq);
+        break;
+    case BLKIF_OP_WRITE:
+    case BLKIF_OP_FLUSH_DISKCACHE:
+        if (!ioreq->req.nr_segments) {
             break;
         }
+        ioreq_free_copy_buffers(ioreq);
+        break;
+    default:
+        break;
     }
 
     ioreq->status = ioreq->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    if (!xen_feature_grant_copy) {
-        ioreq_unmap(ioreq);
-    }
     ioreq_finish(ioreq);
+
     switch (ioreq->req.operation) {
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
@@ -551,18 +437,13 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
-    if (xen_feature_grant_copy) {
-        ioreq_init_copy_buffers(ioreq);
-        if (ioreq->req.nr_segments && (ioreq->req.operation == BLKIF_OP_WRITE ||
-            ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
-            ioreq_grant_copy(ioreq)) {
-                ioreq_free_copy_buffers(ioreq);
-                goto err;
-        }
-    } else {
-        if (ioreq->req.nr_segments && ioreq_map(ioreq)) {
-            goto err;
-        }
+    ioreq_init_copy_buffers(ioreq);
+    if (ioreq->req.nr_segments &&
+        (ioreq->req.operation == BLKIF_OP_WRITE ||
+         ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
+        ioreq_grant_copy(ioreq)) {
+        ioreq_free_copy_buffers(ioreq);
+        goto err;
     }
 
     ioreq->aio_inflight++;
@@ -603,9 +484,6 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
     }
     default:
         /* unknown operation (shouldn't happen -- parse catches this) */
-        if (!xen_feature_grant_copy) {
-            ioreq_unmap(ioreq);
-        }
         goto err;
     }
 
@@ -791,10 +669,6 @@ static void blk_alloc(struct XenDevice *xendev)
 
     blkdev->ctx = iothread_get_aio_context(blkdev->iothread);
     blkdev->bh = aio_bh_new(blkdev->ctx, blk_bh, blkdev);
-
-    if (xen_mode != XEN_EMULATE) {
-        batch_maps = 1;
-    }
 }
 
 static void blk_parse_discard(struct XenBlkDev *blkdev)
@@ -877,8 +751,9 @@ static int blk_init(struct XenDevice *xendev)
 
     blkdev->file_blk  = BLOCK_SIZE;
 
-    xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
-                  xen_feature_grant_copy ? "enabled" : "disabled");
+    if (!xen_feature_grant_copy) {
+        goto out_error;
+    }
 
     /* fill info
      * blk_connect supplies sector-size and sectors
@@ -910,15 +785,6 @@ out_error:
     return -1;
 }
 
-/*
- * We need to account for the grant allocations requiring contiguous
- * chunks; the worst case number would be
- *     max_req * max_seg + (max_req - 1) * (max_seg - 1) + 1,
- * but in order to keep things simple just use
- *     2 * max_req * max_seg.
- */
-#define MAX_GRANTS(max_req, max_seg) (2 * (max_req) * (max_seg))
-
 static int blk_connect(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
@@ -1079,11 +945,8 @@ static int blk_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    /* Calculate the maximum number of grants needed by ioreqs */
-    max_grants = MAX_GRANTS(blkdev->max_requests,
-                            BLKIF_MAX_SEGMENTS_PER_REQUEST);
     /* Add on the number needed for the ring pages */
-    max_grants += blkdev->nr_ring_ref;
+    max_grants = blkdev->nr_ring_ref;
 
     blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
     if (blkdev->xendev.gnttabdev == NULL) {
@@ -1114,8 +977,6 @@ static int blk_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    blkdev->cnt_map++;
-
     switch (blkdev->protocol) {
     case BLKIF_PROTOCOL_NATIVE:
     {
@@ -1171,7 +1032,6 @@ static void blk_disconnect(struct XenDevice *xendev)
     if (blkdev->sring) {
         xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
                         blkdev->nr_ring_ref);
-        blkdev->cnt_map--;
         blkdev->sring = NULL;
     }
 
-- 
2.1.4
