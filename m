Received: from eggs.gnu.org ([2001:4830:134:3::10]:48527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCs-000570-AL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCn-0001IT-Nd
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:37 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCn-0001CA-Hp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:33 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:03 +1000
Message-Id: <20170921085110.25598-12-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 11/18] memory: Move
 address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

So it is called (twice) from the same function. This is to make the next
patches a bit simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index eb730cd619..9868d0f57c 100644
--- a/memory.c
+++ b/memory.c
@@ -947,8 +947,6 @@ static void address_space_update_topology(AddressSpace *as)
      * counting is necessary.
      */
     flatview_unref(old_view);
-
-    address_space_update_ioeventfds(as);
 }
 
 void memory_region_transaction_begin(void)
@@ -971,6 +969,7 @@ void memory_region_transaction_commit(void)
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_topology(as);
+                address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
-- 
2.11.0
