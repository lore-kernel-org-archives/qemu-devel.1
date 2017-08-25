Received: from eggs.gnu.org ([2001:4830:134:3::10]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dlA1d-0004UU-0O
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dlA1Z-0005UI-3A
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:31:33 -0400
Received: from ozlabs.ru ([107.173.13.209]:34762)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dlA1Y-0005Ts-T8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:31:29 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 25 Aug 2017 18:31:23 +1000
Message-Id: <20170825083123.47432-1-aik@ozlabs.ru>
In-Reply-To: <20170824123006.GK5379@umbus.fritz.box>
References: <20170824123006.GK5379@umbus.fritz.box>
Subject: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

Otherwise old dispatch holds way too much memory before RCU gets
a chance to free old dispatches.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is a follow-up to the "Memory use with >100 virtio devices"
thread.


I assume this is a dirty hack (which fixes the problem though)
and I wonder what the proper solution would be. Thanks.


What happens here is that every virtio block device creates 2 address
spaces - for modern config space (called "virtio-pci-cfg-as") and
for busmaster (common pci thing, called after the device name,
in my case "virtio-blk-pci").

Each address_space_init() updates topology for _every_ address space.
Every topology update (address_space_update_topology()) creates a new
dispatch tree - AddressSpaceDispatch with nodes (1KB) and
sections (48KB) and destroys the old one.

However the dispatch destructor is postponed via RCU which does not
get a chance to execute until the machine is initialized but before
we get there, memory is not returned to the pool, and this is a lot
of memory which grows n^2.


Interestingly, mem_add() from exec.c is called twice:
as as->dispatch_listener.region_add() and
as as->dispatch_listener.region_nop() - I did not understand
the trick but it does not work if I remove the .region_nop() hook.
How does it work? :)

---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 01ac21e3cd..ea5f3eb209 100644
--- a/exec.c
+++ b/exec.c
@@ -2707,7 +2707,7 @@ static void mem_commit(MemoryListener *listener)
 
     atomic_rcu_set(&as->dispatch, next);
     if (cur) {
-        call_rcu(cur, address_space_dispatch_free, rcu);
+        address_space_dispatch_free(cur);
     }
 }
 
-- 
2.11.0
