Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F48C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA0420656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA0420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38487 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaTy-0004ny-5n
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:03:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP6-0000nq-0D
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00037a-GF
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:55312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP4-00036I-9J; Mon, 22 Apr 2019 10:58:42 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP1-0003k3-HT; Mon, 22 Apr 2019 17:58:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 17:58:32 +0300
Message-Id: <20190422145838.70903-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/9] block/qcow: use buffer-based io
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422145832.eYUfL7Q5aJ1ukDVbGQNIg3bvR7K--Dl0B8iEVm17bDw@z>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 10d2cf14b3..1bb8fd05e2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -631,7 +631,6 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
     int offset_in_cluster;
     int ret = 0, n;
     uint64_t cluster_offset;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
 
@@ -663,11 +662,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
-                qemu_iovec_init_buf(&hd_qiov, buf, n);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing */
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret = bdrv_co_preadv(bs->backing, offset, n, &hd_qiov, 0);
+                ret = bdrv_co_pread(bs->backing, offset, n, buf, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     break;
@@ -688,11 +686,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
                 ret = -EIO;
                 break;
             }
-            qemu_iovec_init_buf(&hd_qiov, buf, n);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret = bdrv_co_preadv(bs->file, cluster_offset + offset_in_cluster,
-                                 n, &hd_qiov, 0);
+            ret = bdrv_co_pread(bs->file, cluster_offset + offset_in_cluster,
+                                n, buf, 0);
             qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 break;
@@ -731,7 +728,6 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
     int offset_in_cluster;
     uint64_t cluster_offset;
     int ret = 0, n;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
 
@@ -776,11 +772,10 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
             }
         }
 
-        qemu_iovec_init_buf(&hd_qiov, buf, n);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        ret = bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster,
-                              n, &hd_qiov, 0);
+        ret = bdrv_co_pwrite(bs->file, cluster_offset + offset_in_cluster,
+                             n, buf, 0);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             break;
@@ -1056,7 +1051,6 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                            uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcowState *s = bs->opaque;
-    QEMUIOVector hd_qiov;
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
@@ -1122,9 +1116,8 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     }
     cluster_offset &= s->cluster_offset_mask;
 
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
-    ret = bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov, 0);
+    ret = bdrv_co_pwrite(bs->file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
     }
-- 
2.18.0


