Received: from eggs.gnu.org ([2001:4830:134:3::10]:34301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJWK-0002IO-Fc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJWH-0000P6-AA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:40 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 20 Jun 2017 09:47:55 -0400
Message-ID: <20170620134756.9632-3-paul.durrant@citrix.com>
In-Reply-To: <20170620134756.9632-1-paul.durrant@citrix.com>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] xen-disk: add support for multi-page
 shared rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The blkif protocol has had provision for negotiation of multi-page shared
rings for some time now and many guest OS have support in their frontend
drivers.

This patch makes the necessary modifications to xen-disk support a shared
ring up to order 4 (i.e. 16 pages).

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen_disk.c | 141 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 110 insertions(+), 31 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 9b06e3aa81..a9942d32db 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -36,8 +36,6 @@
 
 static int batch_maps   = 0;
 
-static int max_requests = 32;
-
 /* ------------------------------------------------------------- */
 
 #define BLOCK_SIZE  512
@@ -84,6 +82,8 @@ struct ioreq {
     BlockAcctCookie     acct;
 };
 
+#define MAX_RING_PAGE_ORDER 4
+
 struct XenBlkDev {
     struct XenDevice    xendev;  /* must be first */
     char                *params;
@@ -94,7 +94,8 @@ struct XenBlkDev {
     bool                directiosafe;
     const char          *fileproto;
     const char          *filename;
-    int                 ring_ref;
+    unsigned int        ring_ref[1 << MAX_RING_PAGE_ORDER];
+    unsigned int        nr_ring_ref;
     void                *sring;
     int64_t             file_blk;
     int64_t             file_size;
@@ -110,6 +111,7 @@ struct XenBlkDev {
     int                 requests_total;
     int                 requests_inflight;
     int                 requests_finished;
+    unsigned int        max_requests;
 
     /* Persistent grants extension */
     gboolean            feature_discard;
@@ -199,7 +201,7 @@ static struct ioreq *ioreq_start(struct XenBlkDev *blkdev)
     struct ioreq *ioreq = NULL;
 
     if (QLIST_EMPTY(&blkdev->freelist)) {
-        if (blkdev->requests_total >= max_requests) {
+        if (blkdev->requests_total >= blkdev->max_requests) {
             goto out;
         }
         /* allocate new struct */
@@ -905,7 +907,7 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
         ioreq_runio_qemu_aio(ioreq);
     }
 
-    if (blkdev->more_work && blkdev->requests_inflight < max_requests) {
+    if (blkdev->more_work && blkdev->requests_inflight < blkdev->max_requests) {
         qemu_bh_schedule(blkdev->bh);
     }
 }
@@ -918,15 +920,6 @@ static void blk_bh(void *opaque)
     blk_handle_requests(blkdev);
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
 static void blk_alloc(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
@@ -938,11 +931,6 @@ static void blk_alloc(struct XenDevice *xendev)
     if (xen_mode != XEN_EMULATE) {
         batch_maps = 1;
     }
-    if (xengnttab_set_max_grants(xendev->gnttabdev,
-            MAX_GRANTS(max_requests, BLKIF_MAX_SEGMENTS_PER_REQUEST)) < 0) {
-        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
-                      strerror(errno));
-    }
 }
 
 static void blk_parse_discard(struct XenBlkDev *blkdev)
@@ -1037,6 +1025,9 @@ static int blk_init(struct XenDevice *xendev)
                           !blkdev->feature_grant_copy);
     xenstore_write_be_int(&blkdev->xendev, "info", info);
 
+    xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
+                          MAX_RING_PAGE_ORDER);
+
     blk_parse_discard(blkdev);
 
     g_free(directiosafe);
@@ -1058,12 +1049,25 @@ out_error:
     return -1;
 }
 
