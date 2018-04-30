Received: from eggs.gnu.org ([2001:4830:134:3::10]:49081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80U-0005IQ-Hd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80S-0000kj-UJ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:14 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 30 Apr 2018 13:01:36 +0100
Message-ID: <1525089699-13411-2-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] block/xen_disk: remove persistent grant
 code
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
copy is available then persistent grants will not be used.
The xen_disk source can be siginificantly simplified by removing this now
redundant code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen_disk.c | 237 +++++-----------------------------------------------
 1 file changed, 21 insertions(+), 216 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd4..b33611a 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -43,20 +43,6 @@ static int batch_maps   = 0;
 #define BLOCK_SIZE  512
 #define IOCB_COUNT  (BLKIF_MAX_SEGMENTS_PER_REQUEST + 2)
 
-struct PersistentGrant {
-    void *page;
-    struct XenBlkDev *blkdev;
-};
-
-typedef struct PersistentGrant PersistentGrant;
-
-struct PersistentRegion {
-    void *addr;
-    int num;
-};
-
-typedef struct PersistentRegion PersistentRegion;
-
 struct ioreq {
     blkif_request_t     req;
     int16_t             status;
@@ -73,7 +59,6 @@ struct ioreq {
     int                 prot;
     void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     void                *pages;
-    int                 num_unmap;
 
     /* aio status */
     int                 aio_inflight;
@@ -115,13 +100,7 @@ struct XenBlkDev {
     int                 requests_finished;
     unsigned int        max_requests;
 
-    /* Persistent grants extension */
     gboolean            feature_discard;
-    gboolean            feature_persistent;
-    GTree               *persistent_gnts;
-    GSList              *persistent_regions;
-    unsigned int        persistent_gnt_count;
-    unsigned int        max_grants;
 
     /* qemu block driver */
     DriveInfo           *dinfo;
@@ -158,46 +137,6 @@ static void ioreq_reset(struct ioreq *ioreq)
     qemu_iovec_reset(&ioreq->v);
 }
 
-static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
-{
-    uint ua = GPOINTER_TO_UINT(a);
-    uint ub = GPOINTER_TO_UINT(b);
-    return (ua > ub) - (ua < ub);
-}
-
-static void destroy_grant(gpointer pgnt)
-{
-    PersistentGrant *grant = pgnt;
-    xengnttab_handle *gnt = grant->blkdev->xendev.gnttabdev;
-
-    if (xengnttab_unmap(gnt, grant->page, 1) != 0) {
-        xen_pv_printf(&grant->blkdev->xendev, 0,
-                      "xengnttab_unmap failed: %s\n",
-                      strerror(errno));
-    }
-    grant->blkdev->persistent_gnt_count--;
-    xen_pv_printf(&grant->blkdev->xendev, 3,
-                  "unmapped grant %p\n", grant->page);
-    g_free(grant);
-}
-
-static void remove_persistent_region(gpointer data, gpointer dev)
-{
-    PersistentRegion *region = data;
-    struct XenBlkDev *blkdev = dev;
-    xengnttab_handle *gnt = blkdev->xendev.gnttabdev;
-
-    if (xengnttab_unmap(gnt, region->addr, region->num) != 0) {
-        xen_pv_printf(&blkdev->xendev, 0,
-                      "xengnttab_unmap region %p failed: %s\n",
-                      region->addr, strerror(errno));
-    }
-    xen_pv_printf(&blkdev->xendev, 3,
-                  "unmapped grant region %p with %d pages\n",
-                  region->addr, region->num);
-    g_free(region);
-}
-
 static struct ioreq *ioreq_start(struct XenBlkDev *blkdev)
 {
     struct ioreq *ioreq = NULL;
@@ -327,22 +266,22 @@ static void ioreq_unmap(struct ioreq *ioreq)
     xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
     int i;
 
-    if (ioreq->num_unmap == 0 || ioreq->mapped == 0) {
+    if (ioreq->v.niov == 0 || ioreq->mapped == 0) {
         return;
     }
     if (batch_maps) {
         if (!ioreq->pages) {
             return;
         }
-        if (xengnttab_unmap(gnt, ioreq->pages, ioreq->num_unmap) != 0) {
+        if (xengnttab_unmap(gnt, ioreq->pages, ioreq->v.niov) != 0) {
             xen_pv_printf(&ioreq->blkdev->xendev, 0,
                           "xengnttab_unmap failed: %s\n",
                           strerror(errno));
         }
-        ioreq->blkdev->cnt_map -= ioreq->num_unmap;
+        ioreq->blkdev->cnt_map -= ioreq->v.niov;
         ioreq->pages = NULL;
     } else {
-        for (i = 0; i < ioreq->num_unmap; i++) {
+        for (i = 0; i < ioreq->v.niov; i++) {
             if (!ioreq->page[i]) {
                 continue;
             }
@@ -361,138 +300,44 @@ static void ioreq_unmap(struct ioreq *ioreq)
 static int ioreq_map(struct ioreq *ioreq)
 {
     xengnttab_handle *gnt = ioreq->blkdev->xendev.gnttabdev;
-    uint32_t domids[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    uint32_t refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    void *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    int i, j, new_maps = 0;
-    PersistentGrant *grant;
-    PersistentRegion *region;
-    /* domids and refs variables will contain the information necessary
-     * to map the grants that are needed to fulfill this request.
-     *
-     * After mapping the needed grants, the page array will contain the
-     * memory address of each granted page in the order specified in ioreq
-     * (disregarding if it's a persistent grant or not).
-     */
+    int i;
 
     if (ioreq->v.niov == 0 || ioreq->mapped == 1) {
         return 0;
     }
-    if (ioreq->blkdev->feature_persistent) {
-        for (i = 0; i < ioreq->v.niov; i++) {
-            grant = g_tree_lookup(ioreq->blkdev->persistent_gnts,
-                                    GUINT_TO_POINTER(ioreq->refs[i]));
-
-            if (grant != NULL) {
-                page[i] = grant->page;
-                xen_pv_printf(&ioreq->blkdev->xendev, 3,
-                              "using persistent-grant %" PRIu32 "\n",
-                              ioreq->refs[i]);
-            } else {
-                    /* Add the grant to the list of grants that
-                     * should be mapped
-                     */
-                    domids[new_maps] = ioreq->domids[i];
-                    refs[new_maps] = ioreq->refs[i];
-                    page[i] = NULL;
-                    new_maps++;
-            }
-        }
-        /* Set the protection to RW, since grants may be reused later
-         * with a different protection than the one needed for this request
-         */
-        ioreq->prot = PROT_WRITE | PROT_READ;
-    } else {
-        /* All grants in the request should be mapped */
-        memcpy(refs, ioreq->refs, sizeof(refs));
-        memcpy(domids, ioreq->domids, sizeof(domids));
-        memset(page, 0, sizeof(page));
-        new_maps = ioreq->v.niov;
-    }
-
-    if (batch_maps && new_maps) {
+    if (batch_maps) {
         ioreq->pages = xengnttab_map_grant_refs
-            (gnt, new_maps, domids, refs, ioreq->prot);
+            (gnt, ioreq->v.niov, ioreq->domids, ioreq->refs, ioreq->prot);
         if (ioreq->pages == NULL) {
             xen_pv_printf(&ioreq->blkdev->xendev, 0,
                           "can't map %d grant refs (%s, %d maps)\n",
-                          new_maps, strerror(errno), ioreq->blkdev->cnt_map);
+                          ioreq->v.niov, strerror(errno),
+                          ioreq->blkdev->cnt_map);
             return -1;
         }
-        for (i = 0, j = 0; i < ioreq->v.niov; i++) {
-            if (page[i] == NULL) {
-                page[i] = ioreq->pages + (j++) * XC_PAGE_SIZE;
-            }
+        for (i = 0; i < ioreq->v.niov; i++) {
+            ioreq->v.iov[i].iov_base = ioreq->pages + i * XC_PAGE_SIZE +
+                (uintptr_t)ioreq->v.iov[i].iov_base;
         }
-        ioreq->blkdev->cnt_map += new_maps;
-    } else if (new_maps)  {
-        for (i = 0; i < new_maps; i++) {
+        ioreq->blkdev->cnt_map += ioreq->v.niov;
+    } else  {
+        for (i = 0; i < ioreq->v.niov; i++) {
             ioreq->page[i] = xengnttab_map_grant_ref
-                (gnt, domids[i], refs[i], ioreq->prot);
+                (gnt, ioreq->domids[i], ioreq->refs[i], ioreq->prot);
             if (ioreq->page[i] == NULL) {
                 xen_pv_printf(&ioreq->blkdev->xendev, 0,
                               "can't map grant ref %d (%s, %d maps)\n",
-                              refs[i], strerror(errno), ioreq->blkdev->cnt_map);
+                              ioreq->refs[i], strerror(errno),
+                              ioreq->blkdev->cnt_map);
                 ioreq->mapped = 1;
                 ioreq_unmap(ioreq);
                 return -1;
             }
-            ioreq->blkdev->cnt_map++;
-        }
-        for (i = 0, j = 0; i < ioreq->v.niov; i++) {
-            if (page[i] == NULL) {
-                page[i] = ioreq->page[j++];
-            }
+            ioreq->v.iov[i].iov_base = ioreq->page[i] +
+                (uintptr_t)ioreq->v.iov[i].iov_base;
         }
     }
-    if (ioreq->blkdev->feature_persistent && new_maps != 0 &&
-        (!batch_maps || (ioreq->blkdev->persistent_gnt_count + new_maps <=
-        ioreq->blkdev->max_grants))) {
-        /*
-         * If we are using persistent grants and batch mappings only
-         * add the new maps to the list of persistent grants if the whole
-         * area can be persistently mapped.
-         */
-        if (batch_maps) {
-            region = g_malloc0(sizeof(*region));
-            region->addr = ioreq->pages;
-            region->num = new_maps;
-            ioreq->blkdev->persistent_regions = g_slist_append(
-                                            ioreq->blkdev->persistent_regions,
-                                            region);
-        }
-        while ((ioreq->blkdev->persistent_gnt_count < ioreq->blkdev->max_grants)
-              && new_maps) {
-            /* Go through the list of newly mapped grants and add as many
-             * as possible to the list of persistently mapped grants.
-             *
-             * Since we start at the end of ioreq->page(s), we only need
-             * to decrease new_maps to prevent this granted pages from
-             * being unmapped in ioreq_unmap.
-             */
-            grant = g_malloc0(sizeof(*grant));
-            new_maps--;
-            if (batch_maps) {
-                grant->page = ioreq->pages + (new_maps) * XC_PAGE_SIZE;
-            } else {
-                grant->page = ioreq->page[new_maps];
-            }
-            grant->blkdev = ioreq->blkdev;
-            xen_pv_printf(&ioreq->blkdev->xendev, 3,
-                          "adding grant %" PRIu32 " page: %p\n",
-                          refs[new_maps], grant->page);
-            g_tree_insert(ioreq->blkdev->persistent_gnts,
-                          GUINT_TO_POINTER(refs[new_maps]),
-                          grant);
-            ioreq->blkdev->persistent_gnt_count++;
-        }
-        assert(!batch_maps || new_maps == 0);
-    }
-    for (i = 0; i < ioreq->v.niov; i++) {
-        ioreq->v.iov[i].iov_base += (uintptr_t)page[i];
-    }
     ioreq->mapped = 1;
-    ioreq->num_unmap = new_maps;
     return 0;
 }
 
@@ -1039,8 +884,6 @@ static int blk_init(struct XenDevice *xendev)
      * blk_connect supplies sector-size and sectors
      */
     xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
-    xenstore_write_be_int(&blkdev->xendev, "feature-persistent",
-                          !xen_feature_grant_copy);
     xenstore_write_be_int(&blkdev->xendev, "info", info);
 
     xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
@@ -1079,7 +922,7 @@ out_error:
 static int blk_connect(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
-    int pers, index, qflags;
+    int index, qflags;
     bool readonly = true;
     bool writethrough = true;
     int order, ring_ref;
@@ -1202,11 +1045,6 @@ static int blk_connect(struct XenDevice *xendev)
                              &blkdev->xendev.remote_port) == -1) {
         return -1;
     }
-    if (xenstore_read_fe_int(&blkdev->xendev, "feature-persistent", &pers)) {
-        blkdev->feature_persistent = FALSE;
-    } else {
-        blkdev->feature_persistent = !!pers;
-    }
 
     if (!blkdev->xendev.protocol) {
         blkdev->protocol = BLKIF_PROTOCOL_NATIVE;
@@ -1301,19 +1139,6 @@ static int blk_connect(struct XenDevice *xendev)
     }
     }
 
-    if (blkdev->feature_persistent) {
-        /* Init persistent grants */
-        blkdev->max_grants = blkdev->max_requests *
-            BLKIF_MAX_SEGMENTS_PER_REQUEST;
-        blkdev->persistent_gnts = g_tree_new_full((GCompareDataFunc)int_cmp,
-                                             NULL, NULL,
-                                             batch_maps ?
-                                             (GDestroyNotify)g_free :
-                                             (GDestroyNotify)destroy_grant);
-        blkdev->persistent_regions = NULL;
-        blkdev->persistent_gnt_count = 0;
-    }
-
     blk_set_aio_context(blkdev->blk, blkdev->ctx);
 
     xen_be_bind_evtchn(&blkdev->xendev);
@@ -1350,26 +1175,6 @@ static void blk_disconnect(struct XenDevice *xendev)
         blkdev->sring = NULL;
     }
 
-    /*
-     * Unmap persistent grants before switching to the closed state
-     * so the frontend can free them.
-     *
-     * In the !batch_maps case g_tree_destroy will take care of unmapping
-     * the grant, but in the batch_maps case we need to iterate over every
-     * region in persistent_regions and unmap it.
-     */
-    if (blkdev->feature_persistent) {
-        g_tree_destroy(blkdev->persistent_gnts);
-        assert(batch_maps || blkdev->persistent_gnt_count == 0);
-        if (batch_maps) {
-            blkdev->persistent_gnt_count = 0;
-            g_slist_foreach(blkdev->persistent_regions,
-                            (GFunc)remove_persistent_region, blkdev);
-            g_slist_free(blkdev->persistent_regions);
-        }
-        blkdev->feature_persistent = false;
-    }
-
     if (blkdev->xendev.gnttabdev) {
         xengnttab_close(blkdev->xendev.gnttabdev);
         blkdev->xendev.gnttabdev = NULL;
-- 
2.1.4
