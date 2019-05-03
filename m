Received: from eggs.gnu.org ([209.51.188.92]:37892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHN-00046q-EI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHK-00070A-06
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHJ-0006xx-OW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:24 -0300
Message-Id: <20190503004130.8285-14-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/19] tests/boot_linux_console: add a test for
 mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190312171824.5134-14-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index e6f951e01a..f6f5d39aca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ matrix:
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
index 32f1d4d0bf..028fefd7ee 100644
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
@@ -42,6 +45,21 @@ class BootLinuxConsole(Test):
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
@@ -60,3 +78,26 @@ class BootLinuxConsole(Test):
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
2.18.0.rc1.1.g3f1ff2140
