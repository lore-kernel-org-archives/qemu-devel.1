Received: from eggs.gnu.org ([2001:4830:134:3::10]:53084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfv-0005OD-CB
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfp-0007dw-Td
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fMHfp-0007dq-ON
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:45 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 25 May 2018 14:42:17 -0400
Message-Id: <20180525184219.14440-4-crosa@redhat.com>
In-Reply-To: <20180525184219.14440-1-crosa@redhat.com>
References: <20180525184219.14440-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] Acceptance tests: add quick VNC tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>

This patch adds a few simple behavior tests for VNC.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/test_vnc.py | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tests/acceptance/test_vnc.py

diff --git a/tests/acceptance/test_vnc.py b/tests/acceptance/test_vnc.py
new file mode 100644
index 0000000000..b1ef9d71b1
--- /dev/null
+++ b/tests/acceptance/test_vnc.py
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
+    :avocado: tags=vnc,quick
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
+        set_password_response = self.vm.qmp('change',
+                                            device='vnc',
+                                            target='password',
+                                            arg='new_password')
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
+        set_password_response = self.vm.qmp('change',
+                                            device='vnc',
+                                            target='password',
+                                            arg='new_password')
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
+        set_password_response = self.vm.qmp('change',
+                                            device='vnc',
+                                            target='password',
+                                            arg='new_password')
+        self.assertEqual(set_password_response['return'], {})
-- 
2.17.0
