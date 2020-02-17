Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA245C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFAC2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFAC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hzv-0004Zw-1D
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvM-000446-5p
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvK-0007Nn-AH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:47440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvK-0007LB-23; Mon, 17 Feb 2020 10:03:02 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvG-0007Zt-2d; Mon, 17 Feb 2020 18:02:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/22] qemu-iotests/199: better catch postcopy time
Date: Mon, 17 Feb 2020 18:02:38 +0300
Message-Id: <20200217150246.29180-15-vsementsov@virtuozzo.com>
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

The test aims to test _postcopy_ migration, and wants to do some write
operations during postcopy time.

Test considers migrate status=complete event on source as start of
postcopy. This is completely wrong, completion is completion of the
whole migration process. Let's instead consider destination start as
start of postcopy, and use RESUME event for it.

Next, as migration finish, let's use migration status=complete event on
target, as such method is closer to what libvirt or another user will
do, than tracking number of dirty-bitmaps.

Finally, add a possibility to dump events for debug. And if
set debug to True, we see, that actual postcopy period is very small
relatively to the whole test duration time (~0.2 seconds to >40 seconds
for me). This means, that test is very inefficient in what it supposed
to do. Let's improve it in following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index dda918450a..6599fc6fb4 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -20,17 +20,43 @@
 
 import os
 import iotests
-import time
 from iotests import qemu_img
 
+debug = False
+
 disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
 
+def event_seconds(event):
+    return event['timestamp']['seconds'] + \
+        event['timestamp']['microseconds'] / 1000000.0
+
+
+def event_dist(e1, e2):
+    return event_seconds(e2) - event_seconds(e1)
+
+
 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
+        if debug:
+            self.vm_a_events += self.vm_a.get_qmp_events()
+            self.vm_b_events += self.vm_b.get_qmp_events()
+            for e in self.vm_a_events:
+                e['vm'] = 'SRC'
+            for e in self.vm_b_events:
+                e['vm'] = 'DST'
+            events = (self.vm_a_events + self.vm_b_events)
+            events = [(e['timestamp']['seconds'],
+                       e['timestamp']['microseconds'],
+                       e['vm'],
+                       e['event'],
+                       e.get('data', '')) for e in events]
+            for e in sorted(events):
+                print('{}.{:06} {} {} {}'.format(*e))
+
         self.vm_a.shutdown()
         self.vm_b.shutdown()
         os.remove(disk_a)
@@ -47,6 +73,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         self.vm_b.launch()
 
+        # collect received events for debug
+        self.vm_a_events = []
+        self.vm_b_events = []
+
     def test_postcopy(self):
         write_size = 0x40000000
         granularity = 512
@@ -77,15 +107,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
-        bitmaps_cap = {'capability': 'dirty-bitmaps', 'state': True}
-        events_cap = {'capability': 'events', 'state': True}
+        caps = [{'capability': 'dirty-bitmaps', 'state': True},
+                {'capability': 'events', 'state': True}]
 
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=[bitmaps_cap, events_cap])
+        result = self.vm_a.qmp('migrate-set-capabilities', capabilities=caps)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm_b.qmp('migrate-set-capabilities',
-                               capabilities=[bitmaps_cap])
+        result = self.vm_b.qmp('migrate-set-capabilities', capabilities=caps)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
@@ -94,24 +122,38 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         result = self.vm_a.qmp('migrate-start-postcopy')
         self.assert_qmp(result, 'return', {})
 
-        while True:
-            event = self.vm_a.event_wait('MIGRATION')
-            if event['data']['status'] == 'completed':
-                break
+        e_resume = self.vm_b.event_wait('RESUME')
+        self.vm_b_events.append(e_resume)
 
         s = 0x8000
         while s < write_size:
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
+        match = {'data': {'status': 'completed'}}
+        e_complete = self.vm_b.event_wait('MIGRATION', match=match)
+        self.vm_b_events.append(e_complete)
+
+        # take queued event, should already been happened
+        e_stop = self.vm_a.event_wait('STOP')
+        self.vm_a_events.append(e_stop)
+
+        downtime = event_dist(e_stop, e_resume)
+        postcopy_time = event_dist(e_resume, e_complete)
+
+        # TODO: assert downtime * 10 < postcopy_time
+        if debug:
+            print('downtime:', downtime)
+            print('postcopy_time:', postcopy_time)
+
+        # Assert that bitmap migration is finished (check that successor bitmap
+        # is removed)
         result = self.vm_b.qmp('query-block')
-        while len(result['return'][0]['dirty-bitmaps']) > 1:
-            time.sleep(2)
-            result = self.vm_b.qmp('query-block')
+        assert len(result['return'][0]['dirty-bitmaps']) == 1
 
+        # Check content of migrated (and updated by new writes) bitmap
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
-
         self.assert_qmp(result, 'return/sha256', sha256)
 
 
-- 
2.21.0


