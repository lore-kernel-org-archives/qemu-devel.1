Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OX-0003ND-J7
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0000oy-AZ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OV-0000mO-U6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:05 -0400
Message-Id: <20181009232607.15521-6-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/7] Acceptance Tests: set machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

By setting the machine type, even if it's the one that will be picked
based on the arch, it's possible to run the same tests with targets
that require a machine type (in addition to those that don't).

Given that only boot_linux_console.py contains code specific to x86_64
(an explicit reference to the kernel image that will be used) the
other tests can be used to test different targets:

  $ avocado run -p arch=3Daarch64 --filter-by-tags=3D'-x86_64' -- tests/a=
cceptance/

Eventually, to reduce boiler plate code, the idea is to concentrate
the basic configuration (arch, machine, console) in either another
utility method, or make that happen by default.  This is of course the
subject of a future discussion.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 3 ++-
 tests/acceptance/version.py            | 2 ++
 tests/acceptance/vnc.py                | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 98324f7591..58032f971c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -30,7 +30,8 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('pc')
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
         self.vm.set_console()
         kernel_command_line =3D 'console=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
index 13b0a7440d..7a3a20945f 100644
--- a/tests/acceptance/version.py
+++ b/tests/acceptance/version.py
@@ -18,6 +18,8 @@ class Version(Test):
     :avocado: tags=3Dquick
     """
     def test_qmp_human_info_version(self):
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
         self.vm.launch()
         res =3D self.vm.command('human-monitor-command',
                               command_line=3D'info version')
diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
index b1ef9d71b1..4a8a83025f 100644
--- a/tests/acceptance/vnc.py
+++ b/tests/acceptance/vnc.py
@@ -16,6 +16,11 @@ class Vnc(Test):
     :avocado: enable
     :avocado: tags=3Dvnc,quick
     """
+    def setUp(self):
+        super(Vnc, self).setUp()
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
+
     def test_no_vnc(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
--=20
2.17.1
