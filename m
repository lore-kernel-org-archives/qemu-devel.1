Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D759C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215622084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215622084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPAG-0003DQ-Mg
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoP9u-00022z-Ie
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoP9t-0005ru-Bt
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoP9q-0005om-M3; Fri, 19 Jul 2019 05:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01A4D3022468;
 Fri, 19 Jul 2019 09:26:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68BAD10190C8;
 Fri, 19 Jul 2019 09:26:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:10 +0200
Message-Id: <20190719092618.24891-3-mreitz@redhat.com>
In-Reply-To: <20190719092618.24891-1-mreitz@redhat.com>
References: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 09:26:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 02/10] tests: Add job commit by drained_end
 test
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-bdrv-drain.c | 119 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 12e2ecf517..3503ce3b69 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1527,6 +1527,122 @@ static void test_set_aio_context(void)
     iothread_join(b);
 }
=20
+
+typedef struct TestDropBackingBlockJob {
+    BlockJob common;
+    bool should_complete;
+    bool *did_complete;
+} TestDropBackingBlockJob;
+
+static int coroutine_fn test_drop_backing_job_run(Job *job, Error **errp=
)
+{
+    TestDropBackingBlockJob *s =3D
+        container_of(job, TestDropBackingBlockJob, common.job);
+
+    while (!s->should_complete) {
+        job_sleep_ns(job, 0);
+    }
+
+    return 0;
+}
+
+static void test_drop_backing_job_commit(Job *job)
+{
+    TestDropBackingBlockJob *s =3D
+        container_of(job, TestDropBackingBlockJob, common.job);
+
+    bdrv_set_backing_hd(blk_bs(s->common.blk), NULL, &error_abort);
+
+    *s->did_complete =3D true;
+}
+
+static const BlockJobDriver test_drop_backing_job_driver =3D {
+    .job_driver =3D {
+        .instance_size  =3D sizeof(TestDropBackingBlockJob),
+        .free           =3D block_job_free,
+        .user_resume    =3D block_job_user_resume,
+        .drain          =3D block_job_drain,
+        .run            =3D test_drop_backing_job_run,
+        .commit         =3D test_drop_backing_job_commit,
+    }
+};
+
+/**
+ * Creates a child node with three parent nodes on it, and then runs a
+ * block job on the final one, parent-node-2.
+ *
+ * (TODO: parent-node-0 currently serves no purpose, but will as of a
+ * follow-up patch.)
+ *
+ * The job is then asked to complete before a section where the child
+ * is drained.
+ *
+ * Ending this section will undrain the child's parents, first
+ * parent-node-2, then parent-node-1, then parent-node-0 -- the parent
+ * list is in reverse order of how they were added.  Ending the drain
+ * on parent-node-2 will resume the job, thus completing it and
+ * scheduling job_exit().
+ *
+ * Ending the drain on parent-node-1 will poll the AioContext, which
+ * lets job_exit() and thus test_drop_backing_job_commit() run.  That
+ * function removes the child as parent-node-2's backing file.
+ *
+ * In old (and buggy) implementations, there are two problems with
+ * that:
+ * (A) bdrv_drain_invoke() polls for every node that leaves the
+ *     drained section.  This means that job_exit() is scheduled
+ *     before the child has left the drained section.  Its
+ *     quiesce_counter is therefore still 1 when it is removed from
+ *     parent-node-2.
+ *
+ * (B) bdrv_replace_child_noperm() calls drained_end() on the old
+ *     child's parents as many times as the child is quiesced.  This
+ *     means it will call drained_end() on parent-node-2 once.
+ *     Because parent-node-2 is no longer quiesced at this point, this
+ *     will fail.
+ *
+ * bdrv_replace_child_noperm() therefore must call drained_end() on
+ * the parent only if it really is still drained because the child is
+ * drained.
+ */
+static void test_blockjob_commit_by_drained_end(void)
+{
+    BlockDriverState *bs_child, *bs_parents[3];
+    TestDropBackingBlockJob *job;
+    bool job_has_completed =3D false;
+    int i;
+
+    bs_child =3D bdrv_new_open_driver(&bdrv_test, "child-node", BDRV_O_R=
DWR,
+                                    &error_abort);
+
+    for (i =3D 0; i < 3; i++) {
+        char name[32];
+        snprintf(name, sizeof(name), "parent-node-%i", i);
+        bs_parents[i] =3D bdrv_new_open_driver(&bdrv_test, name, BDRV_O_=
RDWR,
+                                             &error_abort);
+        bdrv_set_backing_hd(bs_parents[i], bs_child, &error_abort);
+    }
+
+    job =3D block_job_create("job", &test_drop_backing_job_driver, NULL,
+                           bs_parents[2], 0, BLK_PERM_ALL, 0, 0, NULL, N=
ULL,
+                           &error_abort);
+
+    job->did_complete =3D &job_has_completed;
+
+    job_start(&job->common.job);
+
+    job->should_complete =3D true;
+    bdrv_drained_begin(bs_child);
+    g_assert(!job_has_completed);
+    bdrv_drained_end(bs_child);
+    g_assert(job_has_completed);
+
+    bdrv_unref(bs_parents[0]);
+    bdrv_unref(bs_parents[1]);
+    bdrv_unref(bs_parents[2]);
+    bdrv_unref(bs_child);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -1610,6 +1726,9 @@ int main(int argc, char **argv)
=20
     g_test_add_func("/bdrv-drain/set_aio_context", test_set_aio_context)=
;
=20
+    g_test_add_func("/bdrv-drain/blockjob/commit_by_drained_end",
+                    test_blockjob_commit_by_drained_end);
+
     ret =3D g_test_run();
     qemu_event_destroy(&done_event);
     return ret;
--=20
2.21.0


