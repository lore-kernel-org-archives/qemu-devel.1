Received: from eggs.gnu.org ([209.51.188.92]:35979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9951a354b=Paul.Durrant@citrix.com>)
	id 1hDtnj-0000a0-E1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9951a354b=Paul.Durrant@citrix.com>)
	id 1hDtnh-0007O3-JE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:47 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 9 Apr 2019 17:40:38 +0100
Message-ID: <20190409164038.25484-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen-block: support feature-large-sector-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

A recent Xen commit [1] clarified the semantics of sector based quantities
used in the blkif protocol such that it is now safe to create a xen-block
device with a logical_block_size != 512, as long as the device only
connects to a frontend advertizing 'feature-large-block-size'.

This patch modifies xen-block accordingly. It also uses a stack variable
for the BlockBackend in xen_block_realize() to avoid repeated dereferencing
of the BlockConf pointer, and changes the parameters of
xen_block_dataplane_create() so that the BlockBackend pointer and sector
size are passed expicitly rather than implicitly via the BlockConf.

These modifications have been tested against a recent Windows PV XENVBD
driver [2] using a xen-disk device with a 4kB logical block size.

[1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=67e1c050e36b2c9900cca83618e56189effbad98
[2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c | 25 ++++++++++++----------
 hw/block/dataplane/xen-block.h |  3 ++-
 hw/block/xen-block.c           | 38 +++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 908bd27bbd..50094a886b 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -58,6 +58,7 @@ struct XenBlockDataPlane {
     int requests_inflight;
     unsigned int max_requests;
     BlockBackend *blk;
+    unsigned int sector_size;
     QEMUBH *bh;
     IOThread *iothread;
     AioContext *ctx;
@@ -167,7 +168,7 @@ static int xen_block_parse_request(XenBlockRequest *request)
         goto err;
     }
 
-    request->start = request->req.sector_number * XEN_BLKIF_SECTOR_SIZE;
+    request->start = request->req.sector_number * dataplane->sector_size;
     for (i = 0; i < request->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
             error_report("error: nr_segments too big");
@@ -177,14 +178,14 @@ static int xen_block_parse_request(XenBlockRequest *request)
             error_report("error: first > last sector");
             goto err;
         }
-        if (request->req.seg[i].last_sect * XEN_BLKIF_SECTOR_SIZE >=
+        if (request->req.seg[i].last_sect * dataplane->sector_size >=
             XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
 
         len = (request->req.seg[i].last_sect -
-               request->req.seg[i].first_sect + 1) * XEN_BLKIF_SECTOR_SIZE;
+               request->req.seg[i].first_sect + 1) * dataplane->sector_size;
         request->size += len;
     }
     if (request->start + request->size > blk_getlength(dataplane->blk)) {
@@ -218,17 +219,17 @@ static int xen_block_copy_request(XenBlockRequest *request)
         if (to_domain) {
             segs[i].dest.foreign.ref = request->req.seg[i].gref;
             segs[i].dest.foreign.offset = request->req.seg[i].first_sect *
-                XEN_BLKIF_SECTOR_SIZE;
+                dataplane->sector_size;
             segs[i].source.virt = virt;
         } else {
             segs[i].source.foreign.ref = request->req.seg[i].gref;
             segs[i].source.foreign.offset = request->req.seg[i].first_sect *
-                XEN_BLKIF_SECTOR_SIZE;
+                dataplane->sector_size;
             segs[i].dest.virt = virt;
         }
         segs[i].len = (request->req.seg[i].last_sect -
                        request->req.seg[i].first_sect + 1) *
-                      XEN_BLKIF_SECTOR_SIZE;
+                      dataplane->sector_size;
         virt += segs[i].len;
     }
 
@@ -338,12 +339,12 @@ static bool xen_block_split_discard(XenBlockRequest *request,
 
     /* Wrap around, or overflowing byte limit? */
     if (sec_start + sec_count < sec_count ||
-        sec_start + sec_count > INT64_MAX / XEN_BLKIF_SECTOR_SIZE) {
+        sec_start + sec_count > INT64_MAX / dataplane->sector_size) {
         return false;
     }
 
-    byte_offset = sec_start * XEN_BLKIF_SECTOR_SIZE;
-    byte_remaining = sec_count * XEN_BLKIF_SECTOR_SIZE;
+    byte_offset = sec_start * dataplane->sector_size;
+    byte_remaining = sec_count * dataplane->sector_size;
 
     do {
         byte_chunk = byte_remaining > BDRV_REQUEST_MAX_BYTES ?
@@ -626,13 +627,15 @@ static bool xen_block_dataplane_event(void *opaque)
 }
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
-                                              BlockConf *conf,
+                                              BlockBackend *blk,
+                                              unsigned int sector_size,
                                               IOThread *iothread)
 {
     XenBlockDataPlane *dataplane = g_new0(XenBlockDataPlane, 1);
 
     dataplane->xendev = xendev;
-    dataplane->blk = conf->blk;
+    dataplane->blk = blk;
+    dataplane->sector_size = sector_size;
 
     QLIST_INIT(&dataplane->inflight);
     QLIST_INIT(&dataplane->freelist);
diff --git a/hw/block/dataplane/xen-block.h b/hw/block/dataplane/xen-block.h
index d6fa6d26dd..76dcd51c3d 100644
--- a/hw/block/dataplane/xen-block.h
+++ b/hw/block/dataplane/xen-block.h
@@ -15,7 +15,8 @@
 typedef struct XenBlockDataPlane XenBlockDataPlane;
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
-                                              BlockConf *conf,
+                                              BlockBackend *blk,
+                                              unsigned int sector_size,
                                               IOThread *iothread);
 void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane);
 void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index ef635be4c2..05e890ad78 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -51,11 +51,25 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
+    BlockConf *conf = &blockdev->props.conf;
+    unsigned int feature_large_sector_size;
     unsigned int order, nr_ring_ref, *ring_ref, event_channel, protocol;
     char *str;
 
     trace_xen_block_connect(type, vdev->disk, vdev->partition);
 
+    if (xen_device_frontend_scanf(xendev, "feature-large-sector-size", "%u",
+                                  &feature_large_sector_size) != 1) {
+        feature_large_sector_size = 0;
+    }
+
+    if (feature_large_sector_size != 1 &&
+        conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
+        error_setg(errp, "logical_block_size != %u not supported",
+                   XEN_BLKIF_SECTOR_SIZE);
+        return;
+    }
+
     if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
                                   &order) != 1) {
         nr_ring_ref = 1;
@@ -149,7 +163,7 @@ static void xen_block_set_size(XenBlockDevice *blockdev)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
-    int64_t sectors = blk_getlength(conf->blk) / XEN_BLKIF_SECTOR_SIZE;
+    int64_t sectors = blk_getlength(conf->blk) / conf->logical_block_size;
     XenDevice *xendev = XEN_DEVICE(blockdev);
 
     trace_xen_block_size(type, vdev->disk, vdev->partition, sectors);
@@ -184,6 +198,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
+    BlockBackend *blk = conf->blk;
     Error *local_err = NULL;
 
     if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
@@ -205,8 +220,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
      * The blkif protocol does not deal with removable media, so it must
      * always be present, even for CDRom devices.
      */
-    assert(conf->blk);
-    if (!blk_is_inserted(conf->blk)) {
+    assert(blk);
+    if (!blk_is_inserted(blk)) {
         error_setg(errp, "device needs media, but drive is empty");
         return;
     }
@@ -223,26 +238,20 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
 
     blkconf_blocksizes(conf);
 
-    if (conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
-        error_setg(errp, "logical_block_size != %u not supported",
-                   XEN_BLKIF_SECTOR_SIZE);
-        return;
-    }
-
     if (conf->logical_block_size > conf->physical_block_size) {
         error_setg(
             errp, "logical_block_size > physical_block_size not supported");
         return;
     }
 
-    blk_set_dev_ops(conf->blk, &xen_block_dev_ops, blockdev);
-    blk_set_guest_block_size(conf->blk, conf->logical_block_size);
+    blk_set_dev_ops(blk, &xen_block_dev_ops, blockdev);
+    blk_set_guest_block_size(blk, conf->logical_block_size);
 
     if (conf->discard_granularity == -1) {
         conf->discard_granularity = conf->physical_block_size;
     }
 
-    if (blk_get_flags(conf->blk) & BDRV_O_UNMAP) {
+    if (blk_get_flags(blk) & BDRV_O_UNMAP) {
         xen_device_backend_printf(xendev, "feature-discard", "%u", 1);
         xen_device_backend_printf(xendev, "discard-granularity", "%u",
                                   conf->discard_granularity);
@@ -259,12 +268,13 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
                                blockdev->device_type);
 
     xen_device_backend_printf(xendev, "sector-size", "%u",
-                              XEN_BLKIF_SECTOR_SIZE);
+                              conf->logical_block_size);
 
     xen_block_set_size(blockdev);
 
     blockdev->dataplane =
-        xen_block_dataplane_create(xendev, conf, blockdev->props.iothread);
+        xen_block_dataplane_create(xendev, blk, conf->logical_block_size,
+                                   blockdev->props.iothread);
 }
 
 static void xen_block_frontend_changed(XenDevice *xendev,
-- 
2.20.1.2.gb21ebb6
