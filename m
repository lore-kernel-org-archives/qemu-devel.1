Received: from eggs.gnu.org ([209.51.188.92]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqd-00057C-SD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqc-0005r6-6G
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:03 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:22 -0500
Message-Id: <20190117185628.21862-13-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/18] Boot Linux Console Test: add a test for
 mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
board and verify the serial is working.  Also, it relies on the serial
device set by the machine itself.

If mips is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips" tags.

Alternatively, this test can be run using:

    $ avocado run -t arch:mips tests/acceptance
    $ avocado run -t machine:malta tests/acceptance
    $ avocado run -t endian:big tests/acceptance

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 scripts/qemu.py                        |  1 -
 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 844d514afa..49f9016e6a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -187,7 +187,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/scripts/qemu.py b/scripts/qemu.py
index 88e1608b42..ef84b0f843 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -35,7 +35,6 @@ def kvm_available(target_arch=3DNone):
 #: Maps machine types to the preferred console device types
 CONSOLE_DEV_TYPES =3D {
     r'^clipper$': 'isa-serial',
-    r'^malta': 'isa-serial',
     r'^(pc.*|q35.*|isapc)$': 'isa-serial',
     r'^(40p|powernv|prep)$': 'isa-serial',
     r'^pseries.*': 'spapr-vty',
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 278bb2be3d..0678ec91d2 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -60,3 +60,23 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_mips_malta(self):
+        """
+        :avocado: tags=3Darch:mips
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:big
+        """
+        kernel_url =3D ('http://people.debian.org/~aurel32/qemu/mips/'
+                      'vmlinux-3.2.0-4-4kc-malta')
+        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
