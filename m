Received: from eggs.gnu.org ([2001:4830:134:3::10]:58347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhLw-0001yF-J6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhLv-0001MV-J9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:28 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:45379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhLv-0001L3-3o
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:27 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Mon, 10 Jul 2017 23:40:01 +0100
Message-ID: <1499726403-10129-3-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1499726403-10129-1-git-send-email-igor.druzhinin@citrix.com>
References: <1499726403-10129-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/4] xen/mapcache: add an ability to create
 dummy mappings
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

Dummys are simple anonymous mappings that are placed instead
of regular foreign mappings in certain situations when we need
to postpone the actual mapping but still have to give a
memory region to QEMU to play with.

This is planned to be used for restore on Xen.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-mapcache.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index e60156c..39cb511 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -53,6 +53,8 @@ typedef struct MapCacheEntry {
     uint8_t *vaddr_base;
     unsigned long *valid_mapping;
     uint8_t lock;
+#define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
+    uint8_t flags;
     hwaddr size;
     struct MapCacheEntry *next;
 } MapCacheEntry;
@@ -150,7 +152,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 
 static void xen_remap_bucket(MapCacheEntry *entry,
                              hwaddr size,
-                             hwaddr address_index)
+                             hwaddr address_index,
+                             bool dummy)
 {
     uint8_t *vaddr_base;
     xen_pfn_t *pfns;
@@ -177,11 +180,25 @@ static void xen_remap_bucket(MapCacheEntry *entry,
         pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
     }
 
-    vaddr_base = xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE,
-                                      nb_pfn, pfns, err);
-    if (vaddr_base == NULL) {
-        perror("xenforeignmemory_map");
-        exit(-1);
+    if (!dummy) {
+        vaddr_base = xenforeignmemory_map(xen_fmem, xen_domid,
+                                           PROT_READ | PROT_WRITE,
+                                           nb_pfn, pfns, err);
+        if (vaddr_base == NULL) {
+            perror("xenforeignmemory_map");
+            exit(-1);
+        }
+    } else {
+        /*
+         * We create dummy mappings where we are unable to create a foreign
+         * mapping immediately due to certain circumstances (i.e. on resume now)
+         */
+        vaddr_base = mmap(NULL, size, PROT_READ | PROT_WRITE,
+                          MAP_ANON | MAP_SHARED, -1, 0);
+        if (vaddr_base == NULL) {
+            perror("mmap");
+            exit(-1);
+        }
     }
 
     entry->vaddr_base = vaddr_base;
@@ -190,6 +207,12 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     entry->valid_mapping = (unsigned long *) g_malloc0(sizeof(unsigned long) *
             BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
 
+    if (dummy) {
+        entry->flags |= XEN_MAPCACHE_ENTRY_DUMMY;
+    } else {
+        entry->flags &= ~(XEN_MAPCACHE_ENTRY_DUMMY);
+    }
+
     ram_block_notify_add(entry->vaddr_base, entry->size);
     bitmap_zero(entry->valid_mapping, nb_pfn);
     for (i = 0; i < nb_pfn; i++) {
@@ -211,6 +234,7 @@ static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
     hwaddr cache_size = size;
     hwaddr test_bit_size;
     bool translated = false;
+    bool dummy = false;
 
 tryagain:
     address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
@@ -262,14 +286,14 @@ tryagain:
     if (!entry) {
         entry = g_malloc0(sizeof (MapCacheEntry));
         pentry->next = entry;
-        xen_remap_bucket(entry, cache_size, address_index);
+        xen_remap_bucket(entry, cache_size, address_index, dummy);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(entry, cache_size, address_index);
+            xen_remap_bucket(entry, cache_size, address_index, dummy);
         }
     }
 
@@ -282,6 +306,10 @@ tryagain:
             translated = true;
             goto tryagain;
         }
+        if (!dummy && runstate_check(RUN_STATE_INMIGRATE)) {
+            dummy = true;
+            goto tryagain;
+        }
         trace_xen_map_cache_return(NULL);
         return NULL;
     }
-- 
2.7.4
