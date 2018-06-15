Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAC-0007xs-Mg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAA-0007I9-JV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuAA-0007HS-AD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:22 -0300
Message-Id: <20180615191327.11480-3-ehabkost@redhat.com>
In-Reply-To: <20180615191327.11480-1-ehabkost@redhat.com>
References: <20180615191327.11480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] Add functional/acceptance tests
 infrastructure
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

This patch adds the very minimum infrastructure necessary for writing
and running functional/acceptance tests, including:

 * Documentation
 * The avocado_qemu.Test base test class
 * One example tests (version.py)

Additional functionality is expected to be added along the tests that
require them.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20180530184156.15634-2-crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[ehabkost: fix typo on testing.rst]
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/testing.rst                    | 192 ++++++++++++++++++++++
 tests/acceptance/README.rst               |  10 ++
 tests/acceptance/avocado_qemu/__init__.py |  54 ++++++
 tests/acceptance/version.py               |  24 +++
 4 files changed, 280 insertions(+)
 create mode 100644 tests/acceptance/README.rst
 create mode 100644 tests/acceptance/avocado_qemu/__init__.py
 create mode 100644 tests/acceptance/version.py

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 0ca1a2d4b5..f33e5a8423 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -484,3 +484,195 @@ supported. To start the fuzzer, run
=20
 Alternatively, some command different from "qemu-img info" can be tested=
, by
 changing the ``-c`` option.
