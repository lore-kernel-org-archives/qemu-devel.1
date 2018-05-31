Received: from eggs.gnu.org ([2001:4830:134:3::10]:41572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUt-0000qf-7A
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUs-0006V3-9u
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUs-0006Oj-2L
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUr-0002u0-5L
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:47 +0100
Message-Id: <20180531142357.904-16-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/25] Make flatview_extend_translation() take a
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
add MemTxAttrs as an argument to flatview_extend_translation().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-7-peter.maydell@linaro.org
---
 exec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index 22af4e8cb9..718b33921b 100644
--- a/exec.c
+++ b/exec.c
@@ -3495,9 +3495,9 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
 
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
-                                 hwaddr target_len,
-                                 MemoryRegion *mr, hwaddr base, hwaddr len,
-                                 bool is_write)
+                            hwaddr target_len,
+                            MemoryRegion *mr, hwaddr base, hwaddr len,
+                            bool is_write, MemTxAttrs attrs)
 {
     hwaddr done = 0;
     hwaddr xlat;
@@ -3574,7 +3574,7 @@ void *address_space_map(AddressSpace *as,
 
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
-                                             l, is_write);
+                                        l, is_write, attrs);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
     rcu_read_unlock();
 
@@ -3659,8 +3659,13 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
     mr = cache->mrs.mr;
     memory_region_ref(mr);
     if (memory_access_is_direct(mr, is_write)) {
+        /* We don't care about the memory attributes here as we're only
+         * doing this if we found actual RAM, which behaves the same
+         * regardless of attributes; so UNSPECIFIED is fine.
+         */
         l = flatview_extend_translation(cache->fv, addr, len, mr,
-                                        cache->xlat, l, is_write);
+                                        cache->xlat, l, is_write,
+                                        MEMTXATTRS_UNSPECIFIED);
         cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
     } else {
         cache->ptr = NULL;
-- 
2.17.1
