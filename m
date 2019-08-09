Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CDC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 20:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 20:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwBH7-0002pw-Oo
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 16:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hwBGf-0001vJ-OI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 16:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hwBGe-00058n-LK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 16:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hwBGb-00056p-VD; Fri, 09 Aug 2019 16:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4212230A76BE;
 Fri,  9 Aug 2019 20:13:37 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8525DC1E;
 Fri,  9 Aug 2019 20:13:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 16:13:33 -0400
Message-Id: <20190809201333.29033-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 09 Aug 2019 20:13:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/backup: install notifier during creation
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Backup jobs may yield prior to installing their handler, because of the
job_co_entry shim which guarantees that a job won't begin work until
we are ready to start an entire transaction.

Unfortunately, this makes proving correctness about transactional
points-in-time for backup hard to reason about. Make it explicitly clear
by moving the handler registration to creation time, and changing the
write notifier to a no-op until the job is started.

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c     | 32 +++++++++++++++++++++++---------
 include/qemu/job.h |  5 +++++
 job.c              |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 07d751aea4..4df5b95415 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -344,6 +344,13 @@ static int coroutine_fn backup_before_write_notify(
     assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
=20
+    /* The handler is installed at creation time; the actual point-in-ti=
me
+     * starts at job_start(). Transactions guarantee those two points ar=
e
+     * the same point in time. */
+    if (!job_started(&job->common.job)) {
+        return 0;
+    }
+
     return backup_do_cow(job, req->offset, req->bytes, NULL, true);
 }
=20
@@ -398,6 +405,12 @@ static void backup_clean(Job *job)
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs =3D blk_bs(s->common.blk);
=20
+    /* cancelled before job_start: remove write_notifier */
+    if (s->before_write.notify) {
+        notifier_with_return_remove(&s->before_write);
+        s->before_write.notify =3D NULL;
+    }
+
     if (s->copy_bitmap) {
         bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
         s->copy_bitmap =3D NULL;
@@ -527,17 +540,8 @@ static void backup_init_copy_bitmap(BackupBlockJob *=
job)
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs =3D blk_bs(s->common.blk);
     int ret =3D 0;
=20
-    QLIST_INIT(&s->inflight_reqs);
-    qemu_co_rwlock_init(&s->flush_rwlock);
-
-    backup_init_copy_bitmap(s);
-
-    s->before_write.notify =3D backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
-
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
         int64_t offset =3D 0;
         int64_t count;
@@ -572,6 +576,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
=20
  out:
     notifier_with_return_remove(&s->before_write);
+    s->before_write.notify =3D NULL;
=20
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
@@ -767,6 +772,15 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
                        &error_abort);
     job->len =3D len;
=20
+    /* Finally, install a write notifier that takes effect after job_sta=
rt() */
+    backup_init_copy_bitmap(job);
+
+    QLIST_INIT(&job->inflight_reqs);
+    qemu_co_rwlock_init(&job->flush_rwlock);
+
+    job->before_write.notify =3D backup_before_write_notify;
+    bdrv_add_before_write_notifier(bs, &job->before_write);
+
     return &job->common;
=20
  error:
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9e7cd1e4a0..733afb696b 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -394,6 +394,11 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job));
  */
 void job_start(Job *job);
=20
+/**
+ * job_started returns true if the @job has started.
+ */
+bool job_started(Job *job);
+
 /**
  * @job: The job to enter.
  *
diff --git a/job.c b/job.c
index 28dd48f8a5..745af659ff 100644
--- a/job.c
+++ b/job.c
@@ -243,7 +243,7 @@ bool job_is_completed(Job *job)
     return false;
 }
=20
-static bool job_started(Job *job)
+bool job_started(Job *job)
 {
     return job->co;
 }
--=20
2.21.0


