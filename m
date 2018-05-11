Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQ3-0001i4-4F
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQ1-0004QD-Qd
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:21:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 May 2018 19:20:46 -0300
Message-Id: <20180511222052.8734-5-ehabkost@redhat.com>
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
References: <20180511222052.8734-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 04/10] python: futurize -f
 lib2to3.fixes.fix_has_key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

Change "dict.has_key(key)" to "key in dict"

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_has_key $py

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp        | 4 ++--
 scripts/qmp/qmp-shell  | 2 +-
 scripts/qmp/qom-fuse   | 2 +-
 scripts/qmp/qom-get    | 2 +-
 scripts/qmp/qom-list   | 2 +-
 scripts/qmp/qom-set    | 2 +-
 scripts/qmp/qom-tree   | 2 +-
 tests/qemu-iotests/093 | 2 +-
 tests/qemu-iotests/096 | 4 ++--
 tests/qemu-iotests/136 | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 4d2be4e98a..33a0d6b73a 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -36,7 +36,7 @@ def main(args):
     path = None
 
     # Use QMP_PATH if it's set
-    if os.environ.has_key('QMP_PATH'):
+    if 'QMP_PATH' in os.environ:
         path = os.environ['QMP_PATH']
 
     while len(args):
@@ -80,7 +80,7 @@ def main(args):
 
     def do_command(srv, cmd, **kwds):
         rsp = srv.cmd(cmd, kwds)
-        if rsp.has_key('error'):
+        if 'error' in rsp:
             raise Exception(rsp['error']['desc'])
         return rsp['return']
 
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 38c99d8f72..26418dab95 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -134,7 +134,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     def _fill_completion(self):
         cmds = self.cmd('query-commands')
-        if cmds.has_key('error'):
+        if 'error' in cmds:
             return
         for cmd in cmds['return']:
             self._completer.append(cmd['name'])
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index b75aa72767..b00cb0a0af 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -29,7 +29,7 @@ class QOMFS(Fuse):
         self.ino_count = 1
 
     def get_ino(self, path):
-        if self.ino_map.has_key(path):
+        if path in self.ino_map:
             return self.ino_map[path]
         self.ino_map[path] = self.ino_count
         self.ino_count += 1
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 6313f27e8e..a3f5d7660e 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -45,7 +45,7 @@ if len(args) > 0:
         args = args[2:]
 
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path = os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 80b0a3d1be..2ba25e1792 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -45,7 +45,7 @@ if len(args) > 0:
         args = args[2:]
 
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path = os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index cbffb65880..0352668812 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -46,7 +46,7 @@ if len(args) > 0:
         args = args[2:]
 
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path = os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index ad4be233e6..32e708a13e 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -47,7 +47,7 @@ if len(args) > 0:
         args = args[2:]
 
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path = os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index c3404a3171..68e344f8c1 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -237,7 +237,7 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
                 if name:
                     self.assertEqual(info["group"], name)
                 else:
-                    self.assertFalse(info.has_key('group'))
+                    self.assertFalse('group' in info)
                 return
 
         raise Exception("No group information found for '%s'" % device)
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index aeeb3753cf..a69439602d 100755
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -53,9 +53,9 @@ class TestLiveSnapshot(iotests.QMPTestCase):
                 self.assertEqual(r['iops'], self.iops)
                 self.assertEqual(r['iops_size'], self.iops_size)
             else:
-                self.assertFalse(r.has_key('group'))
+                self.assertFalse('group' in r)
                 self.assertEqual(r['iops'], 0)
-                self.assertFalse(r.has_key('iops_size'))
+                self.assertFalse('iops_size' in r)
 
     def testSnapshot(self):
         self.checkConfig('base')
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 88b97ea7c6..a154d8ef9d 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -203,7 +203,7 @@ sector = "%d"
         if (self.accounted_ops(read = True, write = True, flush = True) != 0):
             self.assertLess(0, stats['idle_time_ns'])
         else:
-            self.assertFalse(stats.has_key('idle_time_ns'))
+            self.assertFalse('idle_time_ns' in stats)
 
         # This test does not alter these, so they must be all 0
         self.assertEqual(0, stats['rd_merged'])
-- 
2.14.3
