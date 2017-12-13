Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLZ-0005Bl-87
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLU-00076i-MR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:53 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLU-00075q-HN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:48 -0500
Received: by mail-qt0-x241.google.com with SMTP id i40so5848559qti.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:21:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:01 -0300
Message-Id: <20171213232025.24503-3-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 02/26] sdcard: add a Python qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Use Python to write high-level SD commands.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include |   2 +
 tests/sdcard_tests.py  | 172 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100755 tests/sdcard_tests.py

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 13673f6d1d..4a1afcb499 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -355,8 +355,10 @@ check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/sdcard_tests.py
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdcard_tests.py
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/sdcard_tests.py b/tests/sdcard_tests.py
new file mode 100755
index 0000000000..033b756cf1
--- /dev/null
+++ b/tests/sdcard_tests.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python
+#
+# Tests for the SD-Bus protocol
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
+import base64
+import struct
+import binascii
+import logging
+
+import qtest
+
+
+# CMD
+(GO_IDLE_STATE, SEND_OP_CMD, ALL_SEND_CID, SEND_RELATIVE_ADDR, # 0 ...
+SEND_DSR, CMD5, SWITCH_FUNCTION, CMD7,
+SEND_IF_COND, SEND_CSD, SEND_CID, READ_DAT_UNTIL_STOP, # 8 ...
+STOP_TRANSMISSION, SEND_STATUS, CMD14, GO_INACTIVE_STATE,
+SET_BLOCKLEN, READ_SINGLE_BLOCK, READ_MULTIPLE_BLOCK, CMD19, # 16 ...
+CMD20, CMD21, CMD22, SET_BLOCK_COUNT,
+WRITE_SINGLE_BLOCK, WRITE_MULTIPLE_BLOCK, PROGRAM_CID, PROGRAM_CSD,  # 24 ...
+SET_WRITE_PROT, CLR_WRITE_PROT, SEND_WRITE_PROT, CMD31,
+ERASE_WR_BLK_START, ERASE_WR_BLK_END, CMD34, CMD35, # 32 ...
+CMD36, CMD37, ERASE, CMD39,
+CMD40, CMD41, LOCK_UNLOCK, CMD43,
+CMD44, CMD45, CMD46, CMD47,
+CMD48, CMD49, CMD50, CMD51,
+CMD52, CMD53, CMD54, APP_CMD,
+GEN_CMD,) = range(57)
+
+# ACMD
+SET_BUS_WIDTH = 6
+SD_STATUS = 13
+SEND_NUM_WR_BLOCKS = 22
+SET_WR_BLK_ERASE_COUNT = 23
+SD_APP_OP_COND = 41
+SET_CLR_CARD_DETECT = 42
+SEND_SCR = 51
+
+
+class SDBus(object):
+    def __init__(self, vm, qom_path, verbose=False):
+        self.vm = vm
+        self.path = qom_path
+        self.verbose = verbose
+
+    def do_cmd(self, command, arg=0, verbose=None):
+        assert command < 64
+        if verbose is None:
+            verbose = self.verbose
+
+        data = self.vm.qmp('sdbus-command', qom_path=self.path, command=command,
+                           arg=arg)['return']
+        if 'base64' in data:
+            data = base64.b64decode(data['base64'])
+            logging.info("CMD#%02d -> %s" % (command, binascii.hexlify(data)))
+        else:
+            logging.info("CMD#%02d -> (none)" % (command))
+            data = None
+        return data
+
+    def do_acmd(self, command, arg=0, verbose=None):
+        self.do_cmd(APP_CMD, verbose=False)
+        return self.do_cmd(command, arg, verbose if verbose else self.verbose)
+
+
+def sdbus_get_qom_path(vm, bus=0):
+        qom_paths = []
+
+        result = vm.qmp('query-block')
+        for block in result['return']:
+            if not 'qdev' in block:
+                continue
+            d = vm.qmp('qom-get', path=block['qdev'], property="parent_bus")
+            qom_paths += [d['return']]
+        assert len(qom_paths) > 0
+
+        return qom_paths[bus]
+
+
+# dumb helper
+def l(buf):
+    return struct.unpack("<L", buf)[0]
+
+
+class TestSdCardSpecV2(qtest.QMPTestCase):
+    def setUp(self):
+        self.vm = qtest.createQtestMachine()
+
+        self.vm._args.append('-drive')
+        self.vm._args.append("id=testcard,driver=null-co,if=sd")
+        self.vm._args.append("-machine")
+        self.vm._args.append("xilinx-zynq-a9")
+        self.vm.launch()
+
+        bus_path = sdbus_get_qom_path(self.vm)
+        self.bus = SDBus(self.vm, bus_path, True)
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_power_on_v2(self):
+
+        self.bus.do_cmd(GO_IDLE_STATE)
+
+        # get voltages
+        for i in range(6):
+            vhs = 1 << (8 + i)
+            data = self.bus.do_cmd(SEND_IF_COND, vhs)
+            v = l(data)
+            self.assertNotEqual(v, 0)
+            self.assertEqual(vhs, v >> 8)
+
+        # get OCR
+        data = self.bus.do_acmd(SD_APP_OP_COND)
+        v = l(data)
+        ocr = (v >> 8) & 0xffff
+        s1_8 = (v >> 24) & 1
+        uhs_ii = (v >> 29) & 1
+        ccs = (v >> 30) & 1
+        init = (v >> 31) & 1
+        # all those are null for v2.00
+        self.assertEqual(s1_8, 0)
+        self.assertEqual(uhs_ii, 0)
+        self.assertEqual(ccs, 0)
+        self.assertEqual(init, 0)
+
+        # ocr << 8
+        # 0 << 24 # use current voltage
+        # 0 << 28 # powersave
+        # 0 << 30 # SDSC
+        data = self.bus.do_acmd(SD_APP_OP_COND, ocr << 8)
+        v = l(data)
+        # check OCR accepted
+        self.assertEqual(ocr, v >> 8)
+
+        # check CID
+        data = self.bus.do_cmd(ALL_SEND_CID)
+        oid, pnm, psn = struct.unpack(">x2s5sxLxxx", data)
+        self.assertEqual(oid, "XY") # QEMU default
+        self.assertEqual(pnm, "QEMU!") # QEMU default
+        self.assertEqual(psn, 0xdeadbeef) # QEMU default
+
+        # check non null RCA
+        data = self.bus.do_cmd(SEND_RELATIVE_ADDR)
+        rca, = struct.unpack(">H", data[:2])
+        self.assertNotEqual(rca, 0)
+
+        self.assertEqual(rca, 0x4567) # QEMU default
+
+        # check for new RCA
+        data = self.bus.do_cmd(SEND_RELATIVE_ADDR)
+        new_rca, = struct.unpack(">H", data[:2])
+        self.assertNotEqual(new_rca, rca)
+
+
+if __name__ == '__main__':
+    qtest.main(supported_machines=['xilinx-zynq-a9'])
-- 
2.15.1
