Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62364C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392A620830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392A620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhIX-0007K6-D9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:21:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFz-0005ej-MN
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFy-00052Y-J7
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFv-0004xs-T8; Mon, 06 May 2019 13:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B2CAC0586C1;
	Mon,  6 May 2019 17:18:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3F9A10021B1;
	Mon,  6 May 2019 17:18:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:18:03 +0200
Message-Id: <20190506171805.14236-9-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 06 May 2019 17:18:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/10] blockjob: Propagate AioContext change to
 all job nodes
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Block jobs require that all of the nodes the job is using are in the
same AioContext. Therefore all BdrvChild objects of the job propagate
.(can_)set_aio_context to all other job nodes, so that the switch is
checked and performed consistently even if both nodes are in different
subtrees.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c |  8 --------
 block/mirror.c | 10 +---------
 blockjob.c     | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 910ed764aa..916817d8b1 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -300,13 +300,6 @@ static void backup_clean(Job *job)
     s->target =3D NULL;
 }
=20
-static void backup_attached_aio_context(BlockJob *job, AioContext *aio_c=
ontext)
-{
-    BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
-
-    blk_set_aio_context(s->target, aio_context);
-}
-
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job =3D container_of(job, BackupBlockJob, com=
mon);
@@ -558,7 +551,6 @@ static const BlockJobDriver backup_job_driver =3D {
         .abort                  =3D backup_abort,
         .clean                  =3D backup_clean,
     },
-    .attached_aio_context   =3D backup_attached_aio_context,
     .drain                  =3D backup_drain,
 };
=20
diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb197..ec4bd9f404 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1142,13 +1142,6 @@ static bool mirror_drained_poll(BlockJob *job)
     return !!s->in_flight;
 }
=20
-static void mirror_attached_aio_context(BlockJob *job, AioContext *new_c=
ontext)
-{
-    MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
-
-    blk_set_aio_context(s->target, new_context);
-}
-
 static void mirror_drain(BlockJob *job)
 {
     MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
@@ -1178,7 +1171,6 @@ static const BlockJobDriver mirror_job_driver =3D {
         .complete               =3D mirror_complete,
     },
     .drained_poll           =3D mirror_drained_poll,
-    .attached_aio_context   =3D mirror_attached_aio_context,
     .drain                  =3D mirror_drain,
 };
=20
@@ -1196,7 +1188,6 @@ static const BlockJobDriver commit_active_job_drive=
r =3D {
         .complete               =3D mirror_complete,
     },
     .drained_poll           =3D mirror_drained_poll,
-    .attached_aio_context   =3D mirror_attached_aio_context,
     .drain                  =3D mirror_drain,
 };
=20
@@ -1612,6 +1603,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
          * ensure that. */
         blk_set_force_allow_inactivate(s->target);
     }
+    blk_set_allow_aio_context_change(s->target, true);
=20
     s->replaces =3D g_strdup(replaces);
     s->on_source_error =3D on_source_error;
diff --git a/blockjob.c b/blockjob.c
index 730101d282..24e6093a9c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -183,11 +183,44 @@ static void child_job_drained_end(BdrvChild *c)
     job_resume(&job->job);
 }
=20
+static bool child_job_can_set_aio_ctx(BdrvChild *c, AioContext *ctx,
+                                      GSList **ignore, Error **errp)
+{
+    BlockJob *job =3D c->opaque;
+    GSList *l;
+
+    for (l =3D job->nodes; l; l =3D l->next) {
+        BdrvChild *sibling =3D l->data;
+        if (!bdrv_child_can_set_aio_context(sibling, ctx, ignore, errp))=
 {
+            return false;
+        }
+    }
+    return true;
+}
+
+static void child_job_set_aio_ctx(BdrvChild *c, AioContext *ctx,
+                                  GSList **ignore)
+{
+    BlockJob *job =3D c->opaque;
+    GSList *l;
+
+    for (l =3D job->nodes; l; l =3D l->next) {
+        BdrvChild *sibling =3D l->data;
+        if (g_slist_find(*ignore, sibling)) {
+            continue;
+        }
+        *ignore =3D g_slist_prepend(*ignore, sibling);
+        bdrv_set_aio_context_ignore(sibling->bs, ctx, ignore);
+    }
+}
+
 static const BdrvChildRole child_job =3D {
     .get_parent_desc    =3D child_job_get_parent_desc,
     .drained_begin      =3D child_job_drained_begin,
     .drained_poll       =3D child_job_drained_poll,
     .drained_end        =3D child_job_drained_end,
+    .can_set_aio_ctx    =3D child_job_can_set_aio_ctx,
+    .set_aio_ctx        =3D child_job_set_aio_ctx,
     .stay_at_node       =3D true,
 };
=20
@@ -440,6 +473,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
=20
     blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
                                  block_job_detach_aio_context, job);
+    blk_set_allow_aio_context_change(blk, true);
=20
     /* Only set speed when necessary to avoid NotSupported error */
     if (speed !=3D 0) {
--=20
2.20.1


