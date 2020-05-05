Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF0AC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA07820721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F6Fnbx2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA07820721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1b2-0003kA-MI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1XL-0006GH-N0; Tue, 05 May 2020 13:39:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1XJ-00089k-BA; Tue, 05 May 2020 13:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=naWKT3sFm8XnzZwxieCgMljjIGnhCAu859Z3ffTW90c=; 
 b=F6Fnbx2TcMaKlnau/2o23wYhCuOpXEhzjeRjy35x6g/zyHLHxRF+hGcZ3IJz/a/JTg8ylMZhi9RDUwWrHcMAQF96VFnWHaffYnrn2Sji2Ts/sH8S8GJDxuJRVJA/sDwP1sruse0hVBDP/60ihfGgjOmHzQlnExwTEXg42+AEe1GAd8xK0H4rllOxkfv4ofcMNzIvuL0NyNUEBVOlCZ8EQ/P34JgZEWVio46zBPpvMwgOTcvOpu6l9lhsprfGoSZNoltuMR/NUkqd2TO0Euty/Qk3ZmNM89ZxnLUfaTbraDzuWWP5kQ2R0NE8Yr9seE3vVf7jA6abQvmB7QiBPsSWgw==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025H-DO; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wc-00043Y-Do; Tue, 05 May 2020 19:38:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/31] qcow2: Make Qcow2AioTask store the full host offset
Date: Tue,  5 May 2020 19:38:01 +0200
Message-Id: <dc7d14be4aa0f3a29dd85ff157e8dd4b23618e2c.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c      | 69 ++++++++++++++++++++++------------------------
 block/trace-events |  2 +-
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 8c97b06783..a387809aa9 100644
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
@@ -2043,7 +2043,7 @@ out:
 
 static coroutine_fn int
 qcow2_co_preadv_encrypted(BlockDriverState *bs,
-                           uint64_t file_cluster_offset,
+                           uint64_t host_offset,
                            uint64_t offset,
                            uint64_t bytes,
                            QEMUIOVector *qiov,
@@ -2070,16 +2070,12 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
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
@@ -2097,7 +2093,7 @@ typedef struct Qcow2AioTask {
 
     BlockDriverState *bs;
     QCow2ClusterType cluster_type; /* only for read */
-    uint64_t file_cluster_offset;
+    uint64_t host_offset; /* or full descriptor in compressed clusters */
     uint64_t offset;
     uint64_t bytes;
     QEMUIOVector *qiov;
@@ -2110,7 +2106,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
                                        AioTaskPool *pool,
                                        AioTaskFunc func,
                                        QCow2ClusterType cluster_type,
-                                       uint64_t file_cluster_offset,
+                                       uint64_t host_offset,
                                        uint64_t offset,
                                        uint64_t bytes,
                                        QEMUIOVector *qiov,
@@ -2125,7 +2121,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
         .bs = bs,
         .cluster_type = cluster_type,
         .qiov = qiov,
-        .file_cluster_offset = file_cluster_offset,
+        .host_offset = host_offset,
         .offset = offset,
         .bytes = bytes,
         .qiov_offset = qiov_offset,
@@ -2134,7 +2130,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
     trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
                          func == qcow2_co_preadv_task_entry ? "read" : "write",
-                         cluster_type, file_cluster_offset, offset, bytes,
+                         cluster_type, host_offset, offset, bytes,
                          qiov, qiov_offset);
 
     if (!pool) {
@@ -2148,13 +2144,12 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
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
@@ -2170,19 +2165,17 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
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
@@ -2198,7 +2191,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 
     assert(!t->l2meta);
 
-    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_offset,
+    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->host_offset,
                                 t->offset, t->bytes, t->qiov, t->qiov_offset);
 }
 
@@ -2234,11 +2227,20 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
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
@@ -2389,7 +2391,7 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
  *           not use it somehow after qcow2_co_pwritev_task() call
  */
 static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
-                                              uint64_t file_cluster_offset,
+                                              uint64_t host_offset,
                                               uint64_t offset, uint64_t bytes,
                                               QEMUIOVector *qiov,
                                               uint64_t qiov_offset,
@@ -2398,7 +2400,6 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
     void *crypt_buf = NULL;
-    int offset_in_cluster = offset_into_cluster(s, offset);
     QEMUIOVector encrypted_qiov;
 
     if (bs->encrypted) {
@@ -2411,9 +2412,7 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
         }
         qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
 
-        if (qcow2_co_encrypt(bs, file_cluster_offset + offset_in_cluster,
-                             offset, crypt_buf, bytes) < 0)
-        {
+        if (qcow2_co_encrypt(bs, host_offset, offset, crypt_buf, bytes) < 0) {
             ret = -EIO;
             goto out_unlocked;
         }
@@ -2437,10 +2436,8 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
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
@@ -2470,7 +2467,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 
     assert(!t->cluster_type);
 
-    return qcow2_co_pwritev_task(t->bs, t->file_cluster_offset,
+    return qcow2_co_pwritev_task(t->bs, t->host_offset,
                                  t->offset, t->bytes, t->qiov, t->qiov_offset,
                                  t->l2meta);
 }
@@ -2525,8 +2522,8 @@ static coroutine_fn int qcow2_co_pwritev_part(
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
@@ -4445,7 +4442,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
-                           uint64_t file_cluster_offset,
+                           uint64_t cluster_descriptor,
                            uint64_t offset,
                            uint64_t bytes,
                            QEMUIOVector *qiov,
@@ -4457,8 +4454,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     uint8_t *buf, *out_buf;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
-    coffset = file_cluster_offset & s->cluster_offset_mask;
-    nb_csectors = ((file_cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
+    coffset = cluster_descriptor & s->cluster_offset_mask;
+    nb_csectors = ((cluster_descriptor >> s->csize_shift) & s->csize_mask) + 1;
     csize = nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE -
         (coffset & ~QCOW2_COMPRESSED_SECTOR_MASK);
 
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..5c9b0769dc 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -77,7 +77,7 @@ luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
 luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p luringcb %p nread %d"
 
 # qcow2.c
-qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t file_cluster_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
+qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t host_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
-- 
2.20.1


