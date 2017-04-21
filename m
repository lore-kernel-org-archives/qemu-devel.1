Received: from eggs.gnu.org ([2001:4830:134:3::10]:35551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exZ-0003oh-38
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exX-0002ff-Di
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:17 -0400
Received: from mail.kernel.org ([198.145.29.136]:42684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exX-0002fY-5p
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:15 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:46 -0700
Message-Id: <1492805702-19690-5-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 05/21] xen: use libxendevicemodel when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

This patch modifies the wrapper functions in xen_common.h to use the
new xendevicemodel interface if it is available along with compatibility
code to use the old libxenctrl interface if it is not.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 include/hw/xen/xen_common.h | 203 +++++++++++++++++++++++++++++++++++++-------
 xen-common.c                |   8 ++
 2 files changed, 178 insertions(+), 33 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 31cf25f..b1f5f53 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -26,48 +26,184 @@ extern xc_interface *xen_xc;
  * We don't support Xen prior to 4.2.0.
  */
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
+
+typedef xc_interface xendevicemodel_handle;
+
+static inline xendevicemodel_handle *xendevicemodel_open(
+    struct xentoollog_logger *logger, unsigned int open_flags)
+{
+    return xen_xc;
+}
+
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 450
+
+static inline int xendevicemodel_create_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, int handle_bufioreq,
+    ioservid_t *id)
+{
+    return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
+                                      id);
+}
+
+static inline int xendevicemodel_get_ioreq_server_info(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
+    xen_pfn_t *ioreq_pfn, xen_pfn_t *bufioreq_pfn,
+    evtchn_port_t *bufioreq_port)
+{
+    return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
+                                        bufioreq_pfn, bufioreq_port);
+}
+
+static inline int xendevicemodel_map_io_range_to_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int is_mmio,
+    uint64_t start, uint64_t end)
+{
+    return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
+                                               start, end);
+}
+
+static inline int xendevicemodel_unmap_io_range_from_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int is_mmio,
+    uint64_t start, uint64_t end)
+{
+    return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_mmio,
+                                                   start, end);
+}
+
+static inline int xendevicemodel_map_pcidev_to_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
+    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
+{
+    return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
+                                             bus, device, function);
+}
+
+static inline int xendevicemodel_unmap_pcidev_from_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
+    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
+{
+    return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segment,
+                                                 bus, device, function);
+}
+
+static inline int xendevicemodel_destroy_ioreq_server(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id)
+{
+    return xc_hvm_destroy_ioreq_server(dmod, domid, id);
+}
+
+static inline int xendevicemodel_set_ioreq_server_state(
+    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int enabled)
+{
+    return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
+}
+
+#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 450 */
+
+static inline int xendevicemodel_set_pci_intx_level(
+    xendevicemodel_handle *dmod, domid_t domid, uint16_t segment,
+    uint8_t bus, uint8_t device, uint8_t intx, unsigned int level)
+{
+    return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
+                                     intx, level);
+}
+
+static inline int xendevicemodel_set_isa_irq_level(
+    xendevicemodel_handle *dmod, domid_t domid, uint8_t irq,
+    unsigned int level)
+{
+    return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
+}
+
+static inline int xendevicemodel_set_pci_link_route(
+    xendevicemodel_handle *dmod, domid_t domid, uint8_t link, uint8_t irq)
+{
+    return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
+}
+
+static inline int xendevicemodel_inject_msi(
+    xendevicemodel_handle *dmod, domid_t domid, uint64_t msi_addr,
+    uint32_t msi_data)
+{
+    return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
+}
+
+static inline int xendevicemodel_track_dirty_vram(
+    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
+    uint32_t nr, unsigned long *dirty_bitmap)
+{
+    return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
+                                   dirty_bitmap);
+}
+
+static inline int xendevicemodel_modified_memory(
+    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
+    uint32_t nr)
+{
+    return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
+}
+
+static inline int xendevicemodel_set_mem_type(
+    xendevicemodel_handle *dmod, domid_t domid, hvmmem_type_t mem_type,
+    uint64_t first_pfn, uint32_t nr)
+{
+    return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
+}
+
+#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 490 */
+
+#undef XC_WANT_COMPAT_DEVICEMODEL_API
+#include <xendevicemodel.h>
+
+#endif
+
+extern xendevicemodel_handle *xen_dmod;
+
 static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t type,
                                    uint64_t first_pfn, uint32_t nr)
 {
-    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
+    return xendevicemodel_set_mem_type(xen_dmod, domid, type, first_pfn,
+                                       nr);
 }
 
 static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segment,
                                          uint8_t bus, uint8_t device,
                                          uint8_t intx, unsigned int level)
 {
-    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus, device,
-                                     intx, level);
+    return xendevicemodel_set_pci_intx_level(xen_dmod, domid, segment, bus,
+                                             device, intx, level);
 }
 
 static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
                                          uint8_t irq)
 {
-    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
+    return xendevicemodel_set_pci_link_route(xen_dmod, domid, link, irq);
 }
 
 static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
                                  uint32_t msi_data)
 {
-    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
+    return xendevicemodel_inject_msi(xen_dmod, domid, msi_addr, msi_data);
 }
 
 static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
                                         unsigned int level)
 {
-    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
+    return xendevicemodel_set_isa_irq_level(xen_dmod, domid, irq, level);
 }
 
 static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_pfn,
                                        uint32_t nr, unsigned long *bitmap)
 {
-    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitmap);
+    return xendevicemodel_track_dirty_vram(xen_dmod, domid, first_pfn, nr,
+                                           bitmap);
 }
 
 static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
                                       uint32_t nr)
 {
-    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
+    return xendevicemodel_modified_memory(xen_dmod, domid, first_pfn, nr);
 }
 
 /* Xen 4.2 through 4.6 */
