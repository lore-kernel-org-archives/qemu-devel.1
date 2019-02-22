Received: from eggs.gnu.org ([209.51.188.92]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGi2-0003tj-5i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGi1-0008Co-4S
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:10 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:43 -0500
Message-Id: <20190222194146.13102-5-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] tests.acceptance: adds multi vm capability
 for acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

From: Caio Carrara <ccarrara@redhat.com>

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
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190212193855.13223-2-ccarrara@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                    | 41 ++++++++++++++++++++++-
 tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++---
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 3ce171829d..60f897d915 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -633,7 +633,46 @@ instance, available at ``self.vm``.  Because many te=
sts will tweak the
 QEMU command line, launching the QEMUMachine (by using ``self.vm.launch(=
)``)
 is left to the test writer.
=20
-At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
+The base test class has also support for tests with more than one
+QEMUMachine. The way to get machines is through the ``self.get_vm()``
+method which will return a QEMUMachine instance. The ``self.get_vm()``
+method accepts arguments that will be passed to the QEMUMachine creation
+and also an optional `name` attribute so you can identify a specific
+machine and get it more than once through the tests methods. A simple
+and hypothetical example follows:
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
index 28bfb8e9d3..a66ec72daa 100644
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
@@ -41,13 +42,29 @@ def pick_default_qemu_bin():
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
