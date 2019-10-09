Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB9ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9148020B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9148020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFXU-00021W-J3
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7Xs-0008Ls-5D
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7Xq-00020k-Gk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:42:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:45618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iI7Xm-0001qt-TQ; Wed, 09 Oct 2019 04:42:03 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iI7Xj-0008Sl-C4; Wed, 09 Oct 2019 11:41:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 3/3] iotests: test nbd reconnect
Date: Wed,  9 Oct 2019 11:41:58 +0300
Message-Id: <20191009084158.15614-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009084158.15614-1-vsementsov@virtuozzo.com>
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add test, which starts backup to nbd target and restarts nbd server
during backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/264        | 95 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/264.out    | 13 +++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 11 ++++
 4 files changed, 120 insertions(+)
 create mode 100755 tests/qemu-iotests/264
 create mode 100644 tests/qemu-iotests/264.out

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
new file mode 100755
index 0000000000..c8cd97ae2b
--- /dev/null
+++ b/tests/qemu-iotests/264
@@ -0,0 +1,95 @@
+#!/usr/bin/env python
+#
+# Test nbd reconnect
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+from iotests import qemu_img_create, qemu_io_silent_check, file_path, \
+        qemu_nbd_popen, log
+
+disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
+nbd_uri = 'nbd+unix:///?socket=' + nbd_sock
+size = 5 * 1024 * 1024
+wait_limit = 3
+wait_step = 0.2
+
+qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
+qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
+srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+
+# Wait for NBD server availability
+t = 0
+ok = False
+while t < wait_limit:
+    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
+    if ok:
+        break
+    time.sleep(wait_step)
+    t += wait_step
+
+assert ok
+
+vm = iotests.VM().add_drive(disk_a)
+vm.launch()
+vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
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
+# Wait for some progress
+t = 0
+while t < wait_limit:
+    jobs = vm.qmp('query-block-jobs')['return']
+    if jobs and jobs[0]['offset'] > 0:
+        break
+    time.sleep(wait_step)
+    t += wait_step
+
+if jobs and jobs[0]['offset'] > 0:
+    log('Backup job is started')
+
+log('Kill NBD server')
+srv.kill()
+srv.wait()
+
+jobs = vm.qmp('query-block-jobs')['return']
+if jobs and jobs[0]['offset'] < jobs[0]['len']:
+    log('Backup job is still in progress')
+
+vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
+
+# Emulate server down time for 1 second
+time.sleep(1)
+
+log('Start NBD server')
+srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+
+e = vm.event_wait('BLOCK_JOB_COMPLETED')
+log('Backup completed: {}'.format(e['data']['offset']))
+
+vm.qmp_log('blockdev-del', node_name='backup0')
+srv.kill()
+vm.shutdown()
diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
new file mode 100644
index 0000000000..3000944b09
--- /dev/null
+++ b/tests/qemu-iotests/264.out
@@ -0,0 +1,13 @@
+{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
+{"return": {}}
+Backup job is started
+Kill NBD server
+Backup job is still in progress
+{"execute": "block-job-set-speed", "arguments": {"device": "drive0", "speed": 0}}
+{"return": {}}
+Start NBD server
+Backup completed: 5242880
+{"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5805a79d9e..71ff0fc015 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -275,6 +275,7 @@
 258 rw quick
 262 rw quick migration
 263 rw quick
+264 rw
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9fb5181c3d..60d1e86b6d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -165,6 +165,13 @@ def qemu_io_silent(*args):
                          (-exitcode, ' '.join(args)))
     return exitcode
 
+def qemu_io_silent_check(*args):
+    '''Run qemu-io and return the true if subprocess returned 0'''
+    args = qemu_io_args + list(args)
+    exitcode = subprocess.call(args, stdout=open('/dev/null', 'w'),
+                               stderr=subprocess.STDOUT)
+    return exitcode == 0
+
 def get_virtio_scsi_device():
     if qemu_default_machine == 's390-ccw-virtio':
         return 'virtio-scsi-ccw'
@@ -230,6 +237,10 @@ def qemu_nbd_early_pipe(*args):
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


