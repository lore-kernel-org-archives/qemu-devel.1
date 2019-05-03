Received: from eggs.gnu.org ([209.51.188.92]:37977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHT-0004Cp-Ix
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHS-00074M-DZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHS-00073n-7v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:28 -0300
Message-Id: <20190503004130.8285-18-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 17/19] tests/boot_linux_console: add a test for
 s390x + s390-ccw-virtio
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

Just like the previous tests, boots a Linux kernel on a s390x target
using the s390-ccw-virtio machine.

Because it's not possible to have multiple VT220 consoles,
'-nodefaults' is used, so that the one set with set_console() works
correctly.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Message-Id: <20190312171824.5134-20-crosa@redhat.com>
[ehabkost: Updated kernel URL to point to fedoraproject.org]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 268df60345..9b271b963d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu"
         - TEST_CMD="make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 54b6e2625d..7c1099e5c8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -175,3 +175,23 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_s390x_s390_ccw_virtio(self):
+        """
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390_ccw_virtio
+        """
+        kernel_url = ('https://download.fedoraproject.org/pub/fedora-secondary/'
+                      'releases/29/Everything/s390x/os/images/kernel.img')
+        kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('s390-ccw-virtio')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
+        self.vm.add_args('-nodefaults',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
-- 
2.18.0.rc1.1.g3f1ff2140
