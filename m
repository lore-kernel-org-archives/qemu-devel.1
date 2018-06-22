Received: from eggs.gnu.org ([2001:4830:134:3::10]:33828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWACB-0003tA-Sr
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC6-0000Fk-U4
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC6-0000Fe-Oi
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:54 -0400
Received: by mail-qk0-x242.google.com with SMTP id q70-v6so2864652qke.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:33 -0300
Message-Id: <20180622004435.10291-5-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Similar to the BootLinuxConsoleX86_64 test:
boot a Linux kernel on a Malta board and verify the serial is working.

This test can be run using:

    $ avocado run -t endian:big tests/acceptance

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 17dc8d58c1..72cf5e943c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -46,3 +46,41 @@ class BootLinuxConsoleX86_64(Test):
                 break
             if 'Kernel panic - not syncing' in msg:
                 self.fail("Kernel panic reached")
+
+
+class BootLinuxConsoleMips(Test):
+    """
+    Boots a mips Linux kernel and checks that the console is operational
+    and the kernel command line is properly passed from QEMU to the kernel
+
+    :avocado: enable
+    :avocado: tags=endian:big
+    :avocado: tags=arch:mips
+    :avocado: tags=board:malta
+    """
+
+    arch = "mips"
+    timeout = 60
+
+    def test(self):
+        kernel_url = ('http://people.debian.org/~aurel32/qemu/mips/'
+                      'vmlinux-3.2.0-4-4kc-malta')
+        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = 'console=ttyS0 printk.time=0'
+        self.vm.add_args('-m', "64",
+                         '-kernel', kernel_path,
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
2.18.0.rc2
