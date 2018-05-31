Received: from eggs.gnu.org ([2001:4830:134:3::10]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0000uQ-Oc
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUv-0006Ys-Ho
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUv-0006Ws-9l
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0002vo-6X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:51 +0100
Message-Id: <20180531142357.904-20-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/25] Make flatview_translate() take a
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

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_translate(); all its
callers now have attrs available.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-11-peter.maydell@linaro.org
---
 include/exec/memory.h |  7 ++++---
 exec.c                | 17 +++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 76a2dd3878..28a694970a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1913,7 +1913,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
-                                 hwaddr *len, bool is_write);
+                                 hwaddr *len, bool is_write,
+                                 MemTxAttrs attrs);
 
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
@@ -1921,7 +1922,7 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     MemTxAttrs attrs)
 {
     return flatview_translate(address_space_to_flatview(as),
-                              addr, xlat, len, is_write);
+                              addr, xlat, len, is_write, attrs);
 }
 
 /* address_space_access_valid: check for validity of accessing an address
@@ -2030,7 +2031,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
             rcu_read_lock();
             fv = address_space_to_flatview(as);
             l = len;
-            mr = flatview_translate(fv, addr, &addr1, &l, false);
+            mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
diff --git a/exec.c b/exec.c
index 33e0a4f153..d54a56fefa 100644
--- a/exec.c
+++ b/exec.c
@@ -618,7 +618,8 @@ iotlb_fail:
 
 /* Called from RCU critical section */
 MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool is_write)
+                                 hwaddr *plen, bool is_write,
+                                 MemTxAttrs attrs)
 {
     MemoryRegion *mr;
     MemoryRegionSection section;
@@ -3152,7 +3153,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true);
+        mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
     }
 
     return result;
@@ -3168,7 +3169,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
     MemTxResult result = MEMTX_OK;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, true);
+    mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
     result = flatview_write_continue(fv, addr, attrs, buf, len,
                                      addr1, l, mr);
 
@@ -3239,7 +3240,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, false);
+        mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
     }
 
     return result;
@@ -3254,7 +3255,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, false);
+    mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
     return flatview_read_continue(fv, addr, attrs, buf, len,
                                   addr1, l, mr);
 }
@@ -3468,7 +3469,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 
     while (len > 0) {
         l = len;
-        mr = flatview_translate(fv, addr, &xlat, &l, is_write);
+        mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
@@ -3516,7 +3517,7 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
 
         len = target_len;
         this_mr = flatview_translate(fv, addr, &xlat,
-                                                   &len, is_write);
+                                     &len, is_write, attrs);
         if (this_mr != mr || xlat != base + done) {
             return done;
         }
@@ -3549,7 +3550,7 @@ void *address_space_map(AddressSpace *as,
     l = len;
     rcu_read_lock();
     fv = address_space_to_flatview(as);
-    mr = flatview_translate(fv, addr, &xlat, &l, is_write);
+    mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
-- 
2.17.1
