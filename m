Received: from eggs.gnu.org ([2001:4830:134:3::10]:51189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxX-0001sG-9N
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxT-00011V-66
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:46 +0300
Message-Id: <1518702707-7077-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 8/9] iotests: add file_path helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Simple way to have auto generated filenames with auto clenup. Like
FilePath but without using 'with' statement and without additional
indentation of the whole test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c1302a2f9b..f2d05ca3fd 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -27,6 +27,7 @@ import struct
 import json
 import signal
 import logging
+import atexit
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
 import qtest
@@ -250,6 +251,37 @@ class FilePath(object):
         return False
 
 
+def file_path_remover():
+    for path in reversed(file_path_remover.paths):
+        try:
+            os.remove(path)
+        except OSError:
+            pass
+
+
+def file_path(*names):
+    ''' Another way to get auto-generated filename that cleans itself up.
+
+    Use it as simple as:
+
+    img_a, img_b = file_path('a.img', 'b.img')
+    sock = file_path('socket')
+    '''
+
+    if not hasattr(file_path_remover, 'paths'):
+        file_path_remover.paths = []
+        atexit.register(file_path_remover)
+
+    paths = []
+    for name in names:
+        filename = '{0}-{1}'.format(os.getpid(), name)
+        path = os.path.join(test_dir, filename)
+        file_path_remover.paths.append(path)
+        paths.append(path)
+
+    return paths[0] if len(paths) == 1 else paths
+
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
 
-- 
2.11.1
