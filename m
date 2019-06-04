Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28797C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0119923CCA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119923CCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54907 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCBx-0004xQ-2T
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:21:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6D-000148-KF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6A-0005fs-Qc
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC6A-0005Bz-Iv; Tue, 04 Jun 2019 12:15:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5k-0005Pq-2h; Tue, 04 Jun 2019 19:15:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:09 +0300
Message-Id: <20190604161514.262241-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 07/12] block/io: bdrv_aligned_preadv: use
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

Use and support new API in bdrv_co_do_copy_on_readv.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index a4f67aca47..0cc80e2d5a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1309,7 +1309,7 @@ err:
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
-    int64_t align, QEMUIOVector *qiov, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     int64_t total_bytes, max_bytes;
@@ -1320,7 +1320,6 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
-    assert(!qiov || bytes == qiov->size);
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
@@ -1357,7 +1356,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         }
 
         if (!ret || pnum != bytes) {
-            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov, 0);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes,
+                                           qiov, qiov_offset);
             goto out;
         }
     }
@@ -1371,7 +1371,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
 
     max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <= max_bytes && bytes <= max_transfer) {
-        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 0, 0);
+        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
         goto out;
     }
 
@@ -1379,17 +1379,12 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         int num;
 
         if (max_bytes) {
-            QEMUIOVector local_qiov;
-
             num = MIN(bytes_remaining, MIN(max_bytes, max_transfer));
             assert(num);
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining, num);
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
-                                     num, &local_qiov, 0, 0);
+                                     num, qiov, bytes - bytes_remaining, 0);
             max_bytes -= num;
-            qemu_iovec_destroy(&local_qiov);
         } else {
             num = bytes_remaining;
             ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
@@ -1486,7 +1481,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret = bdrv_aligned_preadv(child, req, req->overlap_offset, bytes,
-                                  align, &local_qiov, 0);
+                                  align, &local_qiov, 0, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1504,7 +1499,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
         ret = bdrv_aligned_preadv(
                 child, req,
                 req->overlap_offset + req->overlap_bytes - align,
-                align, align, &local_qiov, 0);
+                align, align, &local_qiov, 0, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1585,7 +1580,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
     ret = bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
-                              qiov, flags);
+                              qiov, 0, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
 
-- 
2.18.0


