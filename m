Received: from eggs.gnu.org ([2001:4830:134:3::10]:35503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGJ-0004nX-M8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGH-0005Bw-94
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:47 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 20:37:28 -0500
Message-Id: <20180703013730.55375-5-eblake@redhat.com>
In-Reply-To: <20180703013730.55375-1-eblake@redhat.com>
References: <20180703013730.55375-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] iotests: add 222 to test basic fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20180702194630.9360-3-jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/222     | 155 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222.out |  67 ++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 223 insertions(+)
 create mode 100644 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
new file mode 100644
index 00000000000..ff3bfc14701
--- /dev/null
+++ b/tests/qemu-iotests/222
@@ -0,0 +1,155 @@
+#!/usr/bin/env python
+#
+# This test covers the basic fleecing workflow, which provides a
+# point-in-time snapshot of a node that can be queried over NBD.
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
+patterns = [("0x5d", "0",         "64k"),
+            ("0xd5", "1M",        "64k"),
+            ("0xdc", "32M",       "64k"),
+            ("0xcd", "0x3ff0000", "64k")]  # 64M - 64K
+
+overwrite = [("0xab", "0",         "64k"), # Full overwrite
+             ("0xad", "0x00f8000", "64k"), # Partial-left (1M-32K)
+             ("0x1d", "0x2008000", "64k"), # Partial-right (32M+32K)
+             ("0xea", "0x3fe0000", "64k")] # Adjacent-left (64M - 128K)
+
+zeroes = [("0", "0x00f8000", "32k"), # Left-end of partial-left (1M-32K)
+          ("0", "0x2010000", "32k"), # Right-end of partial-right (32M+64K)
+          ("0", "0x3fe0000", "64k")] # overwrite[3]
+
+remainder = [("0xd5", "0x108000",  "32k"), # Right-end of partial-left [1]
+             ("0xdc", "32M",       "32k"), # Left-end of partial-right [2]
+             ("0xcd", "0x3ff0000", "64k")] # patterns[3]
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
+    assert qemu_img('create', '-f', "qcow2", fleece_img_path, '64M') == 0
+
+    for p in patterns:
+        qemu_io('-f', iotests.imgfmt,
+                '-c', 'write -P%s %s %s' % p, base_img_path)
+
+    log('Done')
+
+    log('')
+    log('--- Launching VM ---')
+    log('')
+
+    vm.add_drive(base_img_path)
+    vm.launch()
+    log('Done')
+
+    log('')
+    log('--- Setting up Fleecing Graph ---')
+    log('')
+
+    src_node = "drive0"
+    tgt_node = "fleeceNode"
+
+    # create tgt_node backed by src_node
+    log(vm.qmp("blockdev-add", **{
+        "driver": "qcow2",
+        "node-name": tgt_node,
+        "file": {
+            "driver": "file",
+            "filename": fleece_img_path,
+        },
+        "backing": src_node,
+    }))
+
+    # Establish COW from source to fleecing node
+    log(vm.qmp("blockdev-backup",
+               device=src_node,
+               target=tgt_node,
+               sync="none"))
+
+    log('')
+    log('--- Setting up NBD Export ---')
+    log('')
+
+    nbd_uri = 'nbd+unix:///%s?socket=%s' % (tgt_node, nbd_sock_path)
+    log(vm.qmp("nbd-server-start",
+               **{"addr": { "type": "unix",
+                            "data": { "path": nbd_sock_path } } }))
+
+    log(vm.qmp("nbd-server-add", device=tgt_node))
+
+    log('')
+    log('--- Sanity Check ---')
+    log('')
+
+    for p in (patterns + zeroes):
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
+        log(vm.hmp_qemu_io(src_node, cmd))
+
+    log('')
+    log('--- Verifying Data ---')
+    log('')
+
+    for p in (patterns + zeroes):
+        cmd = "read -P%s %s %s" % p
+        log(cmd)
+        assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
+
+    log('')
+    log('--- Cleanup ---')
+    log('')
+
+    log(vm.qmp('block-job-cancel', device=src_node))
+    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
+        filters=[iotests.filter_qmp_event])
+    log(vm.qmp('nbd-server-stop'))
+    log(vm.qmp('blockdev-del', node_name=tgt_node))
+    vm.shutdown()
+
+    log('')
+    log('--- Confirming writes ---')
+    log('')
+
+    for p in (overwrite + remainder):
+        cmd = "read -P%s %s %s" % p
+        log(cmd)
+        assert qemu_io_silent(base_img_path, '-c', cmd) == 0
+
+    log('')
+    log('Done')
diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
new file mode 100644
index 00000000000..48f336a02b5
--- /dev/null
+++ b/tests/qemu-iotests/222.out
@@ -0,0 +1,67 @@
+--- Setting up images ---
+
+Done
+
+--- Launching VM ---
+
+Done
+
+--- Setting up Fleecing Graph ---
+
+{u'return': {}}
+{u'return': {}}
+
+--- Setting up NBD Export ---
+
+{u'return': {}}
+{u'return': {}}
+
+--- Sanity Check ---
+
+read -P0x5d 0 64k
+read -P0xd5 1M 64k
+read -P0xdc 32M 64k
+read -P0xcd 0x3ff0000 64k
+read -P0 0x00f8000 32k
+read -P0 0x2010000 32k
+read -P0 0x3fe0000 64k
+
+--- Testing COW ---
+
+write -P0xab 0 64k
+{u'return': u''}
+write -P0xad 0x00f8000 64k
+{u'return': u''}
+write -P0x1d 0x2008000 64k
+{u'return': u''}
+write -P0xea 0x3fe0000 64k
+{u'return': u''}
+
+--- Verifying Data ---
+
+read -P0x5d 0 64k
+read -P0xd5 1M 64k
+read -P0xdc 32M 64k
+read -P0xcd 0x3ff0000 64k
+read -P0 0x00f8000 32k
+read -P0 0x2010000 32k
+read -P0 0x3fe0000 64k
+
+--- Cleanup ---
+
+{u'return': {}}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 67108864, u'offset': 393216}, u'event': u'BLOCK_JOB_CANCELLED'}
+{u'return': {}}
+{u'return': {}}
+
+--- Confirming writes ---
+
+read -P0xab 0 64k
+read -P0xad 0x00f8000 64k
+read -P0x1d 0x2008000 64k
+read -P0xea 0x3fe0000 64k
+read -P0xd5 0x108000 32k
+read -P0xdc 32M 32k
+read -P0xcd 0x3ff0000 64k
+
+Done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index eea75819d2a..8019a9f721f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -220,3 +220,4 @@
 218 rw auto quick
 219 rw auto
 221 rw auto quick
+222 rw auto quick
-- 
2.14.4
