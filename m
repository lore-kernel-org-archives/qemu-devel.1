Received: from eggs.gnu.org ([209.51.188.92]:43689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrI-0005j3-T0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrD-0006wO-KZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:44 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:24 -0500
Message-Id: <20190117185628.21862-15-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/18] Boot Linux Console Test: add a test for
 ppc64 + pseries
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

Just like the previous tests, boots a Linux kernel on a ppc64 target
using the pseries machine.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 scripts/qemu.py                        |  1 -
 tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 28648f7a61..54100eea5a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -187,7 +187,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/scripts/qemu.py b/scripts/qemu.py
index ef84b0f843..1531e28fc1 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -37,7 +37,6 @@ CONSOLE_DEV_TYPES =3D {
     r'^clipper$': 'isa-serial',
     r'^(pc.*|q35.*|isapc)$': 'isa-serial',
     r'^(40p|powernv|prep)$': 'isa-serial',
-    r'^pseries.*': 'spapr-vty',
     r'^s390-ccw-virtio.*': 'sclpconsole',
     }
=20
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 20b845fce1..f3ccd23a7a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -119,3 +119,22 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_ppc64_pseries(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:pseries
+        """
+        kernel_url =3D ('http://mirrors.rit.edu/fedora/fedora-secondary/=
'
+                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlin=
uz')
+        kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('pseries')
+        self.vm.set_console()
+        kernel_command_line =3D 'console=3Dhvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
