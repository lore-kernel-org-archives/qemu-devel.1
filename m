Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B600C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3972184B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3972184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCSXI-0002JT-1z
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 13:21:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSWS-0001qM-Qq
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSWQ-00008U-Rn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:21:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCSVC-00031q-4E; Fri, 05 Apr 2019 13:20:50 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCS8a-0008Mk-EV; Fri, 05 Apr 2019 19:56:20 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Apr 2019 19:56:19 +0300
Message-Id:
 <1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom node
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	berto@igalia.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405165619.WUGrk1djAs33mdzuG03BiNBfMfbIR6wpWujfAc53Te8@z>

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
---
 block/stream.c         | 56 +++++++++++++++++++++++++++-----------------------
 block/trace-events     |  2 +-
 tests/qemu-iotests/245 |  4 ++--
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7a4e0dc..7a25cd7 100644
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
@@ -56,7 +56,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
 
@@ -65,11 +65,11 @@ static int stream_prepare(Job *job)
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
@@ -112,7 +112,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
-    BlockDriverState *base = s->base;
+    bool enable_cor = !backing_bs(s->bottom);
     int64_t len;
     int64_t offset = 0;
     uint64_t delay_ns = 0;
@@ -121,7 +121,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     void *buf;
 
-    if (!bs->backing) {
+    if (bs == s->bottom) {
+        /* Nothing to stream */
         return 0;
     }
 
@@ -138,7 +139,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
      * backing chain since the copy-on-read operation does not take base into
      * account.
      */
-    if (!base) {
+    if (enable_cor) {
         bdrv_enable_copy_on_read(bs);
     }
 
@@ -161,9 +162,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), base,
-                                          offset, n, &n);
-
+            ret = bdrv_is_allocated_above_inclusive(backing_bs(bs), s->bottom,
+                                                    offset, n, &n);
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
                 n = len - offset;
@@ -200,7 +200,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
-    if (!base) {
+    if (enable_cor) {
         bdrv_disable_copy_on_read(bs);
     }
 
@@ -232,8 +232,13 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    BlockDriverState *bottom = NULL;
+    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+
+    /* Find the bottom node that has the base as its backing image */
+    bottom = bdrv_find_overlay(bs, base);
 
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
         return;
     }
 
@@ -250,32 +255,31 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
     }
 
-    /* Block all intermediate nodes between bs and base, because they will
-     * disappear from the chain after this operation. The streaming job reads
-     * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
-        block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
-                           &error_abort);
+    /*
+     * Block all intermediate nodes between bs and bottom (inclusive), because
+     * they will disappear from the chain after this operation. The streaming
+     * job reads every block only once, assuming that it doesn't change, so
+     * forbid writes and resizes.
+     */
+    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
+        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
+                           0, basic_flags, &error_abort);
     }
 
-    s->base = base;
+    s->bottom = bottom;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
 
     s->on_error = on_error;
-    trace_stream_start(bs, base, s);
+    trace_stream_start(bs, bottom, s);
     job_start(&s->common.job);
     return;
 
diff --git a/block/trace-events b/block/trace-events
index 7335a42..5366d45 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -20,7 +20,7 @@ bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_of
 
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-stream_start(void *bs, void *base, void *s) "bs %p base %p s %p"
+stream_start(void *bs, void *bottom, void *s) "bs %p bottom %p s %p"
 
 # commit.c
 commit_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a21..d11e73c 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -859,9 +859,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                              device = 'hd0', base_node = 'hd2', speed = 512 * 1024)
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


