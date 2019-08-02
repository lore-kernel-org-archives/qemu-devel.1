Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0264DC41514
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D512321726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512321726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUFN-0000Bo-0k
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htUEx-00088s-Qn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htUEw-0001WH-HF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:52:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:50418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htUEt-0001Uq-NX; Fri, 02 Aug 2019 05:52:43 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1htUEq-0006c4-5d; Fri, 02 Aug 2019 12:52:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri,  2 Aug 2019 12:52:39 +0300
Message-Id: <20190802095239.31975-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4] blockjob: drain all job nodes in
 block_job_drain
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of draining additional nodes in each job code, let's do it in
common block_job_drain, draining just all job's children.
BlockJobDriver.drain becomes unused, so, drop it at all.

It's also a first step to finally get rid of blockjob->blk.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v4: keep ref/unref around job nodes draining [John, Max]

v3: just resend, as I've some auto returned mails and not sure that
    v2 reached recipients.

v2: apply Max's suggestions:
 - drop BlockJobDriver.drain
 - do firtly loop of bdrv_drained_begin and then separate loop
   of bdrv_drained_end.

   Hmm, a question here: should I call bdrv_drained_end in reverse
   order? Or it's OK as is?

 include/block/blockjob_int.h | 11 -----------
 block/backup.c               | 18 +-----------------
 block/mirror.c               | 26 +++-----------------------
 blockjob.c                   | 22 +++++++++++++++++-----
 4 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e4a318dd15..e1abf4ee85 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -52,17 +52,6 @@ struct BlockJobDriver {
      * besides job->blk to the new AioContext.
      */
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
-
-    /*
-     * If the callback is not NULL, it will be invoked when the job has to be
-     * synchronously cancelled or completed; it should drain BlockDriverStates
-     * as required to ensure progress.
-     *
-     * Block jobs must use the default implementation for job_driver.drain,
-     * which will in turn call this callback after doing generic block job
-     * stuff.
-     */
-    void (*drain)(BlockJob *job);
 };
 
 /**
diff --git a/block/backup.c b/block/backup.c
index 715e1d3be8..7930004bbd 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -320,21 +320,6 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
     hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
 }
 
-static void backup_drain(BlockJob *job)
-{
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
-
-    /* Need to keep a reference in case blk_drain triggers execution
-     * of backup_complete...
-     */
-    if (s->target) {
-        BlockBackend *target = s->target;
-        blk_ref(target);
-        blk_drain(target);
-        blk_unref(target);
-    }
-}
-
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
                                             bool read, int error)
 {
@@ -493,8 +478,7 @@ static const BlockJobDriver backup_job_driver = {
         .commit                 = backup_commit,
         .abort                  = backup_abort,
         .clean                  = backup_clean,
-    },
-    .drain                  = backup_drain,
+    }
 };
 
 static int64_t backup_calculate_cluster_size(BlockDriverState *target,
diff --git a/block/mirror.c b/block/mirror.c
index 8cb75fb409..8456ccd89d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -644,14 +644,11 @@ static int mirror_exit_common(Job *job)
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
 
-    /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
+    /*
+     * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
      * inserting target_bs at s->to_replace, where we might not be able to get
      * these permissions.
-     *
-     * Note that blk_unref() alone doesn't necessarily drop permissions because
-     * we might be running nested inside mirror_drain(), which takes an extra
-     * reference, so use an explicit blk_set_perm() first. */
-    blk_set_perm(s->target, 0, BLK_PERM_ALL, &error_abort);
+     */
     blk_unref(s->target);
     s->target = NULL;
 
@@ -1143,21 +1140,6 @@ static bool mirror_drained_poll(BlockJob *job)
     return !!s->in_flight;
 }
 
-static void mirror_drain(BlockJob *job)
-{
-    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
-
-    /* Need to keep a reference in case blk_drain triggers execution
-     * of mirror_complete...
-     */
-    if (s->target) {
-        BlockBackend *target = s->target;
-        blk_ref(target);
-        blk_drain(target);
-        blk_unref(target);
-    }
-}
-
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1172,7 +1154,6 @@ static const BlockJobDriver mirror_job_driver = {
         .complete               = mirror_complete,
     },
     .drained_poll           = mirror_drained_poll,
-    .drain                  = mirror_drain,
 };
 
 static const BlockJobDriver commit_active_job_driver = {
@@ -1189,7 +1170,6 @@ static const BlockJobDriver commit_active_job_driver = {
         .complete               = mirror_complete,
     },
     .drained_poll           = mirror_drained_poll,
-    .drain                  = mirror_drain,
 };
 
 static void coroutine_fn
diff --git a/blockjob.c b/blockjob.c
index 20b7f557da..f64ee3197b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -92,13 +92,25 @@ void block_job_free(Job *job)
 void block_job_drain(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
-    const JobDriver *drv = job->driver;
-    BlockJobDriver *bjdrv = container_of(drv, BlockJobDriver, job_driver);
+    GSList *nodes = NULL, *el;
 
-    blk_drain(bjob->blk);
-    if (bjdrv->drain) {
-        bjdrv->drain(bjob);
+    for (el = bjob->nodes; el; el = el->next) {
+        BdrvChild *c = el->data;
+        bdrv_ref(c->bs);
+        nodes = g_slist_prepend(nodes, c->bs);
+    }
+
+    for (el = nodes; el; el = el->next) {
+        BlockDriverState *bs = el->data;
+        bdrv_drained_begin(bs);
     }
+    for (el = nodes; el; el = el->next) {
+        BlockDriverState *bs = el->data;
+        bdrv_drained_end(bs);
+        bdrv_unref(bs);
+    }
+
+    g_slist_free(nodes);
 }
 
 static char *child_job_get_parent_desc(BdrvChild *c)
-- 
2.18.0


