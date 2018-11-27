Received: from eggs.gnu.org ([2001:4830:134:3::10]:43246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gRaxE-0002sM-Pc
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gRaxC-0008W7-VU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:50:56 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Tue, 27 Nov 2018 05:50:34 -0500
Message-Id: <20181127105034.21045-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] Introduce Python module structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

This is a simple move of Python code that wraps common QEMU
functionality, and are used by a number of different tests
and scripts.

By treating that code as a real Python module, we can more easily,
among other things:
 * reuse more code
 * apply a more consistent style
 * add tests to that code
 * generate documentation

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure                                  |  1 +
 scripts/qemu.py =3D> python/qemu/__init__.py | 11 ++++++-----
 {scripts/qmp =3D> python/qemu}/qmp.py        |  0
 {scripts =3D> python/qemu}/qtest.py          |  5 +++--
 scripts/device-crash-test                  |  5 +++++
 scripts/qmp/__init__.py                    |  0
 tests/acceptance/avocado_qemu/__init__.py  |  9 +++++----
 tests/migration/guestperf/engine.py        | 10 +++++++---
 tests/qemu-iotests/iotests.py              |  8 ++++++--
 tests/vm/basevm.py                         |  9 +++++++--
 10 files changed, 40 insertions(+), 18 deletions(-)
 rename scripts/qemu.py =3D> python/qemu/__init__.py (98%)
 rename {scripts/qmp =3D> python/qemu}/qmp.py (100%)
 rename {scripts =3D> python/qemu}/qtest.py (97%)
 delete mode 100644 scripts/qmp/__init__.py

diff --git a/configure b/configure
index 0a3c6a72c3..2b64c51009 100755
--- a/configure
+++ b/configure
@@ -7510,6 +7510,7 @@ LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
 LINKS=3D"$LINKS .gdbinit scripts" # scripts needed by relative path in .=
gdbinit
 LINKS=3D"$LINKS tests/acceptance tests/data"
 LINKS=3D"$LINKS tests/qemu-iotests/check"
+LINKS=3D"$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
diff --git a/scripts/qemu.py b/python/qemu/__init__.py
similarity index 98%
rename from scripts/qemu.py
rename to python/qemu/__init__.py
index 6e3b0e6771..2ae5e1f632 100644
--- a/scripts/qemu.py
+++ b/python/qemu/__init__.py
@@ -16,12 +16,13 @@ import errno
 import logging
 import os
 import subprocess
-import qmp.qmp
 import re
 import shutil
 import socket
 import tempfile
=20
+from . import qmp
+
=20
 LOG =3D logging.getLogger(__name__)
=20
@@ -58,7 +59,7 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
     failures reported by the QEMU binary itself.
     """
=20
-class MonitorResponseError(qmp.qmp.QMPError):
+class MonitorResponseError(qmp.QMPError):
     """
     Represents erroneous QMP monitor reply
     """
@@ -259,8 +260,8 @@ class QEMUMachine(object):
         self._qemu_log_path =3D os.path.join(self._temp_dir, self._name =
+ ".log")
         self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
=20
-        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
-                                                server=3DTrue)
+        self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
+                                            server=3DTrue)
=20
     def _post_launch(self):
         self._qmp.accept()
@@ -376,7 +377,7 @@ class QEMUMachine(object):
         """
         reply =3D self.qmp(cmd, conv_keys, **args)
         if reply is None:
-            raise qmp.qmp.QMPError("Monitor is closed")
+            raise qmp.QMPError("Monitor is closed")
         if "error" in reply:
             raise MonitorResponseError(reply)
         return reply["return"]
diff --git a/scripts/qmp/qmp.py b/python/qemu/qmp.py
similarity index 100%
rename from scripts/qmp/qmp.py
rename to python/qemu/qmp.py
diff --git a/scripts/qtest.py b/python/qemu/qtest.py
similarity index 97%
rename from scripts/qtest.py
rename to python/qemu/qtest.py
index adf1fe3f26..bff79cdd13 100644
--- a/scripts/qtest.py
+++ b/python/qemu/qtest.py
@@ -13,7 +13,8 @@
=20
 import socket
 import os
