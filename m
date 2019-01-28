Received: from eggs.gnu.org ([209.51.188.92]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gnvaU-00051t-Ju
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 20:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gnvWQ-0001xZ-F0
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 20:15:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:13843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gnvWN-0001ti-6C
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 20:15:32 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon, 28 Jan 2019 09:15:11 +0800
Message-Id: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] Acceptance tests: use linux-3.6 and set
 vm memory to 4GiB
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

QEMU have already supported to load up to 4G initrd if the sepcified memory is
enough and XLF_CAN_BE_LOADED_ABOVE_4G is set by guest kernel

linux-3.6 kernel shipped by Fedora-18 cannot support xldflags so that it
cannot support loading more than 2GiB initrd

CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
CC: Caio Carrara <ccarrara@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
V2: fix typos
---
 tests/acceptance/linux_initrd.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index 737355c..b283715 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -24,14 +24,16 @@ class LinuxInitrd(Test):
 
     timeout = 60
 
-    def test_with_2gib_file_should_exit_error_msg(self):
+    def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         """
         Pretends to boot QEMU with an initrd file with size of 2GiB
         and expect it exits with error message.
+        Fedora-18 shipped with linux-3.6 which have not supported xloadflags
+        cannot support more than 2GiB initrd.
         """
-        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
-                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
-        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora/li'
+                      'nux/releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_hash = '41464f68efe42b9991250bed86c7081d2ccdbb21'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         max_size = 2 * (1024 ** 3) - 1
 
@@ -39,8 +41,8 @@ class LinuxInitrd(Test):
             initrd.seek(max_size)
             initrd.write(b'\0')
             initrd.flush()
-            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
-                                                initrd.name)
+            cmd = "%s -kernel %s -initrd %s -m 4096" % (
+                  self.qemu_bin, kernel_path, initrd.name)
             res = run(cmd, ignore_status=True)
             self.assertEqual(res.exit_status, 1)
             expected_msg = r'.*initrd is too large.*max: \d+, need %s.*' % (
-- 
2.7.4
