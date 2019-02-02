Received: from eggs.gnu.org ([209.51.188.92]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcT-0002fA-Qk
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcJ-0003QK-N3
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:13 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:56:08 -0500
Message-Id: <20190202005610.24048-19-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/20] Boot Linux Console Test: add a test
 for arm + virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

Just like the previous tests, boots a Linux kernel on an arm target
using the virt machine.

Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 0dbd8183f6..0b6416ba06 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -189,7 +189,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-so=
ftmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 85502fa48a..4b031baf7a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -174,3 +174,22 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_arm_virt(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:virt
+        """
+        kernel_url =3D ('https://sjc.edge.kernel.org/fedora-buffet/fedor=
a/linux/'
+                      'releases/29/Server/armhfp/os/images/pxeboot/vmlin=
uz')
+        kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyAMA0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
