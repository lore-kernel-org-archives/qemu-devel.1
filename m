Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cddKT-0006p6-BE
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cddKO-0004co-BY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:39:37 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41560 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cddKO-0004bM-1a
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:39:32 -0500
From: Peter Lieven <pl@kamp.de>
Date: Tue, 14 Feb 2017 14:39:25 +0100
Message-Id: <1487079565-3548-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, ct@flyingcircus.io, Peter Lieven <pl@kamp.de>

this is something I have been thinking about for almost 2 years now.
we heavily have the following two use cases when using qemu-img convert.

a) reading from NFS and writing to iSCSI for deploying templates
b) reading from iSCSI and writing to NFS for backups

In both processes we use libiscsi and libnfs so we have no kernel pagecache.
As qemu-img convert is implemented with sync operations that means we
read one buffer and then write it. No parallelism and each sync request
takes as long as it takes until it is completed.

This is version 3 of the approach using coroutine worker "threads".

So far I have the following runtimes when reading an uncompressed QCOW2 from
NFS and writing it to iSCSI (raw):

qemu-img (master)
 nfs -> iscsi 22.8 secs
 nfs -> ram   11.7 secs
 ram -> iscsi 12.3 secs

qemu-img-async
 nfs -> iscsi 12.3 secs
 nfs -> ram   10.5 secs
 ram -> iscsi 11.7 secs

Comments appreciated.

Thank you,
Peter

Signed-off-by: Peter Lieven <pl@kamp.de>
---
v2->v3: - updated stats in the commit msg from a host with a better network card
        - only wake up the coroutine that is acutally waiting for a write to complete.
          this was not only overhead, but also breaking at least linux AIO.
        - fix coding style complaints
        - rename some variables and structs

v1->v2: - using coroutine as worker "threads". [Max]
        - keeping the request queue as otherwise it happens
          that we wait on BLK_ZERO chunks while keeping the write order.
          it also avoids redundant calls to get_block_status and helps
          to skip some conditions for fully allocated imaged (!s->min_sparse)

 qemu-img.c | 213 +++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 145 insertions(+), 68 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..970863f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1448,6 +1448,16 @@ enum ImgConvertBlockStatus {
     BLK_BACKING_FILE,
 };
 
