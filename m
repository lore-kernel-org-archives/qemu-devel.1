Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE029C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEAF2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEAF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdH1E-0000r7-Ov
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxZ-000840-6F
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxW-0000mN-PB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxM-0000TS-W4; Tue, 18 Jun 2019 11:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A08E30C1AE6;
 Tue, 18 Jun 2019 15:23:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 397645BBD2;
 Tue, 18 Jun 2019 15:23:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:09 +0200
Message-Id: <20190618152318.24953-6-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 18 Jun 2019 15:23:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/14] block: drop bs->job
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

Drop remaining users of bs->job:
1. assertions actually duplicated by assert(!bs->refcnt)
2. trace-point seems not enough reason to change stream_start to return
   BlockJob pointer
3. Restricting creation of two jobs based on same bs is bad idea, as
   3.1 Some jobs creates filters to be their main node, so, this check
   don't actually prevent creating second job on same real node (which
   will create another filter node) (but I hope it is restricted by
   other mechanisms)
   3.2 Even without bs->job we have two systems of permissions:
   op-blockers and BLK_PERM
   3.3 We may want to run several jobs on one node one day

And finally, drop bs->job pointer itself. Hurrah!

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 3 ---
 block.c                   | 2 --
 blockdev.c                | 2 +-
 blockjob.c                | 8 --------
 tests/test-blockjob.c     | 5 +++--
 block/trace-events        | 2 +-
 6 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8bb1cfb80a..a498c2670b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -812,9 +812,6 @@ struct BlockDriverState {
     /* operation blockers */
     QLIST_HEAD(, BdrvOpBlocker) op_blockers[BLOCK_OP_TYPE_MAX];
=20
-    /* long-running background operation */
-    BlockJob *job;
-
     /* The node that this node inherited default options from (and a reo=
pen on
      * which can affect this node by changing these defaults). This is a=
lways a
      * parent node of this node. */
diff --git a/block.c b/block.c
index e3e77feee0..ceb2ea23c5 100644
--- a/block.c
+++ b/block.c
@@ -3905,7 +3905,6 @@ static void bdrv_close(BlockDriverState *bs)
     BdrvAioNotifier *ban, *ban_next;
     BdrvChild *child, *next;
=20
-    assert(!bs->job);
     assert(!bs->refcnt);
=20
     bdrv_drained_begin(bs); /* complete I/O */
@@ -4146,7 +4145,6 @@ out:
=20
 static void bdrv_delete(BlockDriverState *bs)
 {
-    assert(!bs->job);
     assert(bdrv_op_blocker_is_empty(bs));
     assert(!bs->refcnt);
=20
diff --git a/blockdev.c b/blockdev.c
index a9dd73eafc..5d6a13dea9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3260,7 +3260,7 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
         goto out;
     }
=20
-    trace_qmp_block_stream(bs, bs->job);
+    trace_qmp_block_stream(bs);
=20
 out:
     aio_context_release(aio_context);
diff --git a/blockjob.c b/blockjob.c
index c3620ec544..458ae76f51 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -83,9 +83,7 @@ BlockJob *block_job_get(const char *id)
 void block_job_free(Job *job)
 {
     BlockJob *bjob =3D container_of(job, BlockJob, job);
-    BlockDriverState *bs =3D blk_bs(bjob->blk);
=20
-    bs->job =3D NULL;
     block_job_remove_all_bdrv(bjob);
     blk_unref(bjob->blk);
     error_free(bjob->blocker);
@@ -402,11 +400,6 @@ void *block_job_create(const char *job_id, const Blo=
ckJobDriver *driver,
     BlockJob *job;
     int ret;
=20
-    if (bs->job) {
-        error_setg(errp, QERR_DEVICE_IN_USE, bdrv_get_device_name(bs));
-        return NULL;
-    }
-
     if (job_id =3D=3D NULL && !(flags & JOB_INTERNAL)) {
         job_id =3D bdrv_get_device_name(bs);
     }
@@ -449,7 +442,6 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
     error_setg(&job->blocker, "block device is in use by block job: %s",
                job_type_str(&job->job));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abo=
rt);
-    bs->job =3D job;
=20
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
=20
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 8c91980c70..b33f899873 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -122,8 +122,9 @@ static void test_job_ids(void)
     /* This one is valid */
     job[0] =3D do_test_id(blk[0], "id0", true);
=20
-    /* We cannot have two jobs in the same BDS */
-    do_test_id(blk[0], "id1", false);
+    /* We can have two jobs in the same BDS */
+    job[1] =3D do_test_id(blk[0], "id1", true);
+    job_early_fail(&job[1]->job);
=20
     /* Duplicate job IDs are not allowed */
     job[1] =3D do_test_id(blk[1], "id0", false);
diff --git a/block/trace-events b/block/trace-events
index f6e43ee023..9ccea755da 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -53,7 +53,7 @@ qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
 qmp_block_job_finalize(void *job) "job %p"
 qmp_block_job_dismiss(void *job) "job %p"
-qmp_block_stream(void *bs, void *job) "bs %p job %p"
+qmp_block_stream(void *bs) "bs %p"
=20
 # file-posix.c
 # file-win32.c
--=20
2.20.1


