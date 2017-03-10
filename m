Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=235f9c656=igor.druzhinin@citrix.com>)
	id 1cmQoz-0000hD-91
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=235f9c656=igor.druzhinin@citrix.com>)
	id 1cmQos-0002qT-U7
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:07:29 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:30267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=235f9c656=igor.druzhinin@citrix.com>)
	id 1cmQos-0002q3-IF
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:07:22 -0500
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Fri, 10 Mar 2017 20:06:52 +0000
Message-ID: <1489176412-30529-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] xen: don't save/restore the physmap on VM
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com
Cc: paul.durrant@citrix.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Igor Druzhinin <igor.druzhinin@citrix.com>

Saving/restoring the physmap to/from xenstore was introduced to
QEMU majorly in order to cover up the VRAM region restore issue.
The sequence of restore operations implies that we should know
the effective guest VRAM address *before* we have the VRAM region
restored (which happens later). Unfortunately, in Xen environment
VRAM memory does actually belong to a guest - not QEMU itself -
which means the position of this region is unknown beforehand and
can't be mapped into QEMU address space immediately.

Previously, recreating xenstore keys, holding the physmap, by the
toolstack helped to get this information in place at the right
moment ready to be consumed by QEMU to map the region properly.

The extraneous complexity of having those keys transferred by the
toolstack and unnecessary redundancy prompted us to propose a
solution which doesn't require any extra data in xenstore. The idea
is to defer the VRAM region mapping till the point we actually know
the effective address and able to map it. To that end, we initially
only register the pointer to the framebuffer without actual mapping.
Then, during the memory region restore phase, we perform the mapping
of the known address and update the VRAM region metadata (including
previously registered pointer) accordingly.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
v2:
* Fix some building and coding style issues
---
 exec.c               |   3 ++
 hw/display/vga.c     |   2 +-
 include/hw/xen/xen.h |   2 +-
 xen-hvm-stub.c       |   2 +-
 xen-hvm.c            | 114 ++++++++++++---------------------------------------
 5 files changed, 33 insertions(+), 90 deletions(-)

diff --git a/exec.c b/exec.c
index aabb035..5f2809e 100644
--- a/exec.c
+++ b/exec.c
@@ -2008,6 +2008,9 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1);
+        if (block->host == NULL) {
+            return NULL;
+        }
     }
     return ramblock_ptr(block, addr);
 }
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 69c3e1d..be554c2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2163,7 +2163,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
     memory_region_init_ram(&s->vram, obj, "vga.vram", s->vram_size,
                            &error_fatal);
     vmstate_register_ram(&s->vram, global_vmstate ? NULL : DEVICE(obj));
-    xen_register_framebuffer(&s->vram);
+    xen_register_framebuffer(&s->vram, &s->vram_ptr);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     s->get_bpp = vga_get_bpp;
     s->get_offsets = vga_get_offsets;
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 09c2ce5..3831843 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -45,6 +45,6 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 void xen_modified_memory(ram_addr_t start, ram_addr_t length);
 
-void xen_register_framebuffer(struct MemoryRegion *mr);
+void xen_register_framebuffer(struct MemoryRegion *mr, uint8_t **ptr);
 
 #endif /* QEMU_HW_XEN_H */
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
index c500325..c89065e 100644
--- a/xen-hvm-stub.c
+++ b/xen-hvm-stub.c
@@ -46,7 +46,7 @@ qemu_irq *xen_interrupt_controller_init(void)
     return NULL;
 }
 
-void xen_register_framebuffer(MemoryRegion *mr)
+void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
 {
 }
 
diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb..270cd99 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -41,6 +41,7 @@
 
 static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
+static uint8_t **framebuffer_ptr;
 static bool xen_in_migration;
 
 /* Compatibility with older version */
@@ -302,7 +303,6 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
             return physmap->start_addr;
         }
     }
-
     return start_addr;
 }
 
@@ -317,7 +317,6 @@ static int xen_add_to_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr pfn, start_gpfn;
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
-    char path[80], value[17];
     const char *mr_name;
 
     if (get_physmapping(state, start_addr, size)) {
@@ -340,6 +339,27 @@ go_physmap:
     DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
             start_addr, start_addr + size);
 
+    mr_name = memory_region_name(mr);
+
+    physmap = g_malloc(sizeof(XenPhysmap));
+
+    physmap->start_addr = start_addr;
+    physmap->size = size;
+    physmap->name = mr_name;
+    physmap->phys_offset = phys_offset;
+
+    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /* At this point we have a physmap entry for the framebuffer region
+         * established during the restore phase so we can safely update the
+         * registered framebuffer address here. */
+        if (mr == framebuffer) {
+            *framebuffer_ptr = memory_region_get_ram_ptr(framebuffer);
+        }
+        return 0;
+    }
+
     pfn = phys_offset >> TARGET_PAGE_BITS;
     start_gpfn = start_addr >> TARGET_PAGE_BITS;
     for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
@@ -350,49 +370,17 @@ go_physmap:
         if (rc) {
             DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
                     PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
+
+            QLIST_REMOVE(physmap, list);
+            g_free(physmap);
             return -rc;
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
                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    if (mr_name) {
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
-                xen_domid, (uint64_t)phys_offset);
-        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name))) {
-            return -1;
-        }
-    }
-
     return 0;
 }
 
@@ -1152,54 +1140,6 @@ static void xen_exit_notifier(Notifier *n, void *data)
     xs_daemon_close(state->xenstore);
 }
 
-static void xen_read_physmap(XenIOState *state)
-{
-    XenPhysmap *physmap = NULL;
-    unsigned int len, num, i;
-    char path[80], *value = NULL;
-    char **entries = NULL;
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap", xen_domid);
-    entries = xs_directory(state->xenstore, 0, path, &num);
-    if (entries == NULL)
-        return;
-
-    for (i = 0; i < num; i++) {
-        physmap = g_malloc(sizeof (XenPhysmap));
-        physmap->phys_offset = strtoull(entries[i], NULL, 16);
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
-                xen_domid, entries[i]);
-        value = xs_read(state->xenstore, 0, path, &len);
-        if (value == NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->start_addr = strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/size",
-                xen_domid, entries[i]);
-        value = xs_read(state->xenstore, 0, path, &len);
-        if (value == NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->size = strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/name",
-                xen_domid, entries[i]);
-        physmap->name = xs_read(state->xenstore, 0, path, &len);
-
-        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
-    }
-    free(entries);
-}
-
 static void xen_wakeup_notifier(Notifier *notifier, void *data)
 {
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
@@ -1339,7 +1279,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
     xen_be_register_common();
-    xen_read_physmap(state);
 
     /* Disable ACPI build because Xen handles it */
     pcms->acpi_build_enabled = false;
@@ -1374,9 +1313,10 @@ void destroy_hvm_domain(bool reboot)
     }
 }
 
-void xen_register_framebuffer(MemoryRegion *mr)
+void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
 {
     framebuffer = mr;
+    framebuffer_ptr = ptr;
 }
 
 void xen_shutdown_fatal_error(const char *fmt, ...)
-- 
2.7.4
