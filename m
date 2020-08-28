Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA1C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE5520848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhgF-0007eo-Um
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhfM-00064b-6r; Fri, 28 Aug 2020 12:55:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:38202 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhfJ-0001fm-9l; Fri, 28 Aug 2020 12:55:51 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBheo-001XPR-R2; Fri, 28 Aug 2020 19:55:18 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v8 6/7] block-stream: freeze link to base node during stream
 job
Date: Fri, 28 Aug 2020 19:52:58 +0300
Message-Id: <1598633579-221780-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:53:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

To keep the base node unchanged during the block-stream operation,
freeze it as the other part of the backing chain with the intermediate
nodes related to the job.
This patch revers the change made with the commit c624b015bf as the
correct base file name and its format have to be written down to the
QCOW2 header on the disk when the backing file is being changed after
the stream job completes.
This reversion incurs changes in the tests 030, 245 and discards the
test 258 where concurrent stream/commit jobs are tested. When the link
to a base node is frozen, the concurrent job cannot change the common
backing chain.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c             |  29 ++------
 tests/qemu-iotests/030     |  10 +--
 tests/qemu-iotests/245     |   2 +-
 tests/qemu-iotests/258     | 161 ---------------------------------------------
 tests/qemu-iotests/258.out |  33 ----------
 5 files changed, 14 insertions(+), 221 deletions(-)
 delete mode 100755 tests/qemu-iotests/258
 delete mode 100644 tests/qemu-iotests/258.out

diff --git a/block/stream.c b/block/stream.c
index 8bf6b6d..fee4117 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -32,7 +32,7 @@ enum {
 typedef struct StreamBlockJob {
     BlockJob common;
     BlockDriverState *base_overlay; /* COW overlay (stream from this) */
-    BlockDriverState *above_base;   /* Node directly above the base */
+    BlockDriverState *base;   /* The base node */
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -54,7 +54,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
     }
 }
 
@@ -64,11 +64,11 @@ static int stream_prepare(Job *job)
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
-    BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
+    BlockDriverState *base = s->base;
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, s->above_base);
+    bdrv_unfreeze_backing_chain(bs, s->base);
     s->chain_frozen = false;
 
     if (bdrv_cow_child(unfiltered_bs)) {
@@ -230,7 +230,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     bool bs_read_only;
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
     BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
-    BlockDriverState *above_base;
 
     if (!base_overlay) {
         error_setg(errp, "'%s' is not in the backing chain of '%s'",
@@ -238,20 +237,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    /*
-     * Find the node directly above @base.  @base_overlay is a COW overlay, so
-     * it must have a bdrv_cow_child(), but it is the immediate overlay of
-     * @base, so between the two there can only be filters.
-     */
-    above_base = base_overlay;
-    if (bdrv_cow_bs(above_base) != base) {
-        above_base = bdrv_cow_bs(above_base);
-        while (bdrv_filter_bs(above_base) != base) {
-            above_base = bdrv_filter_bs(above_base);
-        }
-    }
-
-    if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
         return;
     }
 
@@ -284,7 +270,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * above_base node might change after the call to
      * bdrv_reopen_set_read_only() due to parallel block jobs running.
      */
-    base = bdrv_filter_or_cow_bs(above_base);
     for (iter = bdrv_filter_or_cow_bs(bs); iter != base;
          iter = bdrv_filter_or_cow_bs(iter))
     {
@@ -293,7 +278,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     }
 
     s->base_overlay = base_overlay;
-    s->above_base = above_base;
+    s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
@@ -307,5 +292,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, above_base);
+    bdrv_unfreeze_backing_chain(bs, base);
 }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1cdd7e2..c565e76 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -382,7 +382,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # Stream from node2 into node4
         result = self.vm.qmp('block-stream', device='node4', base_node='node2', job_id='node4')
         self.assert_qmp(result, 'error/desc',
-            "Cannot freeze 'backing' link to 'commit-filter'")
+            "Cannot change 'backing' link from 'commit-filter' to 'node2'")
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
         self.assert_qmp(result, 'return', {})
@@ -406,13 +406,15 @@ class TestParallelOps(iotests.QMPTestCase):
         # Stream from node2 into node4
         result = self.vm.qmp('block-stream', device='node4',
                              base_node='commit-filter', job_id='node4')
-        self.assert_qmp(result, 'return', {})
+        self.assert_qmp(result, 'error/desc',
+                        "Cannot freeze 'backing' link to 'commit-filter'")
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
         self.assert_qmp(result, 'return', {})
 
