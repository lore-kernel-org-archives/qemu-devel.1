Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2EC35DF9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC18246B4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DDpcReMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC18246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7O0u-0004bd-BZ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j7Nzo-0003DI-8a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j7Nzm-0000gi-6Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:34:52 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:33970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j7Nzl-0000MN-Da; Thu, 27 Feb 2020 13:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=HyikUCesDCH37bcDyzRmQu7fuOx8P2zF8fh19cRdJC0=; 
 b=DDpcReMooOXfGNSvKELJAPTnLiECwn3WQmApmSGyoOmuzAqO1Hz2EZn6VEho5kwaV2aKziATkMqEqM9ykpaOLM0iwtxNRLNh/SgSKQUeflT9WMf8nNghzqV8JfT1+6UuvvMVfoCMzjxQXz4duA99pO1mEkBugGZHaomUs9Ipcj4OXEKwuBN0602k7NSIALZJ4E/hPS1a+yQYaX0pdwvKxSwKJHYvs1BwCthnAtjtvsNah5zr6/fz48K1lLEWdR/PQkWuO94uaLFuR+2PKK2iPD4kOd6IV9n4cBNZ+BX/m+Ewdrm57y5t7goQnfCl/qaCLoza2n4VJ2aC57GjIMOW+Q==;
Received: from [192.168.12.213] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1j7NzT-0000H1-AZ; Thu, 27 Feb 2020 19:34:31 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1j7NzS-0000VV-OT; Thu, 27 Feb 2020 19:34:30 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qcow2: Make Qcow2AioTask store the full host offset
Date: Thu, 27 Feb 2020 19:34:25 +0100
Message-Id: <ad4d3aaaa26faf5b11707de9589f58799b498b11.1582828123.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582828123.git.berto@igalia.com>
References: <cover.1582828123.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file_cluster_offset field of Qcow2AioTask stores a cluster-aligned
host offset. In practice this is not very useful because all users(*)
of this structure need the final host offset into the cluster, which
they calculate using

   host_offset = file_cluster_offset + offset_into_cluster(s, offset)

There is no reason why Qcow2AioTask cannot store host_offset directly
and that is what this patch does.

