Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURP-0001lS-EQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURM-0007r9-9W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:23 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:03 +0000
Message-ID: <20181121151211.15997-11-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/18] xen: add header and build
 dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

This patch adds the transformations necessary to get dataplane/xen-qdisk.c
to build against the new XenBus/XenDevice framework. MAINTAINERS is also
updated due to the introduction of dataplane/xen-qdisk.h.

NOTE: Existing data structure names are retained for the moment. These will
      be modified by subsequent patches. A typedef for XenQdiskDataPlane
      has been added to the header (based on the old struct XenBlkDev name
      for the moment) so that the old names don't need to leak out of the
      dataplane code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 MAINTAINERS                      |   1 +
 hw/block/dataplane/Makefile.objs |   1 +
 hw/block/dataplane/xen-qdisk.c   | 317 +++++++++++++++++++++++++++------------
 hw/block/dataplane/xen-qdisk.h   |  25 +++
 4 files changed, 244 insertions(+), 100 deletions(-)
 create mode 100644 hw/block/dataplane/xen-qdisk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bfbfc9985..5871f035c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -394,6 +394,7 @@ F: hw/block/dataplane/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
+F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
 
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile.objs
index e786f66421..1c107052d1 100644
--- a/hw/block/dataplane/Makefile.objs
+++ b/hw/block/dataplane/Makefile.objs
@@ -1 +1,2 @@
 obj-y += virtio-blk.o
+obj-$(CONFIG_XEN) += xen-qdisk.o
diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-qdisk.c
index 8e4368e7af..b075aa975d 100644
--- a/hw/block/dataplane/xen-qdisk.c
+++ b/hw/block/dataplane/xen-qdisk.c
@@ -5,65 +5,56 @@
  * Based on original code (c) Gerd Hoffmann <kraxel@redhat.com>
  */
 
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/xen/xen.h"
+#include "hw/xen/xen_common.h"
+#include "hw/block/block.h"
+#include "hw/block/xen_blkif.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "xen-qdisk.h"
+
 struct ioreq {
-    blkif_request_t     req;
-    int16_t             status;
-
-    /* parsed request */
-    off_t               start;
-    QEMUIOVector        v;
-    void                *buf;
-    size_t              size;
-    int                 presync;
-
-    /* aio status */
-    int                 aio_inflight;
-    int                 aio_errors;
-
-    struct XenBlkDev    *blkdev;
-    QLIST_ENTRY(ioreq)   list;
-    BlockAcctCookie     acct;
+    blkif_request_t req;
+    int16_t status;
+    off_t start;
+    QEMUIOVector v;
+    void *buf;
+    size_t size;
+    int presync;
+    int aio_inflight;
+    int aio_errors;
+    struct XenBlkDev *blkdev;
+    QLIST_ENTRY(ioreq) list;
+    BlockAcctCookie acct;
 };
 
-#define MAX_RING_PAGE_ORDER 4
-
 struct XenBlkDev {
-    struct XenLegacyDevice    xendev;  /* must be first */
-    char                *params;
-    char                *mode;
-    char                *type;
-    char                *dev;
-    char                *devtype;
-    bool                directiosafe;
-    const char          *fileproto;
-    const char          *filename;
-    unsigned int        ring_ref[1 << MAX_RING_PAGE_ORDER];
-    unsigned int        nr_ring_ref;
-    void                *sring;
-    int64_t             file_blk;
-    int64_t             file_size;
-    int                 protocol;
-    blkif_back_rings_t  rings;
-    int                 more_work;
-
-    /* request lists */
+    XenDevice *xendev;
+    XenEventChannel *event_channel;
+    unsigned int *ring_ref;
+    unsigned int nr_ring_ref;
+    void *sring;
+    int64_t file_blk;
+    int64_t file_size;
+    int protocol;
+    blkif_back_rings_t rings;
+    int more_work;
     QLIST_HEAD(inflight_head, ioreq) inflight;
     QLIST_HEAD(finished_head, ioreq) finished;
     QLIST_HEAD(freelist_head, ioreq) freelist;
-    int                 requests_total;
-    int                 requests_inflight;
-    int                 requests_finished;
-    unsigned int        max_requests;
-
-    gboolean            feature_discard;
-
-    /* qemu block driver */
-    DriveInfo           *dinfo;
-    BlockBackend        *blk;
-    QEMUBH              *bh;
-
-    IOThread            *iothread;
-    AioContext          *ctx;
+    int requests_total;
+    int requests_inflight;
+    int requests_finished;
+    unsigned int max_requests;
+    BlockBackend *blk;
+    QEMUBH *bh;
+    IOThread *iothread;
+    AioContext *ctx;
 };
 
 static void ioreq_reset(struct ioreq *ioreq)
