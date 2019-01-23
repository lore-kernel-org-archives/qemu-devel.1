Received: from eggs.gnu.org ([209.51.188.92]:36734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=919de7af8=Paul.Durrant@citrix.com>)
	id 1gmEXD-00055t-8i
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=919de7af8=Paul.Durrant@citrix.com>)
	id 1gmEX7-00070X-MM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:09:21 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 23 Jan 2019 09:08:49 +0000
Message-ID: <20190123090849.7758-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen-block: handle resize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Some frontend drivers will handle dynamic resizing of PV disks, so set up
the BlockDevOps resize_cb() method during xen_block_realize() to allow
this to be done.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c |  4 +---
 hw/block/trace-events          |  1 +
 hw/block/xen-block.c           | 26 ++++++++++++++++++++++----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index d0d8905a33..c6a15da024 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -50,7 +50,6 @@ struct XenBlockDataPlane {
     unsigned int nr_ring_ref;
     void *sring;
     int64_t file_blk;
-    int64_t file_size;
     int protocol;
     blkif_back_rings_t rings;
     int more_work;
@@ -189,7 +188,7 @@ static int xen_block_parse_request(XenBlockRequest *request)
                request->req.seg[i].first_sect + 1) * dataplane->file_blk;
         request->size += len;
     }
-    if (request->start + request->size > dataplane->file_size) {
+    if (request->start + request->size > blk_getlength(dataplane->blk)) {
         error_report("error: access beyond end of file");
         goto err;
     }
@@ -638,7 +637,6 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     dataplane->xendev = xendev;
     dataplane->file_blk = conf->logical_block_size;
     dataplane->blk = conf->blk;
-    dataplane->file_size = blk_getlength(dataplane->blk);
 
     QLIST_INIT(&dataplane->inflight);
     QLIST_INIT(&dataplane->freelist);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d0851953c5..8020f9226a 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -126,6 +126,7 @@ xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%
 xen_block_connect(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
 xen_block_disconnect(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
 xen_block_unrealize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
+xen_block_size(const char *type, uint32_t disk, uint32_t partition, int64_t sectors) "%s d%up%u %"PRIi64
 xen_disk_realize(void) ""
 xen_disk_unrealize(void) ""
 xen_cdrom_realize(void) ""
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index a636487b3e..8ea28381ea 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -144,6 +144,24 @@ static void xen_block_unrealize(XenDevice *xendev, Error **errp)
     }
 }
 
+static void xen_block_resize_cb(void *opaque)
+{
+    XenBlockDevice *blockdev = opaque;
+    const char *type = object_get_typename(OBJECT(blockdev));
+    XenBlockVdev *vdev = &blockdev->props.vdev;
+    BlockConf *conf = &blockdev->props.conf;
+    XenDevice *xendev = XEN_DEVICE(blockdev);
+    int64_t sectors = blk_getlength(conf->blk) / conf->logical_block_size;
+
+    trace_xen_block_size(type, vdev->disk, vdev->partition, sectors);
+
+    xen_device_backend_printf(xendev, "sectors", "%"PRIi64, sectors);
+}
+
+static const BlockDevOps xen_block_dev_ops = {
+    .resize_cb = xen_block_resize_cb,
+};
+
 static void xen_block_realize(XenDevice *xendev, Error **errp)
 {
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
@@ -180,7 +198,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
-                                       false, errp)) {
+                                       true, errp)) {
         return;
     }
 
@@ -197,6 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
         return;
     }
 
+    blk_set_dev_ops(conf->blk, &xen_block_dev_ops, blockdev);
     blk_set_guest_block_size(conf->blk, conf->logical_block_size);
 
     if (conf->discard_granularity > 0) {
@@ -215,9 +234,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
 
     xen_device_backend_printf(xendev, "sector-size", "%u",
                               conf->logical_block_size);
-    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,
-                              blk_getlength(conf->blk) /
-                              conf->logical_block_size);
+
+    xen_block_dev_ops.resize_cb(blockdev);
 
     blockdev->dataplane =
         xen_block_dataplane_create(xendev, conf, blockdev->props.iothread);
-- 
2.20.1.2.gb21ebb6
