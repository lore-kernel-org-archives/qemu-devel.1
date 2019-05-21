Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C519C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1CA2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1CA2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0Ta-0006vD-7B
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:50:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0Oq-0003dc-UA
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0Op-0004ID-BX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:45:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:60604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT0Ol-0004AK-Kb; Tue, 21 May 2019 04:45:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hT0Oh-0003ut-IG; Tue, 21 May 2019 11:45:23 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 11:45:20 +0300
Message-Id: <20190521084522.15050-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190521084522.15050-1-vsementsov@virtuozzo.com>
References: <20190521084522.15050-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [RFC PATCH 1/3] block/io: introduce bdrv_co_preadv_part
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce extended variant of bdrv_co_preadv with qiov_offset
parameter, to finally get rid of (most of) local_qiov workarounds.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  6 +++
 block/io.c                | 87 ++++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 94d45c9708..d66929d5ad 100644
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
@@ -921,6 +924,9 @@ extern BlockDriver bdrv_qcow2;
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
diff --git a/block/io.c b/block/io.c
index 396d5364ba..785a2b07f8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -979,11 +979,14 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
 
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
@@ -992,8 +995,20 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    if (drv->bdrv_co_preadv_part) {
+        return drv->bdrv_co_preadv_part(bs, offset, bytes, qiov, qiov_offset,
+                                        flags);
+    }
+
+    if (qiov_offset > 0) {
+        qemu_iovec_init(&local_qiov, qiov->niov);
+        qemu_iovec_concat(&local_qiov, qiov, qiov_offset, bytes);
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
 
@@ -1020,7 +1037,14 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
     assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
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
@@ -1103,7 +1127,8 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
+        int64_t offset, unsigned int bytes,
+        QEMUIOVector *qiov, size_t qiov_offset)
 {
     BlockDriverState *bs = child->bs;
 
@@ -1183,7 +1208,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
             ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
-                                     &local_qiov, 0);
+                                     &local_qiov, 0, 0);
             if (ret < 0) {
                 goto err;
             }
@@ -1214,15 +1239,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 goto err;
             }
 
-            qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip_bytes,
+            qemu_iovec_from_buf(qiov, qiov_offset + progress,
+                                bounce_buffer + skip_bytes,
                                 pnum - skip_bytes);
         } else {
             /* Read directly into the destination */
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_bytes);
-            ret = bdrv_driver_preadv(bs, offset + progress, local_qiov.size,
-                                     &local_qiov, 0);
-            qemu_iovec_destroy(&local_qiov);
+            ret = bdrv_driver_preadv(bs, offset + progress,
+                                     MAX(pnum - skip_bytes,
+                                         qiov->size - qiov_offset - progress),
+                                     qiov, qiov_offset + progress, 0);
             if (ret < 0) {
                 goto err;
             }
@@ -1247,7 +1272,7 @@ err:
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
-    int64_t align, QEMUIOVector *qiov, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     int64_t total_bytes, max_bytes;
@@ -1258,7 +1283,6 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
-    assert(!qiov || bytes == qiov->size);
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
@@ -1295,7 +1319,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         }
 
         if (!ret || pnum != bytes) {
-            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes,
+                                           qiov, qiov_offset);
             goto out;
         }
     }
@@ -1309,7 +1334,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
 
     max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <= max_bytes && bytes <= max_transfer) {
-        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 0);
+        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
         goto out;
     }
 
@@ -1317,17 +1342,12 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         int num;
 
         if (max_bytes) {
-            QEMUIOVector local_qiov;
-
             num = MIN(bytes_remaining, MIN(max_bytes, max_transfer));
             assert(num);
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining, num);
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
-                                     num, &local_qiov, 0);
+                                     num, qiov, bytes - bytes_remaining, 0);
             max_bytes -= num;
-            qemu_iovec_destroy(&local_qiov);
         } else {
             num = bytes_remaining;
             ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
@@ -1346,8 +1366,9 @@ out:
 /*
  * Handle a read request in coroutine context
  */
-int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
@@ -1407,6 +1428,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
     ret = bdrv_aligned_preadv(child, &req, offset, bytes, align,
                               use_local_qiov ? &local_qiov : qiov,
+                              use_local_qiov ? 0 : qiov_offset,
                               flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
@@ -1420,6 +1442,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     return ret;
 }
 
+int coroutine_fn bdrv_co_preadv(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    BdrvRequestFlags flags)
+{
+    return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
+}
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1734,7 +1763,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         wait_serialising_requests(req);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret = bdrv_aligned_preadv(child, req, offset & ~(align - 1), align,
-                                  align, &local_qiov, 0);
+                                  align, &local_qiov, 0, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -1772,7 +1801,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         wait_serialising_requests(req);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret = bdrv_aligned_preadv(child, req, offset, align,
-                                  align, &local_qiov, 0);
+                                  align, &local_qiov, 0, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -1839,7 +1868,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret = bdrv_aligned_preadv(child, &req, offset & ~(align - 1), align,
-                                  align, &head_qiov, 0);
+                                  align, &head_qiov, 0, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -1876,7 +1905,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret = bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(align - 1),
-                                  align, align, &tail_qiov, 0);
+                                  align, align, &tail_qiov, 0, 0);
         if (ret < 0) {
             goto fail;
         }
-- 
2.18.0


