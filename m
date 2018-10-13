Received: from eggs.gnu.org ([2001:4830:134:3::10]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe5-0006UG-Jz
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe4-0004TP-Og
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe4-0004Sj-I1
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id z25-v6so19939367wmf.1
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:16:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:44 +0200
Message-Id: <20181013151545.3731-6-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/6] tests/acceptance: Add test_sh4_r2d in
 BootLinuxConsole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Similar to the test_x86_64_pc test, this boots a Linux kernel on a
R2D board (SH4 little-endian) and verify the serial is working.

This test requires the dpkg-deb tool (apt/dnf install dpkg) to
extract the kernel from the Debian package.

Note, due to a problem with the serial on this machine, this test
is currently disabled.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index e4a60297bf..8f99cc0d7c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -11,6 +11,7 @@
 import logging
 import subprocess
 
+from avocado import skip
 from avocado_qemu import Test
 
 
@@ -137,3 +138,50 @@ class BootLinuxConsole(Test):
                 break
             if 'Kernel panic - not syncing' in msg:
                 self.fail("Kernel panic reached")
+
+    @skip("console not working on r2d machine")
+    def test_sh4_r2d(self):
+        """
+        This test requires the dpkg-deb tool (apt/dnf install dpkg) to extract
+        the kernel from the Debian package.
+        This test also requires the QEMU binary to be compiled with:
+
+          $ configure ... --enable-trace-backends=log
+
+        The kernel can be rebuilt using this Debian kernel source [1] and
+        following the instructions on [2].
+
+        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
+        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-source-2.6.32_2.6.32-30
+
+        :avocado: tags=arch:sh4
+        """
+        if self.arch != 'sh4':
+            self.cancel('Currently specific to the %s target arch' % self.arch)
+
+        deb_url = ('http://snapshot.debian.org/archive/'
+                   'debian-ports/20110116T065852Z/pool-sh4/main/l/'
+                   'linux-2.6/linux-image-2.6.32-5-sh7751r_2.6.32-30_sh4.deb')
+        deb_hash = '8025e503319dc8ad786756e3afaa8eb868e9ef59'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir])
+        kernel_path = self.workdir + '/boot/vmlinuz-2.6.32-5-sh7751r'
+
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine('r2d')
+        self.vm.set_console("") # XXX
+        kernel_command_line = 'console=ttyS0 printk.time=0 noiotrap'
+        self.vm.add_args('-serial', "chardev:console",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+
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
2.19.1
