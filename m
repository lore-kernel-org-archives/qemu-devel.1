Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96576C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC022053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC022053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDtY-0000R6-K3
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZDr7-00068s-3w
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZDr5-0008Td-Vy
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:52:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:42310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZDr3-0008P0-46; Mon, 25 Nov 2019 07:52:37 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZDqx-0007wx-IQ; Mon, 25 Nov 2019 15:52:31 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: add new test cases to bitmap migration
Date: Mon, 25 Nov 2019 15:52:29 +0300
Message-Id: <20191125125229.13531-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125125229.13531-1-vsementsov@virtuozzo.com>
References: <20191125125229.13531-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add optional pre-shutdown: shutdown/launch vm before migration. This
leads to storing persistent bitmap to the storage, which breaks
migration with dirty-bitmaps capability enabled and shared storage
until fixed by previous commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169     | 22 +++++++++++++++-------
 tests/qemu-iotests/169.out |  4 ++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 8c204caf20..9656a7f620 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -134,7 +134,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.check_bitmap(self.vm_a, sha256 if persistent else False)
 
     def do_test_migration(self, persistent, migrate_bitmaps, online,
-                          shared_storage):
+                          shared_storage, pre_shutdown):
         granularity = 512
 
         # regions = ((start, count), ...)
@@ -142,15 +142,13 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                    (0xf0000, 0x10000),
                    (0xa0201, 0x1000))
 
-        should_migrate = migrate_bitmaps or persistent and shared_storage
+        should_migrate = \
+            (migrate_bitmaps and (persistent or not pre_shutdown)) or \
+            (persistent and shared_storage)
         mig_caps = [{'capability': 'events', 'state': True}]
         if migrate_bitmaps:
             mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
 
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=mig_caps)
-        self.assert_qmp(result, 'return', {})
-
         self.vm_b.add_incoming(incoming_cmd if online else "defer")
         self.vm_b.add_drive(disk_a if shared_storage else disk_b)
 
@@ -166,6 +164,14 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 = self.get_bitmap_hash(self.vm_a)
 
+        if pre_shutdown:
+            self.vm_a.shutdown()
+            self.vm_a.launch()
+
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=mig_caps)
+        self.assert_qmp(result, 'return', {})
+
         result = self.vm_a.qmp('migrate', uri=mig_cmd)
         while True:
             event = self.vm_a.event_wait('MIGRATION')
@@ -210,11 +216,13 @@ def inject_test_case(klass, name, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
     setattr(klass, 'test_' + method + name, lambda self: mc(self))
 
-for cmb in list(itertools.product((True, False), repeat=4)):
+for cmb in list(itertools.product((True, False), repeat=5)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
     name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
     name += '_online' if cmb[2] else '_offline'
     name += '_shared' if cmb[3] else '_nonshared'
+    if (cmb[4]):
+        name += '__pre_shutdown'
 
     inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
                      *list(cmb))
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index 3a89159833..5c26d15c0d 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-....................
+....................................
 ----------------------------------------------------------------------
-Ran 20 tests
+Ran 36 tests
 
 OK
-- 
2.21.0


