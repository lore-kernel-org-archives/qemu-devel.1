Received: from eggs.gnu.org ([2001:4830:134:3::10]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tl-0005Is-IY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tk-0003CP-Fo
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:21 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7tk-0003Bl-6H
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:20 -0400
Received: by mail-wr0-x243.google.com with SMTP id u18so36375016wrc.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:20 -0700 (PDT)
Received: from donizetti.lan (94-39-184-28.adsl-ull.clienti.tiscali.it.
	[94.39.184.28]) by smtp.gmail.com with ESMTPSA id
	18sm19436935wrt.52.2017.04.03.12.44.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Apr 2017 12:44:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:08 +0200
Message-Id: <20170403194409.21276-6-pbonzini@redhat.com>
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] exec: revert MemoryRegionCache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

MemoryRegionCache did not know about virtio support for IOMMUs (because the
two features were developed at the same time).  Revert MemoryRegionCache
to "normal" address_space_* operations for 2.9, as it is simpler than
undoing the virtio patches.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 64 +++++++++------------------------------------------
 include/exec/memory.h | 10 ++++----
 2 files changed, 15 insertions(+), 59 deletions(-)

diff --git a/exec.c b/exec.c
index e57a8a2..c97ef4a 100644
--- a/exec.c
+++ b/exec.c
@@ -3236,75 +3236,33 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
                                  hwaddr len,
                                  bool is_write)
 {
-    hwaddr l, xlat;
-    MemoryRegion *mr;
-    void *ptr;
-
-    assert(len > 0);
-
-    l = len;
-    mr = address_space_translate(as, addr, &xlat, &l, is_write);
-    if (!memory_access_is_direct(mr, is_write)) {
-        return -EINVAL;
-    }
-
-    l = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
-    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, &l);
-
-    cache->xlat = xlat;
-    cache->is_write = is_write;
-    cache->mr = mr;
-    cache->ptr = ptr;
-    cache->len = l;
-    memory_region_ref(cache->mr);
-
-    return l;
+    cache->len = len;
+    cache->as = as;
+    cache->xlat = addr;
+    return len;
 }
 
 void address_space_cache_invalidate(MemoryRegionCache *cache,
                                     hwaddr addr,
                                     hwaddr access_len)
 {
-    assert(cache->is_write);
-    invalidate_and_set_dirty(cache->mr, addr + cache->xlat, access_len);
 }
 
 void address_space_cache_destroy(MemoryRegionCache *cache)
 {
-    if (!cache->mr) {
-        return;
-    }
-
-    if (xen_enabled()) {
-        xen_invalidate_map_cache_entry(cache->ptr);
-    }
-    memory_region_unref(cache->mr);
-    cache->mr = NULL;
-}
-
-/* Called from RCU critical section.  This function has the same
- * semantics as address_space_translate, but it only works on a
- * predefined range of a MemoryRegion that was mapped with
- * address_space_cache_init.
- */
-static inline MemoryRegion *address_space_translate_cached(
-    MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
-    hwaddr *plen, bool is_write)
-{
-    assert(addr < cache->len && *plen <= cache->len - addr);
-    *xlat = addr + cache->xlat;
-    return cache->mr;
+    cache->as = NULL;
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
 #define ARG1                     cache
 #define SUFFIX                   _cached
-#define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
+#define TRANSLATE(addr, ...)     \
+    address_space_translate(cache->as, cache->xlat + (addr), __VA_ARGS__)
 #define IS_DIRECT(mr, is_write)  true
-#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
-#define INVALIDATE(mr, ofs, len) ((void)0)
-#define RCU_READ_LOCK()          ((void)0)
-#define RCU_READ_UNLOCK()        ((void)0)
+#define MAP_RAM(mr, ofs)         qemu_map_ram_ptr((mr)->ram_block, ofs)
+#define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
+#define RCU_READ_LOCK()          rcu_read_lock()
+#define RCU_READ_UNLOCK()        rcu_read_unlock()
 #include "memory_ldst.inc.c"
 
 /* virtual memory access for debug (includes writing to ROM) */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256a..f20b191 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1426,13 +1426,11 @@ void stq_be_phys(AddressSpace *as, hwaddr addr, uint64_t val);
 
 struct MemoryRegionCache {
     hwaddr xlat;
-    void *ptr;
     hwaddr len;
-    MemoryRegion *mr;
-    bool is_write;
+    AddressSpace *as;
 };
 
-#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .mr = NULL })
+#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .as = NULL })
 
 /* address_space_cache_init: prepare for repeated access to a physical
  * memory region
@@ -1688,7 +1686,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, int len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
-    memcpy(buf, cache->ptr + addr, len);
+    address_space_read(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 /**
@@ -1704,7 +1702,7 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
                            void *buf, int len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
-    memcpy(cache->ptr + addr, buf, len);
+    address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 #endif
-- 
1.8.3.1
