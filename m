Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F042C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E1820731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E1820731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLms3-0003hV-W7
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jLmrH-0002gi-LC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jLmrG-0007Vs-B9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:57:35 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:36616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jLmrD-0007SG-E5; Tue, 07 Apr 2020 07:57:31 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6532A4594C;
 Tue,  7 Apr 2020 13:57:22 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH for-5.0 v5 1/3] job: take each job's lock individually in
 job_txn_apply
Date: Tue,  7 Apr 2020 13:56:49 +0200
Message-Id: <20200407115651.69472-2-s.reiter@proxmox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407115651.69472-1-s.reiter@proxmox.com>
References: <20200407115651.69472-1-s.reiter@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, t.lamprecht@proxmox.com,
 slp@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers of job_txn_apply hold a single job's lock, but different
jobs within a transaction can have different contexts, thus we need to
lock each one individually before applying the callback function.

Similar to job_completed_txn_abort this also requires releasing the
caller's context before and reacquiring it after to avoid recursive
locks which might break AIO_WAIT_WHILE in the callback. This is safe, sin=
ce
existing code would already have to take this into account, lest
job_completed_txn_abort might have broken.

This also brings to light a different issue: When a callback function in
job_txn_apply moves it's job to a different AIO context, callers will
try to release the wrong lock (now that we re-acquire the lock
correctly, previously it would just continue with the old lock, leaving
the job unlocked for the rest of the return path). Fix this by not cachin=
g
the job's context.

This is only necessary for qmp_block_job_finalize, qmp_job_finalize and
job_exit, since everyone else calls through job_exit.

One test needed adapting, since it calls job_finalize directly, so it
manually needs to acquire the correct context.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
---
 blockdev.c            |  9 ++++++++
 job-qmp.c             |  9 ++++++++
 job.c                 | 50 ++++++++++++++++++++++++++++++++++---------
 tests/test-blockjob.c |  2 ++
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index fa8630cb41..5faddaa705 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3612,7 +3612,16 @@ void qmp_block_job_finalize(const char *id, Error =
**errp)
     }
=20
     trace_qmp_block_job_finalize(job);
+    job_ref(&job->job);
     job_finalize(&job->job, errp);
+
+    /*
+     * Job's context might have changed via job_finalize (and job_txn_ap=
ply
+     * automatically acquires the new one), so make sure we release the =
correct
+     * one.
+     */
+    aio_context =3D blk_get_aio_context(job->blk);
+    job_unref(&job->job);
     aio_context_release(aio_context);
 }
=20
diff --git a/job-qmp.c b/job-qmp.c
index fecc939ebd..f9a58832e1 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -114,7 +114,16 @@ void qmp_job_finalize(const char *id, Error **errp)
     }
=20
     trace_qmp_job_finalize(job);
+    job_ref(job);
     job_finalize(job, errp);
+
+    /*
+     * Job's context might have changed via job_finalize (and job_txn_ap=
ply
+     * automatically acquires the new one), so make sure we release the =
correct
+     * one.
+     */
+    aio_context =3D job->aio_context;
+    job_unref(job);
     aio_context_release(aio_context);
 }
=20
diff --git a/job.c b/job.c
index 134a07b92e..53be57a3a0 100644
--- a/job.c
+++ b/job.c
@@ -136,17 +136,38 @@ static void job_txn_del_job(Job *job)
     }
 }
=20
-static int job_txn_apply(JobTxn *txn, int fn(Job *))
+static int job_txn_apply(Job *job, int fn(Job *))
 {
-    Job *job, *next;
+    AioContext *inner_ctx;
+    Job *other_job, *next;
+    JobTxn *txn =3D job->txn;
     int rc =3D 0;
=20
-    QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
-        rc =3D fn(job);
+    /*
+     * Similar to job_completed_txn_abort, we take each job's lock befor=
e
+     * applying fn, but since we assume that outer_ctx is held by the ca=
ller,
+     * we need to release it here to avoid holding the lock twice - whic=
h would
+     * break AIO_WAIT_WHILE from within fn.
+     */
+    job_ref(job);
+    aio_context_release(job->aio_context);
+
+    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
+        inner_ctx =3D other_job->aio_context;
+        aio_context_acquire(inner_ctx);
+        rc =3D fn(other_job);
+        aio_context_release(inner_ctx);
         if (rc) {
             break;
         }
     }
+
+    /*
+     * Note that job->aio_context might have been changed by calling fn,=
 so we
+     * can't use a local variable to cache it.
+     */
+    aio_context_acquire(job->aio_context);
+    job_unref(job);
     return rc;
 }
=20
@@ -774,11 +795,11 @@ static void job_do_finalize(Job *job)
     assert(job && job->txn);
=20
     /* prepare the transaction to complete */
-    rc =3D job_txn_apply(job->txn, job_prepare);
+    rc =3D job_txn_apply(job, job_prepare);
     if (rc) {
         job_completed_txn_abort(job);
     } else {
-        job_txn_apply(job->txn, job_finalize_single);
+        job_txn_apply(job, job_finalize_single);
     }
 }
=20
@@ -824,10 +845,10 @@ static void job_completed_txn_success(Job *job)
         assert(other_job->ret =3D=3D 0);
     }
=20
-    job_txn_apply(txn, job_transition_to_pending);
+    job_txn_apply(job, job_transition_to_pending);
=20
     /* If no jobs need manual finalization, automatically do so */
-    if (job_txn_apply(txn, job_needs_finalize) =3D=3D 0) {
+    if (job_txn_apply(job, job_needs_finalize) =3D=3D 0) {
         job_do_finalize(job);
     }
 }
@@ -849,9 +870,10 @@ static void job_completed(Job *job)
 static void job_exit(void *opaque)
 {
     Job *job =3D (Job *)opaque;
-    AioContext *ctx =3D job->aio_context;
+    AioContext *ctx;
=20
-    aio_context_acquire(ctx);
+    job_ref(job);
+    aio_context_acquire(job->aio_context);
=20
     /* This is a lie, we're not quiescent, but still doing the completio=
n
      * callbacks. However, completion callbacks tend to involve operatio=
ns that
@@ -862,6 +884,14 @@ static void job_exit(void *opaque)
=20
     job_completed(job);
=20
+    /*
+     * Note that calling job_completed can move the job to a different
+     * aio_context, so we cannot cache from above. job_txn_apply takes c=
are of
+     * acquiring the new lock, and we ref/unref to avoid job_completed f=
reeing
+     * the job underneath us.
+     */
+    ctx =3D job->aio_context;
+    job_unref(job);
     aio_context_release(ctx);
 }
=20
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 4eeb184caf..7519847912 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -367,7 +367,9 @@ static void test_cancel_concluded(void)
     aio_poll(qemu_get_aio_context(), true);
     assert(job->status =3D=3D JOB_STATUS_PENDING);
=20
+    aio_context_acquire(job->aio_context);
     job_finalize(job, &error_abort);
+    aio_context_release(job->aio_context);
     assert(job->status =3D=3D JOB_STATUS_CONCLUDED);
=20
     cancel_common(s);
--=20
2.26.0



