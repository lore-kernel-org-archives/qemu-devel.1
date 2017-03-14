Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2391d9474=igor.druzhinin@citrix.com>)
	id 1cnpQ0-0001Pl-NM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2391d9474=igor.druzhinin@citrix.com>)
	id 1cnpPv-0008A5-Un
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:35:28 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:44932
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2391d9474=igor.druzhinin@citrix.com>)
	id 1cnpPv-00089I-Im
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:35:23 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Tue, 14 Mar 2017 16:35:10 +0000
Message-ID: <1489509310-24166-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4] xen: don't save/restore the physmap on VM
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
Cc: paul.durrant@citrix.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, Igor Druzhinin <igor.druzhinin@citrix.com>

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
just skip the mapping request for the framebuffer if we unable to
map it now. Then, after the memory region restore phase, we perform
the mapping again, this time successfully, and update the VRAM region
metadata accordingly.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
v4:
* Use VGA post_load handler for vram_ptr update

v3:
* Modify qemu_ram_ptr_length similarly with qemu_map_ram_ptr
* Add a comment explaining qemu_map_ram_ptr and qemu_ram_ptr_length 
  semantic change for Xen
* Dropped some redundant changes

v2:
* Fix some building and coding style issues
---
 exec.c           |  16 +++++++++
 hw/display/vga.c |   5 +++
 xen-hvm.c        | 104 ++++++++++---------------------------------------------
 3 files changed, 40 insertions(+), 85 deletions(-)

diff --git a/exec.c b/exec.c
index aabb035..a1ac8cd 100644
--- a/exec.c
+++ b/exec.c
@@ -2008,6 +2008,14 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1);
+        if (block->host == NULL) {
+            /* In case we cannot establish the mapping right away we might
+             * still be able to do it later e.g. on a later stage of restore.
+             * We don't touch the block and return NULL here to indicate
+             * that intention.
+             */
+            return NULL;
+        }
     }
     return ramblock_ptr(block, addr);
 }
@@ -2041,6 +2049,14 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1);
+        if (block->host == NULL) {
+            /* In case we cannot establish the mapping right away we might
+             * still be able to do it later e.g. on a later stage of restore.
+             * We don't touch the block and return NULL here to indicate
+             * that intention.
+             */
+            return NULL;
+        }
     }
 
     return ramblock_ptr(block, addr);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 69c3e1d..f8aebe3 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2035,6 +2035,11 @@ static int vga_common_post_load(void *opaque, int version_id)
 {
     VGACommonState *s = opaque;
 
+    if (xen_enabled() && !s->vram_ptr) {
+        /* update VRAM region pointer in case we've failed
+         * the last time during init phase */
+        s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
+    }
     /* force refresh */
     s->graphic_mode = -1;
     vbe_update_vgaregs(s);
diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb..8bedd9b 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -317,7 +317,6 @@ static int xen_add_to_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr pfn, start_gpfn;
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
-    char path[80], value[17];
     const char *mr_name;
 
     if (get_physmapping(state, start_addr, size)) {
@@ -340,6 +339,22 @@ go_physmap:
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
+        /* If we are migrating the region has been already mapped */
+        return 0;
+    }
+
     pfn = phys_offset >> TARGET_PAGE_BITS;
     start_gpfn = start_addr >> TARGET_PAGE_BITS;
     for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
@@ -350,49 +365,17 @@ go_physmap:
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
 
@@ -1152,54 +1135,6 @@ static void xen_exit_notifier(Notifier *n, void *data)
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
@@ -1339,7 +1274,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
     xen_be_register_common();
-    xen_read_physmap(state);
 
     /* Disable ACPI build because Xen handles it */
     pcms->acpi_build_enabled = false;
-- 
2.7.4
