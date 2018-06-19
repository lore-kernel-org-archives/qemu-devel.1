Received: from eggs.gnu.org ([2001:4830:134:3::10]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hr-0001SH-Tl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hr-0008Lq-2e
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:15 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:58 -0500
Message-Id: <20180619014319.28272-33-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 032/113] address_space_map:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

address_space_map is calling address_space_to_flatview but it can
be called outside the RCU lock.  The function itself is calling
rcu_read_lock/rcu_read_unlock, just in the wrong place, so the
fix is easy.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit ad0c60fa572d4050255b698ecdb67294dd4c0125)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 7c4fb68368..e30155c113 100644
--- a/exec.c
+++ b/exec.c
@@ -3395,7 +3395,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr l, xlat;
     MemoryRegion *mr;
     void *ptr;
-    FlatView *fv = address_space_to_flatview(as);
+    FlatView *fv;
 
     if (len == 0) {
         return NULL;
@@ -3403,6 +3403,7 @@ void *address_space_map(AddressSpace *as,
 
     l = len;
     rcu_read_lock();
+    fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write);
 
     if (!memory_access_is_direct(mr, is_write)) {
-- 
2.11.0
