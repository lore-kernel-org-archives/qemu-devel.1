Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA743C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F19206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F19206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuXn-0001Ul-RZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:43:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWK-0000Vl-E3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWJ-0004a9-7v
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:50226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWJ-0004X8-0F; Thu, 06 Jun 2019 11:41:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWD-0000xX-CX; Thu, 06 Jun 2019 18:41:33 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu,  6 Jun 2019 18:41:32 +0300
Message-Id: <20190606154132.153330-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606154132.153330-1-vsementsov@virtuozzo.com>
References: <20190606154132.153330-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/4] block: drop bs->job
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, armbru@redhat.com, mreitz@redhat.com,
	den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 include/block/block_int.h | 3 ---
 block.c                   | 2 --
 blockdev.c                | 2 +-
 blockjob.c                | 8 --------
 block/trace-events        | 2 +-
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8bb1cfb80a..a498c2670b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -812,9 +812,6 @@ struct BlockDriverState {
     /* operation blockers */
     QLIST_HEAD(, BdrvOpBlocker) op_blockers[BLOCK_OP_TYPE_MAX];
 
-    /* long-running background operation */
-    BlockJob *job;
-
     /* The node that this node inherited default options from (and a reopen on
      * which can affect this node by changing these defaults). This is always a
      * parent node of this node. */
diff --git a/block.c b/block.c
index e3e77feee0..ceb2ea23c5 100644
--- a/block.c
+++ b/block.c
@@ -3905,7 +3905,6 @@ static void bdrv_close(BlockDriverState *bs)
     BdrvAioNotifier *ban, *ban_next;
     BdrvChild *child, *next;
 
-    assert(!bs->job);
     assert(!bs->refcnt);
 
     bdrv_drained_begin(bs); /* complete I/O */
@@ -4146,7 +4145,6 @@ out:
 
 static void bdrv_delete(BlockDriverState *bs)
 {
-    assert(!bs->job);
     assert(bdrv_op_blocker_is_empty(bs));
     assert(!bs->refcnt);
 
diff --git a/blockdev.c b/blockdev.c
index 58aa1369a4..51eb5e86d7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3264,7 +3264,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
-    trace_qmp_block_stream(bs, bs->job);
+    trace_qmp_block_stream(bs);
 
 out:
     aio_context_release(aio_context);
diff --git a/blockjob.c b/blockjob.c
index 7b6737adde..d64ea2623a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -84,9 +84,7 @@ BlockJob *block_job_get(const char *id)
 void block_job_free(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
-    BlockDriverState *bs = blk_bs(bjob->blk);
 
-    bs->job = NULL;
     block_job_remove_all_bdrv(bjob);
     blk_unref(bjob->blk);
     error_free(bjob->blocker);
@@ -403,11 +401,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     BlockJob *job;
     int ret;
 
-    if (bs->job) {
-        error_setg(errp, QERR_DEVICE_IN_USE, bdrv_get_device_name(bs));
-        return NULL;
-    }
-
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
         job_id = bdrv_get_device_name(bs);
     }
@@ -450,7 +443,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     error_setg(&job->blocker, "block device is in use by block job: %s",
                job_type_str(&job->job));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
-    bs->job = job;
 
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
 
diff --git a/block/trace-events b/block/trace-events
index eab51497fc..912f84af39 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -53,7 +53,7 @@ qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
 qmp_block_job_finalize(void *job) "job %p"
 qmp_block_job_dismiss(void *job) "job %p"
-qmp_block_stream(void *bs, void *job) "bs %p job %p"
+qmp_block_stream(void *bs) "bs %p"
 
 # file-posix.c
 # file-win32.c
-- 
2.18.0


