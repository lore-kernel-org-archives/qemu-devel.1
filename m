Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2672C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D76520656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D76520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZc6J-0000LI-Mq
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iZc3u-0005xc-E9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iZc3s-0003vw-TI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:43:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:47914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iZc3s-0003vJ-L9; Tue, 26 Nov 2019 09:43:28 -0500
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iZc3j-0004JL-Be; Tue, 26 Nov 2019 17:43:19 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v9 2/3] qcow2: Allow writing compressed data of multiple
 clusters
Date: Tue, 26 Nov 2019 17:43:17 +0300
Message-Id: <1574779398-88772-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU currently supports writing compressed data of the size equal to
one cluster. This patch allows writing QCOW2 compressed data that
exceed one cluster. Now, we split buffered data into separate clusters
and write them compressed using the block/aio_task API.

Suggested-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 102 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7c18721..0e03a1a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4222,10 +4222,8 @@ fail:
     return ret;
 }
 
-/* XXX: put compressed sectors first, then all the cluster aligned
-   tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
                                  uint64_t offset, uint64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
@@ -4235,32 +4233,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
 
-    if (has_data_file(bs)) {
-        return -ENOTSUP;
-    }
-
-    if (bytes == 0) {
-        /* align end of file to a sector boundary to ease reading with
-           sector based I/Os */
-        int64_t len = bdrv_getlength(bs->file->bs);
-        if (len < 0) {
-            return len;
-        }
-        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
-    }
-
-    if (offset_into_cluster(s, offset)) {
-        return -EINVAL;
-    }
+    assert(bytes == s->cluster_size || (bytes < s->cluster_size &&
+           (offset + bytes == bs->total_sectors << BDRV_SECTOR_BITS)));
 
     buf = qemu_blockalign(bs, s->cluster_size);
-    if (bytes != s->cluster_size) {
-        if (bytes > s->cluster_size ||
-            offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS)
-        {
-            qemu_vfree(buf);
-            return -EINVAL;
-        }
+    if (bytes < s->cluster_size) {
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
     }
@@ -4309,6 +4286,77 @@ fail:
     return ret;
 }
 
+static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
+
+    assert(!t->cluster_type && !t->l2meta);
+
+    return qcow2_co_pwritev_compressed_task(t->bs, t->offset, t->bytes, t->qiov,
+                                            t->qiov_offset);
+}
+
+/*
+ * XXX: put compressed sectors first, then all the cluster aligned
+ * tables to avoid losing bytes in alignment
+ */
+static coroutine_fn int
+qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, size_t qiov_offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    AioTaskPool *aio = NULL;
+    int ret = 0;
+
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
+    if (bytes == 0) {
+        /*
+         * align end of file to a sector boundary to ease reading with
+         * sector based I/Os
+         */
+        int64_t len = bdrv_getlength(bs->file->bs);
+        if (len < 0) {
+            return len;
+        }
+        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
+    }
+
+    if (offset_into_cluster(s, offset)) {
+        return -EINVAL;
+    }
+
+    while (bytes && aio_task_pool_status(aio) == 0) {
+        uint64_t chunk_size = MIN(bytes, s->cluster_size);
+
+        if (!aio && chunk_size != bytes) {
+            aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
+        }
+
+        ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_task_entry,
+                             0, 0, offset, chunk_size, qiov, qiov_offset, NULL);
+        if (ret < 0) {
+            break;
+        }
+        qiov_offset += chunk_size;
+        offset += chunk_size;
+        bytes -= chunk_size;
+    }
+
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
+    return ret;
+}
+
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
-- 
1.8.3.1


