Received: from eggs.gnu.org ([2001:4830:134:3::10]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOM-000334-QU
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOL-0007J1-Ow
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDDOL-0007IT-HA
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 19:19:02 +0100
Message-Id: <20180430181905.32327-9-peter.maydell@linaro.org>
In-Reply-To: <20180430181905.32327-1-peter.maydell@linaro.org>
References: <20180430181905.32327-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 08/11] Make flatview_translate() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_translate(); all its
callers now have attrs available.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h |  7 ++++---
 exec.c                | 17 +++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7c461b9718..bd50424804 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1914,7 +1914,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
-                                 hwaddr *len, bool is_write);
+                                 hwaddr *len, bool is_write,
+                                 MemTxAttrs attrs);
 
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
@@ -1922,7 +1923,7 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     MemTxAttrs attrs)
 {
     return flatview_translate(address_space_to_flatview(as),
-                              addr, xlat, len, is_write);
+                              addr, xlat, len, is_write, attrs);
 }
 
 /* address_space_access_valid: check for validity of accessing an address
@@ -2024,7 +2025,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
             rcu_read_lock();
             fv = address_space_to_flatview(as);
             l = len;
-            mr = flatview_translate(fv, addr, &addr1, &l, false);
+            mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
diff --git a/exec.c b/exec.c
index 0eef4702a5..41f7a7f5c4 100644
--- a/exec.c
+++ b/exec.c
@@ -583,7 +583,8 @@ iotlb_fail:
 
 /* Called from RCU critical section */
 MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool is_write)
+                                 hwaddr *plen, bool is_write,
+                                 MemTxAttrs attrs)
 {
     MemoryRegion *mr;
     MemoryRegionSection section;
@@ -3117,7 +3118,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true);
+        mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
     }
 
     return result;
@@ -3133,7 +3134,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
     MemTxResult result = MEMTX_OK;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, true);
+    mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
     result = flatview_write_continue(fv, addr, attrs, buf, len,
                                      addr1, l, mr);
 
@@ -3204,7 +3205,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, false);
+        mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
     }
 
     return result;
@@ -3219,7 +3220,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, false);
+    mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
     return flatview_read_continue(fv, addr, attrs, buf, len,
                                   addr1, l, mr);
 }
@@ -3433,7 +3434,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 
     while (len > 0) {
         l = len;
-        mr = flatview_translate(fv, addr, &xlat, &l, is_write);
+        mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             /* When our callers all have attrs we'll pass them through here */
@@ -3482,7 +3483,7 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
 
         len = target_len;
         this_mr = flatview_translate(fv, addr, &xlat,
-                                                   &len, is_write);
+                                     &len, is_write, attrs);
         if (this_mr != mr || xlat != base + done) {
             return done;
         }
@@ -3515,7 +3516,7 @@ void *address_space_map(AddressSpace *as,
     l = len;
     rcu_read_lock();
     fv = address_space_to_flatview(as);
-    mr = flatview_translate(fv, addr, &xlat, &l, is_write);
+    mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
-- 
2.17.0
