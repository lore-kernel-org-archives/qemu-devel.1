Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C1E20665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C1E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTq1L-0006NU-7L
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:52:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTpwU-0003AB-PY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTpwT-0007vz-9s
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hTpwS-0007u4-QL; Thu, 23 May 2019 11:47:41 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hTpwL-0002xl-Mv; Thu, 23 May 2019 18:47:33 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:47:31 +0300
Message-Id: <20190523154733.54944-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190523154733.54944-1-vsementsov@virtuozzo.com>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/3] iotests: add test 255 to check bitmap life
 after snapshot + commit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two testcases with persistent bitmaps are not added here, as there are
bugs to be fixed soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/qemu/__init__.py    |  4 +-
 tests/qemu-iotests/255     | 81 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/255.out | 17 ++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 81d9657ec0..4c4317a55e 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -402,7 +402,7 @@ class QEMUMachine(object):
         self._qmp.clear_events()
         return events
 
-    def event_wait(self, name, timeout=60.0, match=None):
+    def event_wait(self, name, timeout=60.0, match=None, fail_on=None):
         """
         Wait for specified timeout on named event in QMP; optionally filter
         results by match.
@@ -430,6 +430,7 @@ class QEMUMachine(object):
 
         # Search cached events
         for event in self._events:
+            assert event['event'] != fail_on
             if (event['event'] == name) and event_match(event, match):
                 self._events.remove(event)
                 return event
@@ -437,6 +438,7 @@ class QEMUMachine(object):
         # Poll for new events
         while True:
             event = self._qmp.pull_event(wait=timeout)
+            assert event['event'] != fail_on
             if (event['event'] == name) and event_match(event, match):
                 return event
             self._events.append(event)
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
new file mode 100755
index 0000000000..36712689d3
--- /dev/null
+++ b/tests/qemu-iotests/255
@@ -0,0 +1,81 @@
+#!/usr/bin/env python
+#
+# Tests for temporary external snapshot when we have bitmaps.
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import iotests
+from iotests import qemu_img_create, file_path, log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+base, top = file_path('base', 'top')
+size = 64 * 1024 * 3
+
+
+def print_bitmap(msg, vm):
+    result = vm.qmp('query-block')['return'][0]
+    if 'dirty-bitmaps' in result:
+        bitmap = result['dirty-bitmaps'][0]
+        log('{}: name={} dirty-clusters={}'.format(msg, bitmap['name'],
+            bitmap['count'] // 64 // 1024))
+    else:
+        log(msg + ': not found')
+
+
+def test(persistent, restart):
+    assert persistent or not restart
+    log("\nTestcase {}persistent {} restart\n".format(
+            '' if persistent else 'non-', 'with' if restart else 'without'))
+
+    qemu_img_create('-f', iotests.imgfmt, base, str(size))
+
+    vm = iotests.VM().add_drive(base)
+    vm.launch()
+
+    vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0',
+               persistent=persistent)
+    vm.hmp_qemu_io('drive0', 'write 0 64K')
+    print_bitmap('initial bitmap', vm)
+
+    vm.qmp_log('blockdev-snapshot-sync', device='drive0', snapshot_file=top,
+               format=iotests.imgfmt, filters=[iotests.filter_qmp_testfiles])
+    vm.hmp_qemu_io('drive0', 'write 64K 512')
+    print_bitmap('check, that no bitmaps in snapshot', vm)
+
+    if restart:
+        log("... Restart ...")
+        vm.shutdown()
+        vm = iotests.VM().add_drive(top)
+        vm.launch()
+
+    vm.qmp_log('block-commit', device='drive0', top=top,
+               filters=[iotests.filter_qmp_testfiles])
+    log(vm.event_wait('BLOCK_JOB_READY', fail_on='BLOCK_JOB_COMPLETED'),
+        filters=[iotests.filter_qmp_event])
+    vm.qmp_log('block-job-complete', device='drive0')
+    log(vm.event_wait('BLOCK_JOB_COMPLETED'),
+        filters=[iotests.filter_qmp_event])
+    print_bitmap('check merged bitmap', vm)
+
+    vm.hmp_qemu_io('drive0', 'write 128K 64K')
+    print_bitmap('check updated bitmap', vm)
+
+    vm.shutdown()
+
+
+test(persistent=False, restart=False)
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
new file mode 100644
index 0000000000..2bffb486d2
--- /dev/null
+++ b/tests/qemu-iotests/255.out
@@ -0,0 +1,17 @@
+
+Testcase non-persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": false}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check, that no bitmaps in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check merged bitmap: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 52b7c16e15..2758f48143 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -251,3 +251,4 @@
 249 rw auto quick
 252 rw auto backing quick
 253 rw auto quick
+255 rw auto quick
-- 
2.18.0


