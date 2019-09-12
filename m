Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13251C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6E2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PX9-0001TM-7M
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQa-0002bE-NK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQY-0001IJ-F0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQT-0001Ek-RY; Thu, 12 Sep 2019 09:46:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39DA981DE0;
 Thu, 12 Sep 2019 13:46:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9C3C600C4;
 Thu, 12 Sep 2019 13:46:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:44 +0200
Message-Id: <20190912134604.22019-3-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 12 Sep 2019 13:46:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/22] job: drop job_drain
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In job_finish_sync job_enter should be enough for a job to make some
progress and draining is a wrong tool for it. So use job_enter directly
here and drop job_drain with all related staff not used more.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h | 19 -------------------
 include/qemu/job.h           | 13 -------------
 block/backup.c               | 19 +------------------
 block/commit.c               |  1 -
 block/mirror.c               | 28 +++-------------------------
 block/stream.c               |  1 -
 blockjob.c                   | 13 -------------
 job.c                        | 12 +-----------
 tests/test-bdrv-drain.c      |  3 ---
 tests/test-block-iothread.c  |  1 -
 tests/test-blockjob-txn.c    |  1 -
 tests/test-blockjob.c        |  2 --
 12 files changed, 5 insertions(+), 108 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e4a318dd15..e2824a36a8 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -52,17 +52,6 @@ struct BlockJobDriver {
      * besides job->blk to the new AioContext.
      */
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context)=
;
-
-    /*
-     * If the callback is not NULL, it will be invoked when the job has =
to be
-     * synchronously cancelled or completed; it should drain BlockDriver=
States
-     * as required to ensure progress.
-     *
-     * Block jobs must use the default implementation for job_driver.dra=
in,
-     * which will in turn call this callback after doing generic block j=
ob
-     * stuff.
-     */
-    void (*drain)(BlockJob *job);
 };
=20
 /**
@@ -107,14 +96,6 @@ void block_job_free(Job *job);
  */
 void block_job_user_resume(Job *job);
=20
-/**
- * block_job_drain:
- * Callback to be used for JobDriver.drain in all block jobs. Drains the=
 main
- * block node associated with the block jobs and calls BlockJobDriver.dr=
ain for
- * job-specific actions.
- */
-void block_job_drain(Job *job);
-
 /**
  * block_job_ratelimit_get_delay:
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 73c67d3175..bd59cd8944 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -220,13 +220,6 @@ struct JobDriver {
      */
     void (*complete)(Job *job, Error **errp);
=20
-    /*
-     * If the callback is not NULL, it will be invoked when the job has =
to be
-     * synchronously cancelled or completed; it should drain any activit=
ies
-     * as required to ensure progress.
-     */
-    void (*drain)(Job *job);
-
     /**
      * If the callback is not NULL, prepare will be invoked when all the=
 jobs
      * belonging to the same transaction complete; or upon this job's co=
mpletion
@@ -470,12 +463,6 @@ bool job_user_paused(Job *job);
  */
 void job_user_resume(Job *job, Error **errp);
=20
-/*
- * Drain any activities as required to ensure progress. This can be call=
ed in a
- * loop to synchronously complete a job.
- */
-void job_drain(Job *job);
-
 /**
  * Get the next element from the list of block jobs after @job, or the
  * first one if @job is %NULL.
diff --git a/block/backup.c b/block/backup.c
index 03637aeb11..763f0d7ff6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -425,21 +425,6 @@ void backup_do_checkpoint(BlockJob *job, Error **err=
p)
     bdrv_set_dirty_bitmap(backup_job->copy_bitmap, 0, backup_job->len);
 }
=20
-static void backup_drain(BlockJob *job)
-{
-    BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
-
-    /* Need to keep a reference in case blk_drain triggers execution
-     * of backup_complete...
-     */
-    if (s->target) {
-        BlockBackend *target =3D s->target;
-        blk_ref(target);
-        blk_drain(target);
-        blk_unref(target);
-    }
-}
-
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
                                             bool read, int error)
 {
@@ -588,13 +573,11 @@ static const BlockJobDriver backup_job_driver =3D {
         .job_type               =3D JOB_TYPE_BACKUP,
         .free                   =3D block_job_free,
         .user_resume            =3D block_job_user_resume,
-        .drain                  =3D block_job_drain,
         .run                    =3D backup_run,
         .commit                 =3D backup_commit,
         .abort                  =3D backup_abort,
         .clean                  =3D backup_clean,
-    },
-    .drain                  =3D backup_drain,
+    }
 };
