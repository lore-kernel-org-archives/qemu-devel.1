Received: from eggs.gnu.org ([209.51.188.92]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHQ-0004A3-RZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHP-00072F-Hm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHN-00070c-G3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:25 -0300
Message-Id: <20190503004130.8285-15-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/19] tests/boot_linux_console: add a test for
 mips64el + malta
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
board and verify the serial is working.

If mips64el is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips64el"
tags.

Alternatively, this test can be run using:

    $ avocado run -t arch:mips64el tests/acceptance
    $ avocado run -t machine:malta tests/acceptance

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190312171824.5134-15-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f6f5d39aca..cb46098972 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 028fefd7ee..38b33b25f7 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -101,3 +101,36 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_mips64el_malta(self):
+        """
+        This test requires the ar tool to extract "data.tar.gz" from
+        the Debian package.
+
+        The kernel can be rebuilt using this Debian kernel source [1] an=
d
+        following the instructions on [2].
+
+        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
+            #linux-source-2.6.32_2.6.32-48
+        [2] https://kernel-team.pages.debian.net/kernel-handbook/
+            ch-common-tasks.html#s-common-official
+
+        :avocado: tags=3Darch:mips64el
+        :avocado: tags=3Dmachine:malta
+        """
+        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
+                   '20130217T032700Z/pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'=
)
+        deb_hash =3D '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-5kc-=
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
