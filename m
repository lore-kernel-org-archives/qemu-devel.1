Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2711C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD0A2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWwTvCr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD0A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpEq-0007c8-W3
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLpBW-0000DU-Mj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLpBV-0006pt-11
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLpBU-0006ph-UF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Di/0Ulxs+DFaG/gRoBnixZvLnKJOghe6DMG+e1zNHQg=;
 b=JWwTvCr/NOgMpt/mGvWpsQqd/tMtMBzPntuSMcX62FZBRCyAZQ/BY429TUSRtDupCOVcOW
 wgUbfgOa031krYJSxvjxKlUwoA3+M/U1P07y6O7YYrMgVe85XSby/K9NLhK3ZODLDnVTz3
 04yLmm15lJ0+IXH7RuLYYp8iB7FPtvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-AVQFkkjkNnGduwTl-hT9KA-1; Tue, 07 Apr 2020 10:26:32 -0400
X-MC-Unique: AVQFkkjkNnGduwTl-hT9KA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC841005509;
 Tue,  7 Apr 2020 14:26:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 613785DA60;
 Tue,  7 Apr 2020 14:26:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/7] job: take each job's lock individually in job_txn_apply
Date: Tue,  7 Apr 2020 16:26:10 +0200
Message-Id: <20200407142616.7961-2-kwolf@redhat.com>
In-Reply-To: <20200407142616.7961-1-kwolf@redhat.com>
References: <20200407142616.7961-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Stefan Reiter <s.reiter@proxmox.com>

All callers of job_txn_apply hold a single job's lock, but different
jobs within a transaction can have different contexts, thus we need to
lock each one individually before applying the callback function.

Similar to job_completed_txn_abort this also requires releasing the
caller's context before and reacquiring it after to avoid recursive
locks which might break AIO_WAIT_WHILE in the callback. This is safe, since
existing code would already have to take this into account, lest
job_completed_txn_abort might have broken.

This also brings to light a different issue: When a callback function in
job_txn_apply moves it's job to a different AIO context, callers will
try to release the wrong lock (now that we re-acquire the lock
correctly, previously it would just continue with the old lock, leaving
the job unlocked for the rest of the return path). Fix this by not caching
the job's context.

This is only necessary for qmp_block_job_finalize, qmp_job_finalize and
job_exit, since everyone else calls through job_exit.

One test needed adapting, since it calls job_finalize directly, so it
manually needs to acquire the correct context.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
Message-Id: <20200407115651.69472-2-s.reiter@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
@@ -3612,7 +3612,16 @@ void qmp_block_job_finalize(const char *id, Error **=
errp)
     }
=20
     trace_qmp_block_job_finalize(job);
+    job_ref(&job->job);
     job_finalize(&job->job, errp);
+
+    /*
+     * Job's context might have changed via job_finalize (and job_txn_appl=
y
+     * automatically acquires the new one), so make sure we release the co=
rrect
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
+     * Job's context might have changed via job_finalize (and job_txn_appl=
y
+     * automatically acquires the new one), so make sure we release the co=
rrect
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
+     * Similar to job_completed_txn_abort, we take each job's lock before
+     * applying fn, but since we assume that outer_ctx is held by the call=
er,
+     * we need to release it here to avoid holding the lock twice - which =
would
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
+     * Note that job->aio_context might have been changed by calling fn, s=
o we
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
     /* This is a lie, we're not quiescent, but still doing the completion
      * callbacks. However, completion callbacks tend to involve operations=
 that
@@ -862,6 +884,14 @@ static void job_exit(void *opaque)
=20
     job_completed(job);
=20
+    /*
+     * Note that calling job_completed can move the job to a different
+     * aio_context, so we cannot cache from above. job_txn_apply takes car=
e of
+     * acquiring the new lock, and we ref/unref to avoid job_completed fre=
eing
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
2.20.1


