Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83CC3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75F1246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75F1246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Zwb-0004Fh-SA
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 02:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvm-0002Zg-8x
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvk-000616-Vc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:51944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zvk-00060b-OE; Fri, 28 Feb 2020 02:19:28 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zve-0002hc-DB; Fri, 28 Feb 2020 10:19:22 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] scripts/simplebench: add qemu/bench_block_job.py
Date: Fri, 28 Feb 2020 10:19:12 +0300
Message-Id: <20200228071914.11746-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228071914.11746-1-vsementsov@virtuozzo.com>
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
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
 qemu-block@nongnu.org, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add block-job benchmarking helper functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench_block_job.py | 119 +++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100755 scripts/simplebench/bench_block_job.py

diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
new file mode 100755
index 0000000000..9808d696cf
--- /dev/null
+++ b/scripts/simplebench/bench_block_job.py
@@ -0,0 +1,119 @@
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
+import sys
+import os
+import socket
+import json
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.machine import QEMUMachine
+from qemu.qmp import QMPConnectError
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
+    except (QMPConnectError, socket.timeout):
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


