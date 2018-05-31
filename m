Received: from eggs.gnu.org ([2001:4830:134:3::10]:57220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fOSw0-0007US-Cl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fOSvz-0006Om-37
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fOSvy-0006Mr-QV
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:27 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 31 May 2018 12:08:21 -0700
Message-Id: <1527793703-13095-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805311206230.23991@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805311206230.23991@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/3] xen/hvm: correct reporting of modified
 memory under physmap during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

From: Igor Druzhinin <igor.druzhinin@citrix.com>

When global_log_dirty is enabled VRAM modification tracking never
worked correctly. The address that is passed to xen_hvm_modified_memory()
is not the effective PFN but RAM block address which is not the same
for VRAM.

We need to make a translation for this address into PFN using
physmap. Since there is no way to access physmap properly inside
xen_hvm_modified_memory() let's make it a global structure.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-hvm.c         | 37 +++++++++++++++++++------------------
 hw/i386/xen/xen-mapcache.c    |  2 +-
 include/sysemu/xen-mapcache.h |  5 ++---
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 6ffa3c2..2afab65 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -86,6 +86,8 @@ typedef struct XenPhysmap {
     QLIST_ENTRY(XenPhysmap) list;
 } XenPhysmap;
 
+static QLIST_HEAD(, XenPhysmap) xen_physmap;
+
 typedef struct XenIOState {
     ioservid_t ioservid;
     shared_iopage_t *shared_page;
@@ -107,7 +109,6 @@ typedef struct XenIOState {
     MemoryListener memory_listener;
     MemoryListener io_listener;
     DeviceListener device_listener;
-    QLIST_HEAD(, XenPhysmap) physmap;
     hwaddr free_phys_offset;
     const XenPhysmap *log_for_dirtybit;
 
@@ -274,14 +275,13 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
     g_free(pfn_list);
 }
 
-static XenPhysmap *get_physmapping(XenIOState *state,
-                                   hwaddr start_addr, ram_addr_t size)
+static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
 {
     XenPhysmap *physmap = NULL;
 
     start_addr &= TARGET_PAGE_MASK;
 
-    QLIST_FOREACH(physmap, &state->physmap, list) {
+    QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
             return physmap;
         }
@@ -289,23 +289,21 @@ static XenPhysmap *get_physmapping(XenIOState *state,
     return NULL;
 }
 
-#ifdef XEN_COMPAT_PHYSMAP
-static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
-                                                   ram_addr_t size, void *opaque)
+static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size)
 {
-    hwaddr addr = start_addr & TARGET_PAGE_MASK;
-    XenIOState *xen_io_state = opaque;
+    hwaddr addr = phys_offset & TARGET_PAGE_MASK;
     XenPhysmap *physmap = NULL;
 
-    QLIST_FOREACH(physmap, &xen_io_state->physmap, list) {
+    QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) {
-            return physmap->start_addr;
+            return physmap->start_addr + (phys_offset - physmap->phys_offset);
         }
     }
 
-    return start_addr;
+    return phys_offset;
 }
 
+#ifdef XEN_COMPAT_PHYSMAP
 static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
 {
     char path[80], value[17];
@@ -355,7 +353,7 @@ static int xen_add_to_physmap(XenIOState *state,
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
     const char *mr_name;
 
-    if (get_physmapping(state, start_addr, size)) {
+    if (get_physmapping(start_addr, size)) {
         return 0;
     }
     if (size <= 0) {
@@ -384,7 +382,7 @@ go_physmap:
     physmap->name = mr_name;
     physmap->phys_offset = phys_offset;
 
-    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+    QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         /* Now when we have a physmap entry we can replace a dummy mapping with
@@ -428,7 +426,7 @@ static int xen_remove_from_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr phys_offset = 0;
 
-    physmap = get_physmapping(state, start_addr, size);
+    physmap = get_physmapping(start_addr, size);
     if (physmap == NULL) {
         return -1;
     }
@@ -597,7 +595,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
     int rc, i, j;
     const XenPhysmap *physmap = NULL;
 
-    physmap = get_physmapping(state, start_addr, size);
+    physmap = get_physmapping(start_addr, size);
     if (physmap == NULL) {
         /* not handled */
         return;
@@ -1222,7 +1220,7 @@ static void xen_read_physmap(XenIOState *state)
                 xen_domid, entries[i]);
         physmap->name = xs_read(state->xenstore, 0, path, &len);
 
-        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+        QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
     }
     free(entries);
 }
@@ -1374,7 +1372,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
 
     state->memory_listener = xen_memory_listener;
-    QLIST_INIT(&state->physmap);
     memory_listener_register(&state->memory_listener, &address_space_memory);
     state->log_for_dirtybit = NULL;
 
@@ -1390,6 +1387,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
     xen_be_register_common();
+
+    QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
     /* Disable ACPI build because Xen handles it */
@@ -1461,6 +1460,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         int rc;
         ram_addr_t start_pfn, nb_pages;
 
+        start = xen_phys_offset_to_gaddr(start, length);
+
         if (length == 0) {
             length = TARGET_PAGE_SIZE;
         }
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index efa35dc..12fd932 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -319,7 +319,7 @@ tryagain:
         mapcache->last_entry = NULL;
 #ifdef XEN_COMPAT_PHYSMAP
         if (!translated && mapcache->phys_offset_to_gaddr) {
-            phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size, mapcache->opaque);
+            phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size);
             translated = true;
             goto tryagain;
         }
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index bd4d49e..a03e2f1 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -9,9 +9,8 @@
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
 
-typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr start_addr,
-                                                     ram_addr_t size,
-                                                     void *opaque);
+typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
+                                         ram_addr_t size);
 #ifdef CONFIG_XEN
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
-- 
1.9.1
