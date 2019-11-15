Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE4E20733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE4E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVceq-00078L-13
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNL-0004eR-Jx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNK-0001yK-2E
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001rt-K4; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcND-0006WW-8I; Fri, 15 Nov 2019 17:14:55 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 23/24] python: add qemu/bench_block_job.py
Date: Fri, 15 Nov 2019 17:14:43 +0300
Message-Id: <20191115141444.24155-24-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115141444.24155-1-vsementsov@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add block-job benchmarking helper functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/qemu/bench_block_job.py | 114 +++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 python/qemu/bench_block_job.py

diff --git a/python/qemu/bench_block_job.py b/python/qemu/bench_block_job.py
new file mode 100755
index 0000000000..6a72be9ba2
--- /dev/null
+++ b/python/qemu/bench_block_job.py
@@ -0,0 +1,114 @@
+#!/usr/bin/env python
+#
+# Benchmark block jobs
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
+
+import socket
+import json
+from .machine import QEMUMachine
+
+
+def bench_block_job(cmd, cmd_args, qemu_args):
+    """Benchmark block-job
+
+    cmd       -- qmp command to run block-job (like blockdev-backup)
+    cmd_args  -- dict of qmp command arguments
+    qemu_args -- list of Qemu command line arguments, including path to Qemu
+                 binary
+
+    Returns {'seconds': int} on success and {'error': str} on failure, dict may
+    contain addional 'vm-log' field. Return value is compatible with
+    simplebench lib.
+    """
+
+    vm = QEMUMachine(qemu_args[0], args=qemu_args[1:])
+
+    try:
+        vm.launch()
+    except OSError as e:
+        return {'error': 'popen failed: ' + str(e)}
+    except socket.timeout:
+        return {'error': 'qemu failed: ' + str(vm.get_log())}
+
+    try:
+        res = vm.qmp(cmd, **cmd_args)
+        if res != {'return': {}}:
+            vm.shutdown()
+            return {'error': '"{}" command failed: {}'.format(cmd, str(res))}
+
+        e = vm.event_wait('JOB_STATUS_CHANGE')
+        assert e['data']['status'] == 'created'
+        start_ms = e['timestamp']['seconds'] * 1000000 + \
+            e['timestamp']['microseconds']
+
+        e = vm.events_wait((('BLOCK_JOB_READY', None),
+                            ('BLOCK_JOB_COMPLETED', None),
+                            ('BLOCK_JOB_FAILED', None)), timeout=True)
+        if e['event'] not in ('BLOCK_JOB_READY', 'BLOCK_JOB_COMPLETED'):
+            vm.shutdown()
+            return {'error': 'block-job failed: ' + str(e),
+                    'vm-log': vm.get_log()}
+        end_ms = e['timestamp']['seconds'] * 1000000 + \
+            e['timestamp']['microseconds']
+    finally:
+        vm.shutdown()
+
+    return {'seconds': (end_ms - start_ms) / 1000000.0}
+
+
+# Bench backup or mirror
+def bench_block_copy(qemu_binary, cmd, source, target):
+    """Helper to run bench_block_job() for mirror or backup"""
+    assert cmd in ('blockdev-backup', 'blockdev-mirror')
+
+    source['node-name'] = 'source'
+    target['node-name'] = 'target'
+
+    return bench_block_job(cmd,
+                           {'job-id': 'job0', 'device': 'source',
+                            'target': 'target', 'sync': 'full'},
+                           [qemu_binary,
+                            '-blockdev', json.dumps(source),
+                            '-blockdev', json.dumps(target)])
+
+
+def drv_file(filename):
+    return {'driver': 'file', 'filename': filename,
+            'cache': {'direct': True}, 'aio': 'native'}
+
+
+def drv_nbd(host, port):
+    return {'driver': 'nbd',
+            'server': {'type': 'inet', 'host': host, 'port': port}}
+
+
+if __name__ == '__main__':
+    import sys
+
+    if len(sys.argv) < 4:
+        print('USAGE: {} <qmp block-job command name> '
+              '<json string of arguments for the command> '
+              '<qemu binary path and arguments>'.format(sys.argv[0]))
+        exit(1)
+
+    res = bench_block_job(sys.argv[1], json.loads(sys.argv[2]), sys.argv[3:])
+    if 'seconds' in res:
+        print('{:.2f}'.format(res['seconds']))
+    else:
+        print(res)
-- 
2.21.0


