Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRar-0003SY-Ee
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRap-0003cY-Qg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:17 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  9 Aug 2017 17:02:55 +0300
Message-Id: <20170809140256.25584-6-el13635@mail.ntua.gr>
In-Reply-To: <20170809140256.25584-1-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 5/6] block: add iotest 191 for legacy
 throttling interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Check that the implicit throttle filter driver node, used for
compatibility with the legacy throttling interface on the BlockBackend
level, works.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 tests/qemu-iotests/191     | 138 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/191.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 144 insertions(+)
 create mode 100644 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
new file mode 100644
index 0000000000..82fd0b2fe5
--- /dev/null
+++ b/tests/qemu-iotests/191
@@ -0,0 +1,138 @@
+#!/usr/bin/env python
+#
+# Tests that the legacy throttling interface using an implicit throttle filter
+# driver node works
+#
+# Copyright (C) 2017 Manos Pitsidianakis
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
+import os
+import iotests
+
+class TestLegacyThrottling(iotests.QMPTestCase):
+    test_img = os.path.join(iotests.test_dir, "test.img")
+    target_img = os.path.join(iotests.test_dir, "target.img")
+    base_img = os.path.join(iotests.test_dir, "base.img")
+
+    def setUp(self):
+        iotests.qemu_img("create", "-f", iotests.imgfmt, self.base_img, "1G")
+        iotests.qemu_img("create", "-f", iotests.imgfmt, self.test_img, "-b", self.base_img)
+        iotests.qemu_io("-f", iotests.imgfmt, "-c", "write -P0x5d 1M 128M", self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
+        self.vm.launch()
+
+    def tearDown(self):
+        self.do_check_throttle_node(expect=True)
+        params = {"device": "drive0",
+                  "bps": 0,
+                  "bps_rd": 0,
+                  "bps_wr": 0,
+                  "iops": 0,
+                  "iops_rd": 0,
+                  "iops_wr": 0,
+                 }
+        """
+        This must remove the implicit throttle_node
+        """
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False,
+                             **params)
+        self.do_check_throttle_node(expect=False)
+        self.vm.shutdown()
+
+    def do_test_job(self, cmd, **args):
+        params = {"device": "drive0",
+                  "bps": 1024,
+                  "bps_rd": 0,
+                  "bps_wr": 0,
+                  "iops": 0,
+                  "iops_rd": 0,
+                  "iops_wr": 0,
+                 }
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False,
+                             **params)
+        self.assert_qmp(result, "return", {})
+        result = self.vm.qmp(cmd, **args)
+        self.assert_qmp(result, "return", {})
+        result = self.vm.qmp("query-block-jobs")
+        self.assert_qmp(result, "return[0]/device", "drive0")
+
+    def do_check_throttle_node(self, expect):
+        result = self.vm.qmp("query-named-block-nodes")
+        for r in result["return"]:
+            if r["drv"] == "throttle":
+                    self.assertTrue(expect)
+                    return
+        if expect:
+            """ throttle_node missing! """
+            self.assertTrue(False)
+
+    def do_check_params(self, file):
+        result = self.vm.qmp("query-block")
+        self.assert_qmp(result, "return[0]/inserted/bps", 1024)
+        self.assert_qmp(result, "return[0]/inserted/drv", iotests.imgfmt)
+        self.assert_qmp(result, "return[0]/inserted/file", file)
+
+    """
+    Check that query-block reports the correct throttling parameters while
+    ignoring the implicit throttle node.
+    """
+    def test_query_block(self):
+        params = {"device": "drive0",
+                  "bps": 1024,
+                  "bps_rd": 0,
+                  "bps_wr": 0,
+                  "iops": 0,
+                  "iops_rd": 0,
+                  "iops_wr": 0,
+                 }
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False,
+                             **params)
+        self.assert_qmp(result, "return", {})
+        self.do_check_params(file=self.test_img)
+
+    """
+    Check that the throttle node doesn't get removed by block jobs, and that
+    query-block reports the correct throttling parameters
+    """
+    def test_drive_mirror(self):
+        self.do_test_job("drive-mirror", device="drive0",
+                          target=self.target_img,
+                          sync="full")
+        self.vm.event_wait("BLOCK_JOB_READY")
+        self.vm.qmp("block-job-complete", device="drive0")
+        """
+        query-block should report `target_img` now
+        """
+        self.do_check_params(file=self.target_img)
+
+    def test_drive_backup(self):
+        self.do_test_job("drive-backup", device="drive0",
+                          target=self.target_img,
+                          sync="full")
+        self.vm.event_wait("BLOCK_JOB_COMPLETED")
+        self.do_check_params(file=self.test_img)
+
+    def test_block_commit(self):
+        self.do_test_job("block-commit", device="drive0")
+        self.vm.event_wait("BLOCK_JOB_READY")
+        self.vm.qmp("block-job-complete", device="drive0")
+        """
+        query-block should report the backing file `base_img` now
+        """
+        self.do_check_params(file=self.base_img)
+
+if __name__ == "__main__":
+    iotests.main(supported_fmts=["qcow2"])
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
new file mode 100644
index 0000000000..89968f35d7
--- /dev/null
+++ b/tests/qemu-iotests/191.out
@@ -0,0 +1,5 @@
+....
+----------------------------------------------------------------------
+Ran 4 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 6e6afb8ba9..1b4221f26d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -187,3 +187,4 @@
 188 rw auto quick
 189 rw auto
 190 rw auto quick
+191 rw auto quick
-- 
2.11.0
