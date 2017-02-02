Received: from eggs.gnu.org ([2001:4830:134:3::10]:57693)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cZJuU-00008l-8B
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cZJuR-000641-Gv
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:06:58 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45443 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cZJuR-00061e-6O
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:06:55 -0500
From: Peter Lieven <pl@kamp.de>
Date: Thu,  2 Feb 2017 17:06:44 +0100
Message-Id: <1486051604-32310-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [RFC][PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Peter Lieven <pl@kamp.de>

this is something I have been thinking about for almost 2 years now.
we heavily have the following two use cases when using qemu-img convert.

a) reading from NFS and writing to iSCSI for deploying templates
b) reading from iSCSI and writing to NFS for backups

In both processes we use libiscsi and libnfs so we have no kernel pagecache.
As qemu-img convert is implemented with sync operations that means we
read one buffer and then write it. No parallelism and each sync request
takes as long as it takes until it is completed.

What I put together is an approach to use aio routines for the conversion
process to have ideally read and write happening in parallel.

The code is far from clean or complete, but I would appreaciate comments
and thoughts from you.

So far I have the following runtimes when reading an uncompressed QCOW2 from
NFS and writing it to iSCSI (raw):

qemu-img (master)
 nfs -> iscsi 33 secs
 nfs -> ram   19 secs
 ram -> iscsi 14 secs

qemu-img-async
 nfs -> iscsi 23 secs
 nfs -> ram   17 secs
 ram -> iscsi 14 secs

Its visible that on master the runtimes add up as expected. The async branch
is faster, but not as fast as I would have expected. I would expect the runtime
to be as slow as the slowest of the two involved transfers.

Thank you,
Peter

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qemu-img.c | 271 +++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 199 insertions(+), 72 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..d06f968 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1446,6 +1446,29 @@ enum ImgConvertBlockStatus {
     BLK_BACKING_FILE,
 };
 
