Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80h-0005Wb-Nm
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80e-0000tY-Ha
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:27 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 30 Apr 2018 13:01:39 +0100
Message-ID: <1525089699-13411-5-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] block/xen_disk: be consistent with use of
 xendev and blkdev->xendev
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

Certain functions in xen_disk are called with a pointer to xendev
(struct XenDevice *). They then use continer_of() to acces the surrounding
blkdev (struct XenBlkDev) but then in various places use &blkdev->xendev
when use of the original xendev pointer is shorter to express and clearly
equivalent.

This patch is a purely cosmetic patch which makes sure there is a xendev
pointer on stack for any function where the pointer is need on multiple
occasions modified those functions to use it consistently.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen_disk.c | 116 +++++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 6d737fd..b538d21 100644
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
@@ -241,7 +242,8 @@ err:
 static int ioreq_grant_copy(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    xengnttab_handle *gnt = blkdev->xendev.gnttabdev;
+    struct XenDevice *xendev = &blkdev->xendev;
+    xengnttab_handle *gnt = xendev->gnttabdev;
     void *virt = ioreq->buf;
     xengnttab_grant_copy_segment_t segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, rc;
@@ -251,13 +253,13 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
         if (ioreq->req.operation == BLKIF_OP_READ) {
             segs[i].flags = GNTCOPY_dest_gref;
             segs[i].dest.foreign.ref = ioreq->req.seg[i].gref;
-            segs[i].dest.foreign.domid = blkdev->xendev.dom;
+            segs[i].dest.foreign.domid = xendev->dom;
             segs[i].dest.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
             segs[i].source.virt = virt;
         } else {
             segs[i].flags = GNTCOPY_source_gref;
             segs[i].source.foreign.ref = ioreq->req.seg[i].gref;
-            segs[i].source.foreign.domid = blkdev->xendev.dom;
+            segs[i].source.foreign.domid = xendev->dom;
             segs[i].source.foreign.offset = ioreq->req.seg[i].first_sect * file_blk;
             segs[i].dest.virt = virt;
         }
@@ -269,7 +271,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
     rc = xengnttab_grant_copy(gnt, ioreq->req.nr_segments, segs);
 
     if (rc) {
-        xen_pv_printf(&blkdev->xendev, 0,
+        xen_pv_printf(xendev, 0,
                       "failed to copy data %d\n", rc);
         ioreq->aio_errors++;
         return -1;
@@ -277,10 +279,10 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
 
     for (i = 0; i < ioreq->req.nr_segments; i++) {
         if (segs[i].status != GNTST_okay) {
-            xen_pv_printf(&blkdev->xendev, 3,
+            xen_pv_printf(xendev, 3,
                           "failed to copy data %d for gref %d, domid %d\n",
                           segs[i].status, ioreq->req.seg[i].gref,
-                          blkdev->xendev.dom);
+                          xendev->dom);
             ioreq->aio_errors++;
             rc = -1;
         }
@@ -296,11 +298,12 @@ static void qemu_aio_complete(void *opaque, int ret)
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
@@ -632,16 +635,17 @@ static void blk_alloc(struct XenDevice *xendev)
 
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
 
@@ -656,7 +660,7 @@ static int blk_init(struct XenDevice *xendev)
     /* read xenstore entries */
     if (blkdev->params == NULL) {
         char *h = NULL;
-        blkdev->params = xenstore_read_be_str(&blkdev->xendev, "params");
+        blkdev->params = xenstore_read_be_str(xendev, "params");
         if (blkdev->params != NULL) {
             h = strchr(blkdev->params, ':');
         }
@@ -676,18 +680,18 @@ static int blk_init(struct XenDevice *xendev)
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
@@ -717,10 +721,10 @@ static int blk_init(struct XenDevice *xendev)
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
@@ -773,7 +777,7 @@ static int blk_connect(struct XenDevice *xendev)
     }
 
     /* init qemu block driver */
-    index = (blkdev->xendev.dev - 202 * 256) / 16;
+    index = (xendev->dev - 202 * 256) / 16;
     blkdev->dinfo = drive_get(IF_XEN, 0, index);
     if (!blkdev->dinfo) {
         Error *local_err = NULL;
@@ -785,11 +789,11 @@ static int blk_connect(struct XenDevice *xendev)
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
@@ -797,11 +801,11 @@ static int blk_connect(struct XenDevice *xendev)
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
@@ -814,7 +818,7 @@ static int blk_connect(struct XenDevice *xendev)
     if (blkdev->file_size < 0) {
         BlockDriverState *bs = blk_bs(blkdev->blk);
         const char *drv_name = bs ? bdrv_get_format_name(bs) : NULL;
-        xen_pv_printf(&blkdev->xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
+        xen_pv_printf(xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
                       (int)blkdev->file_size, strerror(-blkdev->file_size),
                       drv_name ?: "-");
         blkdev->file_size = 0;
@@ -826,15 +830,15 @@ static int blk_connect(struct XenDevice *xendev)
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
@@ -851,7 +855,7 @@ static int blk_connect(struct XenDevice *xendev)
                 return -1;
             }
 
-            if (xenstore_read_fe_int(&blkdev->xendev, key,
+            if (xenstore_read_fe_int(xendev, key,
                                      &ring_ref) == -1) {
                 g_free(key);
                 return -1;
@@ -866,18 +870,18 @@ static int blk_connect(struct XenDevice *xendev)
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
@@ -907,13 +911,13 @@ static int blk_connect(struct XenDevice *xendev)
     /* Add on the number needed for the ring pages */
     max_grants = blkdev->nr_ring_ref;
 
-    blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
-    if (blkdev->xendev.gnttabdev == NULL) {
+    xendev->gnttabdev = xengnttab_open(NULL, 0);
+    if (xendev->gnttabdev == NULL) {
         xen_pv_printf(xendev, 0, "xengnttab_open failed: %s\n",
                       strerror(errno));
         return -1;
     }
-    if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
+    if (xengnttab_set_max_grants(xendev->gnttabdev, max_grants)) {
         xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
                       strerror(errno));
         return -1;
@@ -921,10 +925,10 @@ static int blk_connect(struct XenDevice *xendev)
 
     domids = g_new0(uint32_t, blkdev->nr_ring_ref);
     for (i = 0; i < blkdev->nr_ring_ref; i++) {
-        domids[i] = blkdev->xendev.dom;
+        domids[i] = xendev->dom;
     }
 
-    blkdev->sring = xengnttab_map_grant_refs(blkdev->xendev.gnttabdev,
+    blkdev->sring = xengnttab_map_grant_refs(xendev->gnttabdev,
                                              blkdev->nr_ring_ref,
                                              domids,
                                              blkdev->ring_ref,
@@ -961,12 +965,12 @@ static int blk_connect(struct XenDevice *xendev)
 
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
 
@@ -984,19 +988,19 @@ static void blk_disconnect(struct XenDevice *xendev)
         blk_unref(blkdev->blk);
         blkdev->blk = NULL;
     }
-    xen_pv_unbind_evtchn(&blkdev->xendev);
+    xen_pv_unbind_evtchn(xendev);
 
     aio_context_release(blkdev->ctx);
 
     if (blkdev->sring) {
-        xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
+        xengnttab_unmap(xendev->gnttabdev, blkdev->sring,
                         blkdev->nr_ring_ref);
         blkdev->sring = NULL;
     }
 
-    if (blkdev->xendev.gnttabdev) {
-        xengnttab_close(blkdev->xendev.gnttabdev);
-        blkdev->xendev.gnttabdev = NULL;
+    if (xendev->gnttabdev) {
+        xengnttab_close(xendev->gnttabdev);
+        xendev->gnttabdev = NULL;
     }
 }
 
-- 
2.1.4
