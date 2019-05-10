Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0671CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA4F2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA4F2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Ey-0005wc-2N
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:19:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8CU-0004J4-25
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8CT-0008RD-28
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8CQ-0008Lz-G9; Fri, 10 May 2019 12:16:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC36E83F44;
	Fri, 10 May 2019 16:16:41 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7E6317791;
	Fri, 10 May 2019 16:16:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:16:05 +0200
Message-Id: <20190510161614.23236-7-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
References: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 10 May 2019 16:16:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/15] test-block-iothread: Job coroutine thread
 after AioContext switch
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests that a job coroutine always runs in the right iothread after
the AioContext of its main node has changed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-block-iothread.c | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 97ac0b159d..036ed9a3b3 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -354,6 +354,111 @@ static void test_sync_op(const void *opaque)
     blk_unref(blk);
 }
=20
+typedef struct TestBlockJob {
+    BlockJob common;
+    bool should_complete;
+    int n;
+} TestBlockJob;
+
+static int test_job_prepare(Job *job)
+{
+    g_assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
+    return 0;
+}
+
+static int coroutine_fn test_job_run(Job *job, Error **errp)
+{
+    TestBlockJob *s =3D container_of(job, TestBlockJob, common.job);
+
+    job_transition_to_ready(&s->common.job);
+    while (!s->should_complete) {
+        s->n++;
+        g_assert(qemu_get_current_aio_context() =3D=3D job->aio_context)=
;
+
+        /* Avoid job_sleep_ns() because it marks the job as !busy. We wa=
nt to
+         * emulate some actual activity (probably some I/O) here so that=
 the
+         * drain involved in AioContext switches has to wait for this ac=
tivity
+         * to stop. */
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
+
+        job_pause_point(&s->common.job);
+    }
+
+    g_assert(qemu_get_current_aio_context() =3D=3D job->aio_context);
+    return 0;
+}
+
+static void test_job_complete(Job *job, Error **errp)
+{
+    TestBlockJob *s =3D container_of(job, TestBlockJob, common.job);
+    s->should_complete =3D true;
+}
+
+BlockJobDriver test_job_driver =3D {
+    .job_driver =3D {
+        .instance_size  =3D sizeof(TestBlockJob),
+        .free           =3D block_job_free,
+        .user_resume    =3D block_job_user_resume,
+        .drain          =3D block_job_drain,
+        .run            =3D test_job_run,
+        .complete       =3D test_job_complete,
+        .prepare        =3D test_job_prepare,
+    },
+};
+
+static void test_attach_blockjob(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    TestBlockJob *tjob;
+
+    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
+    blk_insert_bs(blk, bs, &error_abort);
+
+    tjob =3D block_job_create("job0", &test_job_driver, NULL, bs,
+                            0, BLK_PERM_ALL,
+                            0, 0, NULL, NULL, &error_abort);
+    job_start(&tjob->common.job);
+
+    while (tjob->n =3D=3D 0) {
+        aio_poll(qemu_get_aio_context(), false);
+    }
+
+    blk_set_aio_context(blk, ctx);
+
+    tjob->n =3D 0;
+    while (tjob->n =3D=3D 0) {
+        aio_poll(qemu_get_aio_context(), false);
+    }
+
+    aio_context_acquire(ctx);
+    blk_set_aio_context(blk, qemu_get_aio_context());
+    aio_context_release(ctx);
+
+    tjob->n =3D 0;
+    while (tjob->n =3D=3D 0) {
+        aio_poll(qemu_get_aio_context(), false);
+    }
+
+    blk_set_aio_context(blk, ctx);
+
+    tjob->n =3D 0;
+    while (tjob->n =3D=3D 0) {
+        aio_poll(qemu_get_aio_context(), false);
+    }
+
+    aio_context_acquire(ctx);
+    job_complete_sync(&tjob->common.job, &error_abort);
+    blk_set_aio_context(blk, qemu_get_aio_context());
+    aio_context_release(ctx);
+
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
 int main(int argc, char **argv)
 {
     int i;
@@ -368,5 +473,7 @@ int main(int argc, char **argv)
         g_test_add_data_func(t->name, t, test_sync_op);
     }
=20
+    g_test_add_func("/attach/blockjob", test_attach_blockjob);
+
     return g_test_run();
 }
--=20
2.20.1


