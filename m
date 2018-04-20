Received: from eggs.gnu.org ([2001:4830:134:3::10]:39988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahW-0007lR-K7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahU-0007xp-4U
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9ahT-0007vx-Sy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:24:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:51 -0300
Message-Id: <20180420181951.7252-25-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 24/24] avocado_qemu: Add a few VNC related tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

These exercise the basics of firing up QEMU with and without
a VNC device, and attempting to set the password when a VNC
device and password is given (or not).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_vnc.py | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tests/avocado/test_vnc.py

diff --git a/tests/avocado/test_vnc.py b/tests/avocado/test_vnc.py
new file mode 100644
index 0000000000..f5fe26ead6
--- /dev/null
+++ b/tests/avocado/test_vnc.py
@@ -0,0 +1,58 @@
+from avocado import main
+from avocado_qemu import test
+
+
+class Vnc(test.QemuTest):
+    """
+    :avocado: enable
+    :avocado: tags=vnc,quick
+    """
+    def test_no_vnc(self):
+        self.vm.args = ['-nodefaults', '-S']
+        self.vm.launch()
+        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
+
+    def test_no_vnc_change_password(self):
+        self.vm.args = ['-nodefaults', '-S']
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
+        self.vm.args = ['-nodefaults', '-S', '-vnc', ':0']
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
+        self.vm.args = ['-nodefaults', '-S', '-vnc', ':0,password']
+        self.vm.launch()
+        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
+        set_password_response = self.vm.qmp('change',
+                                            device='vnc',
+                                            target='password',
+                                            arg='new_password')
+        self.assertEqual(set_password_response['return'], {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    main()
-- 
2.14.3
