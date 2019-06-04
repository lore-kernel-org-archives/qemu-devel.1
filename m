Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFDC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A313720717
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A313720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCCP-0005PX-QF
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6H-00018h-Si
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6B-0005hG-CA
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC6A-0005By-Pm; Tue, 04 Jun 2019 12:15:43 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5k-0005Pq-Oi; Tue, 04 Jun 2019 19:15:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:13 +0300
Message-Id: <20190604161514.262241-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 11/12] block/qcow2: implement
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement and use new interface to get rid of hd_qiov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-cluster.c |  5 +++--
 block/qcow2.c         | 49 +++++++++++++++++++------------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cf892f37a8..1159d6ed2f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -453,8 +453,9 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
      * interface.  This avoids double I/O throttling and request tracking,
      * which can lead to deadlock when block layer copy-on-read is enabled.
      */
-    ret = bs->drv->bdrv_co_preadv(bs, src_cluster_offset + offset_in_cluster,
-                                  qiov->size, qiov, 0);
+    ret = bs->drv->bdrv_co_preadv_part(bs,
+                                       src_cluster_offset + offset_in_cluster,
+                                       qiov->size, qiov, 0, 0);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 8a033ae08c..c389ef07b0 100644
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
@@ -4087,7 +4081,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
                            uint64_t offset,
                            uint64_t bytes,
-                           QEMUIOVector *qiov)
+                           QEMUIOVector *qiov,
+                           size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret = 0, csize, nb_csectors;
@@ -4118,7 +4113,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
         goto fail;
     }
 
-    qemu_iovec_from_buf(qiov, 0, out_buf + offset_in_cluster, bytes);
+    qemu_iovec_from_buf(qiov, qiov_offset, out_buf + offset_in_cluster, bytes);
 
 fail:
     qemu_vfree(out_buf);
@@ -4638,8 +4633,8 @@ static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
     BDRVQcow2State *s = bs->opaque;
 
     BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
-    return bs->drv->bdrv_co_preadv(bs, qcow2_vm_state_offset(s) + pos,
-                                   qiov->size, qiov, 0);
+    return bs->drv->bdrv_co_preadv_part(bs, qcow2_vm_state_offset(s) + pos,
+                                        qiov->size, qiov, 0, 0);
 }
 
 /*
@@ -5179,7 +5174,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = qcow2_co_block_status,
 
-    .bdrv_co_preadv         = qcow2_co_preadv,
+    .bdrv_co_preadv_part    = qcow2_co_preadv_part,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
     .bdrv_co_flush_to_os    = qcow2_co_flush_to_os,
 
-- 
2.18.0


