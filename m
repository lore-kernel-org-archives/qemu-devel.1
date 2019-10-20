Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CACA9EAE
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C9E21928
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C9E21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMHyX-0007DH-Ct
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 16:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMHx7-0005vO-5N
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMHx5-0006Xf-J6
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:37:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:58844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iMHx5-0006Wu-Bn; Sun, 20 Oct 2019 16:37:23 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iMHx1-00089m-Py; Sun, 20 Oct 2019 23:37:19 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v5 4/4] tests/qemu-iotests: add case for block-stream compress
Date: Sun, 20 Oct 2019 23:37:08 +0300
Message-Id: <1571603828-185910-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a case to the iotest #030 that tests the 'compress' option for a
block-stream job.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/030     | 34 +++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index f3766f2..f33fd21 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -21,7 +21,8 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, qemu_img_pipe
+import json
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
@@ -956,6 +957,37 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.cancel_and_wait(resume=True)
 
+class TestCompressed(iotests.QMPTestCase):
+    allocated_clusters = 8
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-o',
+                 'backing_file={}'.format(backing_img), test_img)
+        cluster_size = 0x10000
+        data_size = self.allocated_clusters * cluster_size
+        qemu_io('-c', 'write -P 0x1 0 {}'.format(data_size), backing_img)
+        self.vm = iotests.VM().add_drive(test_img, "compress=on")
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(test_img)
+        os.remove(backing_img)
+
+    def test_stream_compress(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('block-stream', device='drive0')
+        self.assert_qmp(result, 'return', {})
+
+        match = {'data': {'type': 'stream', 'device': 'drive0'}}
+        self.vm.event_wait(name='BLOCK_JOB_COMPLETED', match=match)
+        self.vm.shutdown()
+
+        top = json.loads(qemu_img_pipe('check', '--output=json', test_img))
+        self.assertEqual(top['compressed-clusters'], self.allocated_clusters)
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 6d9bee1..af8dac1 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-...........................
+............................
 ----------------------------------------------------------------------
-Ran 27 tests
+Ran 28 tests
 
 OK
-- 
1.8.3.1


