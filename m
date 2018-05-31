Received: from eggs.gnu.org ([2001:4830:134:3::10]:41670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUv-0000te-Vr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0006Y1-Ld
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUu-0006Ws-DW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUt-0002vS-Ej
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:50 +0100
Message-Id: <20180531142357.904-19-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/25] Make flatview_access_valid() take a
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
add MemTxAttrs as an argument to flatview_access_valid().
Its callers now all have an attrs value to hand, so we can
correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-10-peter.maydell@linaro.org
---
 exec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index b58eb0fedd..33e0a4f153 100644
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
@@ -3471,9 +3471,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         mr = flatview_translate(fv, addr, &xlat, &l, is_write);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
-            /* When our callers all have attrs we'll pass them through here */
-            if (!memory_region_access_valid(mr, xlat, l, is_write,
-                                            MEMTXATTRS_UNSPECIFIED)) {
+            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
             }
         }
@@ -3493,7 +3491,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
 
     rcu_read_lock();
     fv = address_space_to_flatview(as);
-    result = flatview_access_valid(fv, addr, len, is_write);
+    result = flatview_access_valid(fv, addr, len, is_write, attrs);
     rcu_read_unlock();
     return result;
 }
-- 
2.17.1
