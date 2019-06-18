Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210BEC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D638E214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D638E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGl3-0003MS-4F
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxe-0008Ag-14
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxX-0000oB-61
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxN-0000Tw-Lx; Tue, 18 Jun 2019 11:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 495BD308620B;
 Tue, 18 Jun 2019 15:23:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4093A5F1AE;
 Tue, 18 Jun 2019 15:23:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:06 +0200
Message-Id: <20190618152318.24953-3-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 18 Jun 2019 15:23:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/14] block/replication: drop usage of bs->job
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to remove bs->job pointer. Drop it's usage in replication
code. Additionally we have to return job pointer from some mirror APIs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 12 ++++++------
 block/mirror.c            | 38 ++++++++++++++++++++++----------------
 block/replication.c       | 21 ++++++++++++---------
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 06df2bda1b..8bb1cfb80a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1082,12 +1082,12 @@ void commit_start(const char *job_id, BlockDriver=
State *bs,
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
+                              BlockDriverState *base, int creation_flags=
,
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
@@ -1482,7 +1482,8 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
 };
=20
-static void mirror_start_job(const char *job_id, BlockDriverState *bs,
+static BlockJob *mirror_start_job(
+                             const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *targe=
t,
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
@@ -1514,7 +1515,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
=20
     if (buf_size < 0) {
         error_setg(errp, "Invalid parameter 'buf-size'");
-        return;
+        return NULL;
     }
=20
     if (buf_size =3D=3D 0) {
@@ -1523,7 +1524,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
=20
     if (bs =3D=3D target) {
         error_setg(errp, "Can't mirror node into itself");
-        return;
+        return NULL;
     }
=20
     /* In the case of active commit, add dummy driver to provide consist=
ent
@@ -1532,7 +1533,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
     mirror_top_bs =3D bdrv_new_open_driver(&bdrv_mirror_top, filter_node=
_name,
                                          BDRV_O_RDWR, errp);
     if (mirror_top_bs =3D=3D NULL) {
-        return;
+        return NULL;
     }
     if (!filter_node_name) {
         mirror_top_bs->implicit =3D true;
@@ -1554,7 +1555,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
     if (local_err) {
         bdrv_unref(mirror_top_bs);
         error_propagate(errp, local_err);
-        return;
+        return NULL;
     }
=20
     /* Make sure that the source is not resized while the job is running=
 */
@@ -1662,7 +1663,8 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
=20
     trace_mirror_start(bs, s, opaque);
     job_start(&s->common.job);
-    return;
+
+    return &s->common;
=20
 fail:
     if (s) {
@@ -1684,6 +1686,8 @@ fail:
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
=20
     bdrv_unref(mirror_top_bs);
+
+    return NULL;
 }
=20
 void mirror_start(const char *job_id, BlockDriverState *bs,
@@ -1712,25 +1716,27 @@ void mirror_start(const char *job_id, BlockDriver=
State *bs,
                      filter_node_name, true, copy_mode, errp);
 }
=20
-void commit_active_start(const char *job_id, BlockDriverState *bs,
-                         BlockDriverState *base, int creation_flags,
-                         int64_t speed, BlockdevOnError on_error,
-                         const char *filter_node_name,
-                         BlockCompletionFunc *cb, void *opaque,
-                         bool auto_complete, Error **errp)
+BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
+                              BlockDriverState *base, int creation_flags=
,
+                              int64_t speed, BlockdevOnError on_error,
+                              const char *filter_node_name,
+                              BlockCompletionFunc *cb, void *opaque,
+                              bool auto_complete, Error **errp)
 {
     bool base_read_only;
     Error *local_err =3D NULL;
+    BlockJob *ret;
=20
     base_read_only =3D bdrv_is_read_only(base);
=20
     if (base_read_only) {
         if (bdrv_reopen_set_read_only(base, false, errp) < 0) {
-            return;
+            return NULL;
         }
     }
=20
-    mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0=
,
+    ret =3D mirror_start_job(
+                     job_id, bs, creation_flags, base, NULL, speed, 0, 0=
,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_comple=
te,
@@ -1741,7 +1747,7 @@ void commit_active_start(const char *job_id, BlockD=
riverState *bs,
         goto error_restore_flags;
     }
=20
-    return;
+    return ret;
=20
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propaga=
te
@@ -1749,5 +1755,5 @@ error_restore_flags:
     if (base_read_only) {
         bdrv_reopen_set_read_only(base, true, NULL);
     }
-    return;
+    return NULL;
 }
diff --git a/block/replication.c b/block/replication.c
index 5cffb790b3..b41bc507c0 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -36,8 +36,10 @@ typedef struct BDRVReplicationState {
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
@@ -147,7 +149,7 @@ static void replication_close(BlockDriverState *bs)
         replication_stop(s->rs, false, NULL);
     }
     if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
-        job_cancel_sync(&s->active_disk->bs->job->job);
+        job_cancel_sync(&s->commit_job->job);
     }
=20
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
@@ -315,12 +317,12 @@ static void secondary_do_checkpoint(BDRVReplication=
State *s, Error **errp)
     Error *local_err =3D NULL;
     int ret;
=20
-    if (!s->secondary_disk->bs->job) {
+    if (!s->backup_job) {
         error_setg(errp, "Backup job was cancelled unexpectedly");
         return;
     }
=20
-    backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
+    backup_do_checkpoint(s->backup_job, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -449,7 +451,6 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
     int64_t active_length, hidden_length, disk_length;
     AioContext *aio_context;
     Error *local_err =3D NULL;
-    BlockJob *job;
=20
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
@@ -540,7 +541,8 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
=20
-        job =3D backup_job_create(NULL, s->secondary_disk->bs, s->hidden=
_disk->bs,
+        s->backup_job =3D backup_job_create(
+                                NULL, s->secondary_disk->bs, s->hidden_d=
isk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
@@ -551,7 +553,7 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
             aio_context_release(aio_context);
             return;
         }
-        job_start(&job->job);
+        job_start(&s->backup_job->job);
         break;
     default:
         aio_context_release(aio_context);
@@ -653,8 +655,8 @@ static void replication_stop(ReplicationState *rs, bo=
ol failover, Error **errp)
          * before the BDS is closed, because we will access hidden
          * disk, secondary disk in backup_job_completed().
          */
-        if (s->secondary_disk->bs->job) {
-            job_cancel_sync(&s->secondary_disk->bs->job->job);
+        if (s->backup_job) {
+            job_cancel_sync(&s->backup_job->job);
         }
=20
         if (!failover) {
@@ -665,7 +667,8 @@ static void replication_stop(ReplicationState *rs, bo=
ol failover, Error **errp)
         }
=20
         s->stage =3D BLOCK_REPLICATION_FAILOVER;
-        commit_active_start(NULL, s->active_disk->bs, s->secondary_disk-=
>bs,
+        s->commit_job =3D commit_active_start(
+                            NULL, s->active_disk->bs, s->secondary_disk-=
>bs,
                             JOB_INTERNAL, 0, BLOCKDEV_ON_ERROR_REPORT,
                             NULL, replication_done, bs, true, errp);
         break;
--=20
2.20.1


