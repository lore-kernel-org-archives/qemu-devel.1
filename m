Received: from eggs.gnu.org ([209.51.188.92]:37995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHV-0004F0-NV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHU-000754-Hz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHU-00074q-AX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:29 -0300
Message-Id: <20190503004130.8285-19-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/19] tests/boot_linux_console: add a test for
 alpha + clipper
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
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Message-Id: <20190312171824.5134-21-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 9b271b963d..66448d99d6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 7c1099e5c8..d5c500ea30 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -195,3 +195,25 @@ class BootLinuxConsole(Test):
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
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
+        self.vm.add_args('-vga', 'std',
+                         '-kernel', uncompressed_kernel,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.18.0.rc1.1.g3f1ff2140
