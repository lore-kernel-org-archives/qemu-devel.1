Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2196C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E6A20659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E6A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSyY-0003xX-0s
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsSxV-0002IE-GP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsSxT-0002hV-Jl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:18:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:49376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hsSxT-0002g8-Ck; Tue, 30 Jul 2019 10:18:31 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hsSxP-0000jQ-Qs; Tue, 30 Jul 2019 17:18:27 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 17:18:25 +0300
Message-Id: <20190730141826.709849-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190730141826.709849-1-vsementsov@virtuozzo.com>
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 3/4] block/qcow2: refactor
 qcow2_co_pwritev_part
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
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to previous commit, prepare for parallelizing write-loop
iterations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 150 +++++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 62 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fa71968b2..37766b8b7c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2235,6 +2235,87 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     return 0;
 }
 
+/*
+ * qcow2_co_pwritev_task
+ * Called with s->lock unlocked
+ * l2meta  - if not NULL, qcow2_co_do_pwritev() will consume it. Caller must not
+ *           use it somehow after qcow2_co_pwritev_task() call
+ */
+static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
+                                              uint64_t file_cluster_offset,
+                                              uint64_t offset, uint64_t bytes,
+                                              QEMUIOVector *qiov,
+                                              uint64_t qiov_offset,
+                                              QCowL2Meta *l2meta)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    void *crypt_buf = NULL;
+    int offset_in_cluster = offset_into_cluster(s, offset);
+    QEMUIOVector encrypted_qiov;
+
+    if (bs->encrypted) {
+        assert(s->crypto);
+        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
+        if (crypt_buf == NULL) {
+            ret = -ENOMEM;
+            goto out_unlocked;
+        }
+        qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
+
+        if (qcow2_co_encrypt(bs, file_cluster_offset, offset,
+                             crypt_buf, bytes) < 0) {
+            ret = -EIO;
+            goto out_unlocked;
+        }
+
+        qemu_iovec_init_buf(&encrypted_qiov, crypt_buf, bytes);
+        qiov = &encrypted_qiov;
+        qiov_offset = 0;
+    }
+
+    /* Try to efficiently initialize the physical space with zeroes */
+    ret = handle_alloc_space(bs, l2meta);
+    if (ret < 0) {
+        goto out_unlocked;
+    }
+
+    /*
+     * If we need to do COW, check if it's possible to merge the
+     * writing of the guest data together with that of the COW regions.
+     * If it's not possible (or not necessary) then write the
+     * guest data now.
+     */
+    if (!merge_cow(offset, bytes, qiov, qiov_offset, l2meta)) {
+        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        trace_qcow2_writev_data(qemu_coroutine_self(),
+                                file_cluster_offset + offset_in_cluster);
+        ret = bdrv_co_pwritev_part(s->data_file,
+                                   file_cluster_offset + offset_in_cluster,
+                                   bytes, qiov, qiov_offset, 0);
+        if (ret < 0) {
+            goto out_unlocked;
+        }
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+
+    ret = qcow2_handle_l2meta(bs, &l2meta, true);
+    goto out_locked;
+
+out_unlocked:
+    qemu_co_mutex_lock(&s->lock);
+
+out_locked:
+    qcow2_handle_l2meta(bs, &l2meta, false);
+    qemu_co_mutex_unlock(&s->lock);
+
+    qemu_vfree(crypt_buf);
+
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_pwritev_part(
         BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
@@ -2244,15 +2325,11 @@ static coroutine_fn int qcow2_co_pwritev_part(
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    QEMUIOVector encrypted_qiov;
     uint64_t bytes_done = 0;
-    uint8_t *cluster_data = NULL;
     QCowL2Meta *l2meta = NULL;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
-    qemu_co_mutex_lock(&s->lock);
-
     while (bytes != 0) {
 
         l2meta = NULL;
@@ -2266,6 +2343,8 @@ static coroutine_fn int qcow2_co_pwritev_part(
                             - offset_in_cluster);
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &cluster_offset, &l2meta);
         if (ret < 0) {
@@ -2283,62 +2362,11 @@ static coroutine_fn int qcow2_co_pwritev_part(
 
         qemu_co_mutex_unlock(&s->lock);
 
-        if (bs->encrypted) {
-            assert(s->crypto);
-            if (!cluster_data) {
-                cluster_data = qemu_try_blockalign(bs->file->bs,
-                                                   QCOW_MAX_CRYPT_CLUSTERS
-                                                   * s->cluster_size);
-                if (cluster_data == NULL) {
-                    ret = -ENOMEM;
-                    goto out_unlocked;
-                }
-            }
-
-            assert(cur_bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-            qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
-                              cluster_data, cur_bytes);
-
-            if (qcow2_co_encrypt(bs, cluster_offset, offset,
-                                 cluster_data, cur_bytes) < 0) {
-                ret = -EIO;
-                goto out_unlocked;
-            }
-
-            qemu_iovec_init_buf(&encrypted_qiov, cluster_data, cur_bytes);
-        }
-
-        /* Try to efficiently initialize the physical space with zeroes */
-        ret = handle_alloc_space(bs, l2meta);
+        ret = qcow2_co_pwritev_task(bs, cluster_offset, offset, cur_bytes,
+                                    qiov, bytes_done, l2meta);
+        l2meta = NULL; /* l2meta is consumed by qcow2_co_do_pwritev() */
         if (ret < 0) {
-            goto out_unlocked;
-        }
-
-        /* If we need to do COW, check if it's possible to merge the
-         * writing of the guest data together with that of the COW regions.
-         * If it's not possible (or not necessary) then write the
-         * guest data now. */
-        if (!merge_cow(offset, cur_bytes,
-                       bs->encrypted ? &encrypted_qiov : qiov,
-                       bs->encrypted ? 0 : qiov_offset + bytes_done, l2meta))
-        {
-            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-            trace_qcow2_writev_data(qemu_coroutine_self(),
-                                    cluster_offset + offset_in_cluster);
-            ret = bdrv_co_pwritev_part(
-                    s->data_file, cluster_offset + offset_in_cluster, cur_bytes,
-                    bs->encrypted ? &encrypted_qiov : qiov,
-                    bs->encrypted ? 0 : qiov_offset + bytes_done, 0);
-            if (ret < 0) {
-                goto out_unlocked;
-            }
-        }
-
-        qemu_co_mutex_lock(&s->lock);
-
-        ret = qcow2_handle_l2meta(bs, &l2meta, true);
-        if (ret) {
-            goto out_locked;
+            goto fail_nometa;
         }
 
         bytes -= cur_bytes;
@@ -2347,9 +2375,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
     ret = 0;
-    goto out_locked;
 
-out_unlocked:
     qemu_co_mutex_lock(&s->lock);
 
 out_locked:
@@ -2357,7 +2383,7 @@ out_locked:
 
     qemu_co_mutex_unlock(&s->lock);
 
-    qemu_vfree(cluster_data);
+fail_nometa:
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
-- 
2.18.0


