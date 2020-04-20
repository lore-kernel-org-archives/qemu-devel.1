Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A3CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1392074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1392074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbKz-0005pD-LC
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44872 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbI5-00016G-Qd
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:11 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbI2-00041b-HQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:39790)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHr-0003NJ-Q4; Mon, 20 Apr 2020 14:36:55 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHk-0001xO-AS; Mon, 20 Apr 2020 21:36:48 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 7/7] block: apply COR-filter to block-stream jobs
Date: Mon, 20 Apr 2020 21:36:46 +0300
Message-Id: <1587407806-109784-8-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 14:36:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 185.231.240.75
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
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch completes the series with the COR-filter insertion to any
block-stream operation. It also makes changes to the iotests 030, 141
and 245.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c             | 151 +++++++++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/030     |   6 +-
 tests/qemu-iotests/141.out |   2 +-
 tests/qemu-iotests/245     |   5 +-
 4 files changed, 141 insertions(+), 23 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index fab7923..af14ba8 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -16,6 +16,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
@@ -33,6 +34,8 @@ typedef struct StreamBlockJob {
     BlockJob common;
     BlockDriverState *bottom_cow_node;
     BlockDriverState *above_base;
+    BlockDriverState *cor_filter_bs;
+    BlockDriverState *target_bs;
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -46,22 +49,11 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     assert(bytes < SIZE_MAX);
 
     /* Copy-on-read the unallocated clusters */
-    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
+    return blk_co_pread(blk, offset, bytes, buf, 0);
 }
 
-static void stream_abort(Job *job)
-{
-    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-
-    if (s->chain_frozen) {
-        BlockJob *bjob = &s->common;
-        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->above_base);
-    }
-}
-
-static int stream_prepare(Job *job)
+static int stream_change_backing_file(StreamBlockJob *s)
 {
-    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *unfiltered_bs = bdrv_skip_rw_filters(bs);
@@ -69,9 +61,6 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_chain(bs, s->above_base);
-    s->chain_frozen = false;
-
     if (bdrv_filtered_cow_child(unfiltered_bs)) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -91,11 +80,58 @@ static int stream_prepare(Job *job)
     return ret;
 }
 
+static int stream_exit(Job *job, bool abort)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+    BlockJob *bjob = &s->common;
+    BlockDriverState *target_bs = s->target_bs;
+    int ret = 0;
+
+    if (s->chain_frozen) {
+        bdrv_unfreeze_chain(s->target_bs, s->bottom_cow_node);
+        s->chain_frozen = false;
+    }
+
+    /* Retain the BDS until we complete the graph change. */
+    bdrv_ref(target_bs);
+    /* Hold a guest back from writing while permissions are being reset. */
+    bdrv_drained_begin(target_bs);
+    /* Drop permissions before the graph change. */
+    bdrv_child_try_set_perm(bdrv_filtered_rw_child(s->cor_filter_bs),
+                            0, BLK_PERM_ALL, &error_abort);
+    if (!abort) {
+        ret = stream_change_backing_file(s);
+    }
+
+    bdrv_replace_node(s->cor_filter_bs, target_bs, &error_abort);
+    /* Switch the BB back to the filter so that job terminated properly. */
+    blk_remove_bs(bjob->blk);
+    blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(bjob->blk, s->cor_filter_bs, &error_abort);
+
+    bdrv_drained_end(target_bs);
+    bdrv_unref(target_bs);
+    /* Submit control over filter to the job instance. */
+    bdrv_unref(s->cor_filter_bs);
+
+    return ret;
+}
+
+static int stream_prepare(Job *job)
+{
+    return stream_exit(job, false);
+}
+
+static void stream_abort(Job *job)
+{
+    stream_exit(job, job->ret < 0);
+}
+
 static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
 
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_read_only) {
@@ -212,6 +248,72 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     return error;
 }
 
