Received: from eggs.gnu.org ([209.51.188.92]:37852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHH-0003z2-Q0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHF-0006wh-2D
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHE-0006wU-Tr
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:22 -0300
Message-Id: <20190503004130.8285-12-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/19] tests/boot_linux_console: refactor the
 console watcher into utility method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

This introduces a utility method that monitors the console device and
looks for either a message that signals the test success or failure.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-12-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 30 ++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index bfcae3771b..32f1d4d0bf 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -23,6 +23,25 @@ class BootLinuxConsole(Test):
=20
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
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
2.18.0.rc1.1.g3f1ff2140
