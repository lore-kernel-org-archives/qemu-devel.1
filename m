Received: from eggs.gnu.org ([2001:4830:134:3::10]:58374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhM4-00024y-SM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhM3-0001OE-Jc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:36 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:20122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=357aabd99=igor.druzhinin@citrix.com>)
	id 1dUhM3-0001Ns-3E
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:40:35 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Mon, 10 Jul 2017 23:40:03 +0100
Message-ID: <1499726403-10129-5-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1499726403-10129-1-git-send-email-igor.druzhinin@citrix.com>
References: <1499726403-10129-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/4] xen: don't use xenstore to save/restore
 physmap anymore
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

If we have a system with xenforeignmemory_map2() implemented
we don't need to save/restore physmap on suspend/restore
anymore. In case we resume a VM without physmap - try to
recreate the physmap during memory region restore phase and
remap map cache entries accordingly. The old code is left
for compatibility reasons.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 hw/i386/xen/xen-hvm.c       | 48 ++++++++++++++++++++++++++++++++++-----------
 hw/i386/xen/xen-mapcache.c  |  4 ++++
 include/hw/xen/xen_common.h |  1 +
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d259cf7..d24ca47 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -289,6 +289,7 @@ static XenPhysmap *get_physmapping(XenIOState *state,
     return NULL;
 }
 
+#ifdef XEN_COMPAT_PHYSMAP
 static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
                                                    ram_addr_t size, void *opaque)
 {
@@ -334,6 +335,12 @@ static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
     }
     return 0;
 }
+#else
+static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
+{
+    return 0;
+}
+#endif
 
 static int xen_add_to_physmap(XenIOState *state,
                               hwaddr start_addr,
@@ -368,6 +375,26 @@ go_physmap:
     DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
             start_addr, start_addr + size);
 
+    mr_name = memory_region_name(mr);
+
+    physmap = g_malloc(sizeof (XenPhysmap));
+
+    physmap->start_addr = start_addr;
+    physmap->size = size;
+    physmap->name = mr_name;
+    physmap->phys_offset = phys_offset;
+
+    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /* Now when we have a physmap entry we can replace a dummy mapping with
+         * a real one of guest foreign memory. */
+        uint8_t *p = xen_replace_cache_entry(phys_offset, start_addr, size);
+        assert(p && p == memory_region_get_ram_ptr(mr));
+
+        return 0;
+    }
+
     pfn = phys_offset >> TARGET_PAGE_BITS;
     start_gpfn = start_addr >> TARGET_PAGE_BITS;
     for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
@@ -382,17 +409,6 @@ go_physmap:
         }
     }
 
-    mr_name = memory_region_name(mr);
-
-    physmap = g_malloc(sizeof (XenPhysmap));
-
-    physmap->start_addr = start_addr;
-    physmap->size = size;
-    physmap->name = mr_name;
-    physmap->phys_offset = phys_offset;
-
-    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
-
     xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
                                    start_addr >> TARGET_PAGE_BITS,
                                    (start_addr + size - 1) >> TARGET_PAGE_BITS,
@@ -1158,6 +1174,7 @@ static void xen_exit_notifier(Notifier *n, void *data)
     xs_daemon_close(state->xenstore);
 }
 
+#ifdef XEN_COMPAT_PHYSMAP
 static void xen_read_physmap(XenIOState *state)
 {
     XenPhysmap *physmap = NULL;
@@ -1205,6 +1222,11 @@ static void xen_read_physmap(XenIOState *state)
     }
     free(entries);
 }
+#else
+static void xen_read_physmap(XenIOState *state)
+{
+}
+#endif
 
 static void xen_wakeup_notifier(Notifier *notifier, void *data)
 {
@@ -1331,7 +1353,11 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     state->bufioreq_local_port = rc;
 
     /* Init RAM management */
+#ifdef XEN_COMPAT_PHYSMAP
     xen_map_cache_init(xen_phys_offset_to_gaddr, state);
+#else
+    xen_map_cache_init(NULL, state);
+#endif
     xen_ram_init(pcms, ram_size, ram_memory);
 
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 8bc63e0..84cc4a2 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -239,7 +239,9 @@ static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
     hwaddr address_offset;
     hwaddr cache_size = size;
     hwaddr test_bit_size;
+#ifdef XEN_COMPAT_PHYSMAP
     bool translated = false;
+#endif
     bool dummy = false;
 
 tryagain:
@@ -307,11 +309,13 @@ tryagain:
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
         mapcache->last_entry = NULL;
+#ifdef XEN_COMPAT_PHYSMAP
         if (!translated && mapcache->phys_offset_to_gaddr) {
             phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size, mapcache->opaque);
             translated = true;
             goto tryagain;
         }
+#endif
         if (!dummy && runstate_check(RUN_STATE_INMIGRATE)) {
             dummy = true;
             goto tryagain;
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index e28ed48..86c7f26 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -80,6 +80,7 @@ extern xenforeignmemory_handle *xen_fmem;
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
 
+#define XEN_COMPAT_PHYSMAP
 static inline void *xenforeignmemory_map2(xenforeignmemory_handle *h,
                                           uint32_t dom, void *addr,
                                           int prot, int flags, size_t pages,
-- 
2.7.4
