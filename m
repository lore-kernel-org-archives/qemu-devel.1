Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5902087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5902087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Wx-0002La-UI
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QN-0005YP-34
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QJ-0002vY-Av
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:19 -0500
Received: from relay.sw.ru ([185.231.240.75]:43446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1QI-0002ot-9u; Tue, 05 Nov 2019 11:11:14 -0500
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1QA-0000Xh-61; Tue, 05 Nov 2019 19:11:06 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] iotests: add test for virtio-scsi and virtio-blk
 machine type settings
Date: Tue,  5 Nov 2019 19:11:05 +0300
Message-Id: <20191105161105.19016-5-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It tests proper queue size settings for all available machine types.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 tests/qemu-iotests/267     | 154 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/267.out |   1 +
 tests/qemu-iotests/group   |   1 +
 3 files changed, 156 insertions(+)
 create mode 100755 tests/qemu-iotests/267
 create mode 100644 tests/qemu-iotests/267.out

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
new file mode 100755
index 0000000000..6d3cc574b3
--- /dev/null
+++ b/tests/qemu-iotests/267
@@ -0,0 +1,154 @@
+#!/usr/bin/env python
+#
+# Test virtio-scsi and virtio-blk queue settings for all machine types
+#
+# Copyright (c) 2019 Virtuozzo International GmbH
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
+import sys
+import os
+import re
+import iotests
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
+import qemu
+
+# list of device types and virtqueue properties to test
+# this is a generalized approach
+# for now we just check queue length
+# more properties can be added in each list
+virtio_scsi_props = {'vq_size': 'virtqueue_size'}
+virtio_blk_props = {'vq_size': 'queue-size'}
+
+dev_types = {'virtio-scsi-pci': virtio_scsi_props,
+             'virtio-blk-pci': virtio_blk_props}
+
+vm_dev_params = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
+                 'virtio-blk-pci': ['-device',
+                                    'virtio-blk-pci,id=scsi0,drive=drive0',
+                                    '-drive',
+                                    'driver=null-co,id=drive0,if=none']}
+
+def make_pattern(props):
+     pattern_items = ['{0} = \d+'.format(prop) for prop in props]
+     return '|'.join(pattern_items)
+
+
+def query_virtqueue_props(vm, dev_type_name):
+    output = vm.qmp('human-monitor-command', command_line='info qtree')
+    output = output['return']
+
+    props_list = dev_types[dev_type_name].values();
+
+    pattern = make_pattern(props_list)
+
+    res = re.findall(pattern, output)
+
+    if len(res) != len(props_list):
+        not_found = props_list.difference(set(res))
+
+        ret = (0, '({0}): The following properties not found: {1}'
+                  .format(dev_type_name, ', '.join(not_found)))
+    else:
+        props = dict()
+        for prop in res:
+            p = prop.split(' = ')
+            props[p[0]] = int(p[1])
+        ret = (1, props)
+
+    return ret
+
+
+def check_mt(mt, dev_type_name):
+    vm_params = ['-machine', mt['name']] + vm_dev_params[dev_type_name]
+
+    vm = qemu.QEMUMachine(iotests.qemu_prog, vm_params)
+    vm.launch()
+    ret = query_virtqueue_props(vm, dev_type_name)
+    vm.shutdown()
+
+    if ret[0] == 0:
+        print('Error ({0}): {1}'.format(mt['name'], ret[1]))
+        return 1
+
+    errors = 0
+    props = ret[1]
+
+    for prop_name, prop_val in props.items():
+        if mt[prop_name] != prop_val:
+            print('Error [{0}, {1}]: {2}={3} (expected {4})'.
+                  format(mt['name'], dev_type_name, prop_name, prop_val,
+                         mt[prop_name]))
+            errors += 1
+
+    return errors
+
+def is_256_virtqueue_size_mt(mt):
+    mt = mt.split("-")
+
+    # machine types like pc-x.x
+    if len(mt) == 2:
+        return False
+
+    # machine types like pc-<chip_name>-x.x[.x]
+    ver = mt[2]
+
+    ver = ver.split(".");
+
+    # all versions greater than 4.0.1 goes with 256 queue size
+    if int(ver[0]) >= 4:
+        major = int(ver[1])
+        minor = 0
+        if len(ver) > 2:
+            minor = int(ver[2])
+
+        if major > 0 or minor > 1:
+             return True
+
+    return False
+
+
+# collect all machine types except 'none'
+vm = iotests.VM()
+vm.launch()
+machines = [m['name'] for m in vm.qmp('query-machines')['return']]
+vm.shutdown()
+machines.remove('none')
+machines.remove('isapc')
+
+failed = 0
+
+for dev_type in dev_types:
+    # create a list of machine types and their parameters
+    # machine types vz8.X.X must have virtqueue_length=256
+    # others must have virtqueue_length=128
+    mtypes = list()
+    for m in machines:
+        if is_256_virtqueue_size_mt(m):
+            vq_size = 256
+        else:
+            vq_size = 128
+
+        mtypes.append({'name': m, dev_types[dev_type]['vq_size']: vq_size})
+
+    # test each machine type
+    for mt in mtypes:
+        failed += check_mt(mt, dev_type)
+
+if failed > 0:
+    print('Failed')
+else:
+    print('Success')
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
new file mode 100644
index 0000000000..35821117c8
--- /dev/null
+++ b/tests/qemu-iotests/267.out
@@ -0,0 +1 @@
+Success
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 3605796bb2..ab8523ad60 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -252,3 +252,4 @@
 255 rw auto quick
 256 rw auto quick
 266 rw quick
+267 auto quick
-- 
2.17.0


