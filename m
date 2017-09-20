Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmi-000417-Gh
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufme-0005Mg-GG
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:28 -0400
Received: from ozlabs.ru ([107.173.13.209]:59842)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufme-0005Lh-8c
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:24 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:30 +1000
Message-Id: <20170920114637.42004-12-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 11/18] memory: Move
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
