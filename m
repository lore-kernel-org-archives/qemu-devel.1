Received: from eggs.gnu.org ([209.51.188.92]:43206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrA-0005cP-3r
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCr9-0006kP-5s
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:36 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:20 -0500
Message-Id: <20190117185628.21862-11-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/18] Boot Linux Console Test: refactor the
 console watcher into utility method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

This introduces a utility method that monitors the console device and
looks for either a message that signals the test success or failure.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 30 ++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 35b31162d4..278bb2be3d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -23,6 +23,25 @@ class BootLinuxConsole(Test):
=20
     timeout =3D 60
=20
+    def wait_for_console_pattern(self, success_message,
+                                 failure_message=3D'Kernel panic - not s=
yncing'):
+        """
+        Waits for messages to appear on the console, while logging the c=
ontent
+
+        :param success_message: if this message appears, test succeeds
+        :param failure_message: if this message appears, test fails
+        """
+        console =3D self.vm.console_socket.makefile()
+        console_logger =3D logging.getLogger('console')
+        while True:
+            msg =3D console.readline()
+            console_logger.debug(msg.strip())
+            if success_message in msg:
+                break
+            if failure_message in msg:
+                fail =3D 'Failure message found in console: %s' % failur=
e_message
+                self.fail(fail)
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=3Darch:x86_64
@@ -39,12 +58,5 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
-        console =3D self.vm.console_socket.makefile()
-        console_logger =3D logging.getLogger('console')
-        while True:
-            msg =3D console.readline()
-            console_logger.debug(msg.strip())
-            if 'Kernel command line: %s' % kernel_command_line in msg:
-                break
-            if 'Kernel panic - not syncing' in msg:
-                self.fail("Kernel panic reached")
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
