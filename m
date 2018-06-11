Received: from eggs.gnu.org ([2001:4830:134:3::10]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqC-0001if-5y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqA-0000DC-TP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqA-0000D0-LE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:32 -0300
Message-Id: <20180611174243.31070-3-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/13] python: futurize -f
 libfuturize.fixes.fix_absolute_import
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

Make implicit relative imports explicit and add "from __future__ import
absolute_import" at the top of each relevant module.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f libfuturize.fixes.fix_absolute_import $py

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-3-ehabkost@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qemu-ga-client           | 3 ++-
 scripts/qmp/qmp                      | 3 ++-
 scripts/qmp/qmp-shell                | 3 ++-
 scripts/qmp/qom-fuse                 | 3 ++-
 scripts/qmp/qom-get                  | 3 ++-
 scripts/qmp/qom-list                 | 3 ++-
 scripts/qmp/qom-set                  | 3 ++-
 scripts/qmp/qom-tree                 | 3 ++-
 tests/image-fuzzer/qcow2/__init__.py | 3 ++-
 tests/image-fuzzer/qcow2/layout.py   | 3 ++-
 10 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 8510814683..6045fcd3f2 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -37,10 +37,11 @@
 #
 
 from __future__ import print_function
+from __future__ import absolute_import
 import base64
 import random
 
-import qmp
+from . import qmp
 
 
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 16d3bdb6fe..4d2be4e98a 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -11,8 +11,9 @@
 # See the COPYING file in the top-level directory.
 
 from __future__ import print_function
+from __future__ import absolute_import
 import sys, os
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 def print_response(rsp, prefix=[]):
     if type(rsp) == list:
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index b1cc7e2271..38c99d8f72 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -66,7 +66,8 @@
 # sent to QEMU, which is useful for debugging and documentation generation.
 
 from __future__ import print_function
-import qmp
+from __future__ import absolute_import
+from . import qmp
 import json
 import ast
 import readline
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 5c6754aa63..b75aa72767 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -11,11 +11,12 @@
 # the COPYING file in the top-level directory.
 ##
 
+from __future__ import absolute_import
 import fuse, stat
 from fuse import Fuse
 import os, posix
 from errno import *
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 291c8bfbc2..6313f27e8e 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -12,9 +12,10 @@
 ##
 
 from __future__ import print_function
+from __future__ import absolute_import
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index cd907bb81f..80b0a3d1be 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -12,9 +12,10 @@
 ##
 
 from __future__ import print_function
+from __future__ import absolute_import
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index fbe4b3e471..cbffb65880 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -12,9 +12,10 @@
 ##
 
 from __future__ import print_function
+from __future__ import absolute_import
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 0ffd1ff1de..ad4be233e6 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -14,9 +14,10 @@
 ##
 
 from __future__ import print_function
+from __future__ import absolute_import
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+from .qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/tests/image-fuzzer/qcow2/__init__.py b/tests/image-fuzzer/qcow2/__init__.py
index e2ebe19311..09ef59821b 100644
--- a/tests/image-fuzzer/qcow2/__init__.py
+++ b/tests/image-fuzzer/qcow2/__init__.py
@@ -1 +1,2 @@
-from layout import create_image
+from __future__ import absolute_import
+from .layout import create_image
diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow2/layout.py
index 63e801f4e8..675877da96 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -16,9 +16,10 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+from __future__ import absolute_import
 import random
 import struct
-import fuzz
+from . import fuzz
 from math import ceil
 from os import urandom
 from itertools import chain
-- 
2.18.0.rc1.1.g3f1ff2140
