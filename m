Received: from eggs.gnu.org ([209.51.188.92]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAvt6-0004xh-AD
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAvt4-0005i6-W5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:18:04 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 1 Apr 2019 13:17:19 +0100
Message-ID: <20190401121719.27208-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] xen-block: scale sector based quantities
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The Xen blkif protocol requires that sector based quantities should be
interpreted strictly as multiples of 512 bytes. Specifically:

"first_sect and last_sect in blkif_request_segment, as well as
sector_number in blkif_request, are always expressed in 512-byte units."

Commit fcab2b464e06 "xen: add header and build dataplane/xen-block.c"
incorrectly modified behaviour to use the block device logical_block_size
property as the scale, instead of correctly shifting values by the
hardcoded BDRV_SECTOR_BITS (and hence scaling them to 512 byte units).
This patch undoes that change and restores compliance with the spec.

Furthermore, this patch also restores the original xen_disk behaviour
of advertizing a hardcoded 'sector-size' value of 512 in xenstore and
scaling 'sectors' accordingly. The realize() method is also modified to
fail if logical_block_size is set to anything other than 512.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

v3:
 - Expand commit comment with more explanation
 - Enforce logical_block_size == 512
---
 hw/block/dataplane/xen-block.c | 28 +++++++++++++---------------
 hw/block/xen-block.c           | 10 ++++++++--
 hw/block/xen_blkif.h           |  2 ++
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index f1523c5b45..bb8f1186e4 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -49,7 +49,6 @@ struct XenBlockDataPlane {
     unsigned int *ring_ref;
     unsigned int nr_ring_ref;
     void *sring;
-    int64_t file_blk;
     int protocol;
     blkif_back_rings_t rings;
     int more_work;
@@ -168,7 +167,7 @@ static int xen_block_parse_request(XenBlockRequest *request)
         goto err;
     }
 
-    request->start = request->req.sector_number * dataplane->file_blk;
+    request->start = request->req.sector_number * XEN_BLKIF_SECTOR_SIZE;
     for (i = 0; i < request->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
             error_report("error: nr_segments too big");
@@ -178,14 +177,14 @@ static int xen_block_parse_request(XenBlockRequest *request)
             error_report("error: first > last sector");
             goto err;
         }
-        if (request->req.seg[i].last_sect * dataplane->file_blk >=
+        if (request->req.seg[i].last_sect * XEN_BLKIF_SECTOR_SIZE >=
             XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
 
         len = (request->req.seg[i].last_sect -
-               request->req.seg[i].first_sect + 1) * dataplane->file_blk;
+               request->req.seg[i].first_sect + 1) * XEN_BLKIF_SECTOR_SIZE;
         request->size += len;
     }
     if (request->start + request->size > blk_getlength(dataplane->blk)) {
@@ -205,7 +204,6 @@ static int xen_block_copy_request(XenBlockRequest *request)
     XenDevice *xendev = dataplane->xendev;
     XenDeviceGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, count;
-    int64_t file_blk = dataplane->file_blk;
     bool to_domain = (request->req.operation == BLKIF_OP_READ);
     void *virt = request->buf;
     Error *local_err = NULL;
@@ -220,16 +218,17 @@ static int xen_block_copy_request(XenBlockRequest *request)
         if (to_domain) {
             segs[i].dest.foreign.ref = request->req.seg[i].gref;
             segs[i].dest.foreign.offset = request->req.seg[i].first_sect *
-                file_blk;
+                XEN_BLKIF_SECTOR_SIZE;
             segs[i].source.virt = virt;
         } else {
             segs[i].source.foreign.ref = request->req.seg[i].gref;
             segs[i].source.foreign.offset = request->req.seg[i].first_sect *
-                file_blk;
+                XEN_BLKIF_SECTOR_SIZE;
             segs[i].dest.virt = virt;
         }
         segs[i].len = (request->req.seg[i].last_sect -
-                       request->req.seg[i].first_sect + 1) * file_blk;
+                       request->req.seg[i].first_sect + 1) *
+                      XEN_BLKIF_SECTOR_SIZE;
         virt += segs[i].len;
     }
 
@@ -331,22 +330,22 @@ static bool xen_block_split_discard(XenBlockRequest *request,
     XenBlockDataPlane *dataplane = request->dataplane;
     int64_t byte_offset;
     int byte_chunk;
-    uint64_t byte_remaining, limit;
+    uint64_t byte_remaining;
     uint64_t sec_start = sector_number;
     uint64_t sec_count = nr_sectors;
 
     /* Wrap around, or overflowing byte limit? */
     if (sec_start + sec_count < sec_count ||
-        sec_start + sec_count > INT64_MAX / dataplane->file_blk) {
+        sec_start + sec_count > INT64_MAX / XEN_BLKIF_SECTOR_SIZE) {
         return false;
     }
 
-    limit = BDRV_REQUEST_MAX_SECTORS * dataplane->file_blk;
-    byte_offset = sec_start * dataplane->file_blk;
-    byte_remaining = sec_count * dataplane->file_blk;
+    byte_offset = sec_start * XEN_BLKIF_SECTOR_SIZE;
+    byte_remaining = sec_count * XEN_BLKIF_SECTOR_SIZE;
 
     do {
-        byte_chunk = byte_remaining > limit ? limit : byte_remaining;
+        byte_chunk = byte_remaining > BDRV_REQUEST_MAX_BYTES ?
+            BDRV_REQUEST_MAX_BYTES : byte_remaining;
         request->aio_inflight++;
         blk_aio_pdiscard(dataplane->blk, byte_offset, byte_chunk,
                          xen_block_complete_aio, request);
@@ -632,7 +631,6 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     XenBlockDataPlane *dataplane = g_new0(XenBlockDataPlane, 1);
 
     dataplane->xendev = xendev;
-    dataplane->file_blk = conf->logical_block_size;
     dataplane->blk = conf->blk;
 
     QLIST_INIT(&dataplane->inflight);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index a848849f48..522385561a 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -149,7 +149,7 @@ static void xen_block_set_size(XenBlockDevice *blockdev)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
-    int64_t sectors = blk_getlength(conf->blk) / conf->logical_block_size;
+    int64_t sectors = blk_getlength(conf->blk) / XEN_BLKIF_SECTOR_SIZE;
     XenDevice *xendev = XEN_DEVICE(blockdev);
 
     trace_xen_block_size(type, vdev->disk, vdev->partition, sectors);
@@ -223,6 +223,12 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
 
     blkconf_blocksizes(conf);
 
+    if (conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
+        error_setg(errp, "logical_block_size != %u not supported",
+                   XEN_BLKIF_SECTOR_SIZE);
+        return;
+    }
+
     if (conf->logical_block_size > conf->physical_block_size) {
         error_setg(
             errp, "logical_block_size > physical_block_size not supported");
@@ -253,7 +259,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
                                blockdev->device_type);
 
     xen_device_backend_printf(xendev, "sector-size", "%u",
-                              conf->logical_block_size);
+                              XEN_BLKIF_SECTOR_SIZE);
 
     xen_block_set_size(blockdev);
 
diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
index 3e6e1ea365..a353693ea0 100644
--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -143,4 +143,6 @@ static inline void blkif_get_x86_64_req(blkif_request_t *dst,
     }
 }
 
+#define XEN_BLKIF_SECTOR_SIZE 512
+
 #endif /* XEN_BLKIF_H */
-- 
2.20.1.2.gb21ebb6
