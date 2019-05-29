Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C55BC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1052D24012
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1052D24012
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW2rf-0006wC-4e
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 13:59:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oM-0004Xk-R2
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oK-00073R-64
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:48128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oJ-00072P-U5; Wed, 29 May 2019 13:56:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oE-0006Rz-1q; Wed, 29 May 2019 20:56:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 20:56:16 +0300
Message-Id: <1559152576-281803-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 3/3] block/stream: introduce a bottom node
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	berto@igalia.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bottom node is the intermediate block device that has the base as its
backing image. It is used instead of the base node while a block stream
job is running to avoid dependency on the base that may change due to the
parallel jobs. The change may take place due to a filter node as well that
is inserted between the base and the intermediate bottom node. It occurs
when the base node is the top one for another commit or stream job.
After the introduction of the bottom node, don't freeze its backing child,
that's the base, anymore.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c         | 43 +++++++++++++++++++++++--------------------
 tests/qemu-iotests/245 |  4 ++--
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 65b13b2..cd5e2ba 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -31,7 +31,7 @@ enum {
 
 typedef struct StreamBlockJob {
     BlockJob common;
-    BlockDriverState *base;
+    BlockDriverState *bottom;
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -54,7 +54,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
 
@@ -63,11 +63,11 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
-    BlockDriverState *base = s->base;
+    BlockDriverState *base = backing_bs(s->bottom);
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, base);
+    bdrv_unfreeze_backing_chain(bs, s->bottom);
     s->chain_frozen = false;
 
     if (bs->backing) {
@@ -110,7 +110,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
-    BlockDriverState *base = s->base;
+    bool enable_cor = !backing_bs(s->bottom);
     int64_t len;
     int64_t offset = 0;
     uint64_t delay_ns = 0;
@@ -119,7 +119,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     void *buf;
 
-    if (!bs->backing) {
+    if (bs == s->bottom) {
+        /* Nothing to stream */
         return 0;
     }
 
@@ -136,7 +137,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
      * backing chain since the copy-on-read operation does not take base into
      * account.
      */
-    if (!base) {
+    if (enable_cor) {
         bdrv_enable_copy_on_read(bs);
     }
 
@@ -159,9 +160,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), base, false,
+            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
                                           offset, n, &n);
-
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
                 n = len - offset;
@@ -198,7 +198,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
-    if (!base) {
+    if (enable_cor) {
         bdrv_disable_copy_on_read(bs);
     }
 
@@ -230,8 +230,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
 
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
         return;
     }
 
@@ -248,10 +250,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
     s = block_job_create(job_id, &stream_job_driver, NULL, bs,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                         BLK_PERM_GRAPH_MOD,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                         BLK_PERM_WRITE,
+                         basic_flags | BLK_PERM_GRAPH_MOD,
+                         basic_flags | BLK_PERM_WRITE,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         goto fail;
@@ -259,15 +259,18 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     /* Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
-     * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
+     * every block only once, assuming that it doesn't change, so forbid writes
+     * and resizes. Reassign the base node pointer because the backing BS of the
+     * bottom node might change after the call to bdrv_reopen_set_read_only()
+     * due to parallel block jobs running.
+     */
+    base = backing_bs(bottom);
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
-                           &error_abort);
+                           basic_flags, &error_abort);
     }
 
-    s->base = base;
+    s->bottom = bottom;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 349b94a..bc1ceb9 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -866,9 +866,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                              auto_finalize = False)
         self.assert_qmp(result, 'return', {})
 
-        # We can't remove hd2 while the stream job is ongoing
+        # We can remove hd2 while the stream job is ongoing
         opts['backing']['backing'] = None
-        self.reopen(opts, {}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
+        self.reopen(opts, {})
 
         # We can't remove hd1 while the stream job is ongoing
         opts['backing'] = None
-- 
1.8.3.1


