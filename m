Received: from eggs.gnu.org ([2001:4830:134:3::10]:55769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwH-00004y-5A
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwE-0003x9-HD
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f1EwE-0003wJ-8F
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:32:36 +0300
Message-Id: <20180328173238.507470-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180328173238.507470-1-vsementsov@virtuozzo.com>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] scripts/qemugdb: improve "qemu coroutine"
 command
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

 - print regs
 - catch exception for coredump debugging

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ffaa45c464..7070a592f3 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -80,9 +80,8 @@ def get_jmpbuf_regs(jmpbuf):
         'r15': jmpbuf[JB_R15],
         'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
 
-def bt_jmpbuf(jmpbuf):
-    '''Backtrace a jmpbuf'''
-    regs = get_jmpbuf_regs(jmpbuf)
+def bt_regs(regs):
+    '''Backtrace with specified regs'''
     old = dict()
 
     for i in regs:
@@ -113,7 +112,18 @@ class CoroutineCommand(gdb.Command):
             gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        jmpbuf = coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0]))
+        regs = get_jmpbuf_regs(jmpbuf)
+        for k, v in regs.iteritems():
+            gdb.write('%s: 0x%x\n' %(k,v))
+
+        gdb.write('\n')
+
+        try:
+            bt_regs(regs)
+        except gdb.error:
+            print "Coroutine backtrace can't be obtained without " \
+                  "a process to debug."
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.11.1
