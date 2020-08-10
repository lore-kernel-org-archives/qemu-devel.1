Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE72C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737912083B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737912083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Bi-0007aV-Lb
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k59Ay-0006Vf-Ur; Mon, 10 Aug 2020 10:53:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4173 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k59Aw-0002ik-Ju; Mon, 10 Aug 2020 10:53:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A943CC12641990921B60;
 Mon, 10 Aug 2020 22:53:07 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.173) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 22:53:01 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
Subject: [PATCH v1 2/2] qmp: use aio_context_acquire_timeout replace
 aio_context_acquire
Date: Mon, 10 Aug 2020 22:52:46 +0800
Message-ID: <20200810145246.1049-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200810145246.1049-1-yezhenyu2@huawei.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 10:53:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, yezhenyu2@huawei.com, armbru@redhat.com,
 xiexiangyou@huawei.com, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before doing qmp actions, we need to lock the qemu_global_mutex,
so the qmp actions should not take too long time.

Unfortunately, some qmp actions need to acquire aio context and
this may take a long time.  So replace aio_context_acquire()
by aio_context_acquire_timeout() and return ETIMEDOUT if the
waiting time exceeds LOCK_TIMEOUT (default set to 3 seconds).

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 block/qapi-sysemu.c |  7 ++++++-
 block/qapi.c        |  6 +++++-
 blockdev.c          | 35 ++++++++++++++++++++++++++++++-----
 include/block/aio.h |  1 +
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index 8498402ad4..e7cd7d3c70 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -439,6 +439,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    int ret;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -448,7 +449,11 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     }
 
     aio_context = blk_get_aio_context(blk);
-    aio_context_acquire(aio_context);
+    ret = aio_context_acquire_timeout(aio_context, LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     bs = blk_bs(blk);
     if (!bs) {
diff --git a/block/qapi.c b/block/qapi.c
index afd9f3b4a7..ff2454daff 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -271,7 +271,11 @@ void bdrv_query_image_info(BlockDriverState *bs,
     Error *err = NULL;
     ImageInfo *info;
 
-    aio_context_acquire(bdrv_get_aio_context(bs));
+    ret = aio_context_acquire_timeout(bdrv_get_aio_context(bs), LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     size = bdrv_getlength(bs);
     if (size < 0) {
diff --git a/blockdev.c b/blockdev.c
index 3848a9c8ab..ce133c89e2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2431,6 +2431,7 @@ void qmp_block_resize(bool has_device, const char *device,
     BlockBackend *blk = NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
+    int ret;
 
     bs = bdrv_lookup_bs(has_device ? device : NULL,
                         has_node_name ? node_name : NULL,
@@ -2441,7 +2442,11 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
     aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
+    ret = aio_context_acquire_timeout(aio_context, LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     if (size < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 size");
@@ -3016,7 +3021,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }
 
     aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
+    ret = aio_context_acquire_timeout(aio_context, LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     if (!arg->has_mode) {
         arg->mode = NEW_IMAGE_MODE_ABSOLUTE_PATHS;
@@ -3184,12 +3193,20 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     /* Honor bdrv_try_set_aio_context() context acquisition requirements. */
     old_context = bdrv_get_aio_context(target_bs);
     aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(old_context);
+    ret = aio_context_acquire_timeout(old_context, LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     ret = bdrv_try_set_aio_context(target_bs, aio_context, errp);
 
     aio_context_release(old_context);
-    aio_context_acquire(aio_context);
+    ret = aio_context_acquire_timeout(aio_context, LOCK_TIMEOUT);
+    if (ret) {
+        error_setg_errno(errp, ret, "acquire aio context failed");
+        return;
+    }
 
     if (ret < 0) {
         goto out;
@@ -3603,6 +3620,7 @@ BlockJobInfoList *qmp_query_block_jobs(Error **errp)
 {
     BlockJobInfoList *head = NULL, **p_next = &head;
     BlockJob *job;
+    int ret;
 
     for (job = block_job_next(NULL); job; job = block_job_next(job)) {
         BlockJobInfoList *elem;
@@ -3613,7 +3631,14 @@ BlockJobInfoList *qmp_query_block_jobs(Error **errp)
         }
         elem = g_new0(BlockJobInfoList, 1);
         aio_context = blk_get_aio_context(job->blk);
-        aio_context_acquire(aio_context);
+        ret = aio_context_acquire_timeout(aio_context, LOCK_TIMEOUT);
+        if (ret) {
+            g_free(elem);
+            qapi_free_BlockJobInfoList(head);
+            error_setg_errno(errp, ret, "acquire aio context failed");
+            return NULL;
+        }
+
         elem->value = block_job_query(job, errp);
         aio_context_release(aio_context);
         if (!elem->value) {
diff --git a/include/block/aio.h b/include/block/aio.h
index cb178cdf5a..539096f547 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -290,6 +290,7 @@ void aio_context_acquire(AioContext *ctx);
 /* Add timeout to aio_context_acquire().  If the time for obtaining
  * the lock exceeds @t, return ETIMEDOUT.
  */
+#define LOCK_TIMEOUT  3
 int aio_context_acquire_timeout(AioContext *ctx, int t);
 
 /* Relinquish ownership of the AioContext. */
-- 
2.22.0.windows.1



