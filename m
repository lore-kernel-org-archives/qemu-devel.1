Received: from eggs.gnu.org ([2001:4830:134:3::10]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXwM8-0005S4-1c
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXwM6-0007p9-Mz
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:22:36 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 26 Jun 2018 18:22:26 -0400
Message-Id: <20180626222226.27620-3-jsnow@redhat.com>
In-Reply-To: <20180626222226.27620-1-jsnow@redhat.com>
References: <20180626222226.27620-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] iotests: add 222 to test basic fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/222   | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group |   1 +
 2 files changed, 122 insertions(+)
 create mode 100644 tests/qemu-iotests/222

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
new file mode 100644
index 0000000000..133d10c351
--- /dev/null
+++ b/tests/qemu-iotests/222
@@ -0,0 +1,121 @@
+#!/usr/bin/env python
+#
+# This test covers the basic fleecing workflow.
+#
+# Copyright (C) 2018 Red Hat, Inc.
+# John helped, too.
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
+# Creator/Owner: John Snow <jsnow@redhat.com>
+
+import iotests
+from iotests import log, qemu_img, qemu_io, qemu_io_silent
+
+iotests.verify_platform(['linux'])
+
+patterns = [("0x5d", "0", "64k"),
+            ("0xd5", "1M", "64k"),
+            ("0xdc", "32M", "64k"),
+            ("0xcd", "67043328", "64k")]  # 64M - 64K
+
+overwrite = [("0xab", "0",        "64k"), # Full overwrite
+             ("0xad", "1015808",  "64k"), # Partial-left (1M-32K)
+             ("0x1d", "33587200", "64k"), # Partial-right (32M+32K)
+             ("0xea", "64M", "64k")]      # Adjacent-right (64M)
+
+with iotests.FilePath('base.img') as base_img_path, \
+     iotests.FilePath('fleece.img') as fleece_img_path, \
+     iotests.FilePath('nbd.sock') as nbd_sock_path, \
+     iotests.VM() as vm:
+
+    log('--- Setting up images ---')
+    log('')
+
+    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
+    assert qemu_img('create', '-f', iotests.imgfmt, fleece_img_path, '64M') == 0
+
+    for p in patterns:
+        qemu_io('-c', 'write -P%s %s %s' % p, base_img_path)
+
+    log('Done')
+
+    log('')
+    log('--- Launching VM ---')
+    log('')
+
+    vm.add_drive(base_img_path)
+    vm.launch()
+
+    log('')
+    log('--- Setting up Fleecing Graph ---')
+    log('')
+
+    srcNode = "drive0"
+    tgtNode = "fleeceNode"
+
+    # create tgtNode backed by srcNode
+    log(vm.qmp("blockdev-add", **{
+        "driver": "qcow2",
+        "node-name": tgtNode,
+        "file": {
+            "driver": "file",
+            "filename": fleece_img_path,
+        },
+        "backing": srcNode,
+    }))
+
+    # Establish COW from source to fleecing node
+    log(vm.qmp("blockdev-backup",
+               device=srcNode,
+               target=tgtNode,
+               sync="none"))
+
+    log('')
+    log('--- Setting up NBD Export ---')
+    log('')
+
+    nbd_uri = 'nbd+unix:///%s?socket=%s' % (tgtNode, nbd_sock_path)
+    log(vm.qmp("nbd-server-start",
+               **{"addr": { "type": "unix",
+                            "data": { "path": nbd_sock_path } } }))
+
+    log(vm.qmp("nbd-server-add", device=tgtNode))
+
+    log('')
+    log('--- Sanity Check ---')
+    log('')
+
+    for p in patterns:
+        cmd = "read -P%s %s %s" % p
+        log(cmd)
+        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
+
+    log('')
+    log('--- Testing COW ---')
+    log('')
+
+    for p in overwrite:
+        cmd = "write -P%s %s %s" % p
+        log(cmd)
+        log(vm.hmp_qemu_io(srcNode, cmd))
+
+    log('')
+    log('--- Verifying Data ---')
+    log('')
+
+    for p in patterns:
+        cmd = "read -P%s %s %s" % p
+        log(cmd)
+        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index eea75819d2..8019a9f721 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -220,3 +220,4 @@
 218 rw auto quick
 219 rw auto
 221 rw auto quick
+222 rw auto quick
-- 
2.14.4