+static BlockDriverState *create_filter_node(BlockDriverState *bs,
+                                            const char *filter_node_name,
+                                            Error **errp)
+{
+    QDict *opts = qdict_new();
+
+    qdict_put_str(opts, "driver", "copy-on-read");
+    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+    if (filter_node_name) {
+        qdict_put_str(opts, "node-name", filter_node_name);
+    }
+
+    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
+}
+
+static void remove_filter(BlockDriverState *cor_filter_bs)
+{
+    BdrvChild *child;
+    BlockDriverState *bs;
+
+    child = bdrv_filtered_rw_child(cor_filter_bs);
+    if (!child) {
+        return;
+    }
+    bs = child->bs;
+
+    /* Hold a guest back from writing until we remove the filter */
+    bdrv_drained_begin(bs);
+    bdrv_child_try_set_perm(child, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
+    bdrv_drained_end(bs);
+
+    bdrv_unref(cor_filter_bs);
+}
+
+static BlockDriverState *insert_filter(BlockDriverState *bs,
+                                       const char *filter_node_name,
+                                       Error **errp)
+{
+    BlockDriverState *cor_filter_bs;
+    Error *local_err = NULL;
+
+    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
+    if (cor_filter_bs == NULL) {
+        error_prepend(errp, "Could not create filter node: ");
+        return NULL;
+    }
+
+    if (!filter_node_name) {
+        cor_filter_bs->implicit = true;
+    }
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, cor_filter_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(cor_filter_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return cor_filter_bs;
+}
+
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
@@ -237,6 +339,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     bool bs_read_only;
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    BlockDriverState *cor_filter_bs = NULL;
     BlockDriverState *bottom_cow_node = bdrv_find_overlay(bs, base);
     BlockDriverState *above_base;
 
@@ -267,10 +370,16 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     } else {
         bdrv_unfreeze_chain(bottom_cow_node, above_base);
     }
+
+    cor_filter_bs = insert_filter(bs, filter_node_name, errp);
+    if (cor_filter_bs == NULL) {
+        goto fail;
+    }
+
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
+    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
                          basic_flags | BLK_PERM_GRAPH_MOD,
                          basic_flags | BLK_PERM_WRITE,
                          speed, creation_flags, NULL, NULL, errp);
@@ -294,6 +403,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                            basic_flags, &error_abort);
     }
 
+    s->cor_filter_bs = cor_filter_bs;
+    s->target_bs = bs;
     s->bottom_cow_node = bottom_cow_node;
     s->above_base = above_base;
     s->backing_file_str = g_strdup(backing_file_str);
@@ -310,4 +421,8 @@ fail:
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
     bdrv_unfreeze_chain(bs, bottom_cow_node);
+
+    if (cor_filter_bs) {
+        remove_filter(cor_filter_bs);
+    }
 }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1b69f31..31a5164 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -269,7 +269,9 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
+        result = self.vm.qmp('block-stream', device='node4',
+                             job_id='stream-node4', base=self.imgs[1],
+                             filter_node_name='stream-filter', speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
@@ -287,7 +289,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # block-commit should also fail if it touches nodes used by the stream job
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[4], job_id='commit-node4')
         self.assert_qmp(result, 'error/desc',
-            "Node 'node4' is busy: block device is in use by block job: stream")
+            "Node 'stream-filter' is busy: block device is in use by block job: stream")
 
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[1], top=self.imgs[3], job_id='commit-node1')
         self.assert_qmp(result, 'error/desc',
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 4d71d9d..8cc020f 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -78,7 +78,7 @@ wrote 1048576/1048576 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: stream"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "stream"}}
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 9baeb2b..18839dc 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -907,10 +907,11 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts['backing'] = None
         self.reopen(opts, {'read-only': False}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
 
-        # We can detach hd1 from hd0 because it doesn't affect the stream job
+        # We can't detach hd1 from hd0 while the stream job is ongoing
         opts = hd_opts(0)
         opts['backing'] = None
-        self.reopen(opts)
+        self.reopen(opts, {},
+            "Cannot change backing link if 'hd0' has an implicit backing file")
 
         self.vm.run_job('stream0', auto_finalize = False, auto_dismiss = True)
 
-- 
1.8.3.1


