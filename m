Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B5C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351722467E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351722467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG0y-0000su-Nm
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyw-0006mi-Ie
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyv-0002MV-F8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:42306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFys-0002I2-R0; Wed, 22 Jan 2020 08:23:39 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFyk-00057B-Oq; Wed, 22 Jan 2020 16:23:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/7] qemu-iotests/199: add early shutdown case to bitmaps
 postcopy
Date: Wed, 22 Jan 2020 16:23:28 +0300
Message-Id: <20200122132328.31156-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200122132328.31156-1-vsementsov@virtuozzo.com>
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patches fixed two crashes which may occur on shutdown prior to
bitmaps postcopy finished. Check that it works now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199     | 12 +++++++++++-
 tests/qemu-iotests/199.out |  4 ++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index a2c8ecab5a..a3f6c73aed 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -47,7 +47,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         self.vm_b.launch()
 
-    def test_postcopy(self):
+    def do_test_postcopy(self, early_shutdown):
         write_size = 0x40000000
         granularity = 512
         chunk = 4096
@@ -99,6 +99,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             if event['data']['status'] == 'completed':
                 break
 
+        if early_shutdown:
+            self.vm_b.qmp('quit')
+            return
+
         s = 0x8000
         while s < write_size:
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
@@ -114,6 +118,12 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         self.assert_qmp(result, 'return/sha256', sha256);
 
+    def test_postcopy(self):
+        self.do_test_postcopy(False)
+
+    def test_postcopy_early_shutdown(self):
+        self.do_test_postcopy(True)
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/199.out
+++ b/tests/qemu-iotests/199.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
-- 
2.21.0


