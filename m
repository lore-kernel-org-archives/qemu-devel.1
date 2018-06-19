Received: from eggs.gnu.org ([2001:4830:134:3::10]:45498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hj-0001H7-Qp
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hi-0008C5-PN
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:55 -0500
Message-Id: <20180619014319.28272-30-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 029/113] address_space_write:
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

address_space_write is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_write to address_space_write.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4c6ebbb364aa6f42c5d8e83e932e967eb83f0e44)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 03238a3449..884e243a84 100644
--- a/exec.c
+++ b/exec.c
@@ -3005,6 +3005,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     return result;
 }
 
+/* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len)
 {
@@ -3013,25 +3014,14 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
     MemoryRegion *mr;
     MemTxResult result = MEMTX_OK;
 
-    if (len > 0) {
-        rcu_read_lock();
-        l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true);
-        result = flatview_write_continue(fv, addr, attrs, buf, len,
-                                         addr1, l, mr);
-        rcu_read_unlock();
-    }
+    l = len;
+    mr = flatview_translate(fv, addr, &addr1, &l, true);
+    result = flatview_write_continue(fv, addr, attrs, buf, len,
+                                     addr1, l, mr);
 
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
-                                              MemTxAttrs attrs,
-                                              const uint8_t *buf, int len)
-{
-    return flatview_write(address_space_to_flatview(as), addr, attrs, buf, len);
-}
-
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
@@ -3140,6 +3130,23 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                        addr, attrs, buf, len, is_write);
 }
 
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const uint8_t *buf, int len)
+{
+    MemTxResult result = MEMTX_OK;
+    FlatView *fv;
+
+    if (len > 0) {
+        rcu_read_lock();
+        fv = address_space_to_flatview(as);
+        result = flatview_write(fv, addr, attrs, buf, len);
+        rcu_read_unlock();
+    }
+
+    return result;
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
-- 
2.11.0
