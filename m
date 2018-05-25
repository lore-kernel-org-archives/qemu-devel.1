Received: from eggs.gnu.org ([2001:4830:134:3::10]:53100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfw-0005OL-BX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfq-0007eQ-Sv
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fMHfq-0007eE-OP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:46 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 25 May 2018 14:42:19 -0400
Message-Id: <20180525184219.14440-6-crosa@redhat.com>
In-Reply-To: <20180525184219.14440-1-crosa@redhat.com>
References: <20180525184219.14440-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] Acceptance tests: add Linux kernel boot
 and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>

This test boots a Linux kernel, and checks that the given command
line was effective in two ways:

 * It makes the kernel use the set "console device" as a console
 * The kernel records the command line as expected in the console

Given that way too many error conditions may occur, and detecting the
kernel boot progress status may not be trivial, this test relies on a
timeout to handle unexpected situations.  Also, it's *not* tagged as a
quick test for obvious reasons.

It may be useful, while interactively running/debugging this test, or
tests similar to this one, to show some of the logging channels.
Example:

 $ avocado --show=QMP,console run test_boot_linux_console.py

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/test_boot_linux_console.py | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 tests/acceptance/test_boot_linux_console.py

diff --git a/tests/acceptance/test_boot_linux_console.py b/tests/acceptance/test_boot_linux_console.py
new file mode 100644
index 0000000000..98324f7591
--- /dev/null
+++ b/tests/acceptance/test_boot_linux_console.py
@@ -0,0 +1,47 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+
+from avocado_qemu import Test
+
+
+class BootLinuxConsole(Test):
+    """
+    Boots a x86_64 Linux kernel and checks that the console is operational
+    and the kernel command line is properly passed from QEMU to the kernel
+
+    :avocado: enable
+    :avocado: tags=x86_64
+    """
+
+    timeout = 60
+
+    def test(self):
+        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
+                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('pc')
+        self.vm.set_console()
+        kernel_command_line = 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console = self.vm.console_socket.makefile()
+        console_logger = logging.getLogger('console')
+        while True:
+            msg = console.readline()
+            console_logger.debug(msg.strip())
+            if 'Kernel command line: %s' % kernel_command_line in msg:
+                break
+            if 'Kernel panic - not syncing' in msg:
+                self.fail("Kernel panic reached")
-- 
2.17.0
