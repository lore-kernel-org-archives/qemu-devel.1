Received: from eggs.gnu.org ([2001:4830:134:3::10]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwH-00004x-59
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwE-0003xM-Hf
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f1EwE-0003wK-8S
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:32:35 +0300
Message-Id: <20180328173238.507470-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180328173238.507470-1-vsementsov@virtuozzo.com>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] scripts/qemugdb: get pthread_self from
 "info threads" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

When debugging a coredump, pthread_self can't be obtained from
function arch_prctl. Moreover if qemu crashed in coroutine, we
can't find 'start_thread' in current stack-trace. So, add a method,
actually proposed in 1138f24645e9e, which should work for gdb
version >= 7.3.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ab699794ab..ffaa45c464 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -14,6 +14,7 @@
 # GNU GPL, version 2 or (at your option) any later version.
 
 import gdb
+import re
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
@@ -28,7 +29,17 @@ def get_fs_base():
     return fs_base
 
 def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
+    # Try read pthread_self from gdb command 'info threads'.
+    # Will fail for old gdb.
+    try:
+        threads = gdb.execute('info threads', False, True)
+        m = re.search('^\* 1    Thread (0x[0-9a-f]+)', threads, re.MULTILINE)
+        return int(m.group(1), 16)
+    except TypeError:
+        # gdb doesn't support third parameter for execute
+        pass
+
+    # Try fetch pthread_self() from the glibc start_thread function.
     f = gdb.newest_frame()
     while f.name() != 'start_thread':
         f = f.older()
-- 
2.11.1
