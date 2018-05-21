Received: from eggs.gnu.org ([2001:4830:134:3::10]:42716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQI-0002pw-CM
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQH-00010w-9j
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:44 +0100
Message-Id: <20180521140402.23318-10-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/27] Make flatview_access_valid() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_access_valid().
Its callers now all have an attrs value to hand, so we can
correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index b58eb0fedd..9229fb4058 100644
--- a/exec.c
+++ b/exec.c
@@ -2697,7 +2697,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
-                                  bool is_write);
+                                  bool is_write, MemTxAttrs attrs);
 
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
                                 unsigned len, MemTxAttrs attrs)
@@ -2773,7 +2773,7 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
 #endif
 
     return flatview_access_valid(subpage->fv, addr + subpage->base,
-                                 len, is_write);
+                                 len, is_write, attrs);
 }
 
 static const MemoryRegionOps subpage_ops = {
@@ -3461,7 +3461,7 @@ static void cpu_notify_map_clients(void)
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
-                                  bool is_write)
+                                  bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
     hwaddr l, xlat;
@@ -3472,8 +3472,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             /* When our callers all have attrs we'll pass them through here */
-            if (!memory_region_access_valid(mr, xlat, l, is_write,
-                                            MEMTXATTRS_UNSPECIFIED)) {
+            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
             }
         }
@@ -3493,7 +3492,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
 
     rcu_read_lock();
     fv = address_space_to_flatview(as);
-    result = flatview_access_valid(fv, addr, len, is_write);
+    result = flatview_access_valid(fv, addr, len, is_write, attrs);
     rcu_read_unlock();
     return result;
 }
-- 
2.17.0
