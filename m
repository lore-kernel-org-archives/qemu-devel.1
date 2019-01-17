Received: from eggs.gnu.org ([209.51.188.92]:45769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCs8-0006To-6p
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrS-0007Z2-Ms
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:19 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:28 -0500
Message-Id: <20190117185628.21862-19-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/18] Boot Linux Console Test: add a test for
 alpha + clipper
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

Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
board and verify the serial is working.  One extra command added to
the QEMU command line is '-vga std', because the kernel used is
known to crash without it.

If alpha is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:alpha" tags.

Alternatively, this test can be run using:

    $ avocado run -t arch:alpha tests/acceptance
    $ avocado run -t machine:clipper tests/acceptance

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 scripts/qemu.py                        |  1 -
 tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0d5a4b104b..73a113af87 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -187,7 +187,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-so=
ftmmu,s390x-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-so=
ftmmu,s390x-softmmu,alpha-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/scripts/qemu.py b/scripts/qemu.py
index 1531e28fc1..a704da418a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -34,7 +34,6 @@ def kvm_available(target_arch=3DNone):
=20
 #: Maps machine types to the preferred console device types
 CONSOLE_DEV_TYPES =3D {
-    r'^clipper$': 'isa-serial',
     r'^(pc.*|q35.*|isapc)$': 'isa-serial',
     r'^(40p|powernv|prep)$': 'isa-serial',
     r'^s390-ccw-virtio.*': 'sclpconsole',
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index c4d5477d45..a8028a39d4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -197,3 +197,25 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_alpha_clipper(self):
+        """
+        :avocado: tags=3Darch:alpha
+        :avocado: tags=3Dmachine:clipper
+        """
+        kernel_url =3D ('http://archive.debian.org/debian/dists/lenny/ma=
in/'
+                      'installer-alpha/current/images/cdrom/vmlinuz')
+        kernel_hash =3D '3a943149335529e2ed3e74d0d787b85fb5671ba3'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        uncompressed_kernel =3D archive.uncompress(kernel_path, self.wor=
kdir)
+
+        self.vm.set_machine('clipper')
+        self.vm.set_console()
+        kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
+        self.vm.add_args('-vga', 'std',
+                         '-kernel', uncompressed_kernel,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
