Received: from eggs.gnu.org ([209.51.188.92]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcZ-0002iG-Ca
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcN-0003j6-Cg
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:14 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:56:04 -0500
Message-Id: <20190202005610.24048-15-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/20] Boot Linux Console Test: add a test
 for mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 1b43ed4df6..a4e3328c23 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -189,7 +189,7 @@ matrix:
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
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index e2ef43e7ce..05e43360b8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -8,9 +8,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
=20
+import os
 import logging
=20
 from avocado_qemu import Test
+from avocado.utils import process
+from avocado.utils import archive
=20
=20
 class BootLinuxConsole(Test):
@@ -44,6 +47,21 @@ class BootLinuxConsole(Test):
                 fail =3D 'Failure message found in console: %s' % failur=
e_message
                 self.fail(fail)
=20
+    def extract_from_deb(self, deb, path):
+        """
+        Extracts a file from a deb package into the test workdir
+
+        :param deb: path to the deb archive
+        :param file: path within the deb archive of the file to be extra=
cted
+        :returns: path of the extracted file
+        """
+        cwd =3D os.getcwd()
+        os.chdir(self.workdir)
+        process.run("ar x %s data.tar.gz" % deb)
+        archive.extract("data.tar.gz", self.workdir)
+        os.chdir(cwd)
+        return self.workdir + path
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=3Darch:x86_64
@@ -62,3 +80,26 @@ class BootLinuxConsole(Test):
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
+        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
+                   '20130217T032700Z/pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
+        deb_hash =3D 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-4kc-=
malta')
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.20.1
