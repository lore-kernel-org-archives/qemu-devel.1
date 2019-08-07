Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D38C41514
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F11E21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F11E21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMh8-0001nH-LL
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36615)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007le-3S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg6-0003KA-RR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:40620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg3-0003Cs-VD; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMfz-0005oH-HZ; Wed, 07 Aug 2019 17:12:27 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:19 +0300
Message-Id: <20190807141226.193501-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to test
 reopening qcow2 bitmaps to RW
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reopening bitmaps to RW was broken prior to previous commit. Check that
it works now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/165     | 46 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/165.out |  4 ++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 88f62d3c6d..dd93b5a2d0 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -43,10 +43,10 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         os.remove(disk)
 
     def mkVm(self):
-        return iotests.VM().add_drive(disk)
+        return iotests.VM().add_drive(disk, opts='node-name=node0')
 
     def mkVmRo(self):
-        return iotests.VM().add_drive(disk, opts='readonly=on')
+        return iotests.VM().add_drive(disk, opts='readonly=on,node-name=node0')
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -102,5 +102,47 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
         self.vm.shutdown()
 
+    def test_reopen_rw(self):
+        self.vm = self.mkVm()
+        self.vm.launch()
+        self.qmpAddBitmap()
+
+        # Calculate sha256 corresponding to regions1
+        self.writeRegions(regions1)
+        sha256 = self.getSha256()
+        result = self.vm.qmp('block-dirty-bitmap-clear', node='drive0',
+                             name='bitmap0')
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.shutdown()
+
+        self.vm = self.mkVmRo()
+        self.vm.launch()
+
+        # We've loaded empty bitmap
+        assert sha256 != self.getSha256()
+
+        # Check that we are in RO mode
+        self.writeRegions(regions1)
+        assert sha256 != self.getSha256()
+
+        result = self.vm.qmp('x-blockdev-reopen', **{
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': disk
+            },
+            'read-only': False
+        })
+        self.assert_qmp(result, 'return', {})
+
+        # Check that bitmap is reopened to RW and we can write to it.
+        self.writeRegions(regions1)
+        assert sha256 == self.getSha256()
+
+        self.vm.shutdown()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/165.out b/tests/qemu-iotests/165.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/165.out
+++ b/tests/qemu-iotests/165.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
-- 
2.18.0


