Received: from eggs.gnu.org ([2001:4830:134:3::10]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hl-0001JL-O5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hk-0008DC-J4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:09 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:56 -0500
Message-Id: <20180619014319.28272-31-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 030/113] address_space_read:
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

address_space_read is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_read_full to address_space_read's constant size
fast path and address_space_read_full.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b2a44fcad74f1cc7a6786d38eba7db12ab2352ba)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c                | 38 +++++++++++++++++++++++++-------------
 include/exec/memory.h | 23 +++++++++--------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/exec.c b/exec.c
index 884e243a84..7e3c5c67f0 100644
--- a/exec.c
+++ b/exec.c
@@ -2575,6 +2575,8 @@ static const MemoryRegionOps watch_mem_ops = {
     },
 };
 
+static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
+                                      MemTxAttrs attrs, uint8_t *buf, int len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
@@ -3092,24 +3094,18 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
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
@@ -3130,6 +3126,22 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
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
index ca544027fb..e7fdb1b79a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1907,13 +1907,12 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 
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
@@ -1932,7 +1931,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  *
  * Return a MemTxResult indicating whether the operation succeeded
  * or failed (eg unassigned memory, device rejected the transaction,
- * IOMMU fault).
+ * IOMMU fault).  Called within RCU critical section.
  *
  * @as: #AddressSpace to be accessed
  * @addr: address within that address space
@@ -1940,17 +1939,20 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
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
@@ -1963,18 +1965,11 @@ MemTxResult flatview_read(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
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
2.11.0
