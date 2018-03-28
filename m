Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwH-000051-5o
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwE-0003x5-Gx
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f1EwE-0003wI-8A
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:32:38 +0300
Message-Id: <20180328173238.507470-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180328173238.507470-1-vsementsov@virtuozzo.com>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/4] scripts/qemugdb: backtraces for coroutines
 in coredump
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

We can't get coroutine backtrace through obvious way
 - set regs
 - bt
 - restore regs
when debugging a coredump.
So, let's go hard way: clone current coredump file, patch regs
in it and execute a subprocess gdb to get backtrace from this
patched coredump.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 7070a592f3..2a05851e24 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -15,9 +15,32 @@
 
 import gdb
 import re
+import tempfile
+import subprocess
+import os
+import coredump
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
+def bt_regs_static(regs):
+    files = gdb.execute('info files', False, True).split('\n')
+    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
+    dump = re.search("`(.*)'", files[2]).group(1)
+
+    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
+        temp = f.name
+
+    coredump.clone_coredump(dump, temp, regs)
+
+    cmd = ['gdb', '-batch', '-ex', "python print '----split----'",
+           '-ex', 'bt', executable, temp]
+    out = subprocess.check_output(cmd)
+    out = out.split('----split----')[1]
+
+    os.remove(temp)
+
+    print out
+
 def get_fs_base():
     '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
        pthread_self().'''
@@ -122,8 +145,7 @@ class CoroutineCommand(gdb.Command):
         try:
             bt_regs(regs)
         except gdb.error:
-            print "Coroutine backtrace can't be obtained without " \
-                  "a process to debug."
+            bt_regs_static(regs)
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.11.1
