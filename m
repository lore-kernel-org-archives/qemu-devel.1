Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29199C34027
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027AE20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027AE20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i66-0007br-6o
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvf-0004kJ-OJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hve-0007Ws-Da
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hve-0007L8-50; Mon, 17 Feb 2020 10:03:22 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvH-0007Zt-Ai; Mon, 17 Feb 2020 18:02:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/22] qemu-iotests/199: prepare for new test-cases addition
Date: Mon, 17 Feb 2020 18:02:43 +0300
Message-Id: <20200217150246.29180-20-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move future common part to start_postcopy() method. Move checking
number of bitmaps to check_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199 | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 9a6e8dcb9d..969620b103 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -29,6 +29,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
+granularity = 512
+nb_bitmaps = 15
 
 GiB = 1024 * 1024 * 1024
 
@@ -61,6 +63,15 @@ def event_dist(e1, e2):
     return event_seconds(e2) - event_seconds(e1)
 
 
+def check_bitmaps(vm, count):
+    result = vm.qmp('query-block')
+
+    if count == 0:
+        assert 'dirty-bitmaps' not in result['return'][0]
+    else:
+        assert len(result['return'][0]['dirty-bitmaps']) == count
+
+
 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         if debug:
@@ -101,10 +112,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a_events = []
         self.vm_b_events = []
 
-    def test_postcopy(self):
-        granularity = 512
-        nb_bitmaps = 15
-
+    def start_postcopy(self):
+        """ Run migration until RESUME event on target. Return this event. """
         for i in range(nb_bitmaps):
             result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                    name='bitmap{}'.format(i),
@@ -119,10 +128,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        discards1_sha256 = result['return']['sha256']
+        self.discards1_sha256 = result['return']['sha256']
 
         # Check, that updating the bitmap by discards works
-        assert discards1_sha256 != empty_sha256
+        assert self.discards1_sha256 != empty_sha256
 
         # We want to calculate resulting sha256. Do it in bitmap0, so, disable
         # other bitmaps
@@ -135,7 +144,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        all_discards_sha256 = result['return']['sha256']
+        self.all_discards_sha256 = result['return']['sha256']
 
         # Now, enable some bitmaps, to be updated during migration
         for i in range(2, nb_bitmaps, 2):
@@ -160,6 +169,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         e_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(e_resume)
+        return e_resume
+
+    def test_postcopy_success(self):
+        e_resume = self.start_postcopy()
 
         # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)
@@ -180,18 +193,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
 
-        # Assert that bitmap migration is finished (check that successor bitmap
-        # is removed)
-        result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
+        check_bitmaps(self.vm_b, nb_bitmaps)
 
         # Check content of migrated bitmaps. Still, don't waste time checking
         # every bitmap
         for i in range(0, nb_bitmaps, 5):
             result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                    node='drive0', name='bitmap{}'.format(i))
-            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
-            self.assert_qmp(result, 'return/sha256', sha256)
+            sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha)
 
 
 if __name__ == '__main__':
-- 
2.21.0


