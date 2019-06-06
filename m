Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D69DC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15758206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15758206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuce-0005dy-6i
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:48:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWL-0000W7-2k
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWJ-0004aW-EM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:50222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWJ-0004X5-6r; Thu, 06 Jun 2019 11:41:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWC-0000xX-L1; Thu, 06 Jun 2019 18:41:32 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu,  6 Jun 2019 18:41:29 +0300
Message-Id: <20190606154132.153330-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606154132.153330-1-vsementsov@virtuozzo.com>
References: <20190606154132.153330-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/4] block/replication: drop usage of bs->job
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, armbru@redhat.com, mreitz@redhat.com,
	den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to remove bs->job pointer. Drop it's usage in replication
code. Additionally we have to return job pointer from some mirror APIs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 12 ++++++------
 block/mirror.c            | 38 ++++++++++++++++++++++----------------
 block/replication.c       | 21 ++++++++++++---------
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 06df2bda1b..8bb1cfb80a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1082,12 +1082,12 @@ void commit_start(const char *job_id, BlockDriverState *bs,
  * @errp: Error object.
  *
  */
-void commit_active_start(const char *job_id, BlockDriverState *bs,
-                         BlockDriverState *base, int creation_flags,
-                         int64_t speed, BlockdevOnError on_error,
-                         const char *filter_node_name,
-                         BlockCompletionFunc *cb, void *opaque,
-                         bool auto_complete, Error **errp);
+BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
+                              BlockDriverState *base, int creation_flags,
+                              int64_t speed, BlockdevOnError on_error,
+                              const char *filter_node_name,
+                              BlockCompletionFunc *cb, void *opaque,
+                              bool auto_complete, Error **errp);
 /*
  * mirror_start:
  * @job_id: The id of the newly-created job, or %NULL to use the
diff --git a/block/mirror.c b/block/mirror.c
index f8bdb5b21b..b5878ba574 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1482,7 +1482,8 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
 };
 
-static void mirror_start_job(const char *job_id, BlockDriverState *bs,
+static BlockJob *mirror_start_job(
+                             const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
@@ -1514,7 +1515,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     if (buf_size < 0) {
         error_setg(errp, "Invalid parameter 'buf-size'");
-        return;
+        return NULL;
     }
 
     if (buf_size == 0) {
@@ -1523,7 +1524,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     if (bs == target) {
         error_setg(errp, "Can't mirror node into itself");
-        return;
+        return NULL;
     }
 
     /* In the case of active commit, add dummy driver to provide consistent
@@ -1532,7 +1533,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
                                          BDRV_O_RDWR, errp);
     if (mirror_top_bs == NULL) {
-        return;
+        return NULL;
     }
     if (!filter_node_name) {
         mirror_top_bs->implicit = true;
@@ -1554,7 +1555,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (local_err) {
         bdrv_unref(mirror_top_bs);
         error_propagate(errp, local_err);
-        return;
+        return NULL;
     }
 
     /* Make sure that the source is not resized while the job is running */
@@ -1662,7 +1663,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     trace_mirror_start(bs, s, opaque);
     job_start(&s->common.job);
-    return;
+
+    return &s->common;
 
 fail:
     if (s) {
@@ -1684,6 +1686,8 @@ fail:
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 
     bdrv_unref(mirror_top_bs);
+
+    return NULL;
 }
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
@@ -1712,25 +1716,27 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      filter_node_name, true, copy_mode, errp);
 }
 
-void commit_active_start(const char *job_id, BlockDriverState *bs,
-                         BlockDriverState *base, int creation_flags,
-                         int64_t speed, BlockdevOnError on_error,
-                         const char *filter_node_name,
-                         BlockCompletionFunc *cb, void *opaque,
-                         bool auto_complete, Error **errp)
+BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
+                              BlockDriverState *base, int creation_flags,
+                              int64_t speed, BlockdevOnError on_error,
+                              const char *filter_node_name,
+                              BlockCompletionFunc *cb, void *opaque,
+                              bool auto_complete, Error **errp)
 {
     bool base_read_only;
     Error *local_err = NULL;
+    BlockJob *ret;
 
     base_read_only = bdrv_is_read_only(base);
 
     if (base_read_only) {
         if (bdrv_reopen_set_read_only(base, false, errp) < 0) {
-            return;
+            return NULL;
         }
     }
 
-    mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
+    ret = mirror_start_job(
+                     job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
@@ -1741,7 +1747,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
         goto error_restore_flags;
     }
 
-    return;
+    return ret;
 
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propagate
@@ -1749,5 +1755,5 @@ error_restore_flags:
     if (base_read_only) {
         bdrv_reopen_set_read_only(base, true, NULL);
     }
-    return;
+    return NULL;
 }
diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..507512c290 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -35,8 +35,10 @@ typedef struct BDRVReplicationState {
     ReplicationMode mode;
     ReplicationStage stage;
     BdrvChild *active_disk;
+    BlockJob *commit_job;
     BdrvChild *hidden_disk;
     BdrvChild *secondary_disk;
+    BlockJob *backup_job;
     char *top_id;
     ReplicationState *rs;
     Error *blocker;
@@ -146,7 +148,7 @@ static void replication_close(BlockDriverState *bs)
         replication_stop(s->rs, false, NULL);
     }
     if (s->stage == BLOCK_REPLICATION_FAILOVER) {
-        job_cancel_sync(&s->active_disk->bs->job->job);
+        job_cancel_sync(&s->commit_job->job);
     }
 
     if (s->mode == REPLICATION_MODE_SECONDARY) {
@@ -314,12 +316,12 @@ static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
     Error *local_err = NULL;
     int ret;
 
-    if (!s->secondary_disk->bs->job) {
+    if (!s->backup_job) {
         error_setg(errp, "Backup job was cancelled unexpectedly");
         return;
     }
 
-    backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
+    backup_do_checkpoint(s->backup_job, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -448,7 +450,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     int64_t active_length, hidden_length, disk_length;
     AioContext *aio_context;
     Error *local_err = NULL;
-    BlockJob *job;
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
@@ -539,7 +540,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
-        job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
+        s->backup_job = backup_job_create(
+                                NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
@@ -550,7 +552,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             aio_context_release(aio_context);
             return;
         }
-        job_start(&job->job);
+        job_start(&s->backup_job->job);
         break;
     default:
         aio_context_release(aio_context);
@@ -652,8 +654,8 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
          * before the BDS is closed, because we will access hidden
          * disk, secondary disk in backup_job_completed().
          */
-        if (s->secondary_disk->bs->job) {
-            job_cancel_sync(&s->secondary_disk->bs->job->job);
+        if (s->backup_job) {
+            job_cancel_sync(&s->backup_job->job);
         }
 
         if (!failover) {
@@ -664,7 +666,8 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
         }
 
         s->stage = BLOCK_REPLICATION_FAILOVER;
-        commit_active_start(NULL, s->active_disk->bs, s->secondary_disk->bs,
+        s->commit_job = commit_active_start(
+                            NULL, s->active_disk->bs, s->secondary_disk->bs,
                             JOB_INTERNAL, 0, BLOCKDEV_ON_ERROR_REPORT,
                             NULL, replication_done, bs, true, errp);
         break;
-- 
2.18.0


