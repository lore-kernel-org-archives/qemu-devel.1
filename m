Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C00C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F922084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdbn-00021z-7U
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:35:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTn-0004ZL-Dd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bz-Ra
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003a0-EQ; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTj-00044D-Fc; Thu, 11 Apr 2019 20:27:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:09 +0300
Message-Id: <20190411172709.205032-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 7/7] iotests: test nbd reconnect
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411172709.FCgMylj5OKw016gGPIBhw5wOUviyQYDJMMfCZ6Hzbk0@z>

Add test, which starts backup to nbd target and restarts nbd server
during backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/249        | 63 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out    | 10 ++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py |  4 +++
 4 files changed, 78 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
new file mode 100755
index 0000000000..a29a276207
--- /dev/null
+++ b/tests/qemu-iotests/249
@@ -0,0 +1,63 @@
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
+vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0')
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
+e = vm.event_wait('BLOCK_JOB_COMPLETED')
+log('Backup completed: {}'.format(e['data']['offset']))
+
+vm.qmp_log('blockdev-del', node_name='backup0')
+srv.kill()
+vm.shutdown()
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
new file mode 100644
index 0000000000..15a82ddefb
--- /dev/null
+++ b/tests/qemu-iotests/249.out
@@ -0,0 +1,10 @@
+{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "sync": "full", "target": "backup0"}}
+{"return": {}}
+Kill NBD server
+Backup job is still in progress
+Start NBD server
+Backup completed: 5242880
+{"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..7ac9a5ea4a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+249 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 997dc910cb..3a1f16dbfd 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -218,6 +218,10 @@ def qemu_nbd_pipe(*args):
                           ' '.join(qemu_nbd_args + ['--fork'] + list(args))))
     return exitcode, subp.communicate()[0]
 
+def qemu_nbd_popen(*args):
+    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
+    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+
 def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
     '''Return True if two image files are identical'''
     return qemu_img('compare', '-f', fmt1,
-- 
2.18.0


