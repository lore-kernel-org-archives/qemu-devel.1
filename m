Received: from eggs.gnu.org ([209.51.188.92]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gkQzH-0005gw-Mk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gkQzG-0008M1-Mi
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:02:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:16545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gkQzG-0008Jg-EH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:02:54 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Fri, 18 Jan 2019 18:02:47 +0800
Message-Id: <1547805767-24863-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1547805767-24863-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1547805767-24863-1-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] Acceptance tests: add support more than
 2GiB initrd test with linux-v4.19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

timeout is updated to 5mins since we need more time to load a
large initrd to the guest

CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
CC: Caio Carrara <ccarrara@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tests/acceptance/linux_initrd.py | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index aeb9fde..6f1ee1f 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -8,6 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import logging
 import tempfile
 from avocado.utils.process import run
 
@@ -22,7 +23,7 @@ class LinuxInitrd(Test):
     :avocado: tags=x86_64
     """
 
-    timeout = 60
+    timeout = 300
 
     def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         """
@@ -48,3 +49,37 @@ class LinuxInitrd(Test):
             expected_msg = r'.*initrd is too large.*max: \d+, need %s.*' % (
                 max_size + 1)
             self.assertRegex(res.stderr_text, expected_msg)
+
+    def test_with_2gib_file_should_work_with_linux_v4_18(self):
+        """
+        since linux header introduced xloadflags which can tell bootloader
+        whether initrd can be loaded into above 4G address.
+        """
+        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
+                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        max_size = 2 * (1024 ** 3) - 1
+
+        with tempfile.NamedTemporaryFile() as initrd:
+            initrd.seek(max_size)
+            initrd.write(b'\0')
+            initrd.flush()
+
+            self.vm.set_machine('pc')
+            self.vm.set_console()
+            kernel_command_line = 'console=ttyS0'
+            self.vm.add_args('-kernel', kernel_path,
+                             '-append', kernel_command_line,
+                             '-initrd', initrd.name,
+                             '-m', '5120')
+            self.vm.launch()
+            console = self.vm.console_socket.makefile()
+            console_logger = logging.getLogger('console')
+            while True:
+                msg = console.readline()
+                console_logger.debug(msg.strip())
+                if 'Unpacking initramfs...' in msg:
+                    break
+                if 'Kernel panic - not syncing' in msg:
+                    self.fail("Kernel panic reached")
-- 
2.7.4
