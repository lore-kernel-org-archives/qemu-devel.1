Received: from eggs.gnu.org ([209.51.188.92]:42757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQ4u-0005Rd-0E
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQ4s-0000JY-EQ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:35 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  6 Feb 2019 11:29:01 -0500
Message-Id: <20190206162901.19082-2-crosa@redhat.com>
In-Reply-To: <20190206162901.19082-1-crosa@redhat.com>
References: <20190206162901.19082-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/1] Introduce a Python module structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>

This is a simple move of Python code that wraps common QEMU
functionality, and are used by a number of different tests
and scripts.

By treating that code as a real Python module, we can more easily:
 * reuse code
 * have a proper place for the module's own unittests
 * apply a more consistent style
 * generate documentation

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure                                  |  1 +
 scripts/qemu.py =3D> python/qemu/__init__.py | 11 ++++++-----
 {scripts/qmp =3D> python/qemu}/qmp.py        |  0
 {scripts =3D> python/qemu}/qtest.py          |  5 +++--
 scripts/device-crash-test                  |  2 ++
 scripts/qmp/__init__.py                    |  0
 scripts/qmp/qemu-ga-client                 |  5 ++++-
 scripts/qmp/qmp-shell                      |  4 +++-
 scripts/render_block_graph.py              |  2 ++
 tests/acceptance/avocado_qemu/__init__.py  |  5 ++---
 tests/acceptance/virtio_version.py         |  2 +-
 tests/migration/guestperf/engine.py        |  7 ++++---
 tests/qemu-iotests/235                     |  2 +-
 tests/qemu-iotests/238                     |  2 +-
 tests/qemu-iotests/iotests.py              |  4 ++--
 tests/vm/basevm.py                         |  2 +-
 16 files changed, 33 insertions(+), 21 deletions(-)
 rename scripts/qemu.py =3D> python/qemu/__init__.py (98%)
 rename {scripts/qmp =3D> python/qemu}/qmp.py (100%)
 rename {scripts =3D> python/qemu}/qtest.py (98%)
 delete mode 100644 scripts/qmp/__init__.py

diff --git a/configure b/configure
index 3d89870d99..c1479cf064 100755
--- a/configure
+++ b/configure
@@ -7579,6 +7579,7 @@ LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
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
index 0a5e02eb56..22dd605cfe 100644
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
similarity index 98%
rename from scripts/qtest.py
rename to python/qemu/qtest.py
index afac3fe900..eb45824dd0 100644
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
@@ -79,7 +80,7 @@ class QEMUQtestProtocol(object):
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
index 2a13fa4f84..a6748910ad 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -25,6 +25,7 @@ check for crashes and unexpected errors.
 """
 from __future__ import print_function
=20
+import os
 import sys
 import glob
 import logging
@@ -34,6 +35,7 @@ import random
 import argparse
 from itertools import chain
=20
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
 from qemu import QEMUMachine
=20
 logger =3D logging.getLogger('device-crash-test')
diff --git a/scripts/qmp/__init__.py b/scripts/qmp/__init__.py
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index e8cb7646a0..30cf8a9a0d 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -37,10 +37,13 @@
 #
=20
 from __future__ import print_function
+import os
+import sys
 import base64
 import random
=20
-import qmp
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
+from qemu import qmp
=20
=20
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 770140772d..9fec46e2ed 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -66,7 +66,6 @@
 # sent to QEMU, which is useful for debugging and documentation generati=
on.
=20
 from __future__ import print_function
-import qmp
 import json
 import ast
 import readline
@@ -76,6 +75,9 @@ import errno
 import atexit
 import shlex
=20
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
+from qemu import qmp
+
 class QMPCompleter(list):
     def complete(self, text, state):
         for cmd in self:
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.p=
y
index ed7e581b4f..3e9d282a49 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -23,6 +23,8 @@ import sys
 import subprocess
 import json
 from graphviz import Digraph
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
 from qemu import MonitorResponseError
=20
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..28bfb8e9d3 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -13,9 +13,8 @@ import sys
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(__file_=
_)))
-SRC_ROOT_DIR =3D os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
-sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
+SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..=
')
+sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu import QEMUMachine
=20
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio=
_version.py
index ce990250d8..072c50371e 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -11,7 +11,7 @@ Check compatibility of virtio device types
 import sys
 import os
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scr=
ipts"))
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
 from qemu import QEMUMachine
 from avocado_qemu import Test
=20
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index 398e3f2706..0e304660b8 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -24,13 +24,14 @@ import re
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
+sys.path.append(os.path.join(os.path.dirname(__file__),
+                             '..', '..', '..', 'python'))
+import qemu
+
=20
 class Engine(object):
=20
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d6edd97ab4..75c203b30c 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -23,7 +23,7 @@ import os
 import iotests
 from iotests import qemu_img_create, qemu_io, file_path, log
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
=20
 from qemu import QEMUMachine
=20
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..688abc9acb 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,7 +23,7 @@ import os
 import iotests
 from iotests import log
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
=20
 from qemu import QEMUMachine
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b461f53abf..54a31044b4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -32,8 +32,8 @@ import atexit
 import io
 from collections import OrderedDict
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
-import qtest
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
+from qemu import qtest
=20
=20
 # This will not work if arguments contain spaces but is necessary if we
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5caf77d6b8..9fece647ef 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -17,7 +17,7 @@ import sys
 import logging
 import time
 import datetime
-sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scr=
ipts"))
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
 from qemu import QEMUMachine, kvm_available
 import subprocess
 import hashlib
--=20
2.20.1