@@ -97,6 +233,7 @@ typedef xc_gnttab xengnttab_handle;
     xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
 
 #define xenforeignmemory_open(l, f) xen_xc
+#define xenforeignmemory_close(h)
 
 static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
                                          int prot, size_t pages,
@@ -285,8 +422,8 @@ static inline void xen_map_memory_section(domid_t dom,
     }
 
     trace_xen_map_mmio_range(ioservid, start_addr, end_addr);
-    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 1,
-                                        start_addr, end_addr);
+    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom, ioservid, 1,
+                                                start_addr, end_addr);
 }
 
 static inline void xen_unmap_memory_section(domid_t dom,
@@ -302,8 +439,8 @@ static inline void xen_unmap_memory_section(domid_t dom,
     }
 
     trace_xen_unmap_mmio_range(ioservid, start_addr, end_addr);
-    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
-                                            1, start_addr, end_addr);
+    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod, dom, ioservid,
+                                                    1, start_addr, end_addr);
 }
 
 static inline void xen_map_io_section(domid_t dom,
@@ -319,8 +456,8 @@ static inline void xen_map_io_section(domid_t dom,
     }
 
     trace_xen_map_portio_range(ioservid, start_addr, end_addr);
-    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 0,
-                                        start_addr, end_addr);
+    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom, ioservid, 0,
+                                                start_addr, end_addr);
 }
 
 static inline void xen_unmap_io_section(domid_t dom,
@@ -336,8 +473,8 @@ static inline void xen_unmap_io_section(domid_t dom,
     }
 
     trace_xen_unmap_portio_range(ioservid, start_addr, end_addr);
-    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
-                                            0, start_addr, end_addr);
+    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod, dom, ioservid,
+                                                    0, start_addr, end_addr);
 }
 
 static inline void xen_map_pcidev(domid_t dom,
@@ -350,10 +487,10 @@ static inline void xen_map_pcidev(domid_t dom,
 
     trace_xen_map_pcidev(ioservid, pci_bus_num(pci_dev->bus),
                          PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
-    xc_hvm_map_pcidev_to_ioreq_server(xen_xc, dom, ioservid, 0,
-                                      pci_bus_num(pci_dev->bus),
-                                      PCI_SLOT(pci_dev->devfn),
-                                      PCI_FUNC(pci_dev->devfn));
+    xendevicemodel_map_pcidev_to_ioreq_server(xen_dmod, dom, ioservid, 0,
+                                              pci_bus_num(pci_dev->bus),
+                                              PCI_SLOT(pci_dev->devfn),
+                                              PCI_FUNC(pci_dev->devfn));
 }
 
 static inline void xen_unmap_pcidev(domid_t dom,
@@ -366,18 +503,18 @@ static inline void xen_unmap_pcidev(domid_t dom,
 
     trace_xen_unmap_pcidev(ioservid, pci_bus_num(pci_dev->bus),
                            PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
-    xc_hvm_unmap_pcidev_from_ioreq_server(xen_xc, dom, ioservid, 0,
-                                          pci_bus_num(pci_dev->bus),
-                                          PCI_SLOT(pci_dev->devfn),
-                                          PCI_FUNC(pci_dev->devfn));
+    xendevicemodel_unmap_pcidev_from_ioreq_server(xen_dmod, dom, ioservid, 0,
+                                                  pci_bus_num(pci_dev->bus),
+                                                  PCI_SLOT(pci_dev->devfn),
+                                                  PCI_FUNC(pci_dev->devfn));
 }
 
 static inline void xen_create_ioreq_server(domid_t dom,
                                            ioservid_t *ioservid)
 {
-    int rc = xc_hvm_create_ioreq_server(xen_xc, dom,
-                                        HVM_IOREQSRV_BUFIOREQ_ATOMIC,
-                                        ioservid);
+    int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
+                                                HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                                                ioservid);
 
     if (rc == 0) {
         trace_xen_ioreq_server_create(*ioservid);
@@ -397,7 +534,7 @@ static inline void xen_destroy_ioreq_server(domid_t dom,
     }
 
     trace_xen_ioreq_server_destroy(ioservid);
-    xc_hvm_destroy_ioreq_server(xen_xc, dom, ioservid);
+    xendevicemodel_destroy_ioreq_server(xen_dmod, dom, ioservid);
 }
 
 static inline int xen_get_ioreq_server_info(domid_t dom,
@@ -412,9 +549,9 @@ static inline int xen_get_ioreq_server_info(domid_t dom,
                                                  bufioreq_evtchn);
     }
 
-    return xc_hvm_get_ioreq_server_info(xen_xc, dom, ioservid,
-                                        ioreq_pfn, bufioreq_pfn,
-                                        bufioreq_evtchn);
+    return xendevicemodel_get_ioreq_server_info(xen_dmod, dom, ioservid,
+                                                ioreq_pfn, bufioreq_pfn,
+                                                bufioreq_evtchn);
 }
 
 static inline int xen_set_ioreq_server_state(domid_t dom,
@@ -426,8 +563,8 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
     }
 
     trace_xen_ioreq_server_state(ioservid, enable);
-    return xc_hvm_set_ioreq_server_state(xen_xc, dom, ioservid,
-                                         enable);
+    return xendevicemodel_set_ioreq_server_state(xen_dmod, dom, ioservid,
+                                                 enable);
 }
 
 #endif
diff --git a/xen-common.c b/xen-common.c
index 703e7a5..ae76150 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -27,6 +27,7 @@
 
 xc_interface *xen_xc;
 xenforeignmemory_handle *xen_fmem;
+xendevicemodel_handle *xen_dmod;
 
 static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
@@ -128,6 +129,13 @@ static int xen_init(MachineState *ms)
         xc_interface_close(xen_xc);
         return -1;
     }
+    xen_dmod = xendevicemodel_open(0, 0);
+    if (xen_dmod == NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen devicemodel interface\n");
+        xenforeignmemory_close(xen_fmem);
+        xc_interface_close(xen_xc);
+        return -1;
+    }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
 
     global_state_set_optional();
-- 
1.9.1
