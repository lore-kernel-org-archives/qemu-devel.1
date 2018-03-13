Received: from eggs.gnu.org ([2001:4830:134:3::10]:47399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnV1-0007VQ-VY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUv-0000yf-VB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:07 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:44 -0500
Message-Id: <20180313171345.659672-17-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 16/17] iotests: add file_path helper
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

Simple way to have auto generated filenames with auto cleanup. Like
FilePath but without using 'with' statement and without additional
indentation of the whole test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180312152126.286890-8-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar tweak]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c1302a2f9b1..90cd751e2af 100644
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
+    Use is as simple as:
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
2.14.3
