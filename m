Received: from eggs.gnu.org ([2001:4830:134:3::10]:60578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqG-0001ln-EY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqE-0000Es-UZ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqE-0000EZ-M1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:34 -0300
Message-Id: <20180611174243.31070-5-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/13] python: futurize -f
 lib2to3.fixes.fix_has_key
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

Change "dict.has_key(key)" to "key in dict"

This is necessary for Python 3 compatibility.

Done using:

  $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_has_key $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-5-ehabkost@redhat.com>
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
     path =3D None
=20
     # Use QMP_PATH if it's set
-    if os.environ.has_key('QMP_PATH'):
+    if 'QMP_PATH' in os.environ:
         path =3D os.environ['QMP_PATH']
=20
     while len(args):
@@ -80,7 +80,7 @@ def main(args):
=20
     def do_command(srv, cmd, **kwds):
         rsp =3D srv.cmd(cmd, kwds)
-        if rsp.has_key('error'):
+        if 'error' in rsp:
             raise Exception(rsp['error']['desc'])
         return rsp['return']
=20
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 38c99d8f72..26418dab95 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -134,7 +134,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
=20
     def _fill_completion(self):
         cmds =3D self.cmd('query-commands')
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
         self.ino_count =3D 1
=20
     def get_ino(self, path):
-        if self.ino_map.has_key(path):
+        if path in self.ino_map:
             return self.ino_map[path]
         self.ino_map[path] =3D self.ino_count
         self.ino_count +=3D 1
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 6313f27e8e..a3f5d7660e 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -45,7 +45,7 @@ if len(args) > 0:
         args =3D args[2:]
=20
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path =3D os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 80b0a3d1be..2ba25e1792 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -45,7 +45,7 @@ if len(args) > 0:
         args =3D args[2:]
=20
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path =3D os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index cbffb65880..0352668812 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -46,7 +46,7 @@ if len(args) > 0:
         args =3D args[2:]
=20
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path =3D os.environ['QMP_SOCKET']
     else:
         usage_error("no QMP socket path or address given");
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index ad4be233e6..32e708a13e 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -47,7 +47,7 @@ if len(args) > 0:
         args =3D args[2:]
=20
 if not socket_path:
-    if os.environ.has_key('QMP_SOCKET'):
+    if 'QMP_SOCKET' in os.environ:
         socket_path =3D os.environ['QMP_SOCKET']
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
=20
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
=20
     def testSnapshot(self):
         self.checkConfig('base')
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 88b97ea7c6..a154d8ef9d 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -203,7 +203,7 @@ sector =3D "%d"
         if (self.accounted_ops(read =3D True, write =3D True, flush =3D =
True) !=3D 0):
             self.assertLess(0, stats['idle_time_ns'])
         else:
-            self.assertFalse(stats.has_key('idle_time_ns'))
+            self.assertFalse('idle_time_ns' in stats)
=20
         # This test does not alter these, so they must be all 0
         self.assertEqual(0, stats['rd_merged'])
--=20
2.18.0.rc1.1.g3f1ff2140
