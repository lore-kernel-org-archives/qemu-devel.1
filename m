Received: from eggs.gnu.org ([2001:4830:134:3::10]:34006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7m15-0006Zm-UU
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7lvU-0000q7-2B
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7lvM-0000lp-LU
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B171583F3D
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 18:31:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed,  3 Oct 2018 20:30:34 +0200
Message-Id: <20181003183036.6716-2-philmd@redhat.com>
In-Reply-To: <20181003183036.6716-1-philmd@redhat.com>
References: <20181003183036.6716-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 1/3] acceptance tests: Add SeaBIOS boot
 and debug console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

This test boots SeaBIOS and check the debug console (I/O port on the ISA =
bus)
reports enough information on the initialized devices.

Example:

$ avocado run tests/acceptance/boot_firmware.py
JOB ID     : 3dac2e738c941747ec01f043092b882a8370a92f
JOB LOG    : /home/phil/avocado/job-results/job-2018-10-03T19.42-3dac2e7/=
job.log
 (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: PASS =
(0.27 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
JOB TIME   : 0.56 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_firmware.py | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tests/acceptance/boot_firmware.py

diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_fi=
rmware.py
new file mode 100644
index 0000000000..669e4849f6
--- /dev/null
+++ b/tests/acceptance/boot_firmware.py
@@ -0,0 +1,74 @@
+# coding=3Dutf-8
+#
+# Functional test that boots SeaBIOS and checks the console
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import logging
+
+from avocado_qemu import Test
+from avocado.utils.wait import wait_for
+
+
+def read_console_for_string(console, expected_string, logger, ignore_ans=
i=3DTrue):
+    msg =3D console.readline()
+    if len(msg) =3D=3D 0:
+        return False
+    if logger:
+        logger.debug(msg.strip() if ignore_ansi and not '\x1b' in msg el=
se msg)
+    return expected_string in msg
+
+
+class BootFirmware(Test):
+    """
+    Boots a firmware and checks via a console it is operational
+
+    :avocado: enable
+    """
+
+    def test_seabios(self):
+        """
+        Boots SeaBIOS on a default PC machine, checks the debug console
+
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmaxtime:5s
+        :avocado: tags=3Dquick
+        """
+        debugcon_path =3D os.path.join(self.workdir, 'debugconsole.log')
+        serial_logger =3D logging.getLogger('serial')
+        debugcon_logger =3D logging.getLogger('debugcon')
+
+        self.vm.set_machine('pc')
+        self.vm.set_console()
+        self.vm.add_args('-nographic',
+                         '-net', 'none',
+                         '-global', 'isa-debugcon.iobase=3D0x402',
+                         '-debugcon', 'file:%s' % debugcon_path)
+        self.vm.launch()
+        console =3D self.vm.console_socket.makefile()
+
+        # serial console checks
+        if not wait_for(read_console_for_string, timeout=3D5, step=3D0,
+                        args=3D(console, 'No bootable device.', serial_l=
ogger)):
+            self.fail("SeaBIOS failed to boot")
+
+        # debug console checks
+        expected =3D [
+            'Running on QEMU (i440fx)',
+            'Turning on vga text mode console',
+            'Found 1 lpt ports',
+            'Found 1 serial ports',
+            'PS2 keyboard initialized',
+        ]
+        with open(debugcon_path) as debugcon:
+            content =3D debugcon.readlines()
+            for line in content: # TODO use FDDrainer
+                debugcon_logger.debug(line.strip())
+            for exp in expected:
+                self.assertIn(exp + '\n', content)
--=20
2.17.1
