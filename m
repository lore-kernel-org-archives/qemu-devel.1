Received: from eggs.gnu.org ([209.51.188.92]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grOuX-0004dM-Pc
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grOuV-0007Dx-JJ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:14:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1grOuP-00077G-Rw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:14:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  6 Feb 2019 18:14:25 +0300
Message-Id: <20190206151425.105871-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qemugdb/coroutine: fix arch_prctl has unknown
 return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, vsementsov@virtuozzo.com

qemu coroutine command results in following error output:

Python Exception <class 'gdb.error'> 'arch_prctl' has unknown return
type; cast the call to its declared return type: Error occurred in
Python command: 'arch_prctl' has unknown return type; cast the call to
its declared return type

Fix it by giving it what it wants: arch_prctl return type.

Information on the topic:
   https://sourceware.org/gdb/onlinedocs/gdb/Calling.html

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ab699794ab..81f811ac00 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -22,7 +22,7 @@ def get_fs_base():
        pthread_self().'''
     # %rsp - 120 is scratch space according to the SystemV ABI
     old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call arch_prctl(0x1003, $rsp - 120)', False, True)
+    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
     fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
     gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
     return fs_base
-- 
2.18.0