@@ -142,7 +133,6 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
 static int ioreq_parse(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    struct XenLegacyDevice *xendev = &blkdev->xendev;
     size_t len;
     int i;
 
@@ -164,7 +154,8 @@ static int ioreq_parse(struct ioreq *ioreq)
         goto err;
     };
 
-    if (ioreq->req.operation != BLKIF_OP_READ && blkdev->mode[0] != 'w') {
+    if (ioreq->req.operation != BLKIF_OP_READ &&
+        blk_is_read_only(blkdev->blk)) {
         error_report("error: write req for ro device");
         goto err;
     }
@@ -179,7 +170,7 @@ static int ioreq_parse(struct ioreq *ioreq)
             error_report("error: first > last sector");
             goto err;
         }
-        if (ioreq->req.seg[i].last_sect * BLOCK_SIZE >= XC_PAGE_SIZE) {
+        if (ioreq->req.seg[i].last_sect * blkdev->file_blk >= XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
@@ -202,12 +193,13 @@ err:
 static int ioreq_grant_copy(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    struct XenLegacyDevice *xendev = &blkdev->xendev;
-    XenGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-    int i, count, rc;
+    XenDevice *xendev = blkdev->xendev;
+    XenDeviceGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+    int i, count;
     int64_t file_blk = blkdev->file_blk;
     bool to_domain = (ioreq->req.operation == BLKIF_OP_READ);
     void *virt = ioreq->buf;
+    Error *local_err = NULL;
 
     if (ioreq->req.nr_segments == 0) {
         return 0;
@@ -227,20 +219,24 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
                 file_blk;
             segs[i].dest.virt = virt;
         }
-        segs[i].len = (ioreq->req.seg[i].last_sect
-                       - ioreq->req.seg[i].first_sect + 1) * file_blk;
+        segs[i].len = (ioreq->req.seg[i].last_sect -
+                       ioreq->req.seg[i].first_sect + 1) * file_blk;
         virt += segs[i].len;
     }
 
-    rc = xen_be_copy_grant_refs(xendev, to_domain, segs, count);
+    xen_device_copy_grant_refs(xendev, to_domain, segs, count, &local_err);
+
+    if (local_err) {
+        const char *msg = error_get_pretty(local_err);
+
+        error_report("failed to copy data: %s", msg);
+        error_free(local_err);
 
-    if (rc) {
-        error_report("failed to copy data %d", rc);
         ioreq->aio_errors++;
         return -1;
     }
 
-    return rc;
+    return 0;
 }
 
 static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
@@ -249,7 +245,6 @@ static void qemu_aio_complete(void *opaque, int ret)
 {
     struct ioreq *ioreq = opaque;
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    struct XenLegacyDevice *xendev = &blkdev->xendev;
 
     aio_context_acquire(blkdev->ctx);
 
@@ -327,13 +322,13 @@ static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
 
     /* Wrap around, or overflowing byte limit? */
     if (sec_start + sec_count < sec_count ||
-        sec_start + sec_count > INT64_MAX >> BDRV_SECTOR_BITS) {
+        sec_start + sec_count > INT64_MAX / blkdev->file_blk) {
         return false;
     }
 
-    limit = BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS;
-    byte_offset = sec_start << BDRV_SECTOR_BITS;
-    byte_remaining = sec_count << BDRV_SECTOR_BITS;
+    limit = BDRV_REQUEST_MAX_SECTORS * blkdev->file_blk;
+    byte_offset = sec_start * blkdev->file_blk;
+    byte_remaining = sec_count * blkdev->file_blk;
 
     do {
         byte_chunk = byte_remaining > limit ? limit : byte_remaining;
@@ -415,10 +410,10 @@ err:
 
 static int blk_send_response_one(struct ioreq *ioreq)
 {
-    struct XenBlkDev  *blkdev = ioreq->blkdev;
-    int               send_notify   = 0;
-    int               have_requests = 0;
-    blkif_response_t  *resp;
+    struct XenBlkDev *blkdev = ioreq->blkdev;
+    int send_notify = 0;
+    int have_requests = 0;
+    blkif_response_t *resp;
 
     /* Place on the response ring for the relevant domain. */
     switch (blkdev->protocol) {
@@ -441,9 +436,9 @@ static int blk_send_response_one(struct ioreq *ioreq)
         return 0;
     }
 
-    resp->id        = ioreq->req.id;
+    resp->id = ioreq->req.id;
     resp->operation = ioreq->req.operation;
-    resp->status    = ioreq->status;
+    resp->status = ioreq->status;
 
     blkdev->rings.common.rsp_prod_pvt++;
 
@@ -477,7 +472,7 @@ static void blk_send_response_all(struct XenBlkDev *blkdev)
         ioreq_release(ioreq, true);
     }
     if (send_notify) {
-        xen_pv_send_notify(&blkdev->xendev);
+        xen_device_notify_event_channel(blkdev->xendev, blkdev->event_channel);
     }
 }
 
@@ -548,7 +543,8 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
             };
 
             if (blk_send_response_one(ioreq)) {
-                xen_pv_send_notify(&blkdev->xendev);
+                xen_device_notify_event_channel(blkdev->xendev,
+                                                blkdev->event_channel);
             }
             ioreq_release(ioreq, false);
             continue;
@@ -571,32 +567,47 @@ static void blk_bh(void *opaque)
     aio_context_release(blkdev->ctx);
 }
 
-static void blk_alloc(struct XenLegacyDevice *xendev)
+static void blk_event(void *opaque)
 {
-    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
-    Error *err = NULL;
+    struct XenBlkDev *blkdev = opaque;
 
-    trace_xen_disk_alloc(xendev->name);
+    qemu_bh_schedule(blkdev->bh);
+}
+
+struct XenBlkDev *xen_qdisk_dataplane_create(XenDevice *xendev,
+                                             BlockConf *conf,
+                                             IOThread *iothread)
+{
+    struct XenBlkDev *blkdev = g_new0(struct XenBlkDev, 1);
+
+    blkdev->xendev = xendev;
+    blkdev->file_blk = conf->logical_block_size;
+    blkdev->blk = conf->blk;
+    blkdev->file_size = blk_getlength(blkdev->blk);
 
     QLIST_INIT(&blkdev->inflight);
     QLIST_INIT(&blkdev->finished);
     QLIST_INIT(&blkdev->freelist);
 
-    blkdev->iothread = iothread_create(xendev->name, &err);
-    assert(!err);
-
-    blkdev->ctx = iothread_get_aio_context(blkdev->iothread);
+    if (iothread) {
+        blkdev->iothread = iothread;
+        object_ref(OBJECT(blkdev->iothread));
+        blkdev->ctx = iothread_get_aio_context(blkdev->iothread);
+    } else {
+        blkdev->ctx = qemu_get_aio_context();
+    }
     blkdev->bh = aio_bh_new(blkdev->ctx, blk_bh, blkdev);
+
+    return blkdev;
 }
 
-static int blk_free(struct XenLegacyDevice *xendev)
+void xen_qdisk_dataplane_destroy(struct XenBlkDev *blkdev)
 {
-    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     struct ioreq *ioreq;
 
-    trace_xen_disk_free(xendev->name);
-
-    blk_disconnect(xendev);
+    if (!blkdev) {
+        return;
+    }
 
     while (!QLIST_EMPTY(&blkdev->freelist)) {
         ioreq = QLIST_FIRST(&blkdev->freelist);
@@ -605,19 +616,125 @@ static int blk_free(struct XenLegacyDevice *xendev)
         g_free(ioreq);
     }
 
-    g_free(blkdev->params);
-    g_free(blkdev->mode);
-    g_free(blkdev->type);
-    g_free(blkdev->dev);
-    g_free(blkdev->devtype);
     qemu_bh_delete(blkdev->bh);
-    iothread_destroy(blkdev->iothread);
-    return 0;
+    if (blkdev->iothread) {
+        object_unref(OBJECT(blkdev->iothread));
+    }
+
+    g_free(blkdev);
 }
 
-static void blk_event(struct XenLegacyDevice *xendev)
+void xen_qdisk_dataplane_start(struct XenBlkDev *blkdev,
+                               const unsigned int ring_ref[],
+                               unsigned int nr_ring_ref,
+                               unsigned int event_channel,
+                               unsigned int protocol)
 {
-    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
+    XenDevice *xendev = blkdev->xendev;
+    unsigned int ring_size;
+    unsigned int i;
 
-    qemu_bh_schedule(blkdev->bh);
+    blkdev->nr_ring_ref = nr_ring_ref;
+    blkdev->ring_ref = g_new(unsigned int, nr_ring_ref);
+
+    for (i = 0; i < nr_ring_ref; i++) {
+        blkdev->ring_ref[i] = ring_ref[i];
+    }
+
+    blkdev->protocol = protocol;
+
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
+        assert(false);
+        break;
+    }
+
+    xen_device_set_max_grant_refs(xendev, blkdev->nr_ring_ref,
+                                  &error_fatal);
+
+    blkdev->sring = xen_device_map_grant_refs(xendev,
+                                              blkdev->ring_ref,
+                                              blkdev->nr_ring_ref,
+                                              PROT_READ | PROT_WRITE,
+                                              &error_fatal);
+
+    switch (blkdev->protocol) {
+    case BLKIF_PROTOCOL_NATIVE:
+    {
+        blkif_sring_t *sring_native = blkdev->sring;
+
+        BACK_RING_INIT(&blkdev->rings.native, sring_native, ring_size);
+        break;
+    }
+    case BLKIF_PROTOCOL_X86_32:
+    {
+        blkif_x86_32_sring_t *sring_x86_32 = blkdev->sring;
+
+        BACK_RING_INIT(&blkdev->rings.x86_32_part, sring_x86_32,
+                       ring_size);
+        break;
+    }
+    case BLKIF_PROTOCOL_X86_64:
+    {
+        blkif_x86_64_sring_t *sring_x86_64 = blkdev->sring;
+
+        BACK_RING_INIT(&blkdev->rings.x86_64_part, sring_x86_64,
+                       ring_size);
+        break;
+    }
+    }
+
+    blkdev->event_channel =
+        xen_device_bind_event_channel(xendev, event_channel,
+                                      blk_event, blkdev,
+                                      &error_fatal);
+
+    aio_context_acquire(blkdev->ctx);
+    blk_set_aio_context(blkdev->blk, blkdev->ctx);
+    aio_context_release(blkdev->ctx);
+}
+
+void xen_qdisk_dataplane_stop(struct XenBlkDev *blkdev)
+{
+    XenDevice *xendev;
+
+    if (!blkdev) {
+        return;
+    }
+
+    aio_context_acquire(blkdev->ctx);
+    blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
+    aio_context_release(blkdev->ctx);
+
+    xendev = blkdev->xendev;
+
+    if (blkdev->event_channel) {
+        xen_device_unbind_event_channel(xendev, blkdev->event_channel);
+        blkdev->event_channel = NULL;
+    }
+
+    if (blkdev->sring) {
+        xen_device_unmap_grant_refs(xendev, blkdev->sring,
+                                    blkdev->nr_ring_ref, &error_fatal);
+        blkdev->sring = NULL;
+    }
+
+    g_free(blkdev->ring_ref);
+    blkdev->ring_ref = NULL;
 }
