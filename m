Received: from eggs.gnu.org ([2001:4830:134:3::10]:43151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQY-0002Kf-4r
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQU-00040j-TN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:14 -0300
Message-Id: <20181031003120.26771-10-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] iotests: Modify imports for Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Max Reitz <mreitz@redhat.com>

There are two imports that need to be modified when running the iotests
under Python 3: One is StringIO, which no longer exists; instead, the
StringIO class comes from the io module, so import it from there (and
use the BytesIO class for Python 2).  The other is the ConfigParser,
which has just been renamed to configparser.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181022135307.14398-9-mreitz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/iotests.py            | 13 +++++++++----
 tests/qemu-iotests/nbd-fault-injector.py |  7 +++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7ca94e9278..a0f35e4b68 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -29,6 +29,7 @@ import json
 import signal
 import logging
 import atexit
+import io
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
 import qtest
@@ -681,15 +682,19 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
 
-    # We need to filter out the time taken from the output so that qemu-iotest
-    # can reliably diff the results against master output.
-    import StringIO
     if debug:
         output = sys.stdout
         verbosity = 2
         sys.argv.remove('-d')
     else:
-        output = StringIO.StringIO()
+        # We need to filter out the time taken from the output so that
+        # qemu-iotest can reliably diff the results against master output.
+        if sys.version_info.major >= 3:
+            output = io.StringIO()
+        else:
+            # io.StringIO is for unicode strings, which is not what
+            # 2.x's test runner emits.
+            output = io.BytesIO()
 
     logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
 
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index d45e2e0a6a..6b2d659dee 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -48,7 +48,10 @@ import sys
 import socket
 import struct
 import collections
-import ConfigParser
+if sys.version_info.major >= 3:
+    import configparser
+else:
+    import ConfigParser as configparser
 
 FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
 
@@ -225,7 +228,7 @@ def parse_config(config):
     return rules
 
 def load_rules(filename):
-    config = ConfigParser.RawConfigParser()
+    config = configparser.RawConfigParser()
     with open(filename, 'rt') as f:
         config.readfp(f, filename)
     return parse_config(config)
-- 
2.18.0.rc1.1.g3f1ff2140
