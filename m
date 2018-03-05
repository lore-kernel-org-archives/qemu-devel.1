Received: from eggs.gnu.org ([2001:4830:134:3::10]:35148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcF-0004N0-Qd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcE-0004R8-DW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:52 +0100
Message-Id: <20180305083655.6186-5-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] address_space_read:
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

address_space_read is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_read_full to address_space_read's constant size
fast path and address_space_read_full.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 44 ++++++++++++++++++++++++++++----------------
 include/exec/memory.h | 25 ++++++++++---------------
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/exec.c b/exec.c
index 0b74b58d45..55b7452bd7 100644
--- a/exec.c
+++ b/exec.c
@@ -2612,6 +2612,8 @@ static const MemoryRegionOps watch_mem_ops = {
     },
 };
 
+static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
+                                      MemTxAttrs attrs, uint8_t *buf, int len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
@@ -3161,24 +3163,18 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
     return result;
 }
 
-MemTxResult flatview_read_full(FlatView *fv, hwaddr addr,
-                               MemTxAttrs attrs, uint8_t *buf, int len)
+/* Called from RCU critical section.  */
+static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
+                                 MemTxAttrs attrs, uint8_t *buf, int len)
 {
     hwaddr l;
     hwaddr addr1;
     MemoryRegion *mr;
-    MemTxResult result = MEMTX_OK;
-
-    if (len > 0) {
-        rcu_read_lock();
-        l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, false);
-        result = flatview_read_continue(fv, addr, attrs, buf, len,
-                                        addr1, l, mr);
-        rcu_read_unlock();
-    }
 
-    return result;
+    l = len;
+    mr = flatview_translate(fv, addr, &addr1, &l, false);
+    return flatview_read_continue(fv, addr, attrs, buf, len,
+                                  addr1, l, mr);
 }
 
 static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
@@ -3199,6 +3195,22 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                        addr, attrs, buf, len, is_write);
 }
 
+MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+                                    MemTxAttrs attrs, uint8_t *buf, int len)
+{
+    MemTxResult result = MEMTX_OK;
+    FlatView *fv;
+
+    if (len > 0) {
+        rcu_read_lock();
+        fv = address_space_to_flatview(as);
+        result = flatview_read(fv, addr, attrs, buf, len);
+        rcu_read_unlock();
+    }
+
+    return result;
+}
+
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const uint8_t *buf, int len)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6c8e394675..54ff81fbd1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1894,13 +1894,12 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 
 /* Internal functions, part of the implementation of address_space_read.  */
+MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+                                    MemTxAttrs attrs, uint8_t *buf, int len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
                                    int len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
-
-MemTxResult flatview_read_full(FlatView *fv, hwaddr addr,
-                               MemTxAttrs attrs, uint8_t *buf, int len);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
@@ -1919,25 +1918,28 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  *
  * Return a MemTxResult indicating whether the operation succeeded
  * or failed (eg unassigned memory, device rejected the transaction,
- * IOMMU fault).
+ * IOMMU fault).  Called within RCU critical section.
  *
- * @fv: #FlatView to be accessed
+ * @as: #AddressSpace to be accessed
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult flatview_read(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                          uint8_t *buf, int len)
+MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+                               MemTxAttrs attrs, uint8_t *buf,
+                               int len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
     void *ptr;
     MemoryRegion *mr;
+    FlatView *fv;
 
     if (__builtin_constant_p(len)) {
         if (len) {
             rcu_read_lock();
+            fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false);
             if (len == l && memory_access_is_direct(mr, false)) {
@@ -1950,18 +1952,11 @@ MemTxResult flatview_read(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
             rcu_read_unlock();
         }
     } else {
-        result = flatview_read_full(fv, addr, attrs, buf, len);
+        result = address_space_read_full(as, addr, attrs, buf, len);
     }
     return result;
 }
 
-static inline MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-                                             MemTxAttrs attrs, uint8_t *buf,
-                                             int len)
-{
-    return flatview_read(address_space_to_flatview(as), addr, attrs, buf, len);
-}
-
 /**
  * address_space_read_cached: read from a cached RAM region
  *
-- 
2.14.3
