Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AD1206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AD1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuaH-0003ZQ-Jo
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:45:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWL-0000W5-0M
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYuWJ-0004au-I3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:41:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWJ-0004X4-Am; Thu, 06 Jun 2019 11:41:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYuWC-0000xX-V9; Thu, 06 Jun 2019 18:41:33 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu,  6 Jun 2019 18:41:31 +0300
Message-Id: <20190606154132.153330-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606154132.153330-1-vsementsov@virtuozzo.com>
References: <20190606154132.153330-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/4] blockdev: blockdev_mark_auto_del: drop
 usage of bs->job
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

We are going to remove bs->job pointer. Drop it's usage in
blockdev_mark_auto_del: instead of looking at bs->job let's check all
jobs for references to bs.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/blockjob.h |  9 +++++++++
 blockdev.c               | 17 ++++++++---------
 blockjob.c               | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index ede0bd8dcb..35faa3aa26 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -121,6 +121,15 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
  */
 void block_job_remove_all_bdrv(BlockJob *job);
 
+/**
+ * block_job_has_bdrv:
+ * @job: The block job
+ *
+ * Searches for @bs in the list of nodes that are involved in the
+ * job.
+ */
+bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
+
 /**
  * block_job_set_speed:
  * @job: The job to set the speed for.
diff --git a/blockdev.c b/blockdev.c
index 3f44b891eb..58aa1369a4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -140,22 +140,21 @@ void override_max_devs(BlockInterfaceType type, int max_devs)
 void blockdev_mark_auto_del(BlockBackend *blk)
 {
     DriveInfo *dinfo = blk_legacy_dinfo(blk);
-    BlockDriverState *bs = blk_bs(blk);
-    AioContext *aio_context;
+    BlockJob *job;
 
     if (!dinfo) {
         return;
     }
 
-    if (bs) {
-        aio_context = bdrv_get_aio_context(bs);
-        aio_context_acquire(aio_context);
+    for (job = block_job_next(NULL); job; job = block_job_next(job)) {
+        if (block_job_has_bdrv(job, blk_bs(blk))) {
+            AioContext *aio_context = job->job.aio_context;
+            aio_context_acquire(aio_context);
 
-        if (bs->job) {
-            job_cancel(&bs->job->job, false);
-        }
+            job_cancel(&job->job, false);
 
-        aio_context_release(aio_context);
+            aio_context_release(aio_context);
+        }
     }
 
     dinfo->auto_del = 1;
diff --git a/blockjob.c b/blockjob.c
index 931d675c0c..7b6737adde 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -199,6 +199,20 @@ void block_job_remove_all_bdrv(BlockJob *job)
     job->nodes = NULL;
 }
 
+bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
+{
+    GSList *el;
+
+    for (el = job->nodes; el; el = el->next) {
+        BdrvChild *c = el->data;
+        if (c->bs == bs) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
                        uint64_t perm, uint64_t shared_perm, Error **errp)
 {
-- 
2.18.0


