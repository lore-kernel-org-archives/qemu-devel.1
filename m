Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7061C28D18
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8262620693
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8262620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCF1-0007lZ-Om
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:24:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6E-00014b-29
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6A-0005f6-Dp
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC68-0005C0-Hf; Tue, 04 Jun 2019 12:15:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5j-0005Pq-MY; Tue, 04 Jun 2019 19:15:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:06 +0300
Message-Id: <20190604161514.262241-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 04/12] block: define .*_part io handlers in
 BlockDriver
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add handlers supporting qiov_offset parameter:
    bdrv_co_preadv_part
    bdrv_co_pwritev_part
    bdrv_co_pwritev_compressed_part
This is used to reduce need of defining local_qiovs and hd_qiovs in all
corners of block layer code. The following patches will increase usage
of this new API part by part.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 15 ++++++
 block/backup.c            |  2 +-
 block/io.c                | 96 +++++++++++++++++++++++++++++++--------
 qemu-img.c                |  4 +-
 4 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..46e17d2e2f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -211,6 +211,9 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+    int coroutine_fn (*bdrv_co_preadv_part)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
     /**
@@ -230,6 +233,9 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+    int coroutine_fn (*bdrv_co_pwritev_part)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags);
 
     /*
      * Efficiently zero a region of the disk image.  Typically an image format
@@ -340,6 +346,9 @@ struct BlockDriver {
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
+    int coroutine_fn (*bdrv_co_pwritev_compressed_part)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
+        size_t qiov_offset);
 
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info);
@@ -564,6 +573,12 @@ struct BlockDriver {
     const char *const *strong_runtime_opts;
 };
 
+static inline bool block_driver_can_compress(BlockDriver *drv)
+{
+    return drv->bdrv_co_pwritev_compressed ||
+           drv->bdrv_co_pwritev_compressed_part;
+}
+
 typedef struct BlockLimits {
     /* Alignment requirement, in bytes, for offset/length of I/O
      * requests. Must be a power of 2 less than INT_MAX; defaults to
diff --git a/block/backup.c b/block/backup.c
index 00f4f8af53..af821b8990 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -569,7 +569,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
-    if (compress && target->drv->bdrv_co_pwritev_compressed == NULL) {
+    if (compress && !block_driver_can_compress(target->drv)) {
         error_setg(errp, "Compression is not supported for this drive %s",
                    bdrv_get_device_name(target));
         return NULL;
diff --git a/block/io.c b/block/io.c
index ddd5902dc1..7e53a11492 100644
--- a/block/io.c
+++ b/block/io.c
@@ -128,7 +128,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 
     /* Default alignment based on whether driver has byte interface */
     bs->bl.request_alignment = (drv->bdrv_co_preadv ||
-                                drv->bdrv_aio_preadv) ? 1 : 512;
+                                drv->bdrv_aio_preadv ||
+                                drv->bdrv_co_preadv_part) ? 1 : 512;
 
     /* Take some limits from the children as a default */
     if (bs->file) {
@@ -979,11 +980,14 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
 
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
                                            uint64_t offset, uint64_t bytes,
-                                           QEMUIOVector *qiov, int flags)
+                                           QEMUIOVector *qiov,
+                                           size_t qiov_offset, int flags)
 {
     BlockDriver *drv = bs->drv;
     int64_t sector_num;
     unsigned int nb_sectors;
+    QEMUIOVector local_qiov;
+    int ret;
 
     assert(!(flags & ~BDRV_REQ_MASK));
     assert(!(flags & BDRV_REQ_NO_FALLBACK));
@@ -992,8 +996,19 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    if (drv->bdrv_co_preadv_part) {
+        return drv->bdrv_co_preadv_part(bs, offset, bytes, qiov, qiov_offset,
+                                        flags);
+    }
+
+    if (qiov_offset > 0 || bytes != qiov->size) {
+        qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+        qiov = &local_qiov;
+    }
+
     if (drv->bdrv_co_preadv) {
-        return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
+        ret = drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
+        goto out;
     }
 
     if (drv->bdrv_aio_preadv) {
@@ -1005,10 +1020,12 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
         acb = drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
                                    bdrv_co_io_em_complete, &co);
         if (acb == NULL) {
-            return -EIO;
+            ret = -EIO;
+            goto out;
         } else {
             qemu_coroutine_yield();
-            return co.ret;
+            ret = co.ret;
+            goto out;
         }
     }
 
@@ -1020,16 +1037,25 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
     assert(bytes <= BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
 
-    return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
+    ret = drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
+
+out:
+    if (qiov == &local_qiov) {
+        qemu_iovec_destroy(&local_qiov);
+    }
+
+    return ret;
 }
 
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
                                             uint64_t offset, uint64_t bytes,
