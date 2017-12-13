Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhO-0000kd-CW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhM-0001v4-M1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:18 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:53 -0300
Message-Id: <20171213213557.26561-3-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/6] iotests.py: move the generic QMPTestCase
 to qtest.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

All those methods are generic and can be reused.
Add a few 'from qtest import ...' to keep the patch short.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qtest.py              | 102 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/iotests.py |  86 +++--------------------------------
 2 files changed, 107 insertions(+), 81 deletions(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index df0daf26ca..78db8d02c0 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -12,10 +12,33 @@
 #
 
 import socket
+import sys
 import os
 import qemu
+import re
+import unittest
+import logging
 
 
+qemu_prog = os.environ.get('QEMU_PROG', 'qemu')
+qemu_opts = os.environ.get('QEMU_OPTIONS', '').strip().split(' ')
+
+test_dir = os.environ.get('TEST_DIR')
+output_dir = os.environ.get('OUTPUT_DIR', '.')
+qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
+
+socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
+debug = False
+
+
+def filter_qmp_event(event):
+    '''Filter a QMP event dict'''
+    event = dict(event)
+    if 'timestamp' in event:
+        event['timestamp']['seconds'] = 'SECS'
+        event['timestamp']['microseconds'] = 'USECS'
+    return event
+
 class QEMUQtestProtocol(object):
     def __init__(self, address, server=False):
         """
@@ -107,3 +130,82 @@ class QEMUQtestMachine(qemu.QEMUMachine):
     def qtest(self, cmd):
         '''Send a qtest command to guest'''
         return self._qtest.cmd(cmd)
+
+
+def createQtestMachine(path_suffix=''):
+    name = "qemu%s-%d" % (path_suffix, os.getpid())
+    return QEMUQtestMachine(qemu_prog, qemu_opts, name=name,
+                             test_dir=test_dir,
+                             socket_scm_helper=socket_scm_helper)
+
+class QMPTestCase(unittest.TestCase):
+    '''Abstract base class for QMP test cases'''
+
+    index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
+
+    def dictpath(self, d, path):
+        '''Traverse a path in a nested dict'''
+        for component in path.split('/'):
+            m = QMPTestCase.index_re.match(component)
+            if m:
+                component, idx = m.groups()
+                idx = int(idx)
+
+            if not isinstance(d, dict) or component not in d:
+                self.fail('failed path traversal for "%s" in "%s"' % (path,
+                                                                      str(d)))
+            d = d[component]
+
+            if m:
+                if not isinstance(d, list):
+                    self.fail(('path component "%s" in "%s" is not a list ' +
+                              'in "%s"') % (component, path, str(d)))
+                try:
+                    d = d[idx]
+                except IndexError:
+                    self.fail(('invalid index "%s" in path "%s" ' +
+                              'in "%s"') % (idx, path, str(d)))
+        return d
+
+    def flatten_qmp_object(self, obj, output=None, basestr=''):
+        if output is None:
+            output = dict()
+        if isinstance(obj, list):
+            for i in range(len(obj)):
+                self.flatten_qmp_object(obj[i], output, basestr + str(i) + '.')
+        elif isinstance(obj, dict):
+            for key in obj:
+                self.flatten_qmp_object(obj[key], output, basestr + key + '.')
+        else:
+            output[basestr[:-1]] = obj # Strip trailing '.'
+        return output
+
+    def qmp_to_opts(self, obj):
+        obj = self.flatten_qmp_object(obj)
+        output_list = list()
+        for key in obj:
+            output_list += [key + '=' + obj[key]]
+        return ','.join(output_list)
+
+    def assert_qmp_absent(self, d, path):
+        try:
+            result = self.dictpath(d, path)
+        except AssertionError:
+            return
+        self.fail('path "%s" has value "%s"' % (path, str(result)))
+
+    def assert_qmp(self, d, path, value):
+        '''Assert that the value for a specific path in a QMP dict matches'''
+        result = self.dictpath(d, path)
+        self.assertEqual(result, value, ('values not equal "%s" ' +
+                         'and "%s"') % (str(result), str(value)))
+
+
+def notrun(reason):
+    '''Skip this test suite'''
+    print '%s not run: %s' % (seq, reason)
+    sys.exit(0)
+
+def verify_platform(supported_oses=['linux']):
+    if True not in [sys.platform.startswith(x) for x in supported_oses]:
+        notrun('not suitable for this OS: %s' % sys.platform)
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e1f892c46f..cb3d22855b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -20,7 +20,6 @@ import errno
 import os
 import re
 import subprocess
-import string
 import unittest
 import sys
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
@@ -30,6 +29,10 @@ import json
 import signal
 import logging
 
+# use the following imports from qtest instead of iotests.
+from qtest import qemu_prog, qemu_opts, test_dir, output_dir
+from qtest import qemu_default_machine, socket_scm_helper
+from qtest import filter_qmp_event, verify_platform
 
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
@@ -45,18 +48,10 @@ qemu_nbd_args = [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]
 if os.environ.get('QEMU_NBD_OPTIONS'):
     qemu_nbd_args += os.environ['QEMU_NBD_OPTIONS'].strip().split(' ')
 
-qemu_prog = os.environ.get('QEMU_PROG', 'qemu')
-qemu_opts = os.environ.get('QEMU_OPTIONS', '').strip().split(' ')
-
 imgfmt = os.environ.get('IMGFMT', 'raw')
 imgproto = os.environ.get('IMGPROTO', 'file')
-test_dir = os.environ.get('TEST_DIR')
-output_dir = os.environ.get('OUTPUT_DIR', '.')
 cachemode = os.environ.get('CACHEMODE')
-qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 
-socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
-debug = False
 
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
@@ -134,14 +129,6 @@ chown_re = re.compile(r"chown [0-9]+:[0-9]+")
 def filter_chown(msg):
     return chown_re.sub("chown UID:GID", msg)
 
-def filter_qmp_event(event):
-    '''Filter a QMP event dict'''
-    event = dict(event)
-    if 'timestamp' in event:
-        event['timestamp']['seconds'] = 'SECS'
-        event['timestamp']['microseconds'] = 'USECS'
-    return event
-
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
@@ -257,66 +244,7 @@ class VM(qtest.QEMUQtestMachine):
                         command_line='qemu-io %s "%s"' % (drive, cmd))
 
 
-index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
-
-class QMPTestCase(unittest.TestCase):
-    '''Abstract base class for QMP test cases'''
-
-    def dictpath(self, d, path):
-        '''Traverse a path in a nested dict'''
-        for component in path.split('/'):
-            m = index_re.match(component)
-            if m:
-                component, idx = m.groups()
-                idx = int(idx)
-
-            if not isinstance(d, dict) or component not in d:
-                self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
-            d = d[component]
-
-            if m:
-                if not isinstance(d, list):
-                    self.fail('path component "%s" in "%s" is not a list in "%s"' % (component, path, str(d)))
-                try:
-                    d = d[idx]
-                except IndexError:
-                    self.fail('invalid index "%s" in path "%s" in "%s"' % (idx, path, str(d)))
-        return d
-
-    def flatten_qmp_object(self, obj, output=None, basestr=''):
-        if output is None:
-            output = dict()
-        if isinstance(obj, list):
-            for i in range(len(obj)):
-                self.flatten_qmp_object(obj[i], output, basestr + str(i) + '.')
-        elif isinstance(obj, dict):
-            for key in obj:
-                self.flatten_qmp_object(obj[key], output, basestr + key + '.')
-        else:
-            output[basestr[:-1]] = obj # Strip trailing '.'
-        return output
-
-    def qmp_to_opts(self, obj):
-        obj = self.flatten_qmp_object(obj)
-        output_list = list()
-        for key in obj:
-            output_list += [key + '=' + obj[key]]
-        return ','.join(output_list)
-
-    def assert_qmp_absent(self, d, path):
-        try:
-            result = self.dictpath(d, path)
-        except AssertionError:
-            return
-        self.fail('path "%s" has value "%s"' % (path, str(result)))
-
-    def assert_qmp(self, d, path, value):
-        '''Assert that the value for a specific path in a QMP dict matches'''
-        result = self.dictpath(d, path)
-        self.assertEqual(result, value, 'values not equal "%s" and "%s"' % (str(result), str(value)))
-
-
-class BlockQMPTestCase(QMPTestCase):
+class BlockQMPTestCase(qtest.QMPTestCase):
     '''Abstract base class for Block QMP test cases'''
 
     def assert_no_active_block_jobs(self):
@@ -430,10 +358,6 @@ def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
     if unsupported_fmts and (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
-def verify_platform(supported_oses=['linux']):
-    if True not in [sys.platform.startswith(x) for x in supported_oses]:
-        notrun('not suitable for this OS: %s' % sys.platform)
-
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
-- 
2.15.1
