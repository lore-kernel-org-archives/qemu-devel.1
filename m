Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C99DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5998723CBC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5998723CBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYC8V-0002TS-Fk
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:18:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6A-00011c-Ac
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC66-0005Y8-6w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:41656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC61-0005Bv-5K; Tue, 04 Jun 2019 12:15:34 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5k-0005Pq-BF; Tue, 04 Jun 2019 19:15:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:10 +0300
Message-Id: <20190604161514.262241-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 08/12] block/io: bdrv_aligned_pwritev: use
 and support qiov_offset
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

Use and support new API in bdrv_aligned_pwritev.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index 0cc80e2d5a..660c96527d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1792,7 +1792,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
-    int64_t align, QEMUIOVector *qiov, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -1812,7 +1812,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
-    assert(!qiov || bytes == qiov->size);
+    assert(!qiov || qiov_offset + bytes <= qiov->size);
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
@@ -1820,7 +1820,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov, 0, qiov->size)) {
+        qemu_iovec_is_zero(qiov, qiov_offset, bytes)) {
         flags |= BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
             flags |= BDRV_REQ_MAY_UNMAP;
@@ -1833,15 +1833,15 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
     } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
-        ret = bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov, 0);
+        ret = bdrv_driver_pwritev_compressed(bs, offset, bytes,
+                                             qiov, qiov_offset);
     } else if (bytes <= max_transfer) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
-        ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, 0, flags);
+        ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, qiov_offset, flags);
     } else {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
         while (bytes_remaining) {
             int num = MIN(bytes_remaining, max_transfer);
-            QEMUIOVector local_qiov;
             int local_flags = flags;
 
             assert(num);
@@ -1851,12 +1851,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
                  * need to flush on the last iteration */
                 local_flags &= ~BDRV_REQ_FUA;
             }
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining, num);
 
             ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
-                                      num, &local_qiov, 0, local_flags);
-            qemu_iovec_destroy(&local_qiov);
+                                      num, qiov, bytes - bytes_remaining,
+                                      local_flags);
             if (ret < 0) {
                 break;
             }
@@ -1899,7 +1897,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
             qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
             ret = bdrv_aligned_pwritev(child, req, aligned_offset, write_bytes,
-                                       align, &local_qiov,
+                                       align, &local_qiov, 0,
                                        flags & ~BDRV_REQ_ZERO_WRITE);
             if (ret < 0 || pad.merge_reads) {
                 /* Error or all work is done */
@@ -1915,7 +1913,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         /* Write the aligned part in the middle. */
         uint64_t aligned_bytes = bytes & ~(align - 1);
         ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
-                                   NULL, flags);
+                                   NULL, 0, flags);
         if (ret < 0) {
             goto out;
         }
@@ -1929,7 +1927,8 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
         qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
         ret = bdrv_aligned_pwritev(child, req, offset, align, align,
-                                   &local_qiov, flags & ~BDRV_REQ_ZERO_WRITE);
+                                   &local_qiov, 0,
+                                   flags & ~BDRV_REQ_ZERO_WRITE);
     }
 
 out:
@@ -1982,7 +1981,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     }
 
     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               qiov, flags);
+                               qiov, 0, flags);
 
     bdrv_padding_destroy(&pad);
 
-- 
2.18.0


