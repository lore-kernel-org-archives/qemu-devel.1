Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CFC54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A6F20673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWQD-0004Rv-Np
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHm-0004xe-2V; Tue, 12 May 2020 10:53:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:45872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHh-0005p5-EV; Tue, 12 May 2020 10:53:33 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHZ-0003c8-Uf; Tue, 12 May 2020 17:53:22 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/15] block: prepare block-stream for using COR-filter
Date: Tue, 12 May 2020 17:53:10 +0300
Message-Id: <1589295196-773454-10-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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

This patch is the first one in the series where the COR-filter node
will be hard-coded for using in the block-stream job. The block jobs
may be run in parallel. Exclude conflicts with filter nodes used for
a concurrent job while checking for the blocked operations. It incurs
changes in the iotests 030::test_overlapping_4 that now passes with no
conflict because the stream job does not have a real dependency on its
base and on a filter above it.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 blockdev.c             | 11 +++++++++--
 tests/qemu-iotests/030 |  9 ++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index b3c840e..97c2ba2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2763,6 +2763,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     Error *local_err = NULL;
     const char *base_name = NULL;
     int job_flags = JOB_DEFAULT;
+    BlockDriverState *bottom_cow_node;
 
     if (!has_on_error) {
         on_error = BLOCKDEV_ON_ERROR_REPORT;
@@ -2807,8 +2808,14 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         base_name = base_bs->filename;
     }
 
-    /* Check for op blockers in the whole chain between bs and base */
-    for (iter = bs; iter && iter != base_bs; iter = backing_bs(iter)) {
+    bottom_cow_node = bdrv_find_overlay(bs, base_bs);
+    if (!bottom_cow_node) {
+        error_setg(errp, "bottom node is not found, nothing to stream");
+        goto out;
+    }
+    /* Check for op blockers in the whole chain between bs and bottom */
+    for (iter = bs; iter && iter != bdrv_filtered_bs(bottom_cow_node);
+         iter = bdrv_filtered_bs(iter)) {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 104e3ce..d7638cd 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -368,8 +368,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.wait_until_completed(drive='commit-drive0')
 
     # In this case the base node of the stream job is the same as the
-    # top node of commit job. Since this results in the commit filter
-    # node being part of the stream chain, this is not allowed.
+    # top node of commit job.
     def test_overlapping_4(self):
         self.assert_no_active_block_jobs()
 
@@ -381,13 +380,13 @@ class TestParallelOps(iotests.QMPTestCase):
 
         # Stream from node2 into node4
         result = self.vm.qmp('block-stream', device='node4', base_node='node2', job_id='node4')
-        self.assert_qmp(result, 'error/desc',
-            "Cannot freeze 'backing' link to 'commit-filter'")
+        self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
         self.assert_qmp(result, 'return', {})
 
-        self.wait_until_completed()
+        self.vm.run_job(job='drive0', auto_dismiss=True)
+        self.vm.run_job(job='node4', auto_dismiss=True)
         self.assert_no_active_block_jobs()
 
     # In this case the base node of the stream job is the commit job's
-- 
1.8.3.1


