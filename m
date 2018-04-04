Received: from eggs.gnu.org ([2001:4830:134:3::10]:48950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f3fkl-0000Tu-7n
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f3fki-00063X-3V
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:34:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f3fkh-00063Q-VS
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:34:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Apr 2018 11:34:40 +0100
Message-Id: <20180404103440.19546-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine backtrace
 in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

Use the 'select-frame' GDB command to switch stacks instead of manually
setting the debugged thread's registers (this only works when debugging
a live process, not in a coredump).

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Vladimir: Does this work for you?

 scripts/qemugdb/coroutine.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ab699794ab..ed96434aee 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -77,13 +77,11 @@ def bt_jmpbuf(jmpbuf):
     for i in regs:
         old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
 
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, regs[i]))
+    gdb.execute('select-frame %s %s' % (regs['rsp'], regs['rip']))
 
     gdb.execute('bt')
 
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, old[i]))
+    gdb.execute('select-frame %s %s' % (old['rsp'], old['rip']))
 
 def coroutine_to_jmpbuf(co):
     coroutine_pointer = co.cast(gdb.lookup_type('CoroutineUContext').pointer())
-- 
2.14.3