(*) compressed clusters are the exception: in this case what
    file_cluster_offset was storing was the full compressed cluster
    descriptor (offset + size). This does not change with this patch
    but it is documented now.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3c754f616b..b2c7c8255e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -74,7 +74,7 @@ typedef struct {
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
-                           uint64_t file_cluster_offset,
+                           uint64_t cluster_descriptor,
                            uint64_t offset,
                            uint64_t bytes,
                            QEMUIOVector *qiov,
@@ -2037,7 +2037,7 @@ out:
 
 static coroutine_fn int
 qcow2_co_preadv_encrypted(BlockDriverState *bs,
-                           uint64_t file_cluster_offset,
+                           uint64_t host_offset,
                            uint64_t offset,
                            uint64_t bytes,
                            QEMUIOVector *qiov,
@@ -2064,16 +2064,12 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-    ret = bdrv_co_pread(s->data_file,
-                        file_cluster_offset + offset_into_cluster(s, offset),
-                        bytes, buf, 0);
+    ret = bdrv_co_pread(s->data_file, host_offset, bytes, buf, 0);
     if (ret < 0) {
         goto fail;
     }
 
-    if (qcow2_co_decrypt(bs,
-                         file_cluster_offset + offset_into_cluster(s, offset),
-                         offset, buf, bytes) < 0)
+    if (qcow2_co_decrypt(bs, host_offset, offset, buf, bytes) < 0)
     {
         ret = -EIO;
         goto fail;
@@ -2091,7 +2087,7 @@ typedef struct Qcow2AioTask {
 
     BlockDriverState *bs;
     QCow2ClusterType cluster_type; /* only for read */
-    uint64_t file_cluster_offset;
+    uint64_t host_offset; /* or full descriptor in compressed clusters */
     uint64_t offset;
     uint64_t bytes;
     QEMUIOVector *qiov;
@@ -2104,7 +2100,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
                                        AioTaskPool *pool,
                                        AioTaskFunc func,
                                        QCow2ClusterType cluster_type,
-                                       uint64_t file_cluster_offset,
+                                       uint64_t host_offset,
                                        uint64_t offset,
                                        uint64_t bytes,
                                        QEMUIOVector *qiov,
@@ -2119,7 +2115,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
         .bs = bs,
         .cluster_type = cluster_type,
         .qiov = qiov,
-        .file_cluster_offset = file_cluster_offset,
+        .host_offset = host_offset,
         .offset = offset,
         .bytes = bytes,
         .qiov_offset = qiov_offset,
@@ -2128,7 +2124,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
     trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
                          func == qcow2_co_preadv_task_entry ? "read" : "write",
-                         cluster_type, file_cluster_offset, offset, bytes,
+                         cluster_type, host_offset, offset, bytes,
                          qiov, qiov_offset);
 
     if (!pool) {
@@ -2142,13 +2138,12 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
 static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                              QCow2ClusterType cluster_type,
-                                             uint64_t file_cluster_offset,
+                                             uint64_t host_offset,
                                              uint64_t offset, uint64_t bytes,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
-    int offset_in_cluster = offset_into_cluster(s, offset);
 
     switch (cluster_type) {
     case QCOW2_CLUSTER_ZERO_PLAIN:
@@ -2164,19 +2159,17 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                    qiov, qiov_offset, 0);
 
     case QCOW2_CLUSTER_COMPRESSED:
-        return qcow2_co_preadv_compressed(bs, file_cluster_offset,
+        return qcow2_co_preadv_compressed(bs, host_offset,
                                           offset, bytes, qiov, qiov_offset);
 
     case QCOW2_CLUSTER_NORMAL:
-        assert(offset_into_cluster(s, file_cluster_offset) == 0);
         if (bs->encrypted) {
-            return qcow2_co_preadv_encrypted(bs, file_cluster_offset,
+            return qcow2_co_preadv_encrypted(bs, host_offset,
                                              offset, bytes, qiov, qiov_offset);
         }
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-        return bdrv_co_preadv_part(s->data_file,
-                                   file_cluster_offset + offset_in_cluster,
+        return bdrv_co_preadv_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
 
     default:
@@ -2192,7 +2185,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 
     assert(!t->l2meta);
 
-    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_offset,
+    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->host_offset,
                                 t->offset, t->bytes, t->qiov, t->qiov_offset);
 }
 
@@ -2228,11 +2221,20 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
+            /*
+             * For compressed clusters the variable cluster_offset
+             * does not actually store the offset but the full
+             * descriptor. We need to leave it unchanged because
+             * that's what qcow2_co_preadv_compressed() expects.
+             */
+            uint64_t host_offset = (ret == QCOW2_CLUSTER_COMPRESSED) ?
+                cluster_offset :
+                cluster_offset + offset_into_cluster(s, offset);
             if (!aio && cur_bytes != bytes) {
                 aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
             }
             ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, ret,
-                                 cluster_offset, offset, cur_bytes,
+                                 host_offset, offset, cur_bytes,
                                  qiov, qiov_offset, NULL);
             if (ret < 0) {
                 goto out;
@@ -2383,7 +2385,7 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
  *           not use it somehow after qcow2_co_pwritev_task() call
  */
 static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
-                                              uint64_t file_cluster_offset,
+                                              uint64_t host_offset,
                                               uint64_t offset, uint64_t bytes,
                                               QEMUIOVector *qiov,
                                               uint64_t qiov_offset,
@@ -2392,7 +2394,6 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
     void *crypt_buf = NULL;
-    int offset_in_cluster = offset_into_cluster(s, offset);
     QEMUIOVector encrypted_qiov;
 
     if (bs->encrypted) {
@@ -2405,8 +2406,7 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
         }
         qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
 
-        if (qcow2_co_encrypt(bs, file_cluster_offset + offset_in_cluster,
-                             offset, crypt_buf, bytes) < 0)
+        if (qcow2_co_encrypt(bs, host_offset, offset, crypt_buf, bytes) < 0)
         {
             ret = -EIO;
             goto out_unlocked;
@@ -2431,10 +2431,8 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
      */
     if (!merge_cow(offset, bytes, qiov, qiov_offset, l2meta)) {
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        trace_qcow2_writev_data(qemu_coroutine_self(),
-                                file_cluster_offset + offset_in_cluster);
-        ret = bdrv_co_pwritev_part(s->data_file,
-                                   file_cluster_offset + offset_in_cluster,
+        trace_qcow2_writev_data(qemu_coroutine_self(), host_offset);
+        ret = bdrv_co_pwritev_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
         if (ret < 0) {
             goto out_unlocked;
@@ -2464,7 +2462,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 
     assert(!t->cluster_type);
 
-    return qcow2_co_pwritev_task(t->bs, t->file_cluster_offset,
+    return qcow2_co_pwritev_task(t->bs, t->host_offset,
                                  t->offset, t->bytes, t->qiov, t->qiov_offset,
                                  t->l2meta);
 }
@@ -2519,8 +2517,8 @@ static coroutine_fn int qcow2_co_pwritev_part(
             aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
         }
         ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_task_entry, 0,
-                             cluster_offset, offset, cur_bytes,
-                             qiov, qiov_offset, l2meta);
+                             cluster_offset + offset_in_cluster, offset,
+                             cur_bytes, qiov, qiov_offset, l2meta);
         l2meta = NULL; /* l2meta is consumed by qcow2_co_pwritev_task() */
         if (ret < 0) {
             goto fail_nometa;
@@ -4353,7 +4351,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
-                           uint64_t file_cluster_offset,
+                           uint64_t cluster_descriptor,
                            uint64_t offset,
                            uint64_t bytes,
                            QEMUIOVector *qiov,
@@ -4365,8 +4363,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     uint8_t *buf, *out_buf;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
-    coffset = file_cluster_offset & s->cluster_offset_mask;
-    nb_csectors = ((file_cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
+    coffset = cluster_descriptor & s->cluster_offset_mask;
+    nb_csectors = ((cluster_descriptor >> s->csize_shift) & s->csize_mask) + 1;
     csize = nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE -
         (coffset & ~QCOW2_COMPRESSED_SECTOR_MASK);
 
-- 
2.20.1


