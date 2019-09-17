Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9677E2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9677E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAH7Y-0002Fx-Id
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2h-0006ma-Fw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2f-00033j-VT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:55316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2c-000306-Mz; Tue, 17 Sep 2019 13:13:26 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2Z-0003rq-UA; Tue, 17 Sep 2019 20:13:24 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 20:13:22 +0300
Message-Id: <20190917171322.4127-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917171322.4127-1-vsementsov@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 3/3] iotests: test nbd reconnect
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add test, which starts backup to nbd target and restarts nbd server
during backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/264        | 65 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/264.out    | 12 +++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py |  4 +++
 4 files changed, 82 insertions(+)
 create mode 100755 tests/qemu-iotests/264
 create mode 100644 tests/qemu-iotests/264.out

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
new file mode 100755
index 0000000000..e70f91c5ca
--- /dev/null
+++ b/tests/qemu-iotests/264
@@ -0,0 +1,65 @@
+#!/usr/bin/env python
+#
+# Test nbd reconnect
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
+import time
+
+import iotests
+from iotests import qemu_img_create, file_path, qemu_nbd_popen, log
+
+disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
+
+qemu_img_create('-f', iotests.imgfmt, disk_a, '5M')
+qemu_img_create('-f', iotests.imgfmt, disk_b, '5M')
+srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+time.sleep(1)
+
+vm = iotests.VM().add_drive(disk_a)
+vm.launch()
+vm.hmp_qemu_io('drive0', 'write 0 5M')
+
+vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
+           **{'node_name': 'backup0',
+              'driver': 'raw',
+              'file': {'driver': 'nbd',
+                       'server': {'type': 'unix', 'path': nbd_sock},
+                       'reconnect-delay': 10}})
+vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
+           speed=(1 * 1024 * 1024))
+
+time.sleep(1)
+log('Kill NBD server')
+srv.kill()
+
+jobs = vm.qmp('query-block-jobs')['return']
+if jobs and jobs[0]['offset'] < jobs[0]['len']:
+    log('Backup job is still in progress')
+
+time.sleep(1)
+
+log('Start NBD server')
+srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+
+vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
+e = vm.event_wait('BLOCK_JOB_COMPLETED')
+log('Backup completed: {}'.format(e['data']['offset']))
+
+vm.qmp_log('blockdev-del', node_name='backup0')
+srv.kill()
+vm.shutdown()
diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
new file mode 100644
index 0000000000..4a2f4aa509
--- /dev/null
+++ b/tests/qemu-iotests/264.out
@@ -0,0 +1,12 @@
+{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
+{"return": {}}
+Kill NBD server
+Backup job is still in progress
+Start NBD server
+{"execute": "block-job-set-speed", "arguments": {"device": "drive0", "speed": 0}}
+{"return": {}}
+Backup completed: 5242880
+{"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5d3da937e4..4f6dd6f153 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -275,5 +275,6 @@
 258 rw quick
 262 rw quick migration
 263 rw quick
+264 rw quick
 265 rw auto quick
 266 rw quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b26271187c..a9c496dd7e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -229,6 +229,10 @@ def qemu_nbd_early_pipe(*args):
     else:
         return exitcode, subp.communicate()[0]
 
+def qemu_nbd_popen(*args):
+    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
+    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+
 def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
     '''Return True if two image files are identical'''
     return qemu_img('compare', '-f', fmt1,
-- 
2.21.0