+/*
+ * We need to account for the grant allocations requiring contiguous
+ * chunks; the worst case number would be
+ *     max_req * max_seg + (max_req - 1) * (max_seg - 1) + 1,
+ * but in order to keep things simple just use
+ *     2 * max_req * max_seg.
+ */
+#define MAX_GRANTS(max_req, max_seg) (2 * (max_req) * (max_seg))
+
 static int blk_connect(struct XenDevice *xendev)
 {
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     int pers, index, qflags;
     bool readonly = true;
     bool writethrough = true;
+    int order, ring_ref;
+    unsigned int ring_size, max_grants;
+    unsigned int i;
+    uint32_t *domids;
 
     /* read-only ? */
     if (blkdev->directiosafe) {
@@ -1138,9 +1142,39 @@ static int blk_connect(struct XenDevice *xendev)
     xenstore_write_be_int64(&blkdev->xendev, "sectors",
                             blkdev->file_size / blkdev->file_blk);
 
-    if (xenstore_read_fe_int(&blkdev->xendev, "ring-ref", &blkdev->ring_ref) == -1) {
+    if (xenstore_read_fe_int(&blkdev->xendev, "ring-page-order",
+                             &order) == -1) {
+        blkdev->nr_ring_ref = 1;
+
+        if (xenstore_read_fe_int(&blkdev->xendev, "ring-ref",
+                                 &ring_ref) == -1) {
+            return -1;
+        }
+        blkdev->ring_ref[0] = ring_ref;
+
+    } else if (order >= 0 && order <= MAX_RING_PAGE_ORDER) {
+        blkdev->nr_ring_ref = 1 << order;
+
+        for (i = 0; i < blkdev->nr_ring_ref; i++) {
+            char *key;
+
+            key = g_strdup_printf("ring-ref%u", i);
+            if (!key) {
+                return -1;
+            }
+
+            if (xenstore_read_fe_int(&blkdev->xendev, key,
+                                     &ring_ref) == -1) {
+                return -1;
+            }
+            blkdev->ring_ref[i] = ring_ref;
+
+            g_free(key);
+        }
+    } else {
         return -1;
     }
+
     if (xenstore_read_fe_int(&blkdev->xendev, "event-channel",
                              &blkdev->xendev.remote_port) == -1) {
         return -1;
@@ -1163,41 +1197,85 @@ static int blk_connect(struct XenDevice *xendev)
         blkdev->protocol = BLKIF_PROTOCOL_NATIVE;
     }
 
-    blkdev->sring = xengnttab_map_grant_ref(blkdev->xendev.gnttabdev,
-                                            blkdev->xendev.dom,
-                                            blkdev->ring_ref,
-                                            PROT_READ | PROT_WRITE);
+    ring_size = XC_PAGE_SIZE * blkdev->nr_ring_ref;
+    switch (blkdev->protocol) {
+    case BLKIF_PROTOCOL_NATIVE:
+    {
+        blkdev->max_requests = __CONST_RING_SIZE(blkif, ring_size);
+        break;
+    }
+    case BLKIF_PROTOCOL_X86_32:
+    {
+        blkdev->max_requests = __CONST_RING_SIZE(blkif_x86_32, ring_size);
+        break;
+    }
+    case BLKIF_PROTOCOL_X86_64:
+    {
+        blkdev->max_requests = __CONST_RING_SIZE(blkif_x86_64, ring_size);
+        break;
+    }
+    default:
+        return -1;
+    }
+
+    /* Calculate the maximum number of grants needed by ioreqs */
+    max_grants = MAX_GRANTS(blkdev->max_requests,
+                            BLKIF_MAX_SEGMENTS_PER_REQUEST);
+    /* Add on the number needed for the ring pages */
+    max_grants += blkdev->nr_ring_ref;
+
+    if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
+        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
+                      strerror(errno));
+        return -1;
+    }
+
+    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
+    for (i = 0; i < blkdev->nr_ring_ref; i++) {
+        domids[i] = blkdev->xendev.dom;
+    }
+
+    blkdev->sring = xengnttab_map_grant_refs(blkdev->xendev.gnttabdev,
+                                             blkdev->nr_ring_ref,
+                                             domids,
+                                             blkdev->ring_ref,
+                                             PROT_READ | PROT_WRITE);
+
+    g_free(domids);
+
     if (!blkdev->sring) {
         return -1;
     }
+
     blkdev->cnt_map++;
 
     switch (blkdev->protocol) {
     case BLKIF_PROTOCOL_NATIVE:
     {
         blkif_sring_t *sring_native = blkdev->sring;
-        BACK_RING_INIT(&blkdev->rings.native, sring_native, XC_PAGE_SIZE);
+        BACK_RING_INIT(&blkdev->rings.native, sring_native, ring_size);
         break;
     }
     case BLKIF_PROTOCOL_X86_32:
     {
         blkif_x86_32_sring_t *sring_x86_32 = blkdev->sring;
 
-        BACK_RING_INIT(&blkdev->rings.x86_32_part, sring_x86_32, XC_PAGE_SIZE);
+        BACK_RING_INIT(&blkdev->rings.x86_32_part, sring_x86_32, ring_size);
         break;
     }
     case BLKIF_PROTOCOL_X86_64:
     {
         blkif_x86_64_sring_t *sring_x86_64 = blkdev->sring;
 
-        BACK_RING_INIT(&blkdev->rings.x86_64_part, sring_x86_64, XC_PAGE_SIZE);
+        BACK_RING_INIT(&blkdev->rings.x86_64_part, sring_x86_64, ring_size);
         break;
     }
     }
 
     if (blkdev->feature_persistent) {
         /* Init persistent grants */
-        blkdev->max_grants = max_requests * BLKIF_MAX_SEGMENTS_PER_REQUEST;
+        blkdev->max_grants = blkdev->max_requests *
+            BLKIF_MAX_SEGMENTS_PER_REQUEST;
         blkdev->persistent_gnts = g_tree_new_full((GCompareDataFunc)int_cmp,
                                              NULL, NULL,
                                              batch_maps ?
@@ -1209,9 +1287,9 @@ static int blk_connect(struct XenDevice *xendev)
 
     xen_be_bind_evtchn(&blkdev->xendev);
 
-    xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, ring-ref %d, "
+    xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
                   "remote port %d, local port %d\n",
-                  blkdev->xendev.protocol, blkdev->ring_ref,
+                  blkdev->xendev.protocol, blkdev->nr_ring_ref,
                   blkdev->xendev.remote_port, blkdev->xendev.local_port);
     return 0;
 }
@@ -1228,7 +1306,8 @@ static void blk_disconnect(struct XenDevice *xendev)
     xen_pv_unbind_evtchn(&blkdev->xendev);
 
     if (blkdev->sring) {
-        xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring, 1);
+        xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
+                        blkdev->nr_ring_ref);
         blkdev->cnt_map--;
         blkdev->sring = NULL;
     }
-- 
2.11.0