+typedef struct ImgConvertRequest {
+    int64_t sector_num;
+    enum ImgConvertBlockStatus status;
+    int nb_sectors;
+    QSIMPLEQ_ENTRY(ImgConvertRequest) next;
+} ImgConvertRequest;
+
+/* XXX: this should be a cmdline parameter */
+#define NUM_COROUTINES 8
+
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
@@ -1455,6 +1465,8 @@ typedef struct ImgConvertState {
     int64_t src_cur_offset;
     int64_t total_sectors;
     int64_t allocated_sectors;
+    int64_t allocated_done;
+    int64_t wr_offs;
     enum ImgConvertBlockStatus status;
     int64_t sector_next_status;
     BlockBackend *target;
@@ -1464,11 +1476,16 @@ typedef struct ImgConvertState {
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
+    Coroutine *co[NUM_COROUTINES];
+    int64_t wait_sector_num[NUM_COROUTINES];
+    QSIMPLEQ_HEAD(, ImgConvertRequest) queue;
+    int ret;
 } ImgConvertState;
 
 static void convert_select_part(ImgConvertState *s, int64_t sector_num)
 {
-    assert(sector_num >= s->src_cur_offset);
+    s->src_cur_offset = 0;
+    s->src_cur = 0;
     while (sector_num - s->src_cur_offset >= s->src_sectors[s->src_cur]) {
         s->src_cur_offset += s->src_sectors[s->src_cur];
         s->src_cur++;
@@ -1544,11 +1561,13 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     return n;
 }
 
-static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                        uint8_t *buf)
+static int convert_co_read(ImgConvertState *s, ImgConvertRequest *req,
+                           uint8_t *buf, QEMUIOVector *qiov)
 {
     int n;
     int ret;
+    int64_t sector_num = req->sector_num;
+    int nb_sectors = req->nb_sectors;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1562,10 +1581,13 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
         blk = s->src[s->src_cur];
         bs_sectors = s->src_sectors[s->src_cur];
 
+        qemu_iovec_reset(qiov);
         n = MIN(nb_sectors, bs_sectors - (sector_num - s->src_cur_offset));
-        ret = blk_pread(blk,
-                        (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
-                        buf, n << BDRV_SECTOR_BITS);
+        qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
+
+        ret = blk_co_preadv(
+                blk, (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
+                n << BDRV_SECTOR_BITS, qiov, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1578,15 +1600,18 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                         const uint8_t *buf)
+
+static int convert_co_write(ImgConvertState *s, ImgConvertRequest *req,
+                            uint8_t *buf, QEMUIOVector *qiov)
 {
     int ret;
+    int64_t sector_num = req->sector_num;
+    int nb_sectors = req->nb_sectors;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
-
-        switch (s->status) {
+        qemu_iovec_reset(qiov);
+        switch (req->status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
              * unallocated in the source image, so that the backing file is
@@ -1607,9 +1632,10 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
                     break;
                 }
 
-                ret = blk_pwrite_compressed(s->target,
-                                            sector_num << BDRV_SECTOR_BITS,
-                                            buf, n << BDRV_SECTOR_BITS);
+                qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
+                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
+                                     n << BDRV_SECTOR_BITS, qiov,
+                                     BDRV_REQ_WRITE_COMPRESSED);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1622,8 +1648,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
             if (!s->min_sparse ||
                 is_allocated_sectors_min(buf, n, &n, s->min_sparse))
             {
-                ret = blk_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
-                                 buf, n << BDRV_SECTOR_BITS, 0);
+                qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
+                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
+                                     n << BDRV_SECTOR_BITS, qiov, 0);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1635,8 +1662,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
             if (s->has_zero_init) {
                 break;
             }
-            ret = blk_pwrite_zeroes(s->target, sector_num << BDRV_SECTOR_BITS,
-                                    n << BDRV_SECTOR_BITS, 0);
+            ret = blk_co_pwrite_zeroes(s->target,
+                                       sector_num << BDRV_SECTOR_BITS,
+                                       n << BDRV_SECTOR_BITS, 0);
             if (ret < 0) {
                 return ret;
             }
@@ -1651,12 +1679,92 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_do_copy(ImgConvertState *s)
+static void convert_co_do_copy(void *opaque)
 {
+    ImgConvertState *s = opaque;
     uint8_t *buf = NULL;
-    int64_t sector_num, allocated_done;
+    int ret, i;
+    ImgConvertRequest *req, *next_req;
+    QEMUIOVector qiov;
+    int index = -1;
+
+    for (i = 0; i < NUM_COROUTINES; i++) {
+        if (s->co[i] == qemu_coroutine_self()) {
+            index = i;
+            break;
+        }
+    }
+    assert(index >= 0);
+
+    qemu_iovec_init(&qiov, 1);
+    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
+
+    while (s->ret == -EINPROGRESS && (req = QSIMPLEQ_FIRST(&s->queue))) {
+        QSIMPLEQ_REMOVE_HEAD(&s->queue, next);
+        next_req = QSIMPLEQ_FIRST(&s->queue);
+
+        s->allocated_done += req->nb_sectors;
+        qemu_progress_print(100.0 * s->allocated_done / s->allocated_sectors,
+                            0);
+
+        if (req->status == BLK_DATA) {
+            ret = convert_co_read(s, req, buf, &qiov);
+            if (ret < 0) {
+                error_report("error while reading sector %" PRId64
+                             ": %s", req->sector_num, strerror(-ret));
+                s->ret = ret;
+                goto out;
+            }
+        }
+
+        /* keep writes in order */
+        while (s->wr_offs != req->sector_num) {
+            if (s->ret != -EINPROGRESS) {
+                goto out;
+            }
+            s->wait_sector_num[index] = req->sector_num;
+            qemu_coroutine_yield();
+        }
+        s->wait_sector_num[index] = -1;
+
+        ret = convert_co_write(s, req, buf, &qiov);
+        if (ret < 0) {
+            error_report("error while writing sector %" PRId64
+                         ": %s", req->sector_num, strerror(-ret));
+            s->ret = ret;
+            goto out;
+        }
+
+        if (!next_req) {
+            /* the convert job is completed */
+            s->ret = 0;
+            s->wr_offs = s->total_sectors;
+        } else {
+            s->wr_offs = next_req->sector_num;
+            /* reenter the coroutine that might have waited
+             * for this write completion */
+            for (i = 0; i < NUM_COROUTINES; i++) {
+                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
+                    qemu_coroutine_enter(s->co[i]);
+                    break;
+                }
+            }
+        }
+
+        g_free(req);
+    }
+
+out:
+    qemu_iovec_destroy(&qiov);
+    qemu_vfree(buf);
+    s->co[index] = NULL;
+}
+
+static int convert_do_copy(ImgConvertState *s)
+{
     int ret;
-    int n;
+    int i, n;
+    int64_t sector_num = 0;
 
     /* Check whether we have zero initialisation or can get it efficiently */
     s->has_zero_init = s->min_sparse && !s->target_has_backing
@@ -1682,69 +1790,39 @@ static int convert_do_copy(ImgConvertState *s)
         }
         s->buf_sectors = s->cluster_sectors;
     }
-    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
 
-    /* Calculate allocated sectors for progress */
-    s->allocated_sectors = 0;
-    sector_num = 0;
+    QSIMPLEQ_INIT(&s->queue);
     while (sector_num < s->total_sectors) {
         n = convert_iteration_sectors(s, sector_num);
         if (n < 0) {
             ret = n;
             goto fail;
         }
+
         if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
         {
+            ImgConvertRequest *elt = g_malloc(sizeof(ImgConvertRequest));
+            elt->sector_num = sector_num;
+            elt->status = s->status;
+            elt->nb_sectors = n;
             s->allocated_sectors += n;
+            QSIMPLEQ_INSERT_TAIL(&s->queue, elt, next);
         }
         sector_num += n;
     }
 
-    /* Do the copy */
-    s->src_cur = 0;
-    s->src_cur_offset = 0;
-    s->sector_next_status = 0;
-
-    sector_num = 0;
-    allocated_done = 0;
-
-    while (sector_num < s->total_sectors) {
-        n = convert_iteration_sectors(s, sector_num);
-        if (n < 0) {
-            ret = n;
-            goto fail;
-        }
-        if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
-        {
-            allocated_done += n;
-            qemu_progress_print(100.0 * allocated_done / s->allocated_sectors,
-                                0);
-        }
-
-        if (s->status == BLK_DATA) {
-            ret = convert_read(s, sector_num, n, buf);
-            if (ret < 0) {
-                error_report("error while reading sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
-                goto fail;
-            }
-        } else if (!s->min_sparse && s->status == BLK_ZERO) {
-            n = MIN(n, s->buf_sectors);
-            memset(buf, 0, n * BDRV_SECTOR_SIZE);
-            s->status = BLK_DATA;
-        }
-
-        ret = convert_write(s, sector_num, n, buf);
-        if (ret < 0) {
-            error_report("error while writing sector %" PRId64
-                         ": %s", sector_num, strerror(-ret));
-            goto fail;
-        }
+    s->ret = -EINPROGRESS;
+    for (i = 0; i < NUM_COROUTINES; i++) {
+        s->co[i] = qemu_coroutine_create(convert_co_do_copy, s);
+        s->wait_sector_num[i] = -1;
+        qemu_coroutine_enter(s->co[i]);
+    }
 
-        sector_num += n;
+    while (s->ret == -EINPROGRESS) {
+        main_loop_wait(false);
     }
 
-    if (s->compressed) {
+    if (s->compressed && !s->ret) {
         /* signal EOF to align */
         ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
         if (ret < 0) {
@@ -1752,9 +1830,8 @@ static int convert_do_copy(ImgConvertState *s)
         }
     }
 
-    ret = 0;
+    ret = s->ret;
 fail:
-    qemu_vfree(buf);
     return ret;
 }
 
-- 
1.9.1
