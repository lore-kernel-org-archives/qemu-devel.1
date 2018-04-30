Received: from eggs.gnu.org ([2001:4830:134:3::10]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOP-00033P-H5
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOO-0007KS-4E
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDDON-0007JL-Ta
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 19:19:01 +0100
Message-Id: <20180430181905.32327-8-peter.maydell@linaro.org>
In-Reply-To: <20180430181905.32327-1-peter.maydell@linaro.org>
References: <20180430181905.32327-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 07/11] Make flatview_access_valid() take a
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
add MemTxAttrs as an argument to flatview_access_valid().
Its callers now all have an attrs value to hand, so we can
correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 3ceeb0643f..0eef4702a5 100644
--- a/exec.c
+++ b/exec.c
@@ -2662,7 +2662,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
-                                  bool is_write);
+                                  bool is_write, MemTxAttrs attrs);
 
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
                                 unsigned len, MemTxAttrs attrs)
@@ -2738,7 +2738,7 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
 #endif
 
     return flatview_access_valid(subpage->fv, addr + subpage->base,
-                                 len, is_write);
+                                 len, is_write, attrs);
 }
 
 static const MemoryRegionOps subpage_ops = {
@@ -3426,7 +3426,7 @@ static void cpu_notify_map_clients(void)
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
-                                  bool is_write)
+                                  bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
     hwaddr l, xlat;
@@ -3437,8 +3437,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             /* When our callers all have attrs we'll pass them through here */
-            if (!memory_region_access_valid(mr, xlat, l, is_write,
-                                            MEMTXATTRS_UNSPECIFIED)) {
+            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
             }
         }
@@ -3458,7 +3457,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
 
     rcu_read_lock();
     fv = address_space_to_flatview(as);
-    result = flatview_access_valid(fv, addr, len, is_write);
+    result = flatview_access_valid(fv, addr, len, is_write, attrs);
     rcu_read_unlock();
     return result;
 }
-- 
2.17.0
