Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=232365128=Paul.Durrant@citrix.com>)
	id 1clCmN-0003w4-6f
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=232365128=Paul.Durrant@citrix.com>)
	id 1clCmK-0002fC-Ch
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:43 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:15103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=232365128=Paul.Durrant@citrix.com>)
	id 1clCmK-0002eR-5n
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:40 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 7 Mar 2017 10:55:32 +0000
Message-ID: <1488884134-29190-4-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1488884134-29190-1-git-send-email-paul.durrant@citrix.com>
References: <1488884134-29190-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/5] xen: create wrappers for all other uses
 of xc_hvm_XXX() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This patch creates inline wrapper functions in xen_common.h for all open
coded calls to xc_hvm_XXX() functions outside of xen_common.h so that use
of xen_xc can be made implicit. This again is in preparation for the move
to using libxendevicemodel.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 hw/i386/xen/xen_platform.c  |  2 +-
 include/hw/xen/xen_common.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 xen-hvm.c                   | 27 +++++++++++++--------------
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 6010f35..1419fc9 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -195,7 +195,7 @@ static void platform_fixed_ioport_writeb(void *opaque, uint32_t addr, uint32_t v
     case 0: /* Platform flags */ {
         hvmmem_type_t mem_type = (val & PFFLAG_ROM_LOCK) ?
             HVMMEM_ram_ro : HVMMEM_ram_rw;
-        if (xc_hvm_set_mem_type(xen_xc, xen_domid, mem_type, 0xc0, 0x40)) {
+        if (xen_set_mem_type(xen_domid, mem_type, 0xc0, 0x40)) {
             DPRINTF("unable to change ro/rw state of ROM memory area!\n");
         } else {
             s->flags = val & PFFLAG_ROM_LOCK;
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 1e08b98..31cf25f 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -26,6 +26,50 @@ extern xc_interface *xen_xc;
  * We don't support Xen prior to 4.2.0.
  */
 
+static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t type,
+                                   uint64_t first_pfn, uint32_t nr)
+{
+    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
+}
+
+static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segment,
+                                         uint8_t bus, uint8_t device,
+                                         uint8_t intx, unsigned int level)
+{
+    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus, device,
+                                     intx, level);
+}
+
+static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
+                                         uint8_t irq)
+{
+    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
+}
+
+static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
+                                 uint32_t msi_data)
+{
+    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
+}
+
+static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
+                                        unsigned int level)
+{
+    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
+}
+
+static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_pfn,
+                                       uint32_t nr, unsigned long *bitmap)
+{
+    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitmap);
+}
+
+static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
+                                      uint32_t nr)
+{
+    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
+}
+
 /* Xen 4.2 through 4.6 */
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 471
 
diff --git a/xen-hvm.c b/xen-hvm.c
index edf4983..4b928cf 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -125,8 +125,8 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 
 void xen_piix3_set_irq(void *opaque, int irq_num, int level)
 {
-    xc_hvm_set_pci_intx_level(xen_xc, xen_domid, 0, 0, irq_num >> 2,
-                              irq_num & 3, level);
+    xen_set_pci_intx_level(xen_domid, 0, 0, irq_num >> 2,
+                           irq_num & 3, level);
 }
 
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
@@ -141,7 +141,7 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
         }
         v &= 0xf;
         if (((address + i) >= 0x60) && ((address + i) <= 0x63)) {
-            xc_hvm_set_pci_link_route(xen_xc, xen_domid, address + i - 0x60, v);
+            xen_set_pci_link_route(xen_domid, address + i - 0x60, v);
         }
     }
 }
@@ -156,7 +156,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
 
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
 {
-    xc_hvm_inject_msi(xen_xc, xen_domid, addr, data);
+    xen_inject_msi(xen_domid, addr, data);
 }
 
 static void xen_suspend_notifier(Notifier *notifier, void *data)
@@ -168,7 +168,7 @@ static void xen_suspend_notifier(Notifier *notifier, void *data)
 
 static void xen_set_irq(void *opaque, int irq, int level)
 {
-    xc_hvm_set_isa_irq_level(xen_xc, xen_domid, irq, level);
+    xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
 qemu_irq *xen_interrupt_controller_init(void)
@@ -481,10 +481,10 @@ static void xen_set_memory(struct MemoryListener *listener,
                                section->mr, section->offset_within_region);
         } else {
             mem_type = HVMMEM_ram_ro;
-            if (xc_hvm_set_mem_type(xen_xc, xen_domid, mem_type,
-                                    start_addr >> TARGET_PAGE_BITS,
-                                    size >> TARGET_PAGE_BITS)) {
-                DPRINTF("xc_hvm_set_mem_type error, addr: "TARGET_FMT_plx"\n",
+            if (xen_set_mem_type(xen_domid, mem_type,
+                                 start_addr >> TARGET_PAGE_BITS,
+                                 size >> TARGET_PAGE_BITS)) {
+                DPRINTF("xen_set_mem_type error, addr: "TARGET_FMT_plx"\n",
                         start_addr);
             }
         }
@@ -586,9 +586,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
         return;
     }
 
-    rc = xc_hvm_track_dirty_vram(xen_xc, xen_domid,
-                                 start_addr >> TARGET_PAGE_BITS, npages,
-                                 bitmap);
+    rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
+                              npages, bitmap);
     if (rc < 0) {
 #ifndef ENODATA
 #define ENODATA  ENOENT
@@ -634,7 +633,7 @@ static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
     if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
         state->log_for_dirtybit = NULL;
         /* Disable dirty bit tracking */
-        xc_hvm_track_dirty_vram(xen_xc, xen_domid, 0, 0, NULL);
+        xen_track_dirty_vram(xen_domid, 0, 0, NULL);
     }
 }
 
@@ -1403,7 +1402,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         start_pfn = start >> TARGET_PAGE_BITS;
         nb_pages = ((start + length + TARGET_PAGE_SIZE - 1) >> TARGET_PAGE_BITS)
             - start_pfn;
-        rc = xc_hvm_modified_memory(xen_xc, xen_domid, start_pfn, nb_pages);
+        rc = xen_modified_memory(xen_domid, start_pfn, nb_pages);
         if (rc) {
             fprintf(stderr,
                     "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
-- 
2.1.4
