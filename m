Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5143220809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpnSgIfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5143220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ABo-0006pn-Je
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAC-0004v4-C9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAA-0004rn-FU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOJpc8RV8qvMz8aH/tH1tmr2hdSTKc/5P7btzVhxFp0=;
 b=OpnSgIfBjvnb2/VkzC0lC7w9ArxMFI4BBJeFhy2pNgAy+zn+bsXoi1hpp4HtvhXSlwSzGq
 yLlle2h9BEBKJhJX7xb5nIZxul6ALClJGZlMy6uDCQTiq7BlCOuIH852qmJgCUTuMQtyQT
 erSLi3aHCZIsKEERk3TUgwt9KrF6Ow4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-dMQax1MiM5uFCizsQ1mqMQ-1; Mon, 27 Jul 2020 16:55:55 -0400
X-MC-Unique: dMQax1MiM5uFCizsQ1mqMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2DC38E1361;
 Mon, 27 Jul 2020 20:55:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB39D19724;
 Mon, 27 Jul 2020 20:55:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] qemu-iotests/199: better catch postcopy time
Date: Mon, 27 Jul 2020 15:55:23 -0500
Message-Id: <20200727205543.206624-5-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-4-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index dda918450a8b..dd6044768c76 100755
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
+        event_resume = self.vm_b.event_wait('RESUME')
+        self.vm_b_events.append(event_resume)

         s = 0x8000
         while s < write_size:
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000

+        match = {'data': {'status': 'completed'}}
+        event_complete = self.vm_b.event_wait('MIGRATION', match=match)
+        self.vm_b_events.append(event_complete)
+
+        # take queued event, should already been happened
+        event_stop = self.vm_a.event_wait('STOP')
+        self.vm_a_events.append(event_stop)
+
+        downtime = event_dist(event_stop, event_resume)
+        postcopy_time = event_dist(event_resume, event_complete)
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
2.27.0


