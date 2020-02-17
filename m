Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69EDC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800122070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800122070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i0D-0005Kw-Mf
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvf-0004kW-R4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hve-0007Wo-DQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hve-0007LA-4h; Mon, 17 Feb 2020 10:03:22 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvG-0007Zt-SE; Mon, 17 Feb 2020 18:02:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/22] qemu-iotests/199: increase postcopy period
Date: Mon, 17 Feb 2020 18:02:41 +0300
Message-Id: <20200217150246.29180-18-vsementsov@virtuozzo.com>
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

Test wants force bitmap postcopy. Still, resulting postcopy period is
very small. Let's increase it by adding more bitmaps to migrate. Also,
test disabled bitmaps migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199 | 58 ++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 7914fd0b2b..9a6e8dcb9d 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -103,29 +103,45 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
     def test_postcopy(self):
         granularity = 512
+        nb_bitmaps = 15
 
-        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
-                               name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {})
+        for i in range(nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                                   name='bitmap{}'.format(i),
+                                   granularity=granularity)
+            self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
+                               node='drive0', name='bitmap0')
         empty_sha256 = result['return']['sha256']
 
-        apply_discards(self.vm_a, discards1 + discards2)
+        apply_discards(self.vm_a, discards1)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        sha256 = result['return']['sha256']
+                               node='drive0', name='bitmap0')
+        discards1_sha256 = result['return']['sha256']
 
         # Check, that updating the bitmap by discards works
-        assert sha256 != empty_sha256
+        assert discards1_sha256 != empty_sha256
 
-        result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
-                               name='bitmap')
-        self.assert_qmp(result, 'return', {})
+        # We want to calculate resulting sha256. Do it in bitmap0, so, disable
+        # other bitmaps
+        for i in range(1, nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-disable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
 
-        apply_discards(self.vm_a, discards1)
+        apply_discards(self.vm_a, discards2)
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        all_discards_sha256 = result['return']['sha256']
+
+        # Now, enable some bitmaps, to be updated during migration
+        for i in range(2, nb_bitmaps, 2):
+            result = self.vm_a.qmp('block-dirty-bitmap-enable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
 
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
                 {'capability': 'events', 'state': True}]
@@ -145,6 +161,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         e_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(e_resume)
 
+        # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)
 
         match = {'data': {'status': 'completed'}}
@@ -158,7 +175,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         downtime = event_dist(e_stop, e_resume)
         postcopy_time = event_dist(e_resume, e_complete)
 
-        # TODO: assert downtime * 10 < postcopy_time
+        assert downtime * 10 < postcopy_time
         if debug:
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
@@ -166,12 +183,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         # Assert that bitmap migration is finished (check that successor bitmap
         # is removed)
         result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == 1
-
-        # Check content of migrated (and updated by new writes) bitmap
-        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        self.assert_qmp(result, 'return/sha256', sha256)
+        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
+
+        # Check content of migrated bitmaps. Still, don't waste time checking
+        # every bitmap
+        for i in range(0, nb_bitmaps, 5):
+            result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                                   node='drive0', name='bitmap{}'.format(i))
+            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha256)
 
 
 if __name__ == '__main__':
-- 
2.21.0


