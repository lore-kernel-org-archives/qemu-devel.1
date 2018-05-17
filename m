Received: from eggs.gnu.org ([2001:4830:134:3::10]:50715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKx6-0005L1-3T
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKx0-0006Yv-Ny
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:36:24 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 17 May 2018 16:35:52 +0100
Message-ID: <1526571358-26685-4-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/9] xen_disk: remove open-coded use of
 libxengnttab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that helpers are present in xen_backend, this patch removes open-coded
calls to libxengnttab from the xen_disk code.

This patch also fixes one whitspace error in the assignment of the
XenDevOps initialise method.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

v2:
 - New in v2
---
 hw/block/xen_disk.c | 122 ++++++++++++++--------------------------------------
 1 file changed, 32 insertions(+), 90 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 78bfb41..d3be45a 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -68,7 +68,6 @@ struct ioreq {
     uint8_t             mapped;
 
     /* grant mapping */
-    uint32_t            domids[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     uint32_t            refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int                 prot;
     void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
@@ -142,7 +141,6 @@ static void ioreq_reset(struct ioreq *ioreq)
     ioreq->presync = 0;
     ioreq->mapped = 0;
 
-    memset(ioreq->domids, 0, sizeof(ioreq->domids));
     memset(ioreq->refs, 0, sizeof(ioreq->refs));
     ioreq->prot = 0;
     memset(ioreq->page, 0, sizeof(ioreq->page));
@@ -168,16 +166,12 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 static void destroy_grant(gpointer pgnt)
 {
     PersistentGrant *grant = pgnt;
-    xengnttab_handle *gnt = grant->blkdev->xendev.gnttabdev;
+    struct XenBlkDev *blkdev = grant->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
 
-    if (xengnttab_unmap(gnt, grant->page, 1) != 0) {
-        xen_pv_printf(&grant->blkdev->xendev, 0,
-                      "xengnttab_unmap failed: %s\n",
-                      strerror(errno));
-    }
+    xen_be_unmap_grant_ref(xendev, grant->page);
     grant->blkdev->persistent_gnt_count--;
-    xen_pv_printf(&grant->blkdev->xendev, 3,
-                  "unmapped grant %p\n", grant->page);
+    xen_pv_printf(xendev, 3, "unmapped grant %p\n", grant->page);
     g_free(grant);
 }
 
@@ -185,15 +179,10 @@ static void remove_persistent_region(gpointer data, gpointer dev)
 {
     PersistentRegion *region = data;
     struct XenBlkDev *blkdev = dev;
-    xengnttab_handle *gnt = blkdev->xendev.gnttabdev;
+    struct XenDevice *xendev = &blkdev->xendev;
 
-    if (xengnttab_unmap(gnt, region->addr, region->num) != 0) {
-        xen_pv_printf(&blkdev->xendev, 0,
-                      "xengnttab_unmap region %p failed: %s\n",
-                      region->addr, strerror(errno));
-    }
-    xen_pv_printf(&blkdev->xendev, 3,
-                  "unmapped grant region %p with %d pages\n",
+    xen_be_unmap_grant_refs(xendev, region->addr, region->num);
+    xen_pv_printf(xendev, 3, "unmapped grant region %p with %d pages\n",
                   region->addr, region->num);
     g_free(region);
 }
@@ -304,7 +293,6 @@ static int ioreq_parse(struct ioreq *ioreq)
             goto err;
         }
 
-        ioreq->domids[i] = blkdev->xendev.dom;
         ioreq->refs[i]   = ioreq->req.seg[i].gref;
 
         mem = ioreq->req.seg[i].first_sect * blkdev->file_blk;
@@ -324,7 +312,8 @@ err:
 
 static void ioreq_unmap(struct ioreq *ioreq)
 {
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
     int i;
 
     if (ioreq->num_unmap == 0 || ioreq->mapped == 0) {
@@ -334,11 +323,7 @@ static void ioreq_unmap(struct ioreq *ioreq)
         if (!ioreq->pages) {
             return;
         }
-        if (xengnttab_unmap(gnt, ioreq->pages, ioreq->num_unmap) != 0) {
-            xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                          "xengnttab_unmap failed: %s\n",
-                          strerror(errno));
-        }
+        xen_be_unmap_grant_refs(xendev, ioreq->pages, ioreq->num_unmap);
         ioreq->blkdev->cnt_map -= ioreq->num_unmap;
         ioreq->pages = NULL;
     } else {
@@ -346,11 +331,7 @@ static void ioreq_unmap(struct ioreq *ioreq)
             if (!ioreq->page[i]) {
                 continue;
             }
-            if (xengnttab_unmap(gnt, ioreq->page[i], 1) != 0) {
-                xen_pv_printf(&ioreq->blkdev->xendev, 0,
-                              "xengnttab_unmap failed: %s\n",
-                              strerror(errno));
-            }
+            xen_be_unmap_grant_ref(xendev, ioreq->page[i]);
             ioreq->blkdev->cnt_map--;
             ioreq->page[i] = NULL;
         }
@@ -360,14 +341,14 @@ static void ioreq_unmap(struct ioreq *ioreq)
 
 static int ioreq_map(struct ioreq *ioreq)
 {
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
-    uint32_t domids[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
     uint32_t refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     void *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, j, new_maps = 0;
     PersistentGrant *grant;
     PersistentRegion *region;
-    /* domids and refs variables will contain the information necessary
+    /* refs variable will contain the information necessary
      * to map the grants that are needed to fulfill this request.
      *
      * After mapping the needed grants, the page array will contain the
@@ -392,7 +373,6 @@ static int ioreq_map(struct ioreq *ioreq)
                     /* Add the grant to the list of grants that
                      * should be mapped
                      */
-                    domids[new_maps] = ioreq->domids[i];
                     refs[new_maps] = ioreq->refs[i];
                     page[i] = NULL;
                     new_maps++;
@@ -405,14 +385,13 @@ static int ioreq_map(struct ioreq *ioreq)
     } else {
         /* All grants in the request should be mapped */
         memcpy(refs, ioreq->refs, sizeof(refs));
-        memcpy(domids, ioreq->domids, sizeof(domids));
         memset(page, 0, sizeof(page));
         new_maps = ioreq->v.niov;
     }
 
     if (batch_maps && new_maps) {
-        ioreq->pages = xengnttab_map_grant_refs
-            (gnt, new_maps, domids, refs, ioreq->prot);
+        ioreq->pages = xen_be_map_grant_refs(xendev, refs, new_maps,
+                                             ioreq->prot);
         if (ioreq->pages == NULL) {
             xen_pv_printf(&ioreq->blkdev->xendev, 0,
                           "can't map %d grant refs (%s, %d maps)\n",
@@ -427,8 +406,8 @@ static int ioreq_map(struct ioreq *ioreq)
         ioreq->blkdev->cnt_map += new_maps;
     } else if (new_maps)  {
         for (i = 0; i < new_maps; i++) {
-            ioreq->page[i] = xengnttab_map_grant_ref
-                (gnt, domids[i], refs[i], ioreq->prot);
+            ioreq->page[i] = xen_be_map_grant_ref(xendev, refs[i],
+                                                  ioreq->prot);
             if (ioreq->page[i] == NULL) {
                 xen_pv_printf(&ioreq->blkdev->xendev, 0,
                               "can't map grant ref %d (%s, %d maps)\n",
@@ -527,10 +506,12 @@ static int ioreq_init_copy_buffers(struct ioreq *ioreq)
 
 static int ioreq_grant_copy(struct ioreq *ioreq)
 {
-    xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
-    xengnttab_grant_copy_segment_t segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
+    XenGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, count, rc;
     int64_t file_blk = ioreq->blkdev->file_blk;
+    bool to_domain = (ioreq->req.operation == BLKIF_OP_READ);
 
     if (ioreq->v.niov == 0) {
         return 0;
@@ -539,16 +520,12 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
     count = ioreq->v.niov;
 
     for (i = 0; i < count; i++) {
-        if (ioreq->req.operation == BLKIF_OP_READ) {
-            segs[i].flags = GNTCOPY_dest_gref;
+        if (to_domain) {
             segs[i].dest.foreign.ref = ioreq->refs[i];
-            segs[i].dest.foreign.domid = ioreq->domids[i];
             segs[i].dest.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
             segs[i].source.virt = ioreq->v.iov[i].iov_base;
         } else {
-            segs[i].flags = GNTCOPY_source_gref;
             segs[i].source.foreign.ref = ioreq->refs[i];
-            segs[i].source.foreign.domid = ioreq->domids[i];
             segs[i].source.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
             segs[i].dest.virt = ioreq->v.iov[i].iov_base;
         }
@@ -556,7 +533,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
                        - ioreq->req.seg[i].first_sect + 1) * file_blk;
     }
 
-    rc = xengnttab_grant_copy(gnt, count, segs);
+    rc = xen_be_copy_grant_refs(xendev, to_domain, segs, count);
 
     if (rc) {
         xen_pv_printf(&ioreq->blkdev->xendev, 0,
@@ -565,16 +542,6 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
         return -1;
     }
 
-    for (i = 0; i < count; i++) {
-        if (segs[i].status != GNTST_okay) {
-            xen_pv_printf(&ioreq->blkdev->xendev, 3,
-                          "failed to copy data %d for gref %d, domid %d\n",
-                          segs[i].status, ioreq->refs[i], ioreq->domids[i]);
-            ioreq->aio_errors++;
-            rc = -1;
-        }
-    }
-
     return rc;
 }
 
@@ -1067,7 +1034,6 @@ static int blk_connect(struct XenDevice *xendev)
     int order, ring_ref;
     unsigned int ring_size, max_grants;
     unsigned int i;
-    uint32_t *domids;
 
     trace_xen_disk_connect(xendev->name);
 
@@ -1229,31 +1195,11 @@ static int blk_connect(struct XenDevice *xendev)
     /* Add on the number needed for the ring pages */
     max_grants += blkdev->nr_ring_ref;
 
-    blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
-    if (blkdev->xendev.gnttabdev == NULL) {
-        xen_pv_printf(xendev, 0, "xengnttab_open failed: %s\n",
-                      strerror(errno));
-        return -1;
-    }
-    if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
-        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
-                      strerror(errno));
-        return -1;
-    }
-
-    domids = g_new0(uint32_t, blkdev->nr_ring_ref);
-    for (i = 0; i < blkdev->nr_ring_ref; i++) {
-        domids[i] = blkdev->xendev.dom;
-    }
-
-    blkdev->sring = xengnttab_map_grant_refs(blkdev->xendev.gnttabdev,
-                                             blkdev->nr_ring_ref,
-                                             domids,
-                                             blkdev->ring_ref,
-                                             PROT_READ | PROT_WRITE);
-
-    g_free(domids);
+    xen_be_set_max_grant_refs(xendev, max_grants);
 
+    blkdev->sring = xen_be_map_grant_refs(xendev, blkdev->ring_ref,
+                                          blkdev->nr_ring_ref,
+                                          PROT_READ | PROT_WRITE);
     if (!blkdev->sring) {
         return -1;
     }
@@ -1326,8 +1272,8 @@ static void blk_disconnect(struct XenDevice *xendev)
     aio_context_release(blkdev->ctx);
 
     if (blkdev->sring) {
-        xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
-                        blkdev->nr_ring_ref);
+        xen_be_unmap_grant_refs(xendev, blkdev->sring,
+                                blkdev->nr_ring_ref);
         blkdev->cnt_map--;
         blkdev->sring = NULL;
     }
@@ -1351,11 +1297,6 @@ static void blk_disconnect(struct XenDevice *xendev)
         }
         blkdev->feature_persistent = false;
     }
-
-    if (blkdev->xendev.gnttabdev) {
-        xengnttab_close(blkdev->xendev.gnttabdev);
-        blkdev->xendev.gnttabdev = NULL;
-    }
 }
 
 static int blk_free(struct XenDevice *xendev)
@@ -1392,10 +1333,11 @@ static void blk_event(struct XenDevice *xendev)
 }
 
 struct XenDevOps xen_blkdev_ops = {
+    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .size       = sizeof(struct XenBlkDev),
     .alloc      = blk_alloc,
     .init       = blk_init,
-    .initialise    = blk_connect,
+    .initialise = blk_connect,
     .disconnect = blk_disconnect,
     .event      = blk_event,
     .free       = blk_free,
-- 
2.1.4
