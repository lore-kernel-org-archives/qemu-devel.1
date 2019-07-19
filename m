Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF68C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B9E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPBb-0000ap-Dl
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoPAN-000459-Ae
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoPAM-0006FN-1r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoPAJ-0006Ck-Dm; Fri, 19 Jul 2019 05:26:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBA9730C0DD6;
 Fri, 19 Jul 2019 09:26:58 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFFB25DA38;
 Fri, 19 Jul 2019 09:26:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:15 +0200
Message-Id: <20190719092618.24891-8-mreitz@redhat.com>
In-Reply-To: <20190719092618.24891-1-mreitz@redhat.com>
References: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 09:26:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/10] tests: Extend commit by drained_end
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
 tests/test-bdrv-drain.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 3503ce3b69..03fa1142a1 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1532,6 +1532,7 @@ typedef struct TestDropBackingBlockJob {
     BlockJob common;
     bool should_complete;
     bool *did_complete;
+    BlockDriverState *detach_also;
 } TestDropBackingBlockJob;
=20
 static int coroutine_fn test_drop_backing_job_run(Job *job, Error **errp=
)
@@ -1552,6 +1553,7 @@ static void test_drop_backing_job_commit(Job *job)
         container_of(job, TestDropBackingBlockJob, common.job);
=20
     bdrv_set_backing_hd(blk_bs(s->common.blk), NULL, &error_abort);
+    bdrv_set_backing_hd(s->detach_also, NULL, &error_abort);
=20
     *s->did_complete =3D true;
 }
@@ -1571,9 +1573,6 @@ static const BlockJobDriver test_drop_backing_job_d=
river =3D {
  * Creates a child node with three parent nodes on it, and then runs a
  * block job on the final one, parent-node-2.
  *
- * (TODO: parent-node-0 currently serves no purpose, but will as of a
- * follow-up patch.)
- *
  * The job is then asked to complete before a section where the child
  * is drained.
  *
@@ -1585,7 +1584,7 @@ static const BlockJobDriver test_drop_backing_job_d=
river =3D {
  *
  * Ending the drain on parent-node-1 will poll the AioContext, which
  * lets job_exit() and thus test_drop_backing_job_commit() run.  That
- * function removes the child as parent-node-2's backing file.
+ * function first removes the child as parent-node-2's backing file.
  *
  * In old (and buggy) implementations, there are two problems with
  * that:
@@ -1604,6 +1603,34 @@ static const BlockJobDriver test_drop_backing_job_=
driver =3D {
  * bdrv_replace_child_noperm() therefore must call drained_end() on
  * the parent only if it really is still drained because the child is
  * drained.
+ *
+ * If removing child from parent-node-2 was successful (as it should
+ * be), test_drop_backing_job_commit() will then also remove the child
+ * from parent-node-0.
+ *
+ * With an old version of our drain infrastructure ((A) above), that
+ * resulted in the following flow:
+ *
+ * 1. child attempts to leave its drained section.  The call recurses
+ *    to its parents.
+ *
+ * 2. parent-node-2 leaves the drained section.  Polling in
+ *    bdrv_drain_invoke() will schedule job_exit().
+ *
+ * 3. parent-node-1 leaves the drained section.  Polling in
+ *    bdrv_drain_invoke() will run job_exit(), thus disconnecting
+ *    parent-node-0 from the child node.
+ *
+ * 4. bdrv_parent_drained_end() uses a QLIST_FOREACH_SAFE() loop to
+ *    iterate over the parents.  Thus, it now accesses the BdrvChild
+ *    object that used to connect parent-node-0 and the child node.
+ *    However, that object no longer exists, so it accesses a dangling
+ *    pointer.
+ *
+ * The solution is to only poll once when running a bdrv_drained_end()
+ * operation, specifically at the end when all drained_end()
+ * operations for all involved nodes have been scheduled.
+ * Note that this also solves (A) above, thus hiding (B).
  */
 static void test_blockjob_commit_by_drained_end(void)
 {
@@ -1627,6 +1654,7 @@ static void test_blockjob_commit_by_drained_end(voi=
d)
                            bs_parents[2], 0, BLK_PERM_ALL, 0, 0, NULL, N=
ULL,
                            &error_abort);
=20
+    job->detach_also =3D bs_parents[0];
     job->did_complete =3D &job_has_completed;
=20
     job_start(&job->common.job);
--=20
2.21.0


