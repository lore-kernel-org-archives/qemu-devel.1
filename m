Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goBDg-0003Db-KF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goBAL-00070n-70
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:57:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1goBAK-0006yC-VC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:57:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDDBFC067831
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:47:36 +0000 (UTC)
From: Caio Carrara <ccarrara@redhat.com>
Date: Mon, 28 Jan 2019 15:47:24 -0200
Message-Id: <20190128174725.8809-2-ccarrara@redhat.com>
In-Reply-To: <20190128174725.8809-1-ccarrara@redhat.com>
References: <20190128174725.8809-1-ccarrara@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] tests.acceptance: adds multi vm
 capability for acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wainersm@redhat.com, ehabkost@redhat.com, philmd@redhat.com, crosa@redhat.com, Caio Carrara <ccarrara@redhat.com>

This change adds the possibility to write acceptance tests with multi
virtual machine support. It's done keeping the virtual machines objects
stored in a test attribute (dictionary). This dictionary shouldn't be
accessed directly but through the new method added `get_vm`. This new
method accept a list of args (that will be added as virtual machine
arguments) and an optional name argument. The name is the key that
identify a single virtual machine along the test machines available. If
a name without a machine is informed a new machine will be instantiated.

The current usage of vm in tests will not be broken by this change since
it keeps a property called vm in the base test class. This property only
calls the new method `get_vm` with default parameters (no args and
'default' as machine name).

Signed-off-by: Caio Carrara <ccarrara@redhat.com>
---
 docs/devel/testing.rst                    | 40 ++++++++++++++++++++++-
 tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++---
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 18e2c0868a..b97c0368bc 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -634,7 +634,45 @@ instance, available at ``self.vm``.  Because many te=
sts will tweak the
 QEMU command line, launching the QEMUMachine (by using ``self.vm.launch(=
)``)
 is left to the test writer.
=20
-At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
+The base test class has also support for tests with more than one
+QEMUMachine. The way to get machines is through the ``self.get_vm()``
+method which will return a QEMUMachine instance. The ``self.get_vm()``
+method also accepts an optional `name` attribute so you can identify a
+specific machine and get it more than once through the tests methods. A
+simple and hypothetical example follows:
+
+.. code::
+
+  from avocado_qemu import Test
+
+
+  class MultipleMachines(Test):
+      """
+      :avocado: enable
+      """
+      def test_multiple_machines(self):
+          first_machine =3D self.get_vm()
+          second_machine =3D self.get_vm()
+          self.get_vm(name=3D'third_machine').launch()
+
+          first_machine.launch()
+          second_machine.launch()
+
+          first_res =3D first_machine.command(
+              'human-monitor-command',
+              command_line=3D'info version')
+
+          second_res =3D second_machine.command(
+              'human-monitor-command',
+              command_line=3D'info version')
+
+          third_res =3D self.get_vm(name=3D'third_machine').command(
+              'human-monitor-command',
+              command_line=3D'info version')
+
+          self.assertEquals(first_res, second_res, third_res)
+
+At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
 shutdown.
=20
 QEMUMachine
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..4c9e27feda 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -10,6 +10,7 @@
=20
 import os
 import sys
+import uuid
=20
 import avocado
=20
@@ -42,13 +43,29 @@ def pick_default_qemu_bin():
=20
 class Test(avocado.Test):
     def setUp(self):
-        self.vm =3D None
+        self._vms =3D {}
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Dpick_default_qemu_bin(=
))
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source t=
ree")
-        self.vm =3D QEMUMachine(self.qemu_bin)
+
+    def _new_vm(self, *args):
+        vm =3D QEMUMachine(self.qemu_bin)
+        if args:
+            vm.add_args(*args)
+        return vm
+
+    @property
+    def vm(self):
+        return self.get_vm(name=3D'default')
+
+    def get_vm(self, *args, name=3DNone):
+        if not name:
+            name =3D str(uuid.uuid4())
+        if self._vms.get(name) is None:
+            self._vms[name] =3D self._new_vm(*args)
+        return self._vms[name]
=20
     def tearDown(self):
-        if self.vm is not None:
-            self.vm.shutdown()
+        for vm in self._vms.values():
+            vm.shutdown()
--=20
2.20.1
