Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C93C04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B258204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B258204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNef9-0001mz-E5
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:32:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeaq-0006P4-9P
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeao-0000cz-TL
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:45590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeao-0000ba-IL; Mon, 06 May 2019 10:27:46 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeal-000444-DI; Mon, 06 May 2019 17:27:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  6 May 2019 17:27:40 +0300
Message-Id: <20190506142741.41731-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 7/8] qcow2: bdrv_co_pwritev: move encryption
 code out of the lock
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Encryption will be done in threads, to take benefit of it, we should
move it out of the lock first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5954696245..cba2328005 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2169,11 +2169,20 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &cluster_offset, &l2meta);
         if (ret < 0) {
-            goto fail;
+            goto out_locked;
         }
 
         assert((cluster_offset & 511) == 0);
 
+        ret = qcow2_pre_write_overlap_check(bs, 0,
+                                            cluster_offset + offset_in_cluster,
+                                            cur_bytes, true);
+        if (ret < 0) {
+            goto out_locked;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
@@ -2185,7 +2194,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                                    * s->cluster_size);
                 if (cluster_data == NULL) {
                     ret = -ENOMEM;
-                    goto fail;
+                    goto out_unlocked;
                 }
             }
 
@@ -2200,40 +2209,34 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                       cluster_data,
                                       cur_bytes, NULL) < 0) {
                 ret = -EIO;
-                goto fail;
+                goto out_unlocked;
             }
 
             qemu_iovec_reset(&hd_qiov);
             qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
         }
 
-        ret = qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes, true);
-        if (ret < 0) {
-            goto fail;
-        }
-
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regions.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret = bdrv_co_pwritev(s->data_file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
-                goto fail;
+                goto out_unlocked;
             }
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         ret = qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
-            goto fail;
+            goto out_locked;
         }
 
         bytes -= cur_bytes;
@@ -2242,8 +2245,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
     ret = 0;
+    goto out_locked;
 
-fail:
+out_unlocked:
+    qemu_co_mutex_lock(&s->lock);
+
+out_locked:
     qcow2_handle_l2meta(bs, &l2meta, false);
 
     qemu_co_mutex_unlock(&s->lock);
-- 
2.18.0


