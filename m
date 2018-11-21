Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMM-0003KX-DG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMI-0003xW-Il
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPaMG-0003v8-JI
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:30 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 21 Nov 2018 16:48:18 -0500
Message-Id: <20181121214818.22874-3-crosa@redhat.com>
In-Reply-To: <20181121214818.22874-1-crosa@redhat.com>
References: <20181121214818.22874-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] Add "boot_linux" acceptance test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Cleber Rosa <crosa@redhat.com>

This acceptance test, validates that a full blown Linux guest can
successfully boot in QEMU.  In this specific case, the guest chosen is
Fedora version 29.  By passing parameters, the same test can attempt
to boot different distros, arches, etc.

The method for checking the successful boot is based on "cloudinit"
and its "phone home" feature.  The guest is given an ISO image
with the location of the phone home server, and the information to
post (the instance ID).  Upon receiving the correct information,
from the guest, the test is considered to have PASSed.

This test is currently limited to user mode networking only, and
instructs the guest to connect to the "router" address that is hard
coded in QEMU.

To create the cloudinit ISO image that will be used to configure the
guest, the pycdlib library is also required and has been added as
requirement to the virtual environment created by "check-venv".

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux.py | 46 ++++++++++++++++++++++++++++++++++
 tests/requirements.txt         |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 tests/acceptance/boot_linux.py

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
new file mode 100644
index 0000000000..dceebcb964
--- /dev/null
+++ b/tests/acceptance/boot_linux.py
@@ -0,0 +1,46 @@
+# Functional test that boots a complete Linux system via a cloud image
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from avocado_qemu import Test
+
+from avocado.utils import cloudinit
+from avocado.utils import network
+from avocado.utils import vmimage
+
+
+class BootLinux(Test):
+    """
+    Boots a Linux system, checking for a successful initialization
+
+    :avocado: enable
+    :avocado: tags=3Dx86_64
+    """
+
+    timeout =3D 600
+
+    def test(self):
+        self.vm.add_args('-m', '1024')
+        boot =3D vmimage.get('fedora', arch=3D'x86_64', version=3D'29',
+                           cache_dir=3Dself.cache_dirs[0],
+                           snapshot_dir=3Dself.workdir)
+        self.vm.add_args('-drive', 'file=3D%s' % boot.path)
+
+        cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.iso')
+        phone_home_port =3D network.find_free_port()
+        cloudinit.iso(cloudinit_iso, self.name,
+                      # QEMU's hard coded usermode router address
+                      phone_home_host=3D'10.0.2.2',
+                      phone_home_port=3Dphone_home_port)
+        self.vm.add_args('-drive', 'file=3D%s' % cloudinit_iso)
+
+        self.vm.launch()
+        cloudinit.wait_for_phone_home(('0.0.0.0', phone_home_port), self=
.name)
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 64c6e27a94..fdc2d7d325 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -2,3 +2,4 @@
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
 avocado-framework=3D=3D65.0
+pycdlib=3D=3D1.6.0
--=20
2.19.1
