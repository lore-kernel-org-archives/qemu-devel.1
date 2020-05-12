Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D36CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A468B206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A468B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYGD-0003ym-QF
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7S-0004n9-7s; Tue, 12 May 2020 12:51:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:50550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7P-0001RB-2q; Tue, 12 May 2020 12:51:01 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7D-0004nT-U4; Tue, 12 May 2020 19:50:47 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 15/15] block: apply COR-filter to block-stream jobs
Date: Tue, 12 May 2020 19:50:45 +0300
Message-Id: <1589302245-893269-16-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:53:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch completes the series with the COR-filter insertion to any
block-stream operation. It also makes changes to the iotests 030 and
141.out.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c             | 83 ++++++++++++++++++++++++++++++++--------------
 tests/qemu-iotests/030     |  8 +++--
 tests/qemu-iotests/141.out |  2 +-
 3 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index e0b35f8..a74a07b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
+#include "block/copy-on-read.h"
 
 enum {
     /*
@@ -32,8 +33,11 @@ enum {
 typedef struct StreamBlockJob {
     BlockJob common;
     BlockDriverState *bottom;
+    BlockDriverState *cor_filter_bs;
+    BlockDriverState *target_bs;
     BlockdevOnError on_error;
     char *backing_file_str;
+    char *base_fmt;
     bool bs_read_only;
     bool chain_frozen;
 } StreamBlockJob;
@@ -52,33 +56,25 @@ static void stream_abort(Job *job)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
 
     if (s->chain_frozen) {
-        BlockJob *bjob = &s->common;
-        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
+        bdrv_unfreeze_chain(s->cor_filter_bs, s->bottom);
     }
 }
 
 static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
     BlockDriverState *base = backing_bs(s->bottom);
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_chain(bs, s->bottom);
+    bdrv_unfreeze_chain(s->cor_filter_bs, s->bottom);
     s->chain_frozen = false;
 
     if (bs->backing) {
-        const char *base_id = NULL, *base_fmt = NULL;
-        if (base) {
-            base_id = s->backing_file_str;
-            if (base->drv) {
-                base_fmt = base->drv->format_name;
-            }
-        }
         bdrv_set_backing_hd(bs, base, &local_err);
-        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret = bdrv_change_backing_file(bs, s->backing_file_str,
+                                       s->base_fmt);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
@@ -92,7 +88,9 @@ static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
+
+    bdrv_cor_filter_drop(s->cor_filter_bs);
 
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_read_only) {
@@ -102,13 +100,14 @@ static void stream_clean(Job *job)
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
     bool enable_cor = !backing_bs(s->bottom);
     int64_t len;
     int64_t offset = 0;
@@ -156,8 +155,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
-                                          offset, n, &n);
+            ret = bdrv_is_allocated_above(bdrv_filtered_cow_bs(bs), s->bottom,
+                                          true, offset, n, &n);
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
                 n = len - offset;
@@ -225,7 +224,13 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     bool bs_read_only;
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    BlockDriverState *cor_filter_bs = NULL;
     BlockDriverState *bottom = bdrv_find_overlay(bs, base);
+    char *base_fmt = NULL;
+
+    if (base && base->drv) {
+        base_fmt = g_strdup(base->drv->format_name);
+    }
 
     if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
         return;
@@ -240,17 +245,35 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
+    if (bdrv_freeze_chain(cor_filter_bs, bs, errp) < 0) {
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
     /* Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
      * every block only once, assuming that it doesn't change, so forbid writes
@@ -259,13 +282,17 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * due to parallel block jobs running.
      */
     base = backing_bs(bottom);
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+    for (iter = bdrv_filtered_bs(bs); iter && iter != base;
+         iter = bdrv_filtered_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            basic_flags, &error_abort);
     }
 
+    s->cor_filter_bs = cor_filter_bs;
+    s->target_bs = bs;
     s->bottom = bottom;
     s->backing_file_str = g_strdup(backing_file_str);
+    s->base_fmt = base_fmt;
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
 
@@ -278,5 +305,11 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_chain(bs, bottom);
+
+    if (cor_filter_bs) {
+        bdrv_unfreeze_chain(cor_filter_bs, bottom);
+        bdrv_cor_filter_drop(cor_filter_bs);
+    } else {
+        bdrv_unfreeze_chain(bs, bottom);
+    }
 }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index d7638cd..9856a08 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -269,12 +269,14 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
+        result = self.vm.qmp('block-stream', device='node4',
+                job_id='stream-node4', base=self.imgs[1],
+                filter_node_name='stream-filter', speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
         self.assert_qmp(result, 'error/desc',
-            "Node 'node4' is busy: block device is in use by block job: stream")
+            "Node 'stream-filter' is busy: block device is in use by block job: stream")
 
         result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3', base=self.imgs[2])
         self.assert_qmp(result, 'error/desc',
@@ -287,7 +289,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # block-commit should also fail if it touches nodes used by the stream job
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[4], job_id='commit-node4')
         self.assert_qmp(result, 'error/desc',
-            "Node 'node4' is busy: block device is in use by block job: stream")
+            "Node 'stream-filter' is busy: block device is in use by block job: stream")
 
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[1], top=self.imgs[3], job_id='commit-node1')
         self.assert_qmp(result, 'error/desc',
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 263b680..cf18558 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -99,7 +99,7 @@ wrote 1048576/1048576 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: stream"}}
 {'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-- 
1.8.3.1


