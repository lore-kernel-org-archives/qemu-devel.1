Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF918C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FE22146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrM4-0003nl-QD
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCp-0003fl-WC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCn-0000N6-VX
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:49752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDqCj-0000IU-MZ; Fri, 27 Sep 2019 09:22:37 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpHz-0003za-25; Fri, 27 Sep 2019 15:23:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 7/9] iotests: add test 260 to check bitmap life after
 snapshot + commit
Date: Fri, 27 Sep 2019 15:23:53 +0300
Message-Id: <20190927122355.7344-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927122355.7344-1-vsementsov@virtuozzo.com>
References: <20190927122355.7344-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/260     | 89 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/260.out | 52 ++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 142 insertions(+)
 create mode 100755 tests/qemu-iotests/260
 create mode 100644 tests/qemu-iotests/260.out

diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
new file mode 100755
index 0000000000..4f6082c9d2
--- /dev/null
+++ b/tests/qemu-iotests/260
@@ -0,0 +1,89 @@
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
+from iotests import qemu_img_create, file_path, log, filter_qmp_event
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
+    print_bitmap('check that no bitmaps are in snapshot', vm)
+
+    if restart:
+        log("... Restart ...")
+        vm.shutdown()
+        vm = iotests.VM().add_drive(top)
+        vm.launch()
+
+    vm.qmp_log('block-commit', device='drive0', top=top,
+               filters=[iotests.filter_qmp_testfiles])
+    ev = vm.events_wait((('BLOCK_JOB_READY', None),
+                         ('BLOCK_JOB_COMPLETED', None)))
+    log(filter_qmp_event(ev))
+    if (ev['event'] == 'BLOCK_JOB_COMPLETED'):
+        vm.shutdown()
+        log(vm.get_log())
+        exit()
+
+    vm.qmp_log('block-job-complete', device='drive0')
+    ev = vm.event_wait('BLOCK_JOB_COMPLETED')
+    log(filter_qmp_event(ev))
+    print_bitmap('check bitmap after commit', vm)
+
+    vm.hmp_qemu_io('drive0', 'write 128K 64K')
+    print_bitmap('check updated bitmap', vm)
+
+    vm.shutdown()
+
+
+test(persistent=False, restart=False)
+test(persistent=True, restart=False)
+test(persistent=True, restart=True)
diff --git a/tests/qemu-iotests/260.out b/tests/qemu-iotests/260.out
new file mode 100644
index 0000000000..2f0d98d036
--- /dev/null
+++ b/tests/qemu-iotests/260.out
@@ -0,0 +1,52 @@
+
+Testcase non-persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": false}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent with restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+... Restart ...
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5d3da937e4..5ed068220e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,6 +273,7 @@
 256 rw quick
 257 rw
 258 rw quick
+260 rw auto quick
 262 rw quick migration
 263 rw quick
 265 rw auto quick
-- 
2.21.0