=20
 static int64_t backup_calculate_cluster_size(BlockDriverState *target,
diff --git a/block/commit.c b/block/commit.c
index 408ae15389..bc8454463d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -216,7 +216,6 @@ static const BlockJobDriver commit_job_driver =3D {
         .job_type      =3D JOB_TYPE_COMMIT,
         .free          =3D block_job_free,
         .user_resume   =3D block_job_user_resume,
-        .drain         =3D block_job_drain,
         .run           =3D commit_run,
         .prepare       =3D commit_prepare,
         .abort         =3D commit_abort,
diff --git a/block/mirror.c b/block/mirror.c
index 853e2c7510..fe984efb90 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -646,14 +646,11 @@ static int mirror_exit_common(Job *job)
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
=20
-    /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
+    /*
+     * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
      * inserting target_bs at s->to_replace, where we might not be able =
to get
      * these permissions.
-     *
-     * Note that blk_unref() alone doesn't necessarily drop permissions =
because
-     * we might be running nested inside mirror_drain(), which takes an =
extra
-     * reference, so use an explicit blk_set_perm() first. */
-    blk_set_perm(s->target, 0, BLK_PERM_ALL, &error_abort);
+     */
     blk_unref(s->target);
     s->target =3D NULL;
=20
@@ -1149,28 +1146,12 @@ static bool mirror_drained_poll(BlockJob *job)
     return !!s->in_flight;
 }
=20
-static void mirror_drain(BlockJob *job)
-{
-    MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
-
-    /* Need to keep a reference in case blk_drain triggers execution
-     * of mirror_complete...
-     */
-    if (s->target) {
-        BlockBackend *target =3D s->target;
-        blk_ref(target);
-        blk_drain(target);
-        blk_unref(target);
-    }
-}
-
 static const BlockJobDriver mirror_job_driver =3D {
     .job_driver =3D {
         .instance_size          =3D sizeof(MirrorBlockJob),
         .job_type               =3D JOB_TYPE_MIRROR,
         .free                   =3D block_job_free,
         .user_resume            =3D block_job_user_resume,
-        .drain                  =3D block_job_drain,
         .run                    =3D mirror_run,
         .prepare                =3D mirror_prepare,
         .abort                  =3D mirror_abort,
@@ -1178,7 +1159,6 @@ static const BlockJobDriver mirror_job_driver =3D {
         .complete               =3D mirror_complete,
     },
     .drained_poll           =3D mirror_drained_poll,
-    .drain                  =3D mirror_drain,
 };
=20
 static const BlockJobDriver commit_active_job_driver =3D {
@@ -1187,7 +1167,6 @@ static const BlockJobDriver commit_active_job_drive=
r =3D {
         .job_type               =3D JOB_TYPE_COMMIT,
         .free                   =3D block_job_free,
         .user_resume            =3D block_job_user_resume,
-        .drain                  =3D block_job_drain,
         .run                    =3D mirror_run,
         .prepare                =3D mirror_prepare,
         .abort                  =3D mirror_abort,
@@ -1195,7 +1174,6 @@ static const BlockJobDriver commit_active_job_drive=
r =3D {
         .complete               =3D mirror_complete,
     },
     .drained_poll           =3D mirror_drained_poll,
-    .drain                  =3D mirror_drain,
 };
=20
 static void coroutine_fn
diff --git a/block/stream.c b/block/stream.c
index 0d3a6ac7c3..5562ccbf57 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -212,7 +212,6 @@ static const BlockJobDriver stream_job_driver =3D {
         .abort         =3D stream_abort,
         .clean         =3D stream_clean,
         .user_resume   =3D block_job_user_resume,
-        .drain         =3D block_job_drain,
     },
 };
=20
diff --git a/blockjob.c b/blockjob.c
index 6e32d1a0c0..2abed0f551 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -90,18 +90,6 @@ void block_job_free(Job *job)
     error_free(bjob->blocker);
 }
=20
-void block_job_drain(Job *job)
-{
-    BlockJob *bjob =3D container_of(job, BlockJob, job);
-    const JobDriver *drv =3D job->driver;
-    BlockJobDriver *bjdrv =3D container_of(drv, BlockJobDriver, job_driv=
er);
-
-    blk_drain(bjob->blk);
-    if (bjdrv->drain) {
-        bjdrv->drain(bjob);
-    }
-}
-
 static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job =3D c->opaque;
@@ -422,7 +410,6 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
     assert(is_block_job(&job->job));
     assert(job->job.driver->free =3D=3D &block_job_free);
     assert(job->job.driver->user_resume =3D=3D &block_job_user_resume);
-    assert(job->job.driver->drain =3D=3D &block_job_drain);
=20
     job->blk =3D blk;
=20
diff --git a/job.c b/job.c
index 28dd48f8a5..04409b40aa 100644
--- a/job.c
+++ b/job.c
@@ -523,16 +523,6 @@ void coroutine_fn job_sleep_ns(Job *job, int64_t ns)
     job_pause_point(job);
 }
