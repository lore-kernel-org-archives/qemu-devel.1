Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcD-0004Ld-Rc
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcC-0004PJ-Vb
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:01 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:51 +0100
Message-Id: <20180305083655.6186-4-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] address_space_write:
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
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org

address_space_write is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_write to address_space_write.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index e8d7b335b6..0b74b58d45 100644
--- a/exec.c
+++ b/exec.c
@@ -3074,6 +3074,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     return result;
 }
 
+/* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len)
 {
@@ -3082,25 +3083,14 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
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
@@ -3209,6 +3199,23 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
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
2.14.3