-                                            QEMUIOVector *qiov, int flags)
+                                            QEMUIOVector *qiov,
+                                            size_t qiov_offset, int flags)
 {
     BlockDriver *drv = bs->drv;
     int64_t sector_num;
     unsigned int nb_sectors;
+    QEMUIOVector local_qiov;
     int ret;
 
     assert(!(flags & ~BDRV_REQ_MASK));
@@ -1039,6 +1065,18 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    if (drv->bdrv_co_pwritev_part) {
+        ret = drv->bdrv_co_pwritev_part(bs, offset, bytes, qiov, qiov_offset,
+                                        flags & bs->supported_write_flags);
+        flags &= ~bs->supported_write_flags;
+        goto emulate_flags;
+    }
+
+    if (qiov_offset > 0 || bytes != qiov->size) {
+        qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+        qiov = &local_qiov;
+    }
+
     if (drv->bdrv_co_pwritev) {
         ret = drv->bdrv_co_pwritev(bs, offset, bytes, qiov,
                                    flags & bs->supported_write_flags);
@@ -1082,24 +1120,44 @@ emulate_flags:
         ret = bdrv_co_flush(bs);
     }
 
+    if (qiov == &local_qiov) {
+        qemu_iovec_destroy(&local_qiov);
+    }
+
     return ret;
 }
 
 static int coroutine_fn
 bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                               uint64_t bytes, QEMUIOVector *qiov)
+                               uint64_t bytes, QEMUIOVector *qiov,
+                               size_t qiov_offset)
 {
     BlockDriver *drv = bs->drv;
+    QEMUIOVector local_qiov;
+    int ret;
 
     if (!drv) {
         return -ENOMEDIUM;
     }
 
-    if (!drv->bdrv_co_pwritev_compressed) {
+    if (!block_driver_can_compress(drv)) {
         return -ENOTSUP;
     }
 
-    return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
+    if (drv->bdrv_co_pwritev_compressed_part) {
+        return drv->bdrv_co_pwritev_compressed_part(bs, offset, bytes,
+                                                    qiov, qiov_offset);
+    }
+
+    if (qiov_offset == 0) {
+        return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
+    }
+
+    qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+    ret = drv->bdrv_co_pwritev_compressed(bs, offset, bytes, &local_qiov);
+    qemu_iovec_destroy(&local_qiov);
+
+    return ret;
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
@@ -1183,7 +1241,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
             ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
-                                     &local_qiov, 0);
+                                     &local_qiov, 0, 0);
             if (ret < 0) {
                 goto err;
             }
@@ -1201,7 +1259,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                  * necessary to flush even in cache=writethrough mode.
                  */
                 ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov,
+                                          &local_qiov, 0,
                                           BDRV_REQ_WRITE_UNCHANGED);
             }
 
@@ -1221,7 +1279,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             qemu_iovec_init(&local_qiov, qiov->niov);
             qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_bytes);
             ret = bdrv_driver_preadv(bs, offset + progress, local_qiov.size,
-                                     &local_qiov, 0);
+                                     &local_qiov, 0, 0);
             qemu_iovec_destroy(&local_qiov);
             if (ret < 0) {
                 goto err;
@@ -1309,7 +1367,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
 
     max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <= max_bytes && bytes <= max_transfer) {
-        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 0);
+        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 0, 0);
         goto out;
     }
 
@@ -1325,7 +1383,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
             qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining, num);
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
-                                     num, &local_qiov, 0);
+                                     num, &local_qiov, 0, 0);
             max_bytes -= num;
             qemu_iovec_destroy(&local_qiov);
         } else {
@@ -1620,7 +1678,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             }
             qemu_iovec_init_buf(&qiov, buf, num);
 
-            ret = bdrv_driver_pwritev(bs, offset, num, &qiov, write_flags);
+            ret = bdrv_driver_pwritev(bs, offset, num, &qiov, 0, write_flags);
 
             /* Keep bounce buffer around if it is big enough for all
              * all future requests.
@@ -1776,10 +1834,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
     } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
-        ret = bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov);
+        ret = bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov, 0);
     } else if (bytes <= max_transfer) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
-        ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, flags);
+        ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, 0, flags);
     } else {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
         while (bytes_remaining) {
@@ -1798,7 +1856,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
             qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining, num);
 
             ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
-                                      num, &local_qiov, local_flags);
+                                      num, &local_qiov, 0, local_flags);
             qemu_iovec_destroy(&local_qiov);
             if (ret < 0) {
                 break;
diff --git a/qemu-img.c b/qemu-img.c
index b0535919b1..8a62a75a71 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2329,7 +2329,7 @@ static int img_convert(int argc, char **argv)
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
-        if (drv && !drv->bdrv_co_pwritev_compressed) {
+        if (drv && !block_driver_can_compress(drv)) {
             error_report("Compression not supported for this file format");
             ret = -1;
             goto out;
@@ -2398,7 +2398,7 @@ static int img_convert(int argc, char **argv)
     }
     out_bs = blk_bs(s.target);
 
-    if (s.compressed && !out_bs->drv->bdrv_co_pwritev_compressed) {
+    if (s.compressed && !block_driver_can_compress(out_bs->drv)) {
         error_report("Compression not supported for this file format");
         ret = -1;
         goto out;
-- 
2.18.0


