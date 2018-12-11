Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWflP-00051s-LQ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWflL-0003FI-TW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:59:43 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 10:47:10 +0000
Message-ID: <1544525238-3527-11-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 10/18] xen: add header and build
 dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

This patch adds the transformations necessary to get dataplane/xen-block.c
to build against the new XenBus/XenDevice framework. MAINTAINERS is also
updated due to the introduction of dataplane/xen-block.h.

NOTE: Existing data structure names are retained for the moment. These will
      be modified by subsequent patches. A typedef for XenBlockDataPlane
      has been added to the header (based on the old struct XenBlkDev name
      for the moment) so that the old names don't need to leak out of the
      dataplane code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Tidy up header inclusions
 - Get rid of error_fatal
---
 MAINTAINERS                      |   1 +
 hw/block/dataplane/Makefile.objs |   1 +
 hw/block/dataplane/xen-block.c   | 356 ++++++++++++++++++++++++++++-----------
 hw/block/dataplane/xen-block.h   |  29 ++++
 4 files changed, 287 insertions(+), 100 deletions(-)
 create mode 100644 hw/block/dataplane/xen-block.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ab62ad4..9875581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -408,6 +408,7 @@ F: hw/block/dataplane/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
+F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
 
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile.objs
index e786f66..c6c68db 100644
--- a/hw/block/dataplane/Makefile.objs
+++ b/hw/block/dataplane/Makefile.objs
@@ -1 +1,2 @@
 obj-y += virtio-blk.o
+obj-$(CONFIG_XEN) += xen-block.o
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 98f987d..20d16e7 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -24,65 +24,53 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/xen/xen_common.h"
+#include "hw/block/xen_blkif.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "xen-block.h"
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
@@ -161,7 +149,6 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
 static int ioreq_parse(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    struct XenLegacyDevice *xendev = &blkdev->xendev;
     size_t len;
     int i;
 
@@ -183,7 +170,8 @@ static int ioreq_parse(struct ioreq *ioreq)
         goto err;
     };
 
-    if (ioreq->req.operation != BLKIF_OP_READ && blkdev->mode[0] != 'w') {
+    if (ioreq->req.operation != BLKIF_OP_READ &&
+        blk_is_read_only(blkdev->blk)) {
         error_report("error: write req for ro device");
         goto err;
     }
@@ -198,7 +186,7 @@ static int ioreq_parse(struct ioreq *ioreq)
             error_report("error: first > last sector");
             goto err;
         }
-        if (ioreq->req.seg[i].last_sect * BLOCK_SIZE >= XC_PAGE_SIZE) {
+        if (ioreq->req.seg[i].last_sect * blkdev->file_blk >= XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
@@ -221,12 +209,13 @@ err:
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
@@ -246,20 +235,21 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
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
+        error_reportf_err(local_err, "failed to copy data: ");
 
-    if (rc) {
-        error_report("failed to copy data %d", rc);
         ioreq->aio_errors++;
         return -1;
     }
 
-    return rc;
+    return 0;
 }
 
 static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
@@ -268,7 +258,6 @@ static void qemu_aio_complete(void *opaque, int ret)
 {
     struct ioreq *ioreq = opaque;
     struct XenBlkDev *blkdev = ioreq->blkdev;
-    struct XenLegacyDevice *xendev = &blkdev->xendev;
 
     aio_context_acquire(blkdev->ctx);
 
@@ -346,13 +335,13 @@ static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
 
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
@@ -434,10 +423,10 @@ err:
 
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
@@ -460,9 +449,9 @@ static int blk_send_response_one(struct ioreq *ioreq)
         return 0;
     }
 
-    resp->id        = ioreq->req.id;
+    resp->id = ioreq->req.id;
     resp->operation = ioreq->req.operation;
-    resp->status    = ioreq->status;
+    resp->status = ioreq->status;
 
     blkdev->rings.common.rsp_prod_pvt++;
 
@@ -496,7 +485,14 @@ static void blk_send_response_all(struct XenBlkDev *blkdev)
         ioreq_release(ioreq, true);
     }
     if (send_notify) {
-        xen_pv_send_notify(&blkdev->xendev);
+        Error *local_err = NULL;
+
+        xen_device_notify_event_channel(blkdev->xendev,
+                                        blkdev->event_channel,
+                                        &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
@@ -567,7 +563,14 @@ static void blk_handle_requests(struct XenBlkDev *blkdev)
             };
 
             if (blk_send_response_one(ioreq)) {
-                xen_pv_send_notify(&blkdev->xendev);
+                Error *local_err = NULL;
+
+                xen_device_notify_event_channel(blkdev->xendev,
+                                                blkdev->event_channel,
+                                                &local_err);
+                if (local_err) {
+                    error_report_err(local_err);
+                }
             }
             ioreq_release(ioreq, false);
             continue;
@@ -590,32 +593,47 @@ static void blk_bh(void *opaque)
     aio_context_release(blkdev->ctx);
 }
 
