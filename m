Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486CCC04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112112173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112112173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0Qi-0004fI-8h
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:47:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0Op-0003bG-DZ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0Oo-0004HE-6Q
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:45:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT0Ol-0004AI-Kb; Tue, 21 May 2019 04:45:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hT0Oh-0003ut-Nk; Tue, 21 May 2019 11:45:23 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 11:45:22 +0300
Message-Id: <20190521084522.15050-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190521084522.15050-1-vsementsov@virtuozzo.com>
References: <20190521084522.15050-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [RFC PATCH 3/3] block/qcow2: implement
 .bdrv_co_preadv_part
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

Implement and use new interface to get rid of hd_qiov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5b4e5e7537..dcfa688c13 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -75,7 +75,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
                            uint64_t offset,
                            uint64_t bytes,
-                           QEMUIOVector *qiov);
+                           QEMUIOVector *qiov,
+                           size_t qiov_offset);
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -1955,21 +1956,18 @@ out:
     return ret;
 }
 
-static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                        uint64_t bytes, QEMUIOVector *qiov,
-                                        int flags)
+static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
+                                             uint64_t offset, uint64_t bytes,
+                                             QEMUIOVector *qiov,
+                                             size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset = 0;
-    uint64_t bytes_done = 0;
-    QEMUIOVector hd_qiov;
     uint8_t *cluster_data = NULL;
 
-    qemu_iovec_init(&hd_qiov, qiov->niov);
-
     while (bytes != 0) {
 
         /* prepare next request */
@@ -1988,34 +1986,31 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 
         offset_in_cluster = offset_into_cluster(s, offset);
 
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
-
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
 
             if (bs->backing) {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret = bdrv_co_preadv(bs->backing, offset, cur_bytes,
-                                     &hd_qiov, 0);
+                ret = bdrv_co_preadv_part(bs->backing, offset, cur_bytes,
+                                          qiov, qiov_offset, 0);
                 if (ret < 0) {
                     goto fail;
                 }
             } else {
                 /* Note: in this case, no need to wait */
-                qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+                qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
             }
             break;
 
         case QCOW2_CLUSTER_ZERO_PLAIN:
         case QCOW2_CLUSTER_ZERO_ALLOC:
-            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+            qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
             break;
 
         case QCOW2_CLUSTER_COMPRESSED:
             ret = qcow2_co_preadv_compressed(bs, cluster_offset,
                                              offset, cur_bytes,
-                                             &hd_qiov);
+                                             qiov, qiov_offset);
             if (ret < 0) {
                 goto fail;
             }
@@ -2063,12 +2058,12 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                     ret = -EIO;
                     goto fail;
                 }
-                qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_bytes);
+                qemu_iovec_from_buf(qiov, qiov_offset, cluster_data, cur_bytes);
             } else {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret = bdrv_co_preadv(s->data_file,
-                                     cluster_offset + offset_in_cluster,
-                                     cur_bytes, &hd_qiov, 0);
+                ret = bdrv_co_preadv_part(s->data_file,
+                                          cluster_offset + offset_in_cluster,
+                                          cur_bytes, qiov, qiov_offset, 0);
                 if (ret < 0) {
                     goto fail;
                 }
@@ -2083,12 +2078,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 
         bytes -= cur_bytes;
         offset += cur_bytes;
-        bytes_done += cur_bytes;
+        qiov_offset += cur_bytes;
     }
     ret = 0;
 
 fail:
-    qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
 
     return ret;
@@ -4002,7 +3996,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
                            uint64_t offset,
                            uint64_t bytes,
-                           QEMUIOVector *qiov)
+                           QEMUIOVector *qiov,
+                           size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret = 0, csize, nb_csectors;
@@ -4032,7 +4027,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
         goto fail;
     }
 
-    qemu_iovec_from_buf(qiov, 0, out_buf + offset_in_cluster, bytes);
+    qemu_iovec_from_buf(qiov, qiov_offset, out_buf + offset_in_cluster, bytes);
 
 fail:
     qemu_vfree(out_buf);
@@ -5093,7 +5088,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = qcow2_co_block_status,
 
-    .bdrv_co_preadv         = qcow2_co_preadv,
+    .bdrv_co_preadv_part    = qcow2_co_preadv_part,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
     .bdrv_co_flush_to_os    = qcow2_co_flush_to_os,
 
-- 
2.18.0


