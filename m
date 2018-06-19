Received: from eggs.gnu.org ([2001:4830:134:3::10]:45744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hu-0001VD-0O
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ht-0008N1-01
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:18 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:59 -0500
Message-Id: <20180619014319.28272-34-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 033/113] address_space_rw:
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

address_space_rw is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, transform flatview_rw
into address_space_rw, since flatview_rw is otherwise unused.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit db84fd973eba3f1e121416dcab73a4e8a60f2526)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/exec.c b/exec.c
index e30155c113..d589283bdd 100644
--- a/exec.c
+++ b/exec.c
@@ -3108,24 +3108,6 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                   addr1, l, mr);
 }
 
-static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                               uint8_t *buf, int len, bool is_write)
-{
-    if (is_write) {
-        return flatview_write(fv, addr, attrs, (uint8_t *)buf, len);
-    } else {
-        return flatview_read(fv, addr, attrs, (uint8_t *)buf, len);
-    }
-}
-
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs, uint8_t *buf,
-                             int len, bool is_write)
-{
-    return flatview_rw(address_space_to_flatview(as),
-                       addr, attrs, buf, len, is_write);
-}
-
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len)
 {
@@ -3159,6 +3141,16 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
+MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+                             uint8_t *buf, int len, bool is_write)
+{
+    if (is_write) {
+        return address_space_write(as, addr, attrs, buf, len);
+    } else {
+        return address_space_read_full(as, addr, attrs, buf, len);
+    }
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
-- 
2.11.0
