Received: from eggs.gnu.org ([2001:4830:134:3::10]:46965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAJ-00081j-Bs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAH-0007QI-Pt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuAH-0007Pd-Gn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:26 -0300
Message-Id: <20180615191327.11480-7-ehabkost@redhat.com>
In-Reply-To: <20180615191327.11480-1-ehabkost@redhat.com>
References: <20180615191327.11480-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] Acceptance tests: add Linux kernel boot and
 console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

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

 $ avocado --show=QMP,console run boot_linux_console.py

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20180530184156.15634-6-crosa@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 tests/acceptance/boot_linux_console.py

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
new file mode 100644
index 0000000000..98324f7591
--- /dev/null
+++ b/tests/acceptance/boot_linux_console.py
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
2.18.0.rc1.1.g3f1ff2140