-        self.vm.run_job(job='drive0', auto_dismiss=True)
-        self.vm.run_job(job='node4', auto_dismiss=True)
+        self.wait_until_completed()
+        #self.vm.run_job(job='drive0', auto_dismiss=True)
+        #self.vm.run_job(job='node4', auto_dismiss=True)
         self.assert_no_active_block_jobs()
 
     # Test a block-stream and a block-commit job in parallel
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 5035763..b9399ef 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -872,7 +872,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
         # We can remove hd2 while the stream job is ongoing
         opts['backing']['backing'] = None
-        self.reopen(opts, {})
+        self.reopen(opts, {}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
 
         # We can't remove hd1 while the stream job is ongoing
         opts['backing'] = None
diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
deleted file mode 100755
index e305a15..0000000
--- a/tests/qemu-iotests/258
+++ /dev/null
@@ -1,161 +0,0 @@
-#!/usr/bin/env python3
-#
-# Very specific tests for adjacent commit/stream block jobs
-#
-# Copyright (C) 2019 Red Hat, Inc.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-# Creator/Owner: Max Reitz <mreitz@redhat.com>
-
-import iotests
-from iotests import log, qemu_img, qemu_io_silent, \
-        filter_qmp_testfiles, filter_qmp_imgfmt
-
-# Returns a node for blockdev-add
-def node(node_name, path, backing=None, fmt=None, throttle=None):
-    if fmt is None:
-        fmt = iotests.imgfmt
-
-    res = {
-        'node-name': node_name,
-        'driver': fmt,
-        'file': {
-            'driver': 'file',
-            'filename': path
-        }
-    }
-
-    if backing is not None:
-        res['backing'] = backing
-
-    if throttle:
-        res['file'] = {
-            'driver': 'throttle',
-            'throttle-group': throttle,
-            'file': res['file']
-        }
-
-    return res
-
-# Finds a node in the debug block graph
-def find_graph_node(graph, node_id):
-    return next(node for node in graph['nodes'] if node['id'] == node_id)
-
-
-def test_concurrent_finish(write_to_stream_node):
-    log('')
-    log('=== Commit and stream finish concurrently (letting %s write) ===' % \
-        ('stream' if write_to_stream_node else 'commit'))
-    log('')
-
-    # All chosen in such a way that when the commit job wants to
-    # finish, it polls and thus makes stream finish concurrently --
-    # and the other way around, depending on whether the commit job
-    # is finalized before stream completes or not.
-
-    with iotests.FilePath('node4.img') as node4_path, \
-         iotests.FilePath('node3.img') as node3_path, \
-         iotests.FilePath('node2.img') as node2_path, \
-         iotests.FilePath('node1.img') as node1_path, \
-         iotests.FilePath('node0.img') as node0_path, \
-         iotests.VM() as vm:
-
-        # It is important to use raw for the base layer (so that
-        # permissions are just handed through to the protocol layer)
-        assert qemu_img('create', '-f', 'raw', node0_path, '64M') == 0
-
-        stream_throttle=None
-        commit_throttle=None
-
-        for path in [node1_path, node2_path, node3_path, node4_path]:
-            assert qemu_img('create', '-f', iotests.imgfmt, path, '64M') == 0
-
-        if write_to_stream_node:
-            # This is what (most of the time) makes commit finish
-            # earlier and then pull in stream
-            assert qemu_io_silent(node2_path,
-                                  '-c', 'write %iK 64K' % (65536 - 192),
-                                  '-c', 'write %iK 64K' % (65536 -  64)) == 0
-
-            stream_throttle='tg'
-        else:
-            # And this makes stream finish earlier
-            assert qemu_io_silent(node1_path,
-                                  '-c', 'write %iK 64K' % (65536 - 64)) == 0
-
-            commit_throttle='tg'
-
-        vm.launch()
-
-        vm.qmp_log('object-add',
-                   qom_type='throttle-group',
-                   id='tg',
-                   props={
-                       'x-iops-write': 1,
-                       'x-iops-write-max': 1
-                   })
-
-        vm.qmp_log('blockdev-add',
-                   filters=[filter_qmp_testfiles, filter_qmp_imgfmt],
-                   **node('node4', node4_path, throttle=stream_throttle,
-                     backing=node('node3', node3_path,
-                     backing=node('node2', node2_path,
-                     backing=node('node1', node1_path,
-                     backing=node('node0', node0_path, throttle=commit_throttle,
-                                  fmt='raw'))))))
-
-        vm.qmp_log('block-commit',
-                   job_id='commit',
-                   device='node4',
-                   filter_node_name='commit-filter',
-                   top_node='node1',
-                   base_node='node0',
-                   auto_finalize=False)
-
-        vm.qmp_log('block-stream',
-                   job_id='stream',
-                   device='node3',
-                   base_node='commit-filter')
-
-        if write_to_stream_node:
-            vm.run_job('commit', auto_finalize=False, auto_dismiss=True)
-            vm.run_job('stream', auto_finalize=True, auto_dismiss=True)
-        else:
-            # No, the jobs do not really finish concurrently here,
-            # the stream job does complete strictly before commit.
-            # But still, this is close enough for what we want to
-            # test.
-            vm.run_job('stream', auto_finalize=True, auto_dismiss=True)
-            vm.run_job('commit', auto_finalize=False, auto_dismiss=True)
-
-        # Assert that the backing node of node3 is node 0 now
-        graph = vm.qmp('x-debug-query-block-graph')['return']
-        for edge in graph['edges']:
-            if edge['name'] == 'backing' and \
-               find_graph_node(graph, edge['parent'])['name'] == 'node3':
-                assert find_graph_node(graph, edge['child'])['name'] == 'node0'
-                break
-
-
-def main():
-    log('Running tests:')
-    test_concurrent_finish(True)
-    test_concurrent_finish(False)
-
-if __name__ == '__main__':
-    # Need backing file and change-backing-file support
-    iotests.script_main(main,
-                        supported_fmts=['qcow2', 'qed'],
-                        supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/258.out b/tests/qemu-iotests/258.out
deleted file mode 100644
index ce6e9ba..0000000
--- a/tests/qemu-iotests/258.out
+++ /dev/null
@@ -1,33 +0,0 @@
-Running tests:
-
-=== Commit and stream finish concurrently (letting stream write) ===
-
-{"execute": "object-add", "arguments": {"id": "tg", "props": {"x-iops-write": 1, "x-iops-write-max": 1}, "qom-type": "throttle-group"}}
-{"return": {}}
-{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backing": {"backing": {"driver": "raw", "file": {"driver": "file", "filename": "TEST_DIR/PID-node0.img"}, "node-name": "node0"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node1.img"}, "node-name": "node1"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node2.img"}, "node-name": "node2"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node3.img"}, "node-name": "node3"}, "driver": "IMGFMT", "file": {"driver": "throttle", "file": {"driver": "file", "filename": "TEST_DIR/PID-node4.img"}, "throttle-group": "tg"}, "node-name": "node4"}}
-{"return": {}}
-{"execute": "block-commit", "arguments": {"auto-finalize": false, "base-node": "node0", "device": "node4", "filter-node-name": "commit-filter", "job-id": "commit", "top-node": "node1"}}
-{"return": {}}
-{"execute": "block-stream", "arguments": {"base-node": "commit-filter", "device": "node3", "job-id": "stream"}}
-{"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "commit"}}
-{"return": {}}
-{"data": {"id": "commit", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "commit", "len": 67108864, "offset": 67108864, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "stream", "len": 67108864, "offset": 67108864, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-
-=== Commit and stream finish concurrently (letting commit write) ===
-
-{"execute": "object-add", "arguments": {"id": "tg", "props": {"x-iops-write": 1, "x-iops-write-max": 1}, "qom-type": "throttle-group"}}
-{"return": {}}
-{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backing": {"backing": {"driver": "raw", "file": {"driver": "throttle", "file": {"driver": "file", "filename": "TEST_DIR/PID-node0.img"}, "throttle-group": "tg"}, "node-name": "node0"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node1.img"}, "node-name": "node1"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node2.img"}, "node-name": "node2"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node3.img"}, "node-name": "node3"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node4.img"}, "node-name": "node4"}}
-{"return": {}}
-{"execute": "block-commit", "arguments": {"auto-finalize": false, "base-node": "node0", "device": "node4", "filter-node-name": "commit-filter", "job-id": "commit", "top-node": "node1"}}
-{"return": {}}
-{"execute": "block-stream", "arguments": {"base-node": "commit-filter", "device": "node3", "job-id": "stream"}}
-{"return": {}}
-{"data": {"device": "stream", "len": 67108864, "offset": 67108864, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-finalize", "arguments": {"id": "commit"}}
-{"return": {}}
-{"data": {"id": "commit", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "commit", "len": 67108864, "offset": 67108864, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-- 
1.8.3.1


