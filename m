Received: from eggs.gnu.org ([2001:4830:134:3::10]:47069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kr-0005wS-D7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kq-0006EZ-Kc
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g85Kq-0006EB-Eh
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:40 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 11:14:27 -0400
Message-Id: <20181004151429.7232-6-crosa@redhat.com>
In-Reply-To: <20181004151429.7232-1-crosa@redhat.com>
References: <20181004151429.7232-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] Acceptance Tests: set machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

By setting the machine type, even if it's the one that will be picked
based on the arch, it's possible to run the same tests with targets
that require a machine type (in addition to those that don't).

Given that only boot_linux_console.py contains code specific to x86_64
(an explicit reference to the kernel image that will be used) the
other tests can be used to test different targets:

  $ avocado run -p arch=aarch64 --filter-by-tags='-x86_64' -- tests/acceptance/

Eventually, to reduce boiler plate code, the idea is to concentrate
the basic configuration (arch, machine, console) in either another
utility method, or make that happen by default.  This is of course the
subject of a future discussion.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 3 ++-
 tests/acceptance/version.py            | 2 ++
 tests/acceptance/vnc.py                | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 98324f7591..58032f971c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -30,7 +30,8 @@ class BootLinuxConsole(Test):
         kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
-        self.vm.set_machine('pc')
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
         self.vm.set_console()
         kernel_command_line = 'console=ttyS0'
         self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
index 13b0a7440d..7a3a20945f 100644
--- a/tests/acceptance/version.py
+++ b/tests/acceptance/version.py
@@ -18,6 +18,8 @@ class Version(Test):
     :avocado: tags=quick
     """
     def test_qmp_human_info_version(self):
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
         self.vm.launch()
         res = self.vm.command('human-monitor-command',
                               command_line='info version')
diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
index b1ef9d71b1..4a8a83025f 100644
--- a/tests/acceptance/vnc.py
+++ b/tests/acceptance/vnc.py
@@ -16,6 +16,11 @@ class Vnc(Test):
     :avocado: enable
     :avocado: tags=vnc,quick
     """
+    def setUp(self):
+        super(Vnc, self).setUp()
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine()
+
     def test_no_vnc(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
-- 
2.17.1
