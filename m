Received: from eggs.gnu.org ([209.51.188.92]:39282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGiL-00049j-D9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGiI-0008Qa-41
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:28 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:46 -0500
Message-Id: <20190222194146.13102-8-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] Acceptance tests: expect boot to extract
 2GiB+ initrd with linux-v4.16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

XLF_CAN_BE_LOADED_ABOVE_4G is set on vmlinuz shipped by Fedora-28 so that
it's allowed to be loaded below 4 GB address.

timeout is updated to 5 minutes as well since we need more time to load a
large initrd to the guest

CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
CC: Caio Carrara <ccarrara@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <1548638112-31101-2-git-send-email-lizhijian@cn.fujitsu.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/linux_initrd.py | 37 +++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
index e33b5dcec0..fbdb48e43f 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -8,6 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
=20
+import logging
 import tempfile
 from avocado.utils.process import run
=20
@@ -21,7 +22,7 @@ class LinuxInitrd(Test):
     :avocado: tags=3Dx86_64
     """
=20
-    timeout =3D 60
+    timeout =3D 300
=20
     def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         """
@@ -47,3 +48,37 @@ class LinuxInitrd(Test):
             expected_msg =3D r'.*initrd is too large.*max: \d+, need %s.=
*' % (
                 max_size + 1)
             self.assertRegex(res.stderr_text, expected_msg)
+
+    def test_with_2gib_file_should_work_with_linux_v4_16(self):
+        """
+        QEMU has supported up to 4 GiB initrd for recent kernel
+        Expect guest can reach 'Unpacking initramfs...'
+        """
+        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
+                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+        max_size =3D 2 * (1024 ** 3) + 1
+
+        with tempfile.NamedTemporaryFile() as initrd:
+            initrd.seek(max_size)
+            initrd.write(b'\0')
+            initrd.flush()
+
+            self.vm.set_machine('pc')
+            self.vm.set_console()
+            kernel_command_line =3D 'console=3DttyS0'
+            self.vm.add_args('-kernel', kernel_path,
+                             '-append', kernel_command_line,
+                             '-initrd', initrd.name,
+                             '-m', '5120')
+            self.vm.launch()
+            console =3D self.vm.console_socket.makefile()
+            console_logger =3D logging.getLogger('console')
+            while True:
+                msg =3D console.readline()
+                console_logger.debug(msg.strip())
+                if 'Unpacking initramfs...' in msg:
+                    break
+                if 'Kernel panic - not syncing' in msg:
+                    self.fail("Kernel panic reached")
--=20
2.20.1
