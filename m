Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURM-0001iX-EP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURK-0007os-67
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:20 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:05 +0000
Message-ID: <20181121151211.15997-13-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/18] xen: remove 'ioreq' struct/varable/field
 names from dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is a purely cosmetic patch that purges the name 'ioreq' from struct,
variable and field names. (This name has been problematic for a long time
as 'ioreq' is the name used for generic I/O requests coming from Xen).
The patch replaces 'struct ioreq' with a new 'XenQdiskRequest' type and
'ioreq' field/variable names with 'request', and then does necessary
fix-up to adhere to coding style.

Function names are not modified by this patch. Yhey will be dealt with in
a subsequent patch.

No functional change.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-qdisk.c | 310 +++++++++++++++++++++--------------------
 1 file changed, 156 insertions(+), 154 deletions(-)

diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-qdisk.c
index 2214455ff9..50a48b6f5f 100644
--- a/hw/block/dataplane/xen-qdisk.c
+++ b/hw/block/dataplane/xen-qdisk.c
@@ -18,7 +18,7 @@
 #include "sysemu/iothread.h"
 #include "xen-qdisk.h"
 
-struct ioreq {
+typedef struct XenQdiskRequest {
     blkif_request_t req;
     int16_t status;
     off_t start;
@@ -29,9 +29,9 @@ struct ioreq {
     int aio_inflight;
     int aio_errors;
     XenQdiskDataPlane *dataplane;
-    QLIST_ENTRY(ioreq) list;
+    QLIST_ENTRY(XenQdiskRequest) list;
     BlockAcctCookie acct;
-};
+} XenQdiskRequest;
 
 struct XenQdiskDataPlane {
     XenDevice *xendev;
@@ -44,9 +44,9 @@ struct XenQdiskDataPlane {
     int protocol;
     blkif_back_rings_t rings;
     int more_work;
-    QLIST_HEAD(inflight_head, ioreq) inflight;
-    QLIST_HEAD(finished_head, ioreq) finished;
-    QLIST_HEAD(freelist_head, ioreq) freelist;
+    QLIST_HEAD(inflight_head, XenQdiskRequest) inflight;
+    QLIST_HEAD(finished_head, XenQdiskRequest) finished;
+    QLIST_HEAD(freelist_head, XenQdiskRequest) freelist;
     int requests_total;
     int requests_inflight;
     int requests_finished;
@@ -57,68 +57,68 @@ struct XenQdiskDataPlane {
     AioContext *ctx;
 };
 
-static void ioreq_reset(struct ioreq *ioreq)
+static void ioreq_reset(XenQdiskRequest *request)
 {
-    memset(&ioreq->req, 0, sizeof(ioreq->req));
-    ioreq->status = 0;
-    ioreq->start = 0;
-    ioreq->buf = NULL;
-    ioreq->size = 0;
-    ioreq->presync = 0;
+    memset(&request->req, 0, sizeof(request->req));
+    request->status = 0;
+    request->start = 0;
+    request->buf = NULL;
+    request->size = 0;
+    request->presync = 0;
 
-    ioreq->aio_inflight = 0;
-    ioreq->aio_errors = 0;
+    request->aio_inflight = 0;
+    request->aio_errors = 0;
 
-    ioreq->dataplane = NULL;
-    memset(&ioreq->list, 0, sizeof(ioreq->list));
-    memset(&ioreq->acct, 0, sizeof(ioreq->acct));
+    request->dataplane = NULL;
+    memset(&request->list, 0, sizeof(request->list));
+    memset(&request->acct, 0, sizeof(request->acct));
 
-    qemu_iovec_reset(&ioreq->v);
+    qemu_iovec_reset(&request->v);
 }
 
-static struct ioreq *ioreq_start(XenQdiskDataPlane *dataplane)
+static XenQdiskRequest *ioreq_start(XenQdiskDataPlane *dataplane)
 {
-    struct ioreq *ioreq = NULL;
+    XenQdiskRequest *request = NULL;
 
     if (QLIST_EMPTY(&dataplane->freelist)) {
         if (dataplane->requests_total >= dataplane->max_requests) {
             goto out;
         }
         /* allocate new struct */
-        ioreq = g_malloc0(sizeof(*ioreq));
-        ioreq->dataplane = dataplane;
+        request = g_malloc0(sizeof(*request));
+        request->dataplane = dataplane;
         dataplane->requests_total++;
-        qemu_iovec_init(&ioreq->v, 1);
+        qemu_iovec_init(&request->v, 1);
     } else {
         /* get one from freelist */
-        ioreq = QLIST_FIRST(&dataplane->freelist);
-        QLIST_REMOVE(ioreq, list);
+        request = QLIST_FIRST(&dataplane->freelist);
+        QLIST_REMOVE(request, list);
     }
-    QLIST_INSERT_HEAD(&dataplane->inflight, ioreq, list);
+    QLIST_INSERT_HEAD(&dataplane->inflight, request, list);
     dataplane->requests_inflight++;
 
 out:
-    return ioreq;
+    return request;
 }
 
-static void ioreq_finish(struct ioreq *ioreq)
+static void ioreq_finish(XenQdiskRequest *request)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
 
-    QLIST_REMOVE(ioreq, list);
-    QLIST_INSERT_HEAD(&dataplane->finished, ioreq, list);
+    QLIST_REMOVE(request, list);
+    QLIST_INSERT_HEAD(&dataplane->finished, request, list);
     dataplane->requests_inflight--;
     dataplane->requests_finished++;
 }
 
-static void ioreq_release(struct ioreq *ioreq, bool finish)
+static void ioreq_release(XenQdiskRequest *request, bool finish)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
 
-    QLIST_REMOVE(ioreq, list);
-    ioreq_reset(ioreq);
-    ioreq->dataplane = dataplane;
-    QLIST_INSERT_HEAD(&dataplane->freelist, ioreq, list);
+    QLIST_REMOVE(request, list);
+    ioreq_reset(request);
+    request->dataplane = dataplane;
+    QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
     if (finish) {
         dataplane->requests_finished--;
     } else {
@@ -130,18 +130,18 @@ static void ioreq_release(struct ioreq *ioreq, bool finish)
  * translate request into iovec + start offset
  * do sanity checks along the way
  */
-static int ioreq_parse(struct ioreq *ioreq)
+static int ioreq_parse(XenQdiskRequest *request)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
     size_t len;
     int i;
 
-    switch (ioreq->req.operation) {
+    switch (request->req.operation) {
     case BLKIF_OP_READ:
         break;
     case BLKIF_OP_FLUSH_DISKCACHE:
-        ioreq->presync = 1;
-        if (!ioreq->req.nr_segments) {
+        request->presync = 1;
+        if (!request->req.nr_segments) {
             return 0;
         }
         /* fall through */
@@ -150,77 +150,78 @@ static int ioreq_parse(struct ioreq *ioreq)
     case BLKIF_OP_DISCARD:
         return 0;
     default:
-        error_report("error: unknown operation (%d)", ioreq->req.operation);
+        error_report("error: unknown operation (%d)", request->req.operation);
         goto err;
     };
 
-    if (ioreq->req.operation != BLKIF_OP_READ &&
+    if (request->req.operation != BLKIF_OP_READ &&
         blk_is_read_only(dataplane->blk)) {
         error_report("error: write req for ro device");
         goto err;
     }
 
-    ioreq->start = ioreq->req.sector_number * dataplane->file_blk;
-    for (i = 0; i < ioreq->req.nr_segments; i++) {
+    request->start = request->req.sector_number * dataplane->file_blk;
+    for (i = 0; i < request->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
             error_report("error: nr_segments too big");
             goto err;
         }
-        if (ioreq->req.seg[i].first_sect > ioreq->req.seg[i].last_sect) {
+        if (request->req.seg[i].first_sect > request->req.seg[i].last_sect) {
             error_report("error: first > last sector");
             goto err;
         }
-        if (ioreq->req.seg[i].last_sect * dataplane->file_blk >= XC_PAGE_SIZE) {
+        if (request->req.seg[i].last_sect * dataplane->file_blk >=
+            XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
 
-        len = (ioreq->req.seg[i].last_sect -
-               ioreq->req.seg[i].first_sect + 1) * dataplane->file_blk;
-        ioreq->size += len;
+        len = (request->req.seg[i].last_sect -
+               request->req.seg[i].first_sect + 1) * dataplane->file_blk;
+        request->size += len;
     }
-    if (ioreq->start + ioreq->size > dataplane->file_size) {
+    if (request->start + request->size > dataplane->file_size) {
         error_report("error: access beyond end of file");
         goto err;
     }
     return 0;
 
 err:
-    ioreq->status = BLKIF_RSP_ERROR;
+    request->status = BLKIF_RSP_ERROR;
     return -1;
 }
 
-static int ioreq_grant_copy(struct ioreq *ioreq)
+static int ioreq_grant_copy(XenQdiskRequest *request)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
     XenDevice *xendev = dataplane->xendev;
     XenDeviceGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
     int i, count;
     int64_t file_blk = dataplane->file_blk;
-    bool to_domain = (ioreq->req.operation == BLKIF_OP_READ);
-    void *virt = ioreq->buf;
+    bool to_domain = (request->req.operation == BLKIF_OP_READ);
+    void *virt = request->buf;
     Error *local_err = NULL;
 
-    if (ioreq->req.nr_segments == 0) {
+    if (request->req.nr_segments == 0) {
         return 0;
     }
 
-    count = ioreq->req.nr_segments;
+    count = request->req.nr_segments;
 
     for (i = 0; i < count; i++) {
         if (to_domain) {
-            segs[i].dest.foreign.ref = ioreq->req.seg[i].gref;
-            segs[i].dest.foreign.offset = ioreq->req.seg[i].first_sect *
+            segs[i].dest.foreign.ref = request->req.seg[i].gref;
+            segs[i].dest.foreign.offset = request->req.seg[i].first_sect *
                 file_blk;
             segs[i].source.virt = virt;
         } else {
-            segs[i].source.foreign.ref = ioreq->req.seg[i].gref;
-            segs[i].source.foreign.offset = ioreq->req.seg[i].first_sect *
+            segs[i].source.foreign.ref = request->req.seg[i].gref;
+            segs[i].source.foreign.offset = request->req.seg[i].first_sect *
                 file_blk;
             segs[i].dest.virt = virt;
         }
-        segs[i].len = (ioreq->req.seg[i].last_sect -
-                       ioreq->req.seg[i].first_sect + 1) * file_blk;
+        segs[i].len = (request->req.seg[i].last_sect -
+                       request->req.seg[i].first_sect + 1) * file_blk;
         virt += segs[i].len;
     }
 
@@ -232,72 +233,72 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
         error_report("failed to copy data: %s", msg);
         error_free(local_err);
 
-        ioreq->aio_errors++;
+        request->aio_errors++;
         return -1;
     }
 
     return 0;
 }
 
-static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
+static int ioreq_runio_qemu_aio(XenQdiskRequest *request);
 
 static void qemu_aio_complete(void *opaque, int ret)
 {
-    struct ioreq *ioreq = opaque;
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskRequest *request = opaque;
+    XenQdiskDataPlane *dataplane = request->dataplane;
 
     aio_context_acquire(dataplane->ctx);
 
     if (ret != 0) {
         error_report("%s I/O error",
-                     ioreq->req.operation == BLKIF_OP_READ ?
+                     request->req.operation == BLKIF_OP_READ ?
                      "read" : "write");
-        ioreq->aio_errors++;
+        request->aio_errors++;
     }
 
-    ioreq->aio_inflight--;
-    if (ioreq->presync) {
-        ioreq->presync = 0;
-        ioreq_runio_qemu_aio(ioreq);
+    request->aio_inflight--;
+    if (request->presync) {
+        request->presync = 0;
+        ioreq_runio_qemu_aio(request);
         goto done;
     }
-    if (ioreq->aio_inflight > 0) {
+    if (request->aio_inflight > 0) {
         goto done;
     }
 
-    switch (ioreq->req.operation) {
+    switch (request->req.operation) {
     case BLKIF_OP_READ:
-        /* in case of failure ioreq->aio_errors is increased */
+        /* in case of failure request->aio_errors is increased */
         if (ret == 0) {
-            ioreq_grant_copy(ioreq);
+            ioreq_grant_copy(request);
         }
-        qemu_vfree(ioreq->buf);
+        qemu_vfree(request->buf);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
-        if (!ioreq->req.nr_segments) {
+        if (!request->req.nr_segments) {
             break;
         }
-        qemu_vfree(ioreq->buf);
+        qemu_vfree(request->buf);
         break;
     default:
         break;
     }
 
-    ioreq->status = ioreq->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    ioreq_finish(ioreq);
+    request->status = request->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
+    ioreq_finish(request);
 
-    switch (ioreq->req.operation) {
+    switch (request->req.operation) {
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
-        if (!ioreq->req.nr_segments) {
+        if (!request->req.nr_segments) {
             break;
         }
     case BLKIF_OP_READ:
-        if (ioreq->status == BLKIF_RSP_OKAY) {
-            block_acct_done(blk_get_stats(dataplane->blk), &ioreq->acct);
+        if (request->status == BLKIF_RSP_OKAY) {
+            block_acct_done(blk_get_stats(dataplane->blk), &request->acct);
         } else {
-            block_acct_failed(blk_get_stats(dataplane->blk), &ioreq->acct);
+            block_acct_failed(blk_get_stats(dataplane->blk), &request->acct);
         }
         break;
     case BLKIF_OP_DISCARD:
@@ -310,10 +311,11 @@ done:
     aio_context_release(dataplane->ctx);
 }
 
-static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
+static bool blk_split_discard(XenQdiskRequest *request,
+                              blkif_sector_t sector_number,
                               uint64_t nr_sectors)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
     int64_t byte_offset;
     int byte_chunk;
     uint64_t byte_remaining, limit;
@@ -332,9 +334,9 @@ static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
 
     do {
         byte_chunk = byte_remaining > limit ? limit : byte_remaining;
-        ioreq->aio_inflight++;
+        request->aio_inflight++;
         blk_aio_pdiscard(dataplane->blk, byte_offset, byte_chunk,
-                         qemu_aio_complete, ioreq);
+                         qemu_aio_complete, request);
         byte_remaining -= byte_chunk;
         byte_offset += byte_chunk;
     } while (byte_remaining > 0);
@@ -342,53 +344,53 @@ static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t sector_number,
     return true;
 }
 
-static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
+static int ioreq_runio_qemu_aio(XenQdiskRequest *request)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
-
-    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
-    if (ioreq->req.nr_segments &&
-        (ioreq->req.operation == BLKIF_OP_WRITE ||
-         ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
-        ioreq_grant_copy(ioreq)) {
-        qemu_vfree(ioreq->buf);
+    XenQdiskDataPlane *dataplane = request->dataplane;
+
+    request->buf = qemu_memalign(XC_PAGE_SIZE, request->size);
+    if (request->req.nr_segments &&
+        (request->req.operation == BLKIF_OP_WRITE ||
+         request->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
+        ioreq_grant_copy(request)) {
+        qemu_vfree(request->buf);
         goto err;
     }
 
-    ioreq->aio_inflight++;
-    if (ioreq->presync) {
-        blk_aio_flush(ioreq->dataplane->blk, qemu_aio_complete, ioreq);
+    request->aio_inflight++;
+    if (request->presync) {
+        blk_aio_flush(request->dataplane->blk, qemu_aio_complete, request);
         return 0;
     }
 
-    switch (ioreq->req.operation) {
+    switch (request->req.operation) {
     case BLKIF_OP_READ:
-        qemu_iovec_add(&ioreq->v, ioreq->buf, ioreq->size);
-        block_acct_start(blk_get_stats(dataplane->blk), &ioreq->acct,
-                         ioreq->v.size, BLOCK_ACCT_READ);
-        ioreq->aio_inflight++;
-        blk_aio_preadv(dataplane->blk, ioreq->start, &ioreq->v, 0,
-                       qemu_aio_complete, ioreq);
+        qemu_iovec_add(&request->v, request->buf, request->size);
+        block_acct_start(blk_get_stats(dataplane->blk), &request->acct,
+                         request->v.size, BLOCK_ACCT_READ);
+        request->aio_inflight++;
+        blk_aio_preadv(dataplane->blk, request->start, &request->v, 0,
+                       qemu_aio_complete, request);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
-        if (!ioreq->req.nr_segments) {
+        if (!request->req.nr_segments) {
             break;
         }
 
-        qemu_iovec_add(&ioreq->v, ioreq->buf, ioreq->size);
-        block_acct_start(blk_get_stats(dataplane->blk), &ioreq->acct,
-                         ioreq->v.size,
-                         ioreq->req.operation == BLKIF_OP_WRITE ?
+        qemu_iovec_add(&request->v, request->buf, request->size);
+        block_acct_start(blk_get_stats(dataplane->blk), &request->acct,
+                         request->v.size,
+                         request->req.operation == BLKIF_OP_WRITE ?
                          BLOCK_ACCT_WRITE : BLOCK_ACCT_FLUSH);
-        ioreq->aio_inflight++;
-        blk_aio_pwritev(dataplane->blk, ioreq->start, &ioreq->v, 0,
-                        qemu_aio_complete, ioreq);
+        request->aio_inflight++;
+        blk_aio_pwritev(dataplane->blk, request->start, &request->v, 0,
+                        qemu_aio_complete, request);
         break;
     case BLKIF_OP_DISCARD:
     {
-        struct blkif_request_discard *req = (void *)&ioreq->req;
-        if (!blk_split_discard(ioreq, req->sector_number, req->nr_sectors)) {
+        struct blkif_request_discard *req = (void *)&request->req;
+        if (!blk_split_discard(request, req->sector_number, req->nr_sectors)) {
             goto err;
         }
         break;
@@ -398,19 +400,19 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
         goto err;
     }
 
-    qemu_aio_complete(ioreq, 0);
+    qemu_aio_complete(request, 0);
 
     return 0;
 
 err:
-    ioreq_finish(ioreq);
-    ioreq->status = BLKIF_RSP_ERROR;
+    ioreq_finish(request);
+    request->status = BLKIF_RSP_ERROR;
     return -1;
 }
 
-static int blk_send_response_one(struct ioreq *ioreq)
+static int blk_send_response_one(XenQdiskRequest *request)
 {
-    XenQdiskDataPlane *dataplane = ioreq->dataplane;
+    XenQdiskDataPlane *dataplane = request->dataplane;
     int send_notify = 0;
     int have_requests = 0;
     blkif_response_t *resp;
@@ -436,9 +438,9 @@ static int blk_send_response_one(struct ioreq *ioreq)
         return 0;
     }
 
-    resp->id = ioreq->req.id;
-    resp->operation = ioreq->req.operation;
-    resp->status = ioreq->status;
+    resp->id = request->req.id;
+    resp->operation = request->req.operation;
+    resp->status = request->status;
 
     dataplane->rings.common.rsp_prod_pvt++;
 
@@ -466,13 +468,13 @@ static int blk_send_response_one(struct ioreq *ioreq)
 /* walk finished list, send outstanding responses, free requests */
 static void blk_send_response_all(XenQdiskDataPlane *dataplane)
 {
-    struct ioreq *ioreq;
+    XenQdiskRequest *request;
     int send_notify = 0;
 
     while (!QLIST_EMPTY(&dataplane->finished)) {
-        ioreq = QLIST_FIRST(&dataplane->finished);
-        send_notify += blk_send_response_one(ioreq);
-        ioreq_release(ioreq, true);
+        request = QLIST_FIRST(&dataplane->finished);
+        send_notify += blk_send_response_one(request);
+        ioreq_release(request, true);
     }
     if (send_notify) {
         xen_device_notify_event_channel(dataplane->xendev,
@@ -480,29 +482,29 @@ static void blk_send_response_all(XenQdiskDataPlane *dataplane)
     }
 }
 
-static int blk_get_request(XenQdiskDataPlane *dataplane, struct ioreq *ioreq,
-                           RING_IDX rc)
+static int blk_get_request(XenQdiskDataPlane *dataplane,
+                           XenQdiskRequest *request, RING_IDX rc)
 {
     switch (dataplane->protocol) {
     case BLKIF_PROTOCOL_NATIVE: {
         blkif_request_t *req =
             RING_GET_REQUEST(&dataplane->rings.native, rc);
 
-        memcpy(&ioreq->req, req, sizeof(ioreq->req));
+        memcpy(&request->req, req, sizeof(request->req));
         break;
     }
     case BLKIF_PROTOCOL_X86_32: {
         blkif_x86_32_request_t *req =
             RING_GET_REQUEST(&dataplane->rings.x86_32_part, rc);
 
-        blkif_get_x86_32_req(&ioreq->req, req);
+        blkif_get_x86_32_req(&request->req, req);
         break;
     }
     case BLKIF_PROTOCOL_X86_64: {
         blkif_x86_64_request_t *req =
             RING_GET_REQUEST(&dataplane->rings.x86_64_part, rc);
 
-        blkif_get_x86_64_req(&ioreq->req, req);
+        blkif_get_x86_64_req(&request->req, req);
         break;
     }
     }
@@ -514,7 +516,7 @@ static int blk_get_request(XenQdiskDataPlane *dataplane, struct ioreq *ioreq,
 static void blk_handle_requests(XenQdiskDataPlane *dataplane)
 {
     RING_IDX rc, rp;
-    struct ioreq *ioreq;
+    XenQdiskRequest *request;
 
     dataplane->more_work = 0;
 
@@ -528,18 +530,18 @@ static void blk_handle_requests(XenQdiskDataPlane *dataplane)
         if (RING_REQUEST_CONS_OVERFLOW(&dataplane->rings.common, rc)) {
             break;
         }
-        ioreq = ioreq_start(dataplane);
-        if (ioreq == NULL) {
+        request = ioreq_start(dataplane);
+        if (request == NULL) {
             dataplane->more_work++;
             break;
         }
-        blk_get_request(dataplane, ioreq, rc);
+        blk_get_request(dataplane, request, rc);
         dataplane->rings.common.req_cons = ++rc;
 
         /* parse them */
-        if (ioreq_parse(ioreq) != 0) {
+        if (ioreq_parse(request) != 0) {
 
-            switch (ioreq->req.operation) {
+            switch (request->req.operation) {
             case BLKIF_OP_READ:
                 block_acct_invalid(blk_get_stats(dataplane->blk),
                                    BLOCK_ACCT_READ);
@@ -555,15 +557,15 @@ static void blk_handle_requests(XenQdiskDataPlane *dataplane)
                 break;
             };
 
-            if (blk_send_response_one(ioreq)) {
+            if (blk_send_response_one(request)) {
                 xen_device_notify_event_channel(dataplane->xendev,
                                                 dataplane->event_channel);
             }
-            ioreq_release(ioreq, false);
+            ioreq_release(request, false);
             continue;
         }
 
-        ioreq_runio_qemu_aio(ioreq);
+        ioreq_runio_qemu_aio(request);
     }
 
     if (dataplane->more_work &&
@@ -617,17 +619,17 @@ XenQdiskDataPlane *xen_qdisk_dataplane_create(XenDevice *xendev,
 
 void xen_qdisk_dataplane_destroy(XenQdiskDataPlane *dataplane)
 {
-    struct ioreq *ioreq;
+    XenQdiskRequest *request;
 
     if (!dataplane) {
         return;
     }
 
     while (!QLIST_EMPTY(&dataplane->freelist)) {
-        ioreq = QLIST_FIRST(&dataplane->freelist);
-        QLIST_REMOVE(ioreq, list);
-        qemu_iovec_destroy(&ioreq->v);
-        g_free(ioreq);
+        request = QLIST_FIRST(&dataplane->freelist);
+        QLIST_REMOVE(request, list);
+        qemu_iovec_destroy(&request->v);
+        g_free(request);
     }
 
     qemu_bh_delete(dataplane->bh);
-- 
2.11.0
