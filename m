Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E1C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69570206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAa6s4CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69570206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENHV-0000NT-HV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENG7-0007Ty-Bk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENG5-0004i3-SN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENG1-0004fx-LC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584493949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6CSWcVjwf/mR4GA8o7TUHijgY6z8lbK7E/cQiK0XOA=;
 b=VAa6s4CFrye3cuxw0zXCSlZ7iPwh7qElhp/DxPe8vZXvx2miNrrPUYXIQkzVNCV9LFWvpp
 6/zqZFwu0QwylVDi+RMw/kiiKYgkg545NVS62GHR6X0797gBCKmQgCL7gNGNGWHn8GtdvB
 MC6OYFvD+HlYOPxnaTA+F22jNov6rnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-COwiw_BiM5Gjr-Rzf1XJkw-1; Tue, 17 Mar 2020 21:12:25 -0400
X-MC-Unique: COwiw_BiM5Gjr-Rzf1XJkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAB5E13F7;
 Wed, 18 Mar 2020 01:12:23 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 575898AC30;
 Wed, 18 Mar 2020 01:12:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/4] scripts/simplebench: add qemu/bench_block_job.py
Date: Tue, 17 Mar 2020 21:12:15 -0400
Message-Id: <20200318011217.2102748-3-ehabkost@redhat.com>
In-Reply-To: <20200318011217.2102748-1-ehabkost@redhat.com>
References: <20200318011217.2102748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add block-job benchmarking helper functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200228071914.11746-3-vsementsov@virtuozzo.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/simplebench/bench_block_job.py | 119 +++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100755 scripts/simplebench/bench_block_job.py

diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/b=
ench_block_job.py
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
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
+from qemu.machine import QEMUMachine
+from qemu.qmp import QMPConnectError
+
+
+def bench_block_job(cmd, cmd_args, qemu_args):
+    """Benchmark block-job
+
+    cmd       -- qmp command to run block-job (like blockdev-backup)
+    cmd_args  -- dict of qmp command arguments
+    qemu_args -- list of Qemu command line arguments, including path to Qe=
mu
+                 binary
+
+    Returns {'seconds': int} on success and {'error': str} on failure, dic=
t may
+    contain addional 'vm-log' field. Return value is compatible with
+    simplebench lib.
+    """
+
+    vm =3D QEMUMachine(qemu_args[0], args=3Dqemu_args[1:])
+
+    try:
+        vm.launch()
+    except OSError as e:
+        return {'error': 'popen failed: ' + str(e)}
+    except (QMPConnectError, socket.timeout):
+        return {'error': 'qemu failed: ' + str(vm.get_log())}
+
+    try:
+        res =3D vm.qmp(cmd, **cmd_args)
+        if res !=3D {'return': {}}:
+            vm.shutdown()
+            return {'error': '"{}" command failed: {}'.format(cmd, str(res=
))}
+
+        e =3D vm.event_wait('JOB_STATUS_CHANGE')
+        assert e['data']['status'] =3D=3D 'created'
+        start_ms =3D e['timestamp']['seconds'] * 1000000 + \
+            e['timestamp']['microseconds']
+
+        e =3D vm.events_wait((('BLOCK_JOB_READY', None),
+                            ('BLOCK_JOB_COMPLETED', None),
+                            ('BLOCK_JOB_FAILED', None)), timeout=3DTrue)
+        if e['event'] not in ('BLOCK_JOB_READY', 'BLOCK_JOB_COMPLETED'):
+            vm.shutdown()
+            return {'error': 'block-job failed: ' + str(e),
+                    'vm-log': vm.get_log()}
+        end_ms =3D e['timestamp']['seconds'] * 1000000 + \
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
+    source['node-name'] =3D 'source'
+    target['node-name'] =3D 'target'
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
+if __name__ =3D=3D '__main__':
+    import sys
+
+    if len(sys.argv) < 4:
+        print('USAGE: {} <qmp block-job command name> '
+              '<json string of arguments for the command> '
+              '<qemu binary path and arguments>'.format(sys.argv[0]))
+        exit(1)
+
+    res =3D bench_block_job(sys.argv[1], json.loads(sys.argv[2]), sys.argv=
[3:])
+    if 'seconds' in res:
+        print('{:.2f}'.format(res['seconds']))
+    else:
+        print(res)
--=20
2.24.1


