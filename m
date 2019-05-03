Received: from eggs.gnu.org ([209.51.188.92]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMboz-0001zE-Eb
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMboy-00059P-AM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  3 May 2019 19:17:44 +0200
Message-Id: <20190503171744.21589-3-kwolf@redhat.com>
In-Reply-To: <20190503171744.21589-1-kwolf@redhat.com>
References: <20190503171744.21589-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] test-block-iothread: Job coroutine thread
 after AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

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
