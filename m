Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySZ-0007RC-Sw
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySY-00073F-DC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:55 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:4806
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySX-00072D-UW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:54 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Fri, 30 Jun 2017 17:07:04 +0100
Message-ID: <1498838825-23701-4-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1498838825-23701-1-git-send-email-igor.druzhinin@citrix.com>
References: <1498838825-23701-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] xen/mapcache: introduce
 xen_remap_cache_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Igor Druzhinin <igor.druzhinin@citrix.com>, sstabellini@kernel.org, anthony.perard@citrix.com, paul.durrant@citrix.com, pbonzini@redhat.com

This new call is trying to update a requested map cache entry
according to the changes in the physmap. The call is searching
for the entry, unmaps it, tries to translate the address and
maps again at the same place. If the mapping is dummy this call
will make it real.

This function makes use of a new xenforeignmemory_map2() call
with extended interface that was recently introduced in
libxenforeignmemory [1].

[1] https://www.mail-archive.com/xen-devel@lists.xen.org/msg113007.html

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 configure                     |  18 ++++++++
 hw/i386/xen/xen-mapcache.c    | 105 +++++++++++++++++++++++++++++++++++++++---
 include/hw/xen/xen_common.h   |   7 +++
 include/sysemu/xen-mapcache.h |   6 +++
 4 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index c571ad1..ad6156b 100755
--- a/configure
+++ b/configure
@@ -2021,6 +2021,24 @@ EOF
     # Xen unstable
     elif
         cat > $TMPC <<EOF &&
+#undef XC_WANT_COMPAT_MAP_FOREIGN_API
+#include <xenforeignmemory.h>
+int main(void) {
+  xenforeignmemory_handle *xfmem;
+
+  xfmem = xenforeignmemory_open(0, 0);
+  xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
+
+  return 0;
+}
+EOF
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+      then
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+      xen_ctrl_version=41000
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
 #define __XEN_TOOLS__
 #include <xendevicemodel.h>
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 05050de..5d8d990 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -149,6 +149,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 }
 
 static void xen_remap_bucket(MapCacheEntry *entry,
+                             void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
                              bool dummy)
@@ -179,11 +180,11 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     }
 
     if (!dummy) {
-        vaddr_base = xenforeignmemory_map(xen_fmem, xen_domid,
-                                           PROT_READ|PROT_WRITE,
+        vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
+                                           PROT_READ|PROT_WRITE, 0,
                                            nb_pfn, pfns, err);
         if (vaddr_base == NULL) {
-            perror("xenforeignmemory_map");
+            perror("xenforeignmemory_map2");
             exit(-1);
         }
     } else {
@@ -191,7 +192,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
          * We create dummy mappings where we are unable to create a foreign
          * mapping immediately due to certain circumstances (i.e. on resume now)
          */
-        vaddr_base = mmap(NULL, size, PROT_READ|PROT_WRITE,
+        vaddr_base = mmap(vaddr, size, PROT_READ|PROT_WRITE,
                           MAP_ANON|MAP_SHARED, -1, 0);
         if (vaddr_base == NULL) {
             perror("mmap");
@@ -278,14 +279,14 @@ tryagain:
     if (!entry) {
         entry = g_malloc0(sizeof (MapCacheEntry));
         pentry->next = entry;
-        xen_remap_bucket(entry, cache_size, address_index, dummy);
+        xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(entry, cache_size, address_index, dummy);
+            xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
         }
     }
 
@@ -482,3 +483,95 @@ void xen_invalidate_map_cache(void)
 
     mapcache_unlock();
 }
+
+static uint8_t *xen_remap_cache_entry_unlocked(hwaddr phys_addr, hwaddr size)
+{
+    MapCacheEntry *entry, *pentry = NULL;
+    hwaddr address_index;
+    hwaddr address_offset;
+    hwaddr cache_size = size;
+    hwaddr test_bit_size;
+    void *vaddr = NULL;
+    uint8_t lock;
+
+    address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
+    address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);
+
+    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
+    if (size) {
+        test_bit_size = size + (phys_addr & (XC_PAGE_SIZE - 1));
+        if (test_bit_size % XC_PAGE_SIZE) {
+            test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
+        }
+        cache_size = size + address_offset;
+        if (cache_size % MCACHE_BUCKET_SIZE) {
+            cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
+        }
+    } else {
+        test_bit_size = XC_PAGE_SIZE;
+        cache_size = MCACHE_BUCKET_SIZE;
+    }
+
+    /* Search for the requested map cache entry to invalidate */
+    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
+    while (entry && !(entry->paddr_index == address_index && entry->size == cache_size)) {
+        pentry = entry;
+        entry = entry->next;
+    }
+    if (!entry) {
+        DPRINTF("Trying to update an entry for %lx that is not in the mapcache!\n", phys_addr);
+        return NULL;
+    }
+
+    vaddr = entry->vaddr_base;
+    lock = entry->lock;
+    if (entry->vaddr_base) {
+        ram_block_notify_remove(entry->vaddr_base, entry->size);
+        if (munmap(entry->vaddr_base, entry->size) != 0) {
+            perror("unmap fails");
+            exit(-1);
+        }
+    }
+    entry->vaddr_base = NULL;
+    entry->lock = 0;
+
+    if (mapcache->phys_offset_to_gaddr) {
+        phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size, mapcache->opaque);
+
+        address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
+        address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    }
+
+    /* Address may have changed so we need to repeat the search */
+    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
+    while (entry && entry->lock && entry->vaddr_base) {
+        pentry = entry;
+        entry = entry->next;
+    }
+    if (!entry) {
+        entry = g_malloc0(sizeof (MapCacheEntry));
+        pentry->next = entry;
+    }
+
+    entry->lock = 0;
+    xen_remap_bucket(entry, vaddr, cache_size, address_index, false);
+    if(!test_bits(address_offset >> XC_PAGE_SHIFT,
+                test_bit_size >> XC_PAGE_SHIFT,
+                entry->valid_mapping)) {
+        DPRINTF("Unable to update an entry for %lx in the mapcache!\n", phys_addr);
+        return NULL;
+    }
+
+    entry->lock = lock;
+    return entry->vaddr_base + address_offset;
+}
+
+uint8_t *xen_remap_cache_entry(hwaddr phys_addr, hwaddr size)
+{
+    uint8_t *p;
+
+    mapcache_lock();
+    p = xen_remap_cache_entry_unlocked(phys_addr, size);
+    mapcache_unlock();
+    return p;
+}
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index e00ddd7..70a5cad 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -78,6 +78,13 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
 
 extern xenforeignmemory_handle *xen_fmem;
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
+
+#define xenforeignmemory_map2(h, d, a, p, f, ps, ar, e) \
+    xenforeignmemory_map(h, d, p, ps, ar, e)
+
+#endif
+
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
 
 typedef xc_interface xendevicemodel_handle;
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 01daaad..8c140d0 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -21,6 +21,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
 void xen_invalidate_map_cache_entry(uint8_t *buffer);
 void xen_invalidate_map_cache(void);
+uint8_t *xen_remap_cache_entry(hwaddr phys_addr, hwaddr size);
 
 #else
 
@@ -50,6 +51,11 @@ static inline void xen_invalidate_map_cache(void)
 {
 }
 
+static inline uint8_t *xen_remap_cache_entry(hwaddr phys_addr, hwaddr size)
+{
+    abort();
+}
+
 #endif
 
 #endif /* XEN_MAPCACHE_H */
-- 
2.7.4