+#define CONVERT_MAX_REQS 4
+
+typedef struct ImgConvertState ImgConvertState;
+
+typedef struct ImgConvertReq {
+    ImgConvertState *s;
+    int64_t sector_num;
+    int64_t sector_offs;
+    int64_t next_sector;
+    int nb_sectors;
+    QEMUIOVector qiov;
+    uint8_t *buf;
+    enum ImgConvertBlockStatus status;
+    bool rd_completed;
+} ImgConvertReq;
+
+typedef struct ImgConvertQueueElt {
+    int64_t sector_num;
+    enum ImgConvertBlockStatus status;
+    int nb_sectors;
+    QSIMPLEQ_ENTRY(ImgConvertQueueElt) next;
+} ImgConvertQueueElt;
+
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
@@ -1453,6 +1476,8 @@ typedef struct ImgConvertState {
     int64_t src_cur_offset;
     int64_t total_sectors;
     int64_t allocated_sectors;
+    int64_t allocated_done;
+    int64_t wr_offs;
     enum ImgConvertBlockStatus status;
     int64_t sector_next_status;
     BlockBackend *target;
@@ -1462,11 +1487,15 @@ typedef struct ImgConvertState {
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
+    ImgConvertReq reqs[CONVERT_MAX_REQS];
+    int ret;
+    QSIMPLEQ_HEAD(, ImgConvertQueueElt) queue;
 } ImgConvertState;
 
 static void convert_select_part(ImgConvertState *s, int64_t sector_num)
 {
-    assert(sector_num >= s->src_cur_offset);
+    s->src_cur_offset = 0;
+    s->src_cur = 0;
     while (sector_num - s->src_cur_offset >= s->src_sectors[s->src_cur]) {
         s->src_cur_offset += s->src_sectors[s->src_cur];
         s->src_cur++;
@@ -1542,16 +1571,89 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     return n;
 }
 
-static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                        uint8_t *buf)
+static void convert_aio_read(void *opaque, int ret);
+static void convert_aio_write(void *opaque, int ret);
+
+static void convert_fill_write_queue(ImgConvertState *s)
 {
+    int i;
+    for (i = 0; i < CONVERT_MAX_REQS; i++) {
+         if (s->reqs[i].sector_num == s->wr_offs && s->reqs[i].rd_completed) {
+                s->reqs[i].rd_completed = false;
+                s->reqs[i].sector_offs = 0;
+                convert_aio_write(&s->reqs[i], 0);
+                break;
+         }
+    }
+}
+
+static void convert_fill_read_queue(ImgConvertState *s)
+{
+     ImgConvertQueueElt *elt;
+
+     while ((elt = QSIMPLEQ_FIRST(&s->queue)) && !s->ret) {
+        ImgConvertReq *req = NULL;
+        int i;
+        for (i = 0; i < CONVERT_MAX_REQS; i++) {
+            if (s->reqs[i].sector_num == -1) {
+                req = &s->reqs[i];
+                break;
+            }
+        }
+        if (!req) {
+            return;
+        }
+
+        QSIMPLEQ_REMOVE_HEAD(&s->queue, next);
+
+        printf("convert_fill_read_queue req #%d @%p sector_num %ld nb_sectors %d status %d\n", i, req, elt->sector_num, elt->nb_sectors, elt->status);
+
+        if (elt->status == BLK_DATA || (!s->min_sparse && elt->status == BLK_ZERO))
+        {
+            s->allocated_done += elt->nb_sectors;
+            qemu_progress_print(100.0 * s->allocated_done / s->allocated_sectors,
+                                0);
+        }
+        req->sector_num   = elt->sector_num;
+        req->nb_sectors   = elt->nb_sectors;
+        req->status       = elt->status;
+        req->sector_offs  = 0;
+        g_free(elt);
+
+        if ((elt = QSIMPLEQ_FIRST(&s->queue))) {
+            req->next_sector = elt->sector_num;
+        } else {
+            req->next_sector = s->total_sectors;
+        }
+
+        if (req->status == BLK_DATA) {
+            req->rd_completed = false;
+            convert_aio_read(req, 0);
+        } else if (!s->min_sparse && s->status == BLK_ZERO) {
+            memset(req->buf, 0, req->nb_sectors * BDRV_SECTOR_SIZE);
+            req->status = BLK_DATA;
+            req->rd_completed = true;
+            convert_fill_write_queue(s);
+        }
+    }
+}
+
+static void convert_aio_read(void *opaque, int ret)
+{
+    ImgConvertReq *req = opaque;
+    ImgConvertState *s = req->s;
+    int64_t sector_num = req->sector_num + req->sector_offs;
+    int nb_sectors = req->nb_sectors - req->sector_offs;
+    uint8_t *buf = req->buf + req->sector_offs * BDRV_SECTOR_SIZE;
     int n;
-    int ret;
+
+    printf("convert_aio_read enter req %p sector_num %ld nb_sectors %d offs %ld ret %d\n", req, sector_num, nb_sectors, req->sector_offs, ret);
 
     assert(nb_sectors <= s->buf_sectors);
-    while (nb_sectors > 0) {
+    if (nb_sectors > 0) {
         BlockBackend *blk;
         int64_t bs_sectors;
+        BlockAIOCB *acb;
 
         /* In the case of compression with multiple source files, we can get a
          * nb_sectors that spreads into the next part. So we must be able to
@@ -1561,30 +1663,49 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
         bs_sectors = s->src_sectors[s->src_cur];
 
         n = MIN(nb_sectors, bs_sectors - (sector_num - s->src_cur_offset));
-        ret = blk_pread(blk,
+        qemu_iovec_reset(&req->qiov);
+        qemu_iovec_add(&req->qiov, buf, n << BDRV_SECTOR_BITS);
+        req->sector_offs += n;
+        acb = blk_aio_preadv(blk,
                         (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
-                        buf, n << BDRV_SECTOR_BITS);
-        if (ret < 0) {
-            return ret;
+                        &req->qiov, 0, convert_aio_read, req);
+        if (!acb) {
+            s->ret = -ENOMEM;
+            return;
         }
-
-        sector_num += n;
-        nb_sectors -= n;
-        buf += n * BDRV_SECTOR_SIZE;
+        return;
     }
 
-    return 0;
+    req->rd_completed = true;
+    convert_fill_write_queue(s);
 }
 
-static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                         const uint8_t *buf)
+static void convert_aio_write(void *opaque, int ret)
 {
-    int ret;
+    ImgConvertReq *req = opaque;
+    ImgConvertState *s = req->s;
+    int64_t sector_num;
+    int nb_sectors;
+    uint8_t *buf;
+
+again:
+    sector_num = req->sector_num + req->sector_offs;
+    nb_sectors = req->nb_sectors - req->sector_offs;
+    buf = req->buf + req->sector_offs * BDRV_SECTOR_SIZE;
+    printf("convert_aio_write enter req %p sector_num %ld nb_sectors %d offs %ld ret %d\n", req, sector_num, nb_sectors, req->sector_offs, ret);
 
-    while (nb_sectors > 0) {
+    if (ret) {
+        error_report("error while writing sector %" PRId64
+                     ": %s", req->sector_num, strerror(-ret));
+        s->ret = ret;
+        return;
+    }
+
+    if (nb_sectors > 0) {
         int n = nb_sectors;
+        BlockAIOCB *acb;
 
-        switch (s->status) {
+        switch (req->status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
              * unallocated in the source image, so that the backing file is
@@ -1598,6 +1719,7 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
              * write if the buffer is completely zeroed and we're allowed to
              * keep the target sparse. */
             if (s->compressed) {
+                assert(0); //XXX TODO
                 if (s->has_zero_init && s->min_sparse &&
                     buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
                 {
@@ -1609,7 +1731,8 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
                                             sector_num << BDRV_SECTOR_BITS,
                                             buf, n << BDRV_SECTOR_BITS);
                 if (ret < 0) {
-                    return ret;
+                    s->ret = ret;
+                    return;
                 }
                 break;
             }
@@ -1620,10 +1743,15 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
             if (!s->min_sparse ||
                 is_allocated_sectors_min(buf, n, &n, s->min_sparse))
             {
-                ret = blk_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
-                                 buf, n << BDRV_SECTOR_BITS, 0);
-                if (ret < 0) {
-                    return ret;
+                qemu_iovec_reset(&req->qiov);
+                qemu_iovec_add(&req->qiov, buf, n << BDRV_SECTOR_BITS);
+                req->sector_offs += n;
+                acb = blk_aio_pwritev(s->target,
+                                      sector_num << BDRV_SECTOR_BITS,
+                                      &req->qiov, 0, convert_aio_write, req);
+                if (!acb) {
+                    s->ret = -ENOMEM;
+                    return;
                 }
                 break;
             }
@@ -1631,30 +1759,39 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
 
         case BLK_ZERO:
             if (s->has_zero_init) {
-                break;
+                printf("convert_aio_write n %d blocks are zero\n", n);
+                req->sector_offs += n;
+                goto again;
             }
+            assert(0); //XXX TODO
             ret = blk_pwrite_zeroes(s->target, sector_num << BDRV_SECTOR_BITS,
                                     n << BDRV_SECTOR_BITS, 0);
             if (ret < 0) {
-                return ret;
+                s->ret = ret;
+                return;
             }
             break;
         }
 
-        sector_num += n;
-        nb_sectors -= n;
-        buf += n * BDRV_SECTOR_SIZE;
+        return;
     }
 
-    return 0;
+    /* request is available for reading again */
+    printf("wr offs new = %ld\n", req->next_sector);
+    req->sector_num = -1;
+    s->wr_offs = req->next_sector;
+
+    convert_fill_read_queue(s);
+    convert_fill_write_queue(s);
+    return;
 }
 
 static int convert_do_copy(ImgConvertState *s)
 {
-    uint8_t *buf = NULL;
-    int64_t sector_num, allocated_done;
     int ret;
     int n;
+    int i;
+    int64_t sector_num;
 
     /* Check whether we have zero initialisation or can get it efficiently */
     s->has_zero_init = s->min_sparse && !s->target_has_backing
@@ -1680,20 +1817,38 @@ static int convert_do_copy(ImgConvertState *s)
         }
         s->buf_sectors = s->cluster_sectors;
     }
-    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
+
+    for (i = 0; i < CONVERT_MAX_REQS; i++) {
+        qemu_iovec_init(&s->reqs[i].qiov, 1);
+        s->reqs[i].buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
+        s->reqs[i].sector_num = -1;
+        s->reqs[i].s = s;
+    }
 
     /* Calculate allocated sectors for progress */
     s->allocated_sectors = 0;
     sector_num = 0;
+    QSIMPLEQ_INIT(&s->queue);
     while (sector_num < s->total_sectors) {
         n = convert_iteration_sectors(s, sector_num);
         if (n < 0) {
             ret = n;
             goto fail;
         }
+
+        if (!s->min_sparse && s->status == BLK_ZERO) {
+            n = MIN(n, s->buf_sectors);
+        }
+
+        printf("convert_iteration_sectors %ld n %d status %d\n", sector_num, n, s->status);
         if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
         {
+            ImgConvertQueueElt *elt = g_malloc(sizeof(ImgConvertQueueElt));
+            elt->sector_num = sector_num;
+            elt->status = s->status;
+            elt->nb_sectors = n;
             s->allocated_sectors += n;
+            QSIMPLEQ_INSERT_TAIL(&s->queue, elt, next);
         }
         sector_num += n;
     }
@@ -1702,47 +1857,16 @@ static int convert_do_copy(ImgConvertState *s)
     s->src_cur = 0;
     s->src_cur_offset = 0;
     s->sector_next_status = 0;
+    s->wr_offs = 0;
+    s->allocated_done = 0;
 
-    sector_num = 0;
-    allocated_done = 0;
+    convert_fill_read_queue(s);
 
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
-
-        sector_num += n;
+    while (s->wr_offs < s->total_sectors && !s->ret) {
+        main_loop_wait(false);
     }
 
-    if (s->compressed) {
+    if (s->compressed && !s->ret) {
         /* signal EOF to align */
         ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
         if (ret < 0) {
@@ -1750,9 +1874,12 @@ static int convert_do_copy(ImgConvertState *s)
         }
     }
 
-    ret = 0;
+    ret = s->ret;
 fail:
-    qemu_vfree(buf);
+    for (i = 0; i < CONVERT_MAX_REQS; i++) {
+         qemu_iovec_destroy(&s->reqs[i].qiov);
+         qemu_vfree(s->reqs[i].buf);
+    }
     return ret;
 }
 
-- 
1.9.1
