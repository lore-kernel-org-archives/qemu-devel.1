Received: from eggs.gnu.org ([2001:4830:134:3::10]:47287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi2h-0003Kf-Gk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi2e-0007nQ-9J
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dAi2e-0007n8-0I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:21:56 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 16 May 2017 12:21:49 -0700
Message-Id: <1494962512-4831-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/4] xen/mapcache: store dma information in
 revmapcache entries for debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

The Xen mapcache is able to create long term mappings, they are called
"locked" mappings. The third parameter of the xen_map_cache call
specifies if a mapping is a "locked" mapping.

>From the QEMU point of view there are two kinds of long term mappings:

[a] device memory mappings, such as option roms and video memory
[b] dma mappings, created by dma_memory_map & friends

After certain operations, ballooning a VM in particular, Xen asks QEMU
kindly to destroy all mappings. However, certainly [a] mappings are
present and cannot be removed. That's not a problem as they are not
affected by balloonning. The *real* problem is that if there are any
mappings of type [b], any outstanding dma operations could fail. This is
a known shortcoming. In other words, when Xen asks QEMU to destroy all
mappings, it is an error if any [b] mappings exist.

However today we have no way of distinguishing [a] from [b]. Because of
that, we cannot even print a decent warning.

This patch introduces a new "dma" bool field to MapCacheRev entires, to
remember if a given mapping is for dma or is a long term device memory
mapping. When xen_invalidate_map_cache is called, we print a warning if
any [b] mappings exist. We ignore [a] mappings.

Mappings created by qemu_map_ram_ptr are assumed to be [a], while
mappings created by address_space_map->qemu_ram_ptr_length are assumed
to be [b].

The goal of the patch is to make debugging and system understanding
easier.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 exec.c                        |  8 ++++----
 hw/i386/xen/xen-mapcache.c    | 15 ++++++++++-----
 include/sysemu/xen-mapcache.h |  5 +++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index eac6085..85769e1 100644
--- a/exec.c
+++ b/exec.c
@@ -2084,10 +2084,10 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
          * In that case just map until the end of the page.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, 0, 0);
+            return xen_map_cache(addr, 0, 0, false);
         }
 
-        block->host = xen_map_cache(block->offset, block->max_length, 1);
+        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
     }
     return ramblock_ptr(block, addr);
 }
@@ -2117,10 +2117,10 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, *size, 1);
+            return xen_map_cache(addr, *size, 1, true);
         }
 
-        block->host = xen_map_cache(block->offset, block->max_length, 1);
+        block->host = xen_map_cache(block->offset, block->max_length, 1, true);
     }
 
     return ramblock_ptr(block, addr);
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 31debdf..e60156c 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -62,6 +62,7 @@ typedef struct MapCacheRev {
     hwaddr paddr_index;
     hwaddr size;
     QTAILQ_ENTRY(MapCacheRev) next;
+    bool dma;
 } MapCacheRev;
 
 typedef struct MapCache {
@@ -202,7 +203,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
 }
 
 static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
-                                       uint8_t lock)
+                                       uint8_t lock, bool dma)
 {
     MapCacheEntry *entry, *pentry = NULL;
     hwaddr address_index;
@@ -289,6 +290,7 @@ tryagain:
     if (lock) {
         MapCacheRev *reventry = g_malloc0(sizeof(MapCacheRev));
         entry->lock++;
+        reventry->dma = dma;
         reventry->vaddr_req = mapcache->last_entry->vaddr_base + address_offset;
         reventry->paddr_index = mapcache->last_entry->paddr_index;
         reventry->size = entry->size;
@@ -300,12 +302,12 @@ tryagain:
 }
 
 uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock)
+                       uint8_t lock, bool dma)
 {
     uint8_t *p;
 
     mapcache_lock();
-    p = xen_map_cache_unlocked(phys_addr, size, lock);
+    p = xen_map_cache_unlocked(phys_addr, size, lock, dma);
     mapcache_unlock();
     return p;
 }
@@ -426,8 +428,11 @@ void xen_invalidate_map_cache(void)
     mapcache_lock();
 
     QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-        DPRINTF("There should be no locked mappings at this time, "
-                "but "TARGET_FMT_plx" -> %p is present\n",
+        if (!reventry->dma) {
+            continue;
+        }
+        fprintf(stderr, "Locked DMA mapping while invalidating mapcache!"
+                " "TARGET_FMT_plx" -> %p is present\n",
                 reventry->paddr_index, reventry->vaddr_req);
     }
 
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index b8c93b9..01daaad 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -17,7 +17,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr start_addr,
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock);
+                       uint8_t lock, bool dma);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
 void xen_invalidate_map_cache_entry(uint8_t *buffer);
 void xen_invalidate_map_cache(void);
@@ -31,7 +31,8 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 
 static inline uint8_t *xen_map_cache(hwaddr phys_addr,
                                      hwaddr size,
-                                     uint8_t lock)
+                                     uint8_t lock,
+                                     bool dma)
 {
     abort();
 }
-- 
1.9.1
