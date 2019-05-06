Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF8C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2E720830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhQH-0005yN-Np
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:29:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhG0-0005gB-W8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFz-00053q-UM
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFx-00050R-F8; Mon, 06 May 2019 13:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1C023019888;
	Mon,  6 May 2019 17:18:24 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 876811001DC1;
	Mon,  6 May 2019 17:18:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:18:04 +0200
Message-Id: <20190506171805.14236-10-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 06 May 2019 17:18:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/10] blockjob: Remove AioContext notifiers
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

The notifiers made sure that the job is quiesced and that the
job->aio_context field is updated. The first part is unnecessary today
since bdrv_set_aio_context_ignore() drains the block node, and this
means drainig the block job, too. The second part can be done in the
.set_aio_ctx callback of the block job BdrvChildRole.

The notifiers were problematic because they poll the AioContext while
the graph is in an inconsistent state with some nodes already in the new
context, but others still in the old context. So removing the notifiers
not only simplifies the code, but actually makes the code safer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 24e6093a9c..9ca942ba01 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -81,10 +81,6 @@ BlockJob *block_job_get(const char *id)
     }
 }
=20
-static void block_job_attached_aio_context(AioContext *new_context,
-                                           void *opaque);
-static void block_job_detach_aio_context(void *opaque);
-
 void block_job_free(Job *job)
 {
     BlockJob *bjob =3D container_of(job, BlockJob, job);
@@ -92,28 +88,10 @@ void block_job_free(Job *job)
=20
     bs->job =3D NULL;
     block_job_remove_all_bdrv(bjob);
-    blk_remove_aio_context_notifier(bjob->blk,
-                                    block_job_attached_aio_context,
-                                    block_job_detach_aio_context, bjob);
     blk_unref(bjob->blk);
     error_free(bjob->blocker);
 }
=20
-static void block_job_attached_aio_context(AioContext *new_context,
-                                           void *opaque)
-{
-    BlockJob *job =3D opaque;
-    const JobDriver *drv =3D job->job.driver;
-    BlockJobDriver *bjdrv =3D container_of(drv, BlockJobDriver, job_driv=
er);
-
-    job->job.aio_context =3D new_context;
-    if (bjdrv->attached_aio_context) {
-        bjdrv->attached_aio_context(job, new_context);
-    }
-
-    job_resume(&job->job);
-}
-
 void block_job_drain(Job *job)
 {
     BlockJob *bjob =3D container_of(job, BlockJob, job);
@@ -126,23 +104,6 @@ void block_job_drain(Job *job)
     }
 }
=20
-static void block_job_detach_aio_context(void *opaque)
-{
-    BlockJob *job =3D opaque;
-
-    /* In case the job terminates during aio_poll()... */
-    job_ref(&job->job);
-
-    job_pause(&job->job);
-
-    while (!job->job.paused && !job_is_completed(&job->job)) {
-        job_drain(&job->job);
-    }
-
-    job->job.aio_context =3D NULL;
-    job_unref(&job->job);
-}
-
 static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job =3D c->opaque;
@@ -212,6 +173,8 @@ static void child_job_set_aio_ctx(BdrvChild *c, AioCo=
ntext *ctx,
         *ignore =3D g_slist_prepend(*ignore, sibling);
         bdrv_set_aio_context_ignore(sibling->bs, ctx, ignore);
     }
+
+    job->job.aio_context =3D ctx;
 }
=20
 static const BdrvChildRole child_job =3D {
@@ -471,8 +434,6 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
=20
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
=20
-    blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
-                                 block_job_detach_aio_context, job);
     blk_set_allow_aio_context_change(blk, true);
=20
     /* Only set speed when necessary to avoid NotSupported error */
--=20
2.20.1


