Received: from eggs.gnu.org ([2001:4830:134:3::10]:47572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE2G-0006lE-38
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE2F-00007H-0r
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:36 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Feb 2018 13:08:23 -0600
Message-Id: <20180209190824.32221-2-eblake@redhat.com>
In-Reply-To: <20180209190824.32221-1-eblake@redhat.com>
References: <20180209190824.32221-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Support default luks options in VM.add_drive and in new library
function qemu_img_create. Use it in 205 iotests.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180206182507.21753-1-vsementsov@virtuozzo.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/205        |  4 ++--
 tests/qemu-iotests/iotests.py | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 10388920dc3..e7b2eae51d5 100644
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -22,7 +22,7 @@ import os
 import sys
 import iotests
 import time
-from iotests import qemu_img, qemu_io, filter_qemu_io, QemuIoInteractive
+from iotests import qemu_img_create, qemu_io, filter_qemu_io, QemuIoInteractive

 nbd_sock = 'nbd_sock'
 nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
@@ -31,7 +31,7 @@ disk = os.path.join(iotests.test_dir, 'disk')

 class TestNbdServerRemove(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
+        qemu_img_create('-f', iotests.imgfmt, disk, '1M')

         self.vm = iotests.VM().add_drive(disk)
         self.vm.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5a10b2d5345..1bcc9ca57dc 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -58,6 +58,11 @@ qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
 debug = False

+luks_default_secret_object = 'secret,id=keysec0,data=' + \
+                             os.environ['IMGKEYSECRET']
+luks_default_key_secret_opt = 'key-secret=keysec0'
+
+
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
     devnull = open('/dev/null', 'r+')
@@ -66,6 +71,25 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode

+def qemu_img_create(*args):
+    args = list(args)
+
+    # default luks support
+    if '-f' in args and args[args.index('-f') + 1] == 'luks':
+        if '-o' in args:
+            i = args.index('-o')
+            if 'key-secret' not in args[i + 1]:
+                args[i + 1].append(luks_default_key_secret_opt)
+                args.insert(i + 2, '--object')
+                args.insert(i + 3, luks_default_secret_object)
+        else:
+            args = ['-o', luks_default_key_secret_opt,
+                    '--object', luks_default_secret_object] + args
+
+    args.insert(0, 'create')
+
+    return qemu_img(*args)
+
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit code'''
     exitcode = subprocess.call(qemu_img_args + list(args))
@@ -263,6 +287,13 @@ class VM(qtest.QEMUQtestMachine):
         if opts:
             options.append(opts)

+        if format == 'luks' and 'key-secret' not in opts:
+            # default luks support
+            if luks_default_secret_object not in self._args:
+                self.add_object(luks_default_secret_object)
+
+            options.append(luks_default_key_secret_opt)
+
         self._args.append('-drive')
         self._args.append(','.join(options))
         self._num_drives += 1
-- 
2.14.3