-import qemu
+
+from . import QEMUMachine
=20
=20
 class QEMUQtestProtocol(object):
@@ -73,7 +74,7 @@ class QEMUQtestProtocol(object):
         self._sock.settimeout(timeout)
=20
=20
-class QEMUQtestMachine(qemu.QEMUMachine):
+class QEMUQtestMachine(QEMUMachine):
     '''A QEMU VM'''
=20
     def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"/va=
r/tmp",
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0c84..c75ae0ecbc 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,6 +35,11 @@ import random
 import argparse
 from itertools import chain
=20
+THIS_DIR =3D os.path.dirname(os.path.abspath(__file__))
+TOP_DIR =3D os.path.dirname(THIS_DIR)
+PYTHON_MODULE_PATH =3D os.path.join(TOP_DIR, 'python')
+sys.path.append(PYTHON_MODULE_PATH)
+
 from qemu import QEMUMachine
=20
 logger =3D logging.getLogger('device-crash-test')
diff --git a/scripts/qmp/__init__.py b/scripts/qmp/__init__.py
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..4f3e426ebd 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -13,9 +13,10 @@ import sys
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(__file_=
_)))
-SRC_ROOT_DIR =3D os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
-sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
+THIS_DIR =3D os.path.dirname(os.path.abspath(__file__))
+TOP_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(THIS_DIR)))
+PYTHON_MODULE_PATH =3D os.path.join(TOP_DIR, 'python')
+sys.path.append(PYTHON_MODULE_PATH)
=20
 from qemu import QEMUMachine
=20
@@ -34,7 +35,7 @@ def pick_default_qemu_bin():
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
-    qemu_bin_from_src_dir_path =3D os.path.join(SRC_ROOT_DIR,
+    qemu_bin_from_src_dir_path =3D os.path.join(TOP_DIR,
                                               qemu_bin_relative_path)
     if is_readable_executable_file(qemu_bin_from_src_dir_path):
         return qemu_bin_from_src_dir_path
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index 398e3f2706..73c9b66821 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -24,13 +24,17 @@ import re
 import sys
 import time
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '..'=
, 'scripts'))
-import qemu
-import qmp.qmp
 from guestperf.progress import Progress, ProgressStats
 from guestperf.report import Report
 from guestperf.timings import TimingRecord, Timings
=20
+THIS_DIR =3D os.path.dirname(os.path.abspath(__file__))
+TOP_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(THIS_DIR)))
+PYTHON_MODULE_PATH =3D os.path.join(TOP_DIR, 'python')
+sys.path.append(PYTHON_MODULE_PATH)
+
+import qemu
+
=20
 class Engine(object):
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index d537538ba0..92fddd2a58 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -31,8 +31,12 @@ import logging
 import atexit
 import io
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
-import qtest
+THIS_DIR =3D os.path.dirname(os.path.abspath(__file__))
+TOP_DIR =3D os.path.dirname(os.path.dirname(THIS_DIR))
+PYTHON_MODULE_PATH =3D os.path.join(TOP_DIR, 'python')
+sys.path.append(PYTHON_MODULE_PATH)
+
+from qemu import qtest
=20
=20
 # This will not work if arguments contain spaces but is necessary if we
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5caf77d6b8..464234a7b2 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -17,8 +17,6 @@ import sys
 import logging
 import time
 import datetime
-sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scr=
ipts"))
-from qemu import QEMUMachine, kvm_available
 import subprocess
 import hashlib
 import optparse
@@ -28,6 +26,13 @@ import shutil
 import multiprocessing
 import traceback
=20
+THIS_DIR =3D os.path.dirname(os.path.abspath(__file__))
+TOP_DIR =3D os.path.dirname(os.path.dirname(THIS_DIR))
+PYTHON_MODULE_PATH =3D os.path.join(TOP_DIR, 'python')
+sys.path.append(PYTHON_MODULE_PATH)
+
+from qemu import QEMUMachine, kvm_available
+
 SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")).read()
 SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
--=20
2.19.1
