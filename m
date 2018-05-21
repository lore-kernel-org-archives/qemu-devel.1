Received: from eggs.gnu.org ([2001:4830:134:3::10]:41793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaS-0000hH-IU
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaQ-0003LJ-0v
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaP-0003JJ-LL
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:13 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:35:04 -0700
Message-Id: <1526931304-7289-15-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 15/15] xen_disk: be consistent with use of
 xendev and blkdev->xendev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

Certain functions in xen_disk are called with a pointer to xendev
(struct XenDevice *). They then use container_of() to acces the surrounding
blkdev (struct XenBlkDev) but then in various places use &blkdev->xendev
when use of the original xendev pointer is shorter to express and clearly
equivalent.

This patch is a purely cosmetic patch which makes sure there is a xendev
pointer on stack for any function where the pointer is need on multiple
occasions modified those functions to use it consistently.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/block/xen_disk.c | 90 +++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 28651c5..9fbc0cd 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -178,10 +178,11 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
 static int ioreq_parse(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
     size_t len;
     int i;
 
-    xen_pv_printf(&blkdev->xendev, 3,
+    xen_pv_printf(xendev, 3,
                   "op %d, nr %d, handle %d, id %" PRId64 ", sector %" PRId64 "\n",
                   ioreq->req.operation, ioreq->req.nr_segments,
                   ioreq->req.handle, ioreq->req.id, ioreq->req.sector_number);
@@ -199,28 +200,28 @@ static int ioreq_parse(struct ioreq *ioreq)
     case BLKIF_OP_DISCARD:
         return 0;
     default:
-        xen_pv_printf(&blkdev->xendev, 0, "error: unknown operation (%d)\n",
+        xen_pv_printf(xendev, 0, "error: unknown operation (%d)\n",
                       ioreq->req.operation);
         goto err;
     };
 
     if (ioreq->req.operation != BLKIF_OP_READ && blkdev->mode[0] != 'w') {
-        xen_pv_printf(&blkdev->xendev, 0, "error: write req for ro device\n");
+        xen_pv_printf(xendev, 0, "error: write req for ro device\n");
         goto err;
     }
 
     ioreq->start = ioreq->req.sector_number * blkdev->file_blk;
     for (i = 0; i < ioreq->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
-            xen_pv_printf(&blkdev->xendev, 0, "error: nr_segments too big\n");
+            xen_pv_printf(xendev, 0, "error: nr_segments too big\n");
             goto err;
         }
         if (ioreq->req.seg[i].first_sect > ioreq->req.seg[i].last_sect) {
-            xen_pv_printf(&blkdev->xendev, 0, "error: first > last sector\n");
+            xen_pv_printf(xendev, 0, "error: first > last sector\n");
             goto err;
         }
         if (ioreq->req.seg[i].last_sect * BLOCK_SIZE >= XC_PAGE_SIZE) {
-            xen_pv_printf(&blkdev->xendev, 0, "error: page crossing\n");
+            xen_pv_printf(xendev, 0, "error: page crossing\n");
             goto err;
         }
 
@@ -228,7 +229,7 @@ static int ioreq_parse(struct ioreq *ioreq)
         ioreq->size += len;
     }
     if (ioreq->start + ioreq->size > blkdev->file_size) {
-        xen_pv_printf(&blkdev->xendev, 0, "error: access beyond end of file\n");
+        xen_pv_printf(xendev, 0, "error: access beyond end of file\n");
         goto err;
     }
     return 0;
@@ -244,7 +245,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
     struct XenDevice *xendev = &blkdev->xendev;
     XenGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, count, rc;
-    int64_t file_blk = ioreq->blkdev->file_blk;
+    int64_t file_blk = blkdev->file_blk;
     bool to_domain = (ioreq->req.operation == BLKIF_OP_READ);
     void *virt = ioreq->buf;
 
@@ -272,7 +273,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
     rc = xen_be_copy_grant_refs(xendev, to_domain, segs, count);
 
     if (rc) {
-        xen_pv_printf(&ioreq->blkdev->xendev, 0,
+        xen_pv_printf(xendev, 0,
                       "failed to copy data %d\n", rc);
         ioreq->aio_errors++;
         return -1;
@@ -287,11 +288,12 @@ static void qemu_aio_complete(void *opaque, int ret)
 {
     struct ioreq *ioreq = opaque;
     struct XenBlkDev *blkdev = ioreq->blkdev;
+    struct XenDevice *xendev = &blkdev->xendev;
 
     aio_context_acquire(blkdev->ctx);
 
     if (ret != 0) {
-        xen_pv_printf(&blkdev->xendev, 0, "%s I/O error\n",
+        xen_pv_printf(xendev, 0, "%s I/O error\n",
                       ioreq->req.operation == BLKIF_OP_READ ? "read" : "write");
         ioreq->aio_errors++;
     }
@@ -625,16 +627,17 @@ static void blk_alloc(struct XenDevice *xendev)
 
 static void blk_parse_discard(struct XenBlkDev *blkdev)
 {
+    struct XenDevice *xendev = &blkdev->xendev;
     int enable;
 
     blkdev->feature_discard = true;
 
-    if (xenstore_read_be_int(&blkdev->xendev, "discard-enable", &enable) == 0) {
+    if (xenstore_read_be_int(xendev, "discard-enable", &enable) == 0) {
         blkdev->feature_discard = !!enable;
     }
 
     if (blkdev->feature_discard) {
-        xenstore_write_be_int(&blkdev->xendev, "feature-discard", 1);
+        xenstore_write_be_int(xendev, "feature-discard", 1);
     }
 }
 
@@ -649,7 +652,7 @@ static int blk_init(struct XenDevice *xendev)
     /* read xenstore entries */
     if (blkdev->params == NULL) {
         char *h = NULL;
-        blkdev->params = xenstore_read_be_str(&blkdev->xendev, "params");
+        blkdev->params = xenstore_read_be_str(xendev, "params");
         if (blkdev->params != NULL) {
             h = strchr(blkdev->params, ':');
         }
@@ -669,18 +672,18 @@ static int blk_init(struct XenDevice *xendev)
         blkdev->fileproto = "vpc";
     }
     if (blkdev->mode == NULL) {
-        blkdev->mode = xenstore_read_be_str(&blkdev->xendev, "mode");
+        blkdev->mode = xenstore_read_be_str(xendev, "mode");
     }
     if (blkdev->type == NULL) {
-        blkdev->type = xenstore_read_be_str(&blkdev->xendev, "type");
+        blkdev->type = xenstore_read_be_str(xendev, "type");
     }
     if (blkdev->dev == NULL) {
-        blkdev->dev = xenstore_read_be_str(&blkdev->xendev, "dev");
+        blkdev->dev = xenstore_read_be_str(xendev, "dev");
     }
     if (blkdev->devtype == NULL) {
-        blkdev->devtype = xenstore_read_be_str(&blkdev->xendev, "device-type");
+        blkdev->devtype = xenstore_read_be_str(xendev, "device-type");
     }
-    directiosafe = xenstore_read_be_str(&blkdev->xendev, "direct-io-safe");
+    directiosafe = xenstore_read_be_str(xendev, "direct-io-safe");
     blkdev->directiosafe = (directiosafe && atoi(directiosafe));
 
     /* do we have all we need? */
@@ -706,10 +709,10 @@ static int blk_init(struct XenDevice *xendev)
     /* fill info
      * blk_connect supplies sector-size and sectors
      */
-    xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
-    xenstore_write_be_int(&blkdev->xendev, "info", info);
+    xenstore_write_be_int(xendev, "feature-flush-cache", 1);
+    xenstore_write_be_int(xendev, "info", info);
 
-    xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
+    xenstore_write_be_int(xendev, "max-ring-page-order",
                           MAX_RING_PAGE_ORDER);
 
     blk_parse_discard(blkdev);
@@ -761,7 +764,7 @@ static int blk_connect(struct XenDevice *xendev)
     }
 
     /* init qemu block driver */
-    index = (blkdev->xendev.dev - 202 * 256) / 16;
+    index = (xendev->dev - 202 * 256) / 16;
     blkdev->dinfo = drive_get(IF_XEN, 0, index);
     if (!blkdev->dinfo) {
         Error *local_err = NULL;
@@ -773,11 +776,11 @@ static int blk_connect(struct XenDevice *xendev)
         }
 
         /* setup via xenbus -> create new block driver instance */
-        xen_pv_printf(&blkdev->xendev, 2, "create new bdrv (xenbus setup)\n");
+        xen_pv_printf(xendev, 2, "create new bdrv (xenbus setup)\n");
         blkdev->blk = blk_new_open(blkdev->filename, NULL, options,
                                    qflags, &local_err);
         if (!blkdev->blk) {
-            xen_pv_printf(&blkdev->xendev, 0, "error: %s\n",
+            xen_pv_printf(xendev, 0, "error: %s\n",
                           error_get_pretty(local_err));
             error_free(local_err);
             return -1;
@@ -785,11 +788,11 @@ static int blk_connect(struct XenDevice *xendev)
         blk_set_enable_write_cache(blkdev->blk, !writethrough);
     } else {
         /* setup via qemu cmdline -> already setup for us */
-        xen_pv_printf(&blkdev->xendev, 2,
+        xen_pv_printf(xendev, 2,
                       "get configured bdrv (cmdline setup)\n");
         blkdev->blk = blk_by_legacy_dinfo(blkdev->dinfo);
         if (blk_is_read_only(blkdev->blk) && !readonly) {
-            xen_pv_printf(&blkdev->xendev, 0, "Unexpected read-only drive");
+            xen_pv_printf(xendev, 0, "Unexpected read-only drive");
             blkdev->blk = NULL;
             return -1;
         }
@@ -802,7 +805,7 @@ static int blk_connect(struct XenDevice *xendev)
     if (blkdev->file_size < 0) {
         BlockDriverState *bs = blk_bs(blkdev->blk);
         const char *drv_name = bs ? bdrv_get_format_name(bs) : NULL;
-        xen_pv_printf(&blkdev->xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
+        xen_pv_printf(xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
                       (int)blkdev->file_size, strerror(-blkdev->file_size),
                       drv_name ?: "-");
         blkdev->file_size = 0;
@@ -814,15 +817,15 @@ static int blk_connect(struct XenDevice *xendev)
                   blkdev->file_size, blkdev->file_size >> 20);
 
     /* Fill in number of sector size and number of sectors */
-    xenstore_write_be_int(&blkdev->xendev, "sector-size", blkdev->file_blk);
-    xenstore_write_be_int64(&blkdev->xendev, "sectors",
+    xenstore_write_be_int(xendev, "sector-size", blkdev->file_blk);
+    xenstore_write_be_int64(xendev, "sectors",
                             blkdev->file_size / blkdev->file_blk);
 
-    if (xenstore_read_fe_int(&blkdev->xendev, "ring-page-order",
+    if (xenstore_read_fe_int(xendev, "ring-page-order",
                              &order) == -1) {
         blkdev->nr_ring_ref = 1;
 
-        if (xenstore_read_fe_int(&blkdev->xendev, "ring-ref",
+        if (xenstore_read_fe_int(xendev, "ring-ref",
                                  &ring_ref) == -1) {
             return -1;
         }
@@ -839,7 +842,7 @@ static int blk_connect(struct XenDevice *xendev)
                 return -1;
             }
 
-            if (xenstore_read_fe_int(&blkdev->xendev, key,
+            if (xenstore_read_fe_int(xendev, key,
                                      &ring_ref) == -1) {
                 g_free(key);
                 return -1;
@@ -854,18 +857,18 @@ static int blk_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    if (xenstore_read_fe_int(&blkdev->xendev, "event-channel",
-                             &blkdev->xendev.remote_port) == -1) {
+    if (xenstore_read_fe_int(xendev, "event-channel",
+                             &xendev->remote_port) == -1) {
         return -1;
     }
 
-    if (!blkdev->xendev.protocol) {
+    if (!xendev->protocol) {
         blkdev->protocol = BLKIF_PROTOCOL_NATIVE;
-    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_NATIVE) == 0) {
+    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_NATIVE) == 0) {
         blkdev->protocol = BLKIF_PROTOCOL_NATIVE;
-    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_X86_32) == 0) {
+    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_32) == 0) {
         blkdev->protocol = BLKIF_PROTOCOL_X86_32;
-    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_X86_64) == 0) {
+    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_64) == 0) {
         blkdev->protocol = BLKIF_PROTOCOL_X86_64;
     } else {
         blkdev->protocol = BLKIF_PROTOCOL_NATIVE;
@@ -896,7 +899,6 @@ static int blk_connect(struct XenDevice *xendev)
     max_grants = blkdev->nr_ring_ref;
 
     xen_be_set_max_grant_refs(xendev, max_grants);
-
     blkdev->sring = xen_be_map_grant_refs(xendev, blkdev->ring_ref,
                                           blkdev->nr_ring_ref,
                                           PROT_READ | PROT_WRITE);
@@ -929,12 +931,12 @@ static int blk_connect(struct XenDevice *xendev)
 
     blk_set_aio_context(blkdev->blk, blkdev->ctx);
 
-    xen_be_bind_evtchn(&blkdev->xendev);
+    xen_be_bind_evtchn(xendev);
 
-    xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
+    xen_pv_printf(xendev, 1, "ok: proto %s, nr-ring-ref %u, "
                   "remote port %d, local port %d\n",
-                  blkdev->xendev.protocol, blkdev->nr_ring_ref,
-                  blkdev->xendev.remote_port, blkdev->xendev.local_port);
+                  xendev->protocol, blkdev->nr_ring_ref,
+                  xendev->remote_port, xendev->local_port);
     return 0;
 }
 
@@ -952,7 +954,7 @@ static void blk_disconnect(struct XenDevice *xendev)
         blk_unref(blkdev->blk);
         blkdev->blk = NULL;
     }
-    xen_pv_unbind_evtchn(&blkdev->xendev);
+    xen_pv_unbind_evtchn(xendev);
 
     aio_context_release(blkdev->ctx);
 
-- 
1.9.1