+
+Acceptance tests using the Avocado Framework
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``tests/acceptance`` directory hosts functional tests, also known
+as acceptance level tests.  They're usually higher level tests, and
+may interact with external resources and with various guest operating
+systems.
+
+These tests are written using the Avocado Testing Framework (which must
+be installed separately) in conjunction with a the ``avocado_qemu.Test``
+class, implemented at ``tests/acceptance/avocado_qemu``.
+
+Tests based on ``avocado_qemu.Test`` can easily:
+
+ * Customize the command line arguments given to the convenience
+   ``self.vm`` attribute (a QEMUMachine instance)
+
+ * Interact with the QEMU monitor, send QMP commands and check
+   their results
+
+ * Interact with the guest OS, using the convenience console device
+   (which may be useful to assert the effectiveness and correctness of
+   command line arguments or QMP commands)
+
+ * Interact with external data files that accompany the test itself
+   (see ``self.get_data()``)
+
+ * Download (and cache) remote data files, such as firmware and kernel
+   images
+
+ * Have access to a library of guest OS images (by means of the
+   ``avocado.utils.vmimage`` library)
+
+ * Make use of various other test related utilities available at the
+   test class itself and at the utility library:
+
+   - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.=
html#avocado.Test
+   - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado=
.utils.html
+
+Installation
+------------
+
+To install Avocado and its dependencies, run:
+
+.. code::
+
+  pip install --user avocado-framework
+
+Alternatively, follow the instructions on this link:
+
+  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html=
#installing-avocado
+
+Overview
+--------
+
+This directory provides the ``avocado_qemu`` Python module, containing
+the ``avocado_qemu.Test`` class.  Here's a simple usage example:
+
+.. code::
+
+  from avocado_qemu import Test
+
+
+  class Version(Test):
+      """
+      :avocado: enable
+      :avocado: tags=3Dquick
+      """
+      def test_qmp_human_info_version(self):
+          self.vm.launch()
+          res =3D self.vm.command('human-monitor-command',
+                                command_line=3D'info version')
+          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+
+To execute your test, run:
+
+.. code::
+
+  avocado run version.py
+
+Tests may be classified according to a convention by using docstring
+directives such as ``:avocado: tags=3DTAG1,TAG2``.  To run all tests
+in the current directory, tagged as "quick", run:
+
+.. code::
+
+  avocado run -t quick .
+
+The ``avocado_qemu.Test`` base test class
+-----------------------------------------
+
+The ``avocado_qemu.Test`` class has a number of characteristics that
+are worth being mentioned right away.
+
+First of all, it attempts to give each test a ready to use QEMUMachine
+instance, available at ``self.vm``.  Because many tests will tweak the
+QEMU command line, launching the QEMUMachine (by using ``self.vm.launch(=
)``)
+is left to the test writer.
+
+At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
+shutdown.
+
+QEMUMachine
+~~~~~~~~~~~
+
+The QEMUMachine API is already widely used in the Python iotests,
+device-crash-test and other Python scripts.  It's a wrapper around the
+execution of a QEMU binary, giving its users:
+
+ * the ability to set command line arguments to be given to the QEMU
+   binary
+
+ * a ready to use QMP connection and interface, which can be used to
+   send commands and inspect its results, as well as asynchronous
+   events
+
+ * convenience methods to set commonly used command line arguments in
+   a more succinct and intuitive way
+
+QEMU binary selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The QEMU binary used for the ``self.vm`` QEMUMachine instance will
+primarily depend on the value of the ``qemu_bin`` parameter.  If it's
+not explicitly set, its default value will be the result of a dynamic
+probe in the same source tree.  A suitable binary will be one that
+targets the architecture matching host machine.
+
+Based on this description, test writers will usually rely on one of
+the following approaches:
+
+1) Set ``qemu_bin``, and use the given binary
+
+2) Do not set ``qemu_bin``, and use a QEMU binary named like
+   "${arch}-softmmu/qemu-system-${arch}", either in the current
+   working directory, or in the current source tree.
+
+The resulting ``qemu_bin`` value will be preserved in the
+``avocado_qemu.Test`` as an attribute with the same name.
+
+Attribute reference
+-------------------
+
+Besides the attributes and methods that are part of the base
+``avocado.Test`` class, the following attributes are available on any
+``avocado_qemu.Test`` instance.
+
+vm
+~~
+
+A QEMUMachine instance, initially configured according to the given
+``qemu_bin`` parameter.
+
+qemu_bin
+~~~~~~~~
+
+The preserved value of the ``qemu_bin`` parameter or the result of the
+dynamic probe for a QEMU binary in the current working directory or
+source tree.
+
+Parameter reference
+-------------------
+
+To understand how Avocado parameters are accessed by tests, and how
+they can be passed to tests, please refer to::
+
+  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#ac=
cessing-test-parameters
+
+Parameter values can be easily seen in the log files, and will look
+like the following:
+
+.. code::
+
+  PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-system=
-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
+
+qemu_bin
+~~~~~~~~
+
+The exact QEMU binary to be used on QEMUMachine.
+
+Uninstalling Avocado
+--------------------
+
+If you've followed the installation instructions above, you can easily
+uninstall Avocado.  Start by listing the packages you have installed::
+
+  pip list --user
+
+And remove any package you want with::
+
+  pip uninstall <package_name>
diff --git a/tests/acceptance/README.rst b/tests/acceptance/README.rst
new file mode 100644
index 0000000000..89260faed6
--- /dev/null
+++ b/tests/acceptance/README.rst
@@ -0,0 +1,10 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Acceptance tests using the Avocado Framework
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This directory contains functional tests, also known as acceptance
+level tests.  They're usually higher level, and may interact with
+external resources and with various guest operating systems.
+
+For more information, please refer to ``docs/devel/testing.rst``,
+section "Acceptance tests using the Avocado Framework".
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
new file mode 100644
index 0000000000..1e54fd5932
--- /dev/null
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -0,0 +1,54 @@
+# Test class and utilities for functional tests
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
+import sys
+
+import avocado
+
+SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(__file_=
_)))
+SRC_ROOT_DIR =3D os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
+sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
+
+from qemu import QEMUMachine
+
+def is_readable_executable_file(path):
+    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
+
+
+def pick_default_qemu_bin():
+    """
+    Picks the path of a QEMU binary, starting either in the current work=
ing
+    directory or in the source tree root directory.
+    """
+    arch =3D os.uname()[4]
+    qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
+                                          "qemu-system-%s" % arch)
+    if is_readable_executable_file(qemu_bin_relative_path):
+        return qemu_bin_relative_path
+
+    qemu_bin_from_src_dir_path =3D os.path.join(SRC_ROOT_DIR,
+                                              qemu_bin_relative_path)
+    if is_readable_executable_file(qemu_bin_from_src_dir_path):
+        return qemu_bin_from_src_dir_path
+
+
+class Test(avocado.Test):
+    def setUp(self):
+        self.vm =3D None
+        self.qemu_bin =3D self.params.get('qemu_bin',
+                                        default=3Dpick_default_qemu_bin(=
))
+        if self.qemu_bin is None:
+            self.cancel("No QEMU binary defined or found in the source t=
ree")
+        self.vm =3D QEMUMachine(self.qemu_bin)
+
+    def tearDown(self):
+        if self.vm is not None:
+            self.vm.shutdown()
diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
new file mode 100644
index 0000000000..13b0a7440d
--- /dev/null
+++ b/tests/acceptance/version.py
@@ -0,0 +1,24 @@
+# Version check example test
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+
+from avocado_qemu import Test
+
+
+class Version(Test):
+    """
+    :avocado: enable
+    :avocado: tags=3Dquick
+    """
+    def test_qmp_human_info_version(self):
+        self.vm.launch()
+        res =3D self.vm.command('human-monitor-command',
+                              command_line=3D'info version')
+        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
--=20
2.18.0.rc1.1.g3f1ff2140