=20
-void job_drain(Job *job)
-{
-    /* If job is !busy this kicks it into the next pause point. */
-    job_enter(job);
-
-    if (job->driver->drain) {
-        job->driver->drain(job);
-    }
-}
-
 /* Assumes the block_job_mutex is held */
 static bool job_timer_not_pending(Job *job)
 {
@@ -991,7 +981,7 @@ int job_finish_sync(Job *job, void (*finish)(Job *, E=
rror **errp), Error **errp)
     }
=20
     AIO_WAIT_WHILE(job->aio_context,
-                   (job_drain(job), !job_is_completed(job)));
+                   (job_enter(job), !job_is_completed(job)));
=20
     ret =3D (job_is_cancelled(job) && job->ret =3D=3D 0) ? -ECANCELED : =
job->ret;
     job_unref(job);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 374bef6bb2..fa0e6a648b 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -848,7 +848,6 @@ BlockJobDriver test_job_driver =3D {
         .instance_size  =3D sizeof(TestBlockJob),
         .free           =3D block_job_free,
         .user_resume    =3D block_job_user_resume,
-        .drain          =3D block_job_drain,
         .run            =3D test_job_run,
         .complete       =3D test_job_complete,
         .prepare        =3D test_job_prepare,
@@ -1574,7 +1573,6 @@ static const BlockJobDriver test_drop_backing_job_d=
river =3D {
         .instance_size  =3D sizeof(TestDropBackingBlockJob),
         .free           =3D block_job_free,
         .user_resume    =3D block_job_user_resume,
-        .drain          =3D block_job_drain,
         .run            =3D test_drop_backing_job_run,
         .commit         =3D test_drop_backing_job_commit,
     }
@@ -1711,7 +1709,6 @@ static const BlockJobDriver test_simple_job_driver =
=3D {
         .instance_size  =3D sizeof(TestSimpleBlockJob),
         .free           =3D block_job_free,
         .user_resume    =3D block_job_user_resume,
-        .drain          =3D block_job_drain,
         .run            =3D test_simple_job_run,
         .clean          =3D test_simple_job_clean,
     },
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 926577b1f9..cfe30bab21 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -401,7 +401,6 @@ BlockJobDriver test_job_driver =3D {
         .instance_size  =3D sizeof(TestBlockJob),
         .free           =3D block_job_free,
         .user_resume    =3D block_job_user_resume,
-        .drain          =3D block_job_drain,
         .run            =3D test_job_run,
         .complete       =3D test_job_complete,
         .prepare        =3D test_job_prepare,
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 7da9216d5b..8bd13b9949 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -72,7 +72,6 @@ static const BlockJobDriver test_block_job_driver =3D {
         .instance_size =3D sizeof(TestBlockJob),
         .free          =3D block_job_free,
         .user_resume   =3D block_job_user_resume,
-        .drain         =3D block_job_drain,
         .run           =3D test_block_job_run,
         .clean         =3D test_block_job_clean,
     },
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 68a0819495..7844c9ffcb 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -22,7 +22,6 @@ static const BlockJobDriver test_block_job_driver =3D {
         .instance_size =3D sizeof(BlockJob),
         .free          =3D block_job_free,
         .user_resume   =3D block_job_user_resume,
-        .drain         =3D block_job_drain,
     },
 };
=20
@@ -196,7 +195,6 @@ static const BlockJobDriver test_cancel_driver =3D {
         .instance_size =3D sizeof(CancelJob),
         .free          =3D block_job_free,
         .user_resume   =3D block_job_user_resume,
-        .drain         =3D block_job_drain,
         .run           =3D cancel_job_run,
         .complete      =3D cancel_job_complete,
     },
--=20
2.20.1


