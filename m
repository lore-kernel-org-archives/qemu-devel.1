Received: from eggs.gnu.org ([209.51.188.92]:42984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqx-0005Rm-Cu
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqs-0006MS-QF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:20 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:25 -0500
Message-Id: <20190117185628.21862-16-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/18] Boot Linux Console Test: add a test for
 aarch64 + virt
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

Just like the previous tests, boots a Linux kernel on a aarch64 target
using the virt machine.

One special option added is the CPU type, given that the kernel
selected fails to boot on the virt machine's default CPU (cortex-a15).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 54100eea5a..595e8c0b6c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -187,7 +187,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index f3ccd23a7a..107700b517 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_aarch64_virt(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        """
+        kernel_url =3D ('https://sjc.edge.kernel.org/fedora-buffet/fedor=
a/linux/'
+                      'releases/29/Server/aarch64/os/images/pxeboot/vmli=
nuz')
+        kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line =3D 'console=3DttyAMA0'
+        self.vm.add_args('-cpu', 'cortex-a53',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
