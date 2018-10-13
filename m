Received: from eggs.gnu.org ([2001:4830:134:3::10]:54080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe4-0006Tk-Cm
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe3-0004SM-FZ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe3-0004RQ-8M
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id y16so16451624wrw.3
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:15:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:43 +0200
Message-Id: <20181013151545.3731-5-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/6] tests/acceptance: Add
 test_mipsel_5kc_malta in BootLinuxConsole
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
Malta board (MIPS 5Kc little-endian) and verify the serial is working.

This test requires the dpkg-deb tool (apt/dnf install dpkg) to
extract the kernel from the Debian package.

  $ avocado run -p arch=mips64el tests/acceptance/boot_linux_console.py
  JOB ID     : 6450db71ca27757f53e13809625fc5107d0e6e4e
  JOB LOG    : /home/phil/avocado/job-results/job-2018-10-13T13.34-6450db7/job.log
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc: CANCEL: Currently specific to the x86_64 target arch (0.00 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta: CANCEL: Currently specific to the mips target arch (0.00 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mipsel_5kc_malta: PASS (0.78 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 2
  JOB TIME   : 0.97 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 81c96fc338..e4a60297bf 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -93,3 +93,47 @@ class BootLinuxConsole(Test):
                 break
             if 'Kernel panic - not syncing' in msg:
                 self.fail("Kernel panic reached")
+
+    def test_mipsel_5kc_malta(self):
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
+        :avocado: tags=arch:mips64el
+        """
+        if self.arch != 'mips64el':
+            self.cancel('Currently specific to the %s target arch' % self.arch)
+
+        deb_url = ('http://snapshot.debian.org/archive/debian/20130217T032700Z/'
+                   'pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
+        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir])
+        kernel_path = self.workdir + '/boot/vmlinux-2.6.32-5-5kc-malta'
+
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine('malta')
+        self.vm.set_console("") # XXX
+        kernel_command_line = 'console=ttyS0 printk.time=0'
+        self.vm.add_args('-m', "64",
+                         '-serial', "chardev:console",
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
