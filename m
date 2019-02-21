Received: from eggs.gnu.org ([209.51.188.92]:33345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwchh-0006UC-74
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwchf-0001Bj-6P
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:59:09 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 20 Feb 2019 19:57:49 -0500
Message-Id: <20190221005753.27955-17-crosa@redhat.com>
In-Reply-To: <20190221005753.27955-1-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/20] Boot Linux Console Test: add a test
 for ppc64 + pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Just like the previous tests, boots a Linux kernel on a ppc64 target
using the pseries machine.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 0260263bb8..b5abe130f1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -198,7 +198,7 @@ matrix:
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
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 899c27a9ec..6bc9a6b303 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -137,3 +137,22 @@ class BootLinuxConsole(Test):
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
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3Dhvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
