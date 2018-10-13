Received: from eggs.gnu.org ([2001:4830:134:3::10]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe3-0006T1-BS
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe2-0004RC-9M
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe2-0004QB-0y
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id 206-v6so14887143wmb.5
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:15:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:42 +0200
Message-Id: <20181013151545.3731-4-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/6] tests/acceptance: Add
 test_mips_4kc_malta in BootLinuxConsole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Similar to the test_x86_64_pc test, this boots a Linux kernel on a
Malta board (MIPS 4Kc big-endian) and verify the serial is working.

This test requires the dpkg-deb tool (apt/dnf install dpkg) to
extract the kernel from the Debian package.

  $ avocado --show=console run -p arch=mips tests/acceptance/boot_linux_console.py
  console: [    0.000000] Initializing cgroup subsys cpuset
  console: [    0.000000] Initializing cgroup subsys cpu
  console: [    0.000000] Linux version 2.6.32-5-4kc-malta (Debian 2.6.32-48) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 Sat Feb 16 12:43:42 UTC 2013
  console: [    0.000000]
  console: [    0.000000] LINUX started...
  console: [    0.000000] bootconsole [early0] enabled
  console: [    0.000000] CPU revision is: 00019300 (MIPS 24Kc)
  console: [    0.000000] FPU revision is: 00739300
  console: [    0.000000] Determined physical RAM map:
  console: [    0.000000]  memory: 00001000 @ 00000000 (reserved)
  console: [    0.000000]  memory: 000ef000 @ 00001000 (ROM data)
  console: [    0.000000]  memory: 005b7000 @ 000f0000 (reserved)
  console: [    0.000000]  memory: 03958000 @ 006a7000 (usable)
  console: [    0.000000] Wasting 54496 bytes for tracking 1703 unused pages
  console: [    0.000000] Initrd not found or empty - disabling initrd
  console: [    0.000000] Zone PFN ranges:
  console: [    0.000000]   DMA      0x00000000 -> 0x00001000
  console: [    0.000000]   Normal   0x00001000 -> 0x00003fff
  console: [    0.000000] Movable zone start PFN for each node
  console: [    0.000000] early_node_map[1] active PFN ranges
  console: [    0.000000]     0: 0x00000000 -> 0x00003fff
  console: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16255
  console: [    0.000000] Kernel command line: console=ttyS0 printk.time=0

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3aa4dbe5f9..81c96fc338 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -9,6 +9,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 import logging
+import subprocess
 
 from avocado_qemu import Test
 
@@ -47,3 +48,48 @@ class BootLinuxConsole(Test):
                 break
             if 'Kernel panic - not syncing' in msg:
                 self.fail("Kernel panic reached")
+
+    def test_mips_4kc_malta(self):
+        """
+        This test requires the dpkg-deb tool (apt/dnf install dpkg) to extract
+        the kernel from the Debian package.
+
+        The kernel can be rebuilt using this Debian kernel source [1] and
+        following the instructions on [2].
+
+        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
+        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-source-2.6.32_2.6.32-48
+
+        :avocado: tags=arch:mips
+        """
+        if self.arch != 'mips': # FIXME use 'arch' tag in parent class?
+            self.cancel('Currently specific to the %s target arch' % self.arch)
+
+        deb_url = ('http://snapshot.debian.org/archive/debian/20130217T032700Z/'
+                   'pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
+        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir]) # FIXME move to avocado ...
+        kernel_path = self.workdir + '/boot/vmlinux-2.6.32-5-4kc-malta'          # FIXME ... and use from assets?
+
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine('malta')
+        self.vm.set_console("") # XXX this disable isa-serial to use -serial ...
+        kernel_command_line = 'console=ttyS0 printk.time=0'
+        self.vm.add_args('-m', "64",
+                         '-serial', "chardev:console", # XXX ... here.
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+
+        # FIXME below to parent class?
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
