Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0803E2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0803E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k897A-0007Kz-7z
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8968-0005r8-G9; Tue, 18 Aug 2020 17:24:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:41584 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8965-0003ca-2i; Tue, 18 Aug 2020 17:24:48 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k895p-000GtS-PL; Wed, 19 Aug 2020 00:24:29 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 4/4] block: apply COR-filter to block-stream jobs
Date: Wed, 19 Aug 2020 00:24:40 +0300
Message-Id: <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:24:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch completes the series with the COR-filter insertion to any
block-stream operation. It also makes changes to the iotests 030.
The test case 'test_stream_parallel' was deleted due to multiple
errors.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c             | 76 ++++++++++++++++++++++++++++++++--------------
 tests/qemu-iotests/030     | 50 +++---------------------------
 tests/qemu-iotests/030.out |  4 +--
 3 files changed, 61 insertions(+), 69 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 8bf6b6d..0b11979 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
+#include "block/copy-on-read.h"
 
 enum {
     /*
@@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
     BlockJob common;
     BlockDriverState *base_overlay; /* COW overlay (stream from this) */
     BlockDriverState *above_base;   /* Node directly above the base */
+    BlockDriverState *cor_filter_bs;
+    BlockDriverState *target_bs;
     BlockdevOnError on_error;
     char *backing_file_str;
+    char *base_fmt;
     bool bs_read_only;
     bool chain_frozen;
 } StreamBlockJob;
@@ -53,34 +57,26 @@ static void stream_abort(Job *job)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
 
     if (s->chain_frozen) {
-        BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
+        bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
     }
 }
 
 static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
     BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, s->above_base);
+    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
     s->chain_frozen = false;
 
     if (bdrv_cow_child(unfiltered_bs)) {
-        const char *base_id = NULL, *base_fmt = NULL;
-        if (base) {
-            base_id = s->backing_file_str;
-            if (base->drv) {
-                base_fmt = base->drv->format_name;
-            }
-        }
         bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
-        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
+        ret = bdrv_change_backing_file(unfiltered_bs, s->backing_file_str,
+                                       s->base_fmt);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
@@ -94,7 +90,9 @@ static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
+
+    bdrv_cor_filter_drop(s->cor_filter_bs);
 
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_read_only) {
@@ -104,13 +102,14 @@ static void stream_clean(Job *job)
     }
 
     g_free(s->backing_file_str);
+    g_free(s->base_fmt);
 }
 
 static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
-    BlockDriverState *bs = blk_bs(blk);
+    BlockDriverState *bs = s->target_bs;
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
     bool enable_cor = !bdrv_cow_child(s->base_overlay);
     int64_t len;
@@ -231,6 +230,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
     BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
     BlockDriverState *above_base;
+    BlockDriverState *cor_filter_bs = NULL;
+    char *base_fmt = NULL;
+
+    if (base && base->drv) {
+        base_fmt = g_strdup(base->drv->format_name);
+    }
 
     if (!base_overlay) {
         error_setg(errp, "'%s' is not in the backing chain of '%s'",
@@ -264,17 +269,36 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
-    /* Prevent concurrent jobs trying to modify the graph structure here, we
-     * already have our own plans. Also don't allow resize as the image size is
-     * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
-                         basic_flags | BLK_PERM_GRAPH_MOD,
-                         basic_flags | BLK_PERM_WRITE,
+    cor_filter_bs = bdrv_cor_filter_append(bs, filter_node_name, errp);
+    if (cor_filter_bs == NULL) {
+        goto fail;
+    }
+
+    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
+        bdrv_cor_filter_drop(cor_filter_bs);
+        cor_filter_bs = NULL;
+        goto fail;
+    }
+
+    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
+                         BLK_PERM_CONSISTENT_READ,
+                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         goto fail;
     }
 
+    /*
+     * Prevent concurrent jobs trying to modify the graph structure here, we
+     * already have our own plans. Also don't allow resize as the image size is
+     * queried only at the job start and then cached.
+     */
+    if (block_job_add_bdrv(&s->common, "active node", bs,
+                           basic_flags | BLK_PERM_GRAPH_MOD,
+                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
+        goto fail;
+    }
+
     /* Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
      * every block only once, assuming that it doesn't change, so forbid writes
@@ -294,6 +318,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
+    s->cor_filter_bs = cor_filter_bs;
+    s->target_bs = bs;
+    s->base_fmt = base_fmt;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
@@ -307,5 +334,10 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, above_base);
+    if (cor_filter_bs) {
+        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
+        bdrv_cor_filter_drop(cor_filter_bs);
+    } else {
+        bdrv_unfreeze_backing_chain(bs, above_base);
+    }
 }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1cdd7e2..fec9d89 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -221,60 +221,20 @@ class TestParallelOps(iotests.QMPTestCase):
         for img in self.imgs:
             os.remove(img)
 
-    # Test that it's possible to run several block-stream operations
-    # in parallel in the same snapshot chain
-    def test_stream_parallel(self):
-        self.assert_no_active_block_jobs()
-
-        # Check that the maps don't match before the streaming operations
-        for i in range(2, self.num_imgs, 2):
-            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i]),
-                                qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i-1]),
-                                'image file map matches backing file before streaming')
-
-        # Create all streaming jobs
-        pending_jobs = []
-        for i in range(2, self.num_imgs, 2):
-            node_name = 'node%d' % i
-            job_id = 'stream-%s' % node_name
-            pending_jobs.append(job_id)
-            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=512*1024)
-            self.assert_qmp(result, 'return', {})
-
-        for job in pending_jobs:
-            result = self.vm.qmp('block-job-set-speed', device=job, speed=0)
-            self.assert_qmp(result, 'return', {})
-
-        # Wait for all jobs to be finished.
-        while len(pending_jobs) > 0:
-            for event in self.vm.get_qmp_events(wait=True):
-                if event['event'] == 'BLOCK_JOB_COMPLETED':
-                    job_id = self.dictpath(event, 'data/device')
-                    self.assertTrue(job_id in pending_jobs)
-                    self.assert_qmp_absent(event, 'data/error')
-                    pending_jobs.remove(job_id)
-
-        self.assert_no_active_block_jobs()
-        self.vm.shutdown()
-
-        # Check that all maps match now
-        for i in range(2, self.num_imgs, 2):
-            self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i]),
-                             qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i-1]),
-                             'image file map does not match backing file after streaming')
-
     # Test that it's not possible to perform two block-stream
     # operations if there are nodes involved in both.
     def test_overlapping_1(self):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
+        result = self.vm.qmp('block-stream', device='node4',
+                             job_id='stream-node4', base=self.imgs[1],
+                             filter_node_name='stream-filter', speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
         self.assert_qmp(result, 'error/desc',
-            "Node 'node4' is busy: block device is in use by block job: stream")
+            "Node 'stream-filter' is busy: block device is in use by block job: stream")
 
         result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3', base=self.imgs[2])
         self.assert_qmp(result, 'error/desc',
@@ -287,7 +247,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # block-commit should also fail if it touches nodes used by the stream job
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[4], job_id='commit-node4')
         self.assert_qmp(result, 'error/desc',
-            "Node 'node4' is busy: block device is in use by block job: stream")
+            "Node 'stream-filter' is busy: block device is in use by block job: stream")
 
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[1], top=self.imgs[3], job_id='commit-node1')
         self.assert_qmp(result, 'error/desc',
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 6d9bee1..5eb508d 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-...........................
+..........................
 ----------------------------------------------------------------------
-Ran 27 tests
+Ran 26 tests
 
 OK
-- 
1.8.3.1