-static void blk_alloc(struct XenLegacyDevice *xendev)
+static void blk_event(void *opaque)
+{
+    struct XenBlkDev *blkdev = opaque;
+
+    qemu_bh_schedule(blkdev->bh);
+}
+
+struct XenBlkDev *xen_block_dataplane_create(XenDevice *xendev,
+                                             BlockConf *conf,
+                                             IOThread *iothread)
 {
-    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
-    Error *err = NULL;
+    struct XenBlkDev *blkdev = g_new0(struct XenBlkDev, 1);
 
-    trace_xen_disk_alloc(xendev->name);
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
+void xen_block_dataplane_destroy(struct XenBlkDev *blkdev)
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
@@ -624,19 +642,157 @@ static int blk_free(struct XenLegacyDevice *xendev)
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
+
+void xen_block_dataplane_stop(struct XenBlkDev *blkdev)
 {
-    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
+    XenDevice *xendev;
 
-    qemu_bh_schedule(blkdev->bh);
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
+        Error *local_err = NULL;
+
+        xen_device_unbind_event_channel(xendev, blkdev->event_channel,
+                                        &local_err);
+        blkdev->event_channel = NULL;
+
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
+
+    if (blkdev->sring) {
+        Error *local_err = NULL;
+
+        xen_device_unmap_grant_refs(xendev, blkdev->sring,
+                                    blkdev->nr_ring_ref, &local_err);
+        blkdev->sring = NULL;
+
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
+
+    g_free(blkdev->ring_ref);
+    blkdev->ring_ref = NULL;
+}
+
+void xen_block_dataplane_start(struct XenBlkDev *blkdev,
+                               const unsigned int ring_ref[],
+                               unsigned int nr_ring_ref,
+                               unsigned int event_channel,
+                               unsigned int protocol,
+                               Error **errp)
+{
+    XenDevice *xendev = blkdev->xendev;
+    Error *local_err = NULL;
+    unsigned int ring_size;
+    unsigned int i;
+
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
+        error_setg(errp, "unknown protocol %u", blkdev->protocol);
+        return;
+    }
+
+    xen_device_set_max_grant_refs(xendev, blkdev->nr_ring_ref,
+                                  &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto stop;
+    }
+
+    blkdev->sring = xen_device_map_grant_refs(xendev,
+                                              blkdev->ring_ref,
+                                              blkdev->nr_ring_ref,
+                                              PROT_READ | PROT_WRITE,
+                                              &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto stop;
+    }
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
+                                      &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto stop;
+    }
+
+    aio_context_acquire(blkdev->ctx);
+    blk_set_aio_context(blkdev->blk, blkdev->ctx);
+    aio_context_release(blkdev->ctx);
+    return;
+
+stop:
+    xen_block_dataplane_stop(blkdev);
 }
diff --git a/hw/block/dataplane/xen-block.h b/hw/block/dataplane/xen-block.h
new file mode 100644
index 0000000..f31da38
--- /dev/null
+++ b/hw/block/dataplane/xen-block.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_BLOCK_DATAPLANE_XEN_BLOCK_H
+#define HW_BLOCK_DATAPLANE_XEN_BLOCK_H
+
+#include "hw/block/block.h"
+#include "hw/xen/xen-bus.h"
+#include "sysemu/iothread.h"
+
+typedef struct XenBlkDev XenBlockDataPlane;
+
+XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
+                                              BlockConf *conf,
+                                              IOThread *iothread);
+void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane);
+void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
+                               const unsigned int ring_ref[],
+                               unsigned int nr_ring_ref,
+                               unsigned int event_channel,
+                               unsigned int protocol,
+                               Error **errp);
+void xen_block_dataplane_stop(XenBlockDataPlane *dataplane);
+
+#endif /* HW_BLOCK_DATAPLANE_XEN_BLOCK_H */
-- 
2.1.4
