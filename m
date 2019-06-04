Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC2C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D8E23CCA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D8E23CCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCAI-0003lt-82
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6D-000149-KJ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6A-0005fk-Mf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:41662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC6A-0005C4-EL; Tue, 04 Jun 2019 12:15:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5k-0005Pq-GR; Tue, 04 Jun 2019 19:15:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:11 +0300
Message-Id: <20190604161514.262241-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 09/12] block/io: introduce bdrv_co_p{read,
 write}v_part
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

Introduce extended variants of bdrv_co_preadv and bdrv_co_pwritev
with qiov_offset parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  6 ++++++
 block/io.c                | 29 +++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 46e17d2e2f..8b7b5d5b84 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -940,9 +940,15 @@ extern BlockDriver bdrv_qcow2;
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
     int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flags)
diff --git a/block/io.c b/block/io.c
index 660c96527d..82051730fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1534,7 +1534,8 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
  *
  * Function always succeeds.
  */
-static bool bdrv_pad_request(BlockDriverState *bs, QEMUIOVector **qiov,
+static bool bdrv_pad_request(BlockDriverState *bs,
+                             QEMUIOVector **qiov, size_t *qiov_offset,
                              int64_t *offset, unsigned int *bytes,
                              BdrvRequestPadding *pad)
 {
@@ -1543,11 +1544,12 @@ static bool bdrv_pad_request(BlockDriverState *bs, QEMUIOVector **qiov,
     }
 
     qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
-                             *qiov, 0, *bytes,
+                             *qiov, *qiov_offset, *bytes,
                              pad->buf + pad->buf_len - pad->tail, pad->tail);
     *bytes += pad->head + pad->tail;
     *offset -= pad->head;
     *qiov = &pad->local_qiov;
+    *qiov_offset = 0;
 
     return true;
 }
@@ -1555,6 +1557,14 @@ static bool bdrv_pad_request(BlockDriverState *bs, QEMUIOVector **qiov,
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
+{
+    return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
+}
+
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
     BdrvTrackedRequest req;
@@ -1575,12 +1585,12 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
         flags |= BDRV_REQ_COPY_ON_READ;
     }
 
-    bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad);
+    bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad);
 
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
     ret = bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
-                              qiov, 0, flags);
+                              qiov, qiov_offset, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
 
@@ -1943,6 +1953,13 @@ out:
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
+{
+    return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
+}
+
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
     BdrvTrackedRequest req;
@@ -1974,14 +1991,14 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         goto out;
     }
 
-    if (bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad)) {
+    if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
 
     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               qiov, 0, flags);
+                               qiov, qiov_offset, flags);
 
     bdrv_padding_destroy(&pad);
 
-- 
2.18.0