diff --git a/hw/block/dataplane/xen-qdisk.h b/hw/block/dataplane/xen-qdisk.h
new file mode 100644
index 0000000000..16bcd500bf
--- /dev/null
+++ b/hw/block/dataplane/xen-qdisk.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) Citrix Systems Inc.
+ * All rights reserved.
+ */
+
+#ifndef HW_BLOCK_DATAPLANE_QDISK_H
+#define HW_BLOCK_DATAPLANE_QDISK_H
+
+#include "hw/xen/xen-bus.h"
+#include "sysemu/iothread.h"
+
+typedef struct XenBlkDev XenQdiskDataPlane;
+
+XenQdiskDataPlane *xen_qdisk_dataplane_create(XenDevice *xendev,
+                                              BlockConf *conf,
+                                              IOThread *iothread);
+void xen_qdisk_dataplane_destroy(XenQdiskDataPlane *dataplane);
+void xen_qdisk_dataplane_start(XenQdiskDataPlane *dataplane,
+                               const unsigned int ring_ref[],
+                               unsigned int nr_ring_ref,
+                               unsigned int event_channel,
+                               unsigned int protocol);
+void xen_qdisk_dataplane_stop(XenQdiskDataPlane *dataplane);
+
+#endif /* HW_BLOCK_DATAPLANE_QDISK_H */
-- 
2.11.0
