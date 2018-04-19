Received: from eggs.gnu.org ([2001:4830:134:3::10]:33286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiR-0003Wj-0e
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiP-0007Y4-Ij
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:23 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiP-0007Y0-Cp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:21 -0400
Received: by mail-qt0-x241.google.com with SMTP id b13-v6so6486280qtp.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:47:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:42 -0300
Message-Id: <20180419164642.9536-8-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 7/7] avocado: Add tests booting the Malta
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/avocado/test_linux-boot-console.py      | 92 +++++++++++++++++++
 .../parameters.yaml                           |  2 +
 2 files changed, 94 insertions(+)

diff --git a/tests/avocado/test_linux-boot-console.py b/tests/avocado/test_linux-boot-console.py
index f54d10dd79..4ae1e3bf37 100644
--- a/tests/avocado/test_linux-boot-console.py
+++ b/tests/avocado/test_linux-boot-console.py
@@ -86,3 +86,95 @@ class TestAlphaClipperBoot2_6(test.QemuTest):
 
     def tearDown(self):
         os.remove(self.console_path)
+
+
+class TestMips4kcMaltaBoot2_6(test.QemuTest):
+    """
+    :avocado: enable
+    :avocado: tags=arch_mips
+    """
+    ARCH = "mips"
+
+    def kernel_url(self):
+        return 'http://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-4kc-malta'
+
+    def setUp(self):
+        self.console_path = tempfile.mkstemp()[1]
+        kernel_path = cachedfile(self.kernel_url())
+        self.vm._args.extend(['-machine', 'malta'])
+        self.vm._args.extend(['-m', '64'])
+        self.vm._args.extend(['-kernel', kernel_path])
+        self.vm._args.extend(['-append', '"console=ttyS0 printk.time=0"'])
+        self.vm._args.extend(['-chardev', 'socket,id=uart0,server,nowait,path=' + self.console_path])
+        self.vm._args.extend(['-serial', 'chardev:uart0'])
+        self.vm._args.extend(['-nographic'])
+
+    def test_boot_console(self):
+        """
+        :avocado: tags=uart,printk
+        """
+        if self.params.get('arch') != self.ARCH:
+            return
+
+        self.vm.launch(self.console_path)
+        console = self.vm.get_console(console_address=self.console_path, login=False)
+        # no filesystem provided on purpose, wait for the Kernel panic
+        bootlog = console.read_until_any_line_matches(["Kernel panic - not syncing: VFS: Unable to mount root fs"], timeout=6.0)[1]
+        console.close()
+        # check Super I/O
+        self.assertIn(u'ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A', bootlog)
+        self.assertIn(u'ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A', bootlog)
+        self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
+        self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
+        # check PCI (network interface)
+        self.assertIn(u'registered as PCnet/PCI II 79C970A', bootlog)
+        self.vm.shutdown()
+
+    def tearDown(self):
+        os.remove(self.console_path)
+
+# FIXME this is a copy of TestMips4kcMaltaBoot2_6 with a different the kernel url
+class TestMips4kcMaltaBoot3_2(test.QemuTest):
+    """
+    :avocado: enable
+    :avocado: tags=arch_mips
+    """
+    ARCH = "mips"
+
+    def kernel_url(self):
+        return 'http://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta'
+
+    def setUp(self):
+        self.console_path = tempfile.mkstemp()[1]
+        kernel_path = cachedfile(self.kernel_url())
+        self.vm._args.extend(['-machine', 'malta'])
+        self.vm._args.extend(['-m', '64'])
+        self.vm._args.extend(['-kernel', kernel_path])
+        self.vm._args.extend(['-append', '"console=ttyS0 printk.time=0"'])
+        self.vm._args.extend(['-chardev', 'socket,id=uart0,server,nowait,path=' + self.console_path])
+        self.vm._args.extend(['-serial', 'chardev:uart0'])
+        self.vm._args.extend(['-nographic'])
+
+    def test_boot_console(self):
+        """
+        :avocado: tags=uart,printk
+        """
+        if self.params.get('arch') != self.ARCH:
+            return
+
+        self.vm.launch(self.console_path)
+        console = self.vm.get_console(console_address=self.console_path, login=False)
+        # no filesystem provided on purpose, wait for the Kernel panic
+        bootlog = console.read_until_any_line_matches(["Kernel panic - not syncing: VFS: Unable to mount root fs"], timeout=6.0)[1]
+        console.close()
+        # check Super I/O
+        self.assertIn(u'ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A', bootlog)
+        self.assertIn(u'ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A', bootlog)
+        self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
+        self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
+        # check PCI (network interface)
+        self.assertIn(u'registered as PCnet/PCI II 79C970A', bootlog)
+        self.vm.shutdown()
+
+    def tearDown(self):
+        os.remove(self.console_path)
diff --git a/tests/avocado/test_linux-boot-console.py.data/parameters.yaml b/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
index ed8c08058c..156f271a73 100644
--- a/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
+++ b/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
@@ -1,3 +1,5 @@
 architecture: !mux
     alpha:
         arch: alpha
+    mips:
+        arch: mips
-- 
2.17.0
