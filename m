Received: from eggs.gnu.org ([2001:4830:134:3::10]:46936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAF-0007zc-AE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAE-0007LN-8P
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuAD-0007Ki-VO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:24 -0300
Message-Id: <20180615191327.11480-5-ehabkost@redhat.com>
In-Reply-To: <20180615191327.11480-1-ehabkost@redhat.com>
References: <20180615191327.11480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] Acceptance tests: add quick VNC tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

This patch adds a few simple behavior tests for VNC.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180530184156.15634-4-crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tests/acceptance/vnc.py

diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
new file mode 100644
index 0000000000..b1ef9d71b1
--- /dev/null
+++ b/tests/acceptance/vnc.py
@@ -0,0 +1,60 @@
+# Simple functional tests for VNC functionality
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+
+
+class Vnc(Test):
+    """
+    :avocado: enable
+    :avocado: tags=3Dvnc,quick
+    """
+    def test_no_vnc(self):
+        self.vm.add_args('-nodefaults', '-S')
+        self.vm.launch()
+        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
+
+    def test_no_vnc_change_password(self):
+        self.vm.add_args('-nodefaults', '-S')
+        self.vm.launch()
+        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
+        set_password_response =3D self.vm.qmp('change',
+                                            device=3D'vnc',
+                                            target=3D'password',
+                                            arg=3D'new_password')
+        self.assertIn('error', set_password_response)
+        self.assertEqual(set_password_response['error']['class'],
+                         'GenericError')
+        self.assertEqual(set_password_response['error']['desc'],
+                         'Could not set password')
+
+    def test_vnc_change_password_requires_a_password(self):
+        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
+        self.vm.launch()
+        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
+        set_password_response =3D self.vm.qmp('change',
+                                            device=3D'vnc',
+                                            target=3D'password',
+                                            arg=3D'new_password')
+        self.assertIn('error', set_password_response)
+        self.assertEqual(set_password_response['error']['class'],
+                         'GenericError')
+        self.assertEqual(set_password_response['error']['desc'],
+                         'Could not set password')
+
+    def test_vnc_change_password(self):
+        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password')
+        self.vm.launch()
+        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
+        set_password_response =3D self.vm.qmp('change',
+                                            device=3D'vnc',
+                                            target=3D'password',
+                                            arg=3D'new_password')
+        self.assertEqual(set_password_response['return'], {})
--=20
2.18.0.rc1.1.g3f1ff2140
