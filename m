Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgj-0004J7-Ki
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-00017a-Ta
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:57 -0500
Received: from smtp.citrix.com ([66.165.176.89]:7547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-00016D-N0
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:54 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 3 Mar 2017 11:47:47 +0000
Message-ID: <1488541671-26740-2-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1488541671-26740-1-git-send-email-paul.durrant@citrix.com>
References: <1488541671-26740-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/5] xen: make use of xen_xc implicit in
 xen_common.h inlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

Doing this will make the transition to using the new libxendevicemodel
interface less intrusive on the callers of these functions, since using
the new library will require a change of handle.

NOTE: The patch also moves the 'externs' for xen_xc and xen_fmem from
      xen_backend.h to xen_common.h, and the declarations from
      xen_backend.c to xen-common.c, which is where they belong.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_backend.c         |  2 -
 include/hw/xen/xen_backend.h |  2 -
 include/hw/xen/xen_common.h  | 90 +++++++++++++++++++++++---------------------
 xen-common.c                 |  3 ++
 xen-hvm.c                    | 20 +++++-----
 5 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6c21c37..d34c49e 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -43,8 +43,6 @@ BusState *xen_sysbus;
 /* ------------------------------------------------------------- */
 
 /* public */
-xc_interface *xen_xc = NULL;
-xenforeignmemory_handle *xen_fmem = NULL;
 struct xs_handle *xenstore = NULL;
 const char *xen_protocol;
 
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 4f4799a..30811a1 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -14,8 +14,6 @@
     OBJECT_CHECK(XenDevice, (obj), TYPE_XENBACKEND)
 
 /* variables */
-extern xc_interface *xen_xc;
-extern xenforeignmemory_handle *xen_fmem;
 extern struct xs_handle *xenstore;
 extern const char *xen_protocol;
 extern DeviceState *xen_sysdev;
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index dce76ee..1e08b98 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -20,6 +20,8 @@
 #include "qemu/queue.h"
 #include "hw/xen/trace.h"
 
+extern xc_interface *xen_xc;
+
 /*
  * We don't support Xen prior to 4.2.0.
  */
@@ -73,6 +75,8 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
 
 #endif
 
+extern xenforeignmemory_handle *xen_fmem;
+
 void destroy_hvm_domain(bool reboot);
 
 /* shutdown/destroy current domain because of an error */
@@ -107,8 +111,7 @@ static inline int xen_get_vmport_regs_pfn(xc_interface *xc, domid_t dom,
 
 #endif
 
-static inline int xen_get_default_ioreq_server_info(xc_interface *xc,
-                                                    domid_t dom,
+static inline int xen_get_default_ioreq_server_info(domid_t dom,
                                                     xen_pfn_t *ioreq_pfn,
                                                     xen_pfn_t *bufioreq_pfn,
                                                     evtchn_port_t
@@ -117,7 +120,7 @@ static inline int xen_get_default_ioreq_server_info(xc_interface *xc,
     unsigned long param;
     int rc;
 
-    rc = xc_get_hvm_param(xc, dom, HVM_PARAM_IOREQ_PFN, &param);
+    rc = xc_get_hvm_param(xen_xc, dom, HVM_PARAM_IOREQ_PFN, &param);
     if (rc < 0) {
         fprintf(stderr, "failed to get HVM_PARAM_IOREQ_PFN\n");
         return -1;
@@ -125,7 +128,7 @@ static inline int xen_get_default_ioreq_server_info(xc_interface *xc,
 
     *ioreq_pfn = param;
 
-    rc = xc_get_hvm_param(xc, dom, HVM_PARAM_BUFIOREQ_PFN, &param);
+    rc = xc_get_hvm_param(xen_xc, dom, HVM_PARAM_BUFIOREQ_PFN, &param);
     if (rc < 0) {
         fprintf(stderr, "failed to get HVM_PARAM_BUFIOREQ_PFN\n");
         return -1;
@@ -133,7 +136,7 @@ static inline int xen_get_default_ioreq_server_info(xc_interface *xc,
 
     *bufioreq_pfn = param;
 
-    rc = xc_get_hvm_param(xc, dom, HVM_PARAM_BUFIOREQ_EVTCHN,
+    rc = xc_get_hvm_param(xen_xc, dom, HVM_PARAM_BUFIOREQ_EVTCHN,
                           &param);
     if (rc < 0) {
         fprintf(stderr, "failed to get HVM_PARAM_BUFIOREQ_EVTCHN\n");
@@ -156,63 +159,64 @@ static inline int xen_get_default_ioreq_server_info(xc_interface *xc,
 
 typedef uint16_t ioservid_t;
 
-static inline void xen_map_memory_section(xc_interface *xc, domid_t dom,
+static inline void xen_map_memory_section(domid_t dom,
                                           ioservid_t ioservid,
                                           MemoryRegionSection *section)
 {
 }
 
-static inline void xen_unmap_memory_section(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_memory_section(domid_t dom,
                                             ioservid_t ioservid,
                                             MemoryRegionSection *section)
 {
 }
 
-static inline void xen_map_io_section(xc_interface *xc, domid_t dom,
+static inline void xen_map_io_section(domid_t dom,
                                       ioservid_t ioservid,
                                       MemoryRegionSection *section)
 {
 }
 
-static inline void xen_unmap_io_section(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_io_section(domid_t dom,
                                         ioservid_t ioservid,
                                         MemoryRegionSection *section)
 {
 }
 
-static inline void xen_map_pcidev(xc_interface *xc, domid_t dom,
+static inline void xen_map_pcidev(domid_t dom,
                                   ioservid_t ioservid,
                                   PCIDevice *pci_dev)
 {
 }
 
-static inline void xen_unmap_pcidev(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_pcidev(domid_t dom,
                                     ioservid_t ioservid,
                                     PCIDevice *pci_dev)
 {
 }
 
-static inline void xen_create_ioreq_server(xc_interface *xc, domid_t dom,
+static inline void xen_create_ioreq_server(domid_t dom,
                                            ioservid_t *ioservid)
 {
 }
 
-static inline void xen_destroy_ioreq_server(xc_interface *xc, domid_t dom,
+static inline void xen_destroy_ioreq_server(domid_t dom,
                                             ioservid_t ioservid)
 {
 }
 
-static inline int xen_get_ioreq_server_info(xc_interface *xc, domid_t dom,
+static inline int xen_get_ioreq_server_info(domid_t dom,
                                             ioservid_t ioservid,
                                             xen_pfn_t *ioreq_pfn,
                                             xen_pfn_t *bufioreq_pfn,
                                             evtchn_port_t *bufioreq_evtchn)
 {
-    return xen_get_default_ioreq_server_info(xc, dom, ioreq_pfn, bufioreq_pfn,
+    return xen_get_default_ioreq_server_info(dom, ioreq_pfn,
+                                             bufioreq_pfn,
                                              bufioreq_evtchn);
 }
 
-static inline int xen_set_ioreq_server_state(xc_interface *xc, domid_t dom,
+static inline int xen_set_ioreq_server_state(domid_t dom,
                                              ioservid_t ioservid,
                                              bool enable)
 {
@@ -224,7 +228,7 @@ static inline int xen_set_ioreq_server_state(xc_interface *xc, domid_t dom,
 
 static bool use_default_ioreq_server;
 
-static inline void xen_map_memory_section(xc_interface *xc, domid_t dom,
+static inline void xen_map_memory_section(domid_t dom,
                                           ioservid_t ioservid,
                                           MemoryRegionSection *section)
 {
@@ -237,11 +241,11 @@ static inline void xen_map_memory_section(xc_interface *xc, domid_t dom,
     }
 
     trace_xen_map_mmio_range(ioservid, start_addr, end_addr);
-    xc_hvm_map_io_range_to_ioreq_server(xc, dom, ioservid, 1,
+    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 1,
                                         start_addr, end_addr);
 }
 
-static inline void xen_unmap_memory_section(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_memory_section(domid_t dom,
                                             ioservid_t ioservid,
                                             MemoryRegionSection *section)
 {
@@ -253,13 +257,12 @@ static inline void xen_unmap_memory_section(xc_interface *xc, domid_t dom,
         return;
     }
 
-
     trace_xen_unmap_mmio_range(ioservid, start_addr, end_addr);
-    xc_hvm_unmap_io_range_from_ioreq_server(xc, dom, ioservid, 1,
-                                            start_addr, end_addr);
+    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
+                                            1, start_addr, end_addr);
 }
 
-static inline void xen_map_io_section(xc_interface *xc, domid_t dom,
+static inline void xen_map_io_section(domid_t dom,
                                       ioservid_t ioservid,
                                       MemoryRegionSection *section)
 {
@@ -271,13 +274,12 @@ static inline void xen_map_io_section(xc_interface *xc, domid_t dom,
         return;
     }
 
-
     trace_xen_map_portio_range(ioservid, start_addr, end_addr);
-    xc_hvm_map_io_range_to_ioreq_server(xc, dom, ioservid, 0,
+    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 0,
                                         start_addr, end_addr);
 }
 
-static inline void xen_unmap_io_section(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_io_section(domid_t dom,
                                         ioservid_t ioservid,
                                         MemoryRegionSection *section)
 {
@@ -290,11 +292,11 @@ static inline void xen_unmap_io_section(xc_interface *xc, domid_t dom,
     }
 
     trace_xen_unmap_portio_range(ioservid, start_addr, end_addr);
-    xc_hvm_unmap_io_range_from_ioreq_server(xc, dom, ioservid, 0,
-                                            start_addr, end_addr);
+    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
+                                            0, start_addr, end_addr);
 }
 
-static inline void xen_map_pcidev(xc_interface *xc, domid_t dom,
+static inline void xen_map_pcidev(domid_t dom,
                                   ioservid_t ioservid,
                                   PCIDevice *pci_dev)
 {
@@ -304,13 +306,13 @@ static inline void xen_map_pcidev(xc_interface *xc, domid_t dom,
 
     trace_xen_map_pcidev(ioservid, pci_bus_num(pci_dev->bus),
                          PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
-    xc_hvm_map_pcidev_to_ioreq_server(xc, dom, ioservid,
-                                      0, pci_bus_num(pci_dev->bus),
+    xc_hvm_map_pcidev_to_ioreq_server(xen_xc, dom, ioservid, 0,
+                                      pci_bus_num(pci_dev->bus),
                                       PCI_SLOT(pci_dev->devfn),
                                       PCI_FUNC(pci_dev->devfn));
 }
 
-static inline void xen_unmap_pcidev(xc_interface *xc, domid_t dom,
+static inline void xen_unmap_pcidev(domid_t dom,
                                     ioservid_t ioservid,
                                     PCIDevice *pci_dev)
 {
@@ -320,16 +322,17 @@ static inline void xen_unmap_pcidev(xc_interface *xc, domid_t dom,
 
     trace_xen_unmap_pcidev(ioservid, pci_bus_num(pci_dev->bus),
                            PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
-    xc_hvm_unmap_pcidev_from_ioreq_server(xc, dom, ioservid,
-                                          0, pci_bus_num(pci_dev->bus),
+    xc_hvm_unmap_pcidev_from_ioreq_server(xen_xc, dom, ioservid, 0,
+                                          pci_bus_num(pci_dev->bus),
                                           PCI_SLOT(pci_dev->devfn),
                                           PCI_FUNC(pci_dev->devfn));
 }
 
-static inline void xen_create_ioreq_server(xc_interface *xc, domid_t dom,
+static inline void xen_create_ioreq_server(domid_t dom,
                                            ioservid_t *ioservid)
 {
-    int rc = xc_hvm_create_ioreq_server(xc, dom, HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+    int rc = xc_hvm_create_ioreq_server(xen_xc, dom,
+                                        HVM_IOREQSRV_BUFIOREQ_ATOMIC,
                                         ioservid);
 
     if (rc == 0) {
@@ -342,7 +345,7 @@ static inline void xen_create_ioreq_server(xc_interface *xc, domid_t dom,
     trace_xen_default_ioreq_server();
 }
 
-static inline void xen_destroy_ioreq_server(xc_interface *xc, domid_t dom,
+static inline void xen_destroy_ioreq_server(domid_t dom,
                                             ioservid_t ioservid)
 {
     if (use_default_ioreq_server) {
@@ -350,27 +353,27 @@ static inline void xen_destroy_ioreq_server(xc_interface *xc, domid_t dom,
     }
 
     trace_xen_ioreq_server_destroy(ioservid);
-    xc_hvm_destroy_ioreq_server(xc, dom, ioservid);
+    xc_hvm_destroy_ioreq_server(xen_xc, dom, ioservid);
 }
 
-static inline int xen_get_ioreq_server_info(xc_interface *xc, domid_t dom,
+static inline int xen_get_ioreq_server_info(domid_t dom,
                                             ioservid_t ioservid,
                                             xen_pfn_t *ioreq_pfn,
                                             xen_pfn_t *bufioreq_pfn,
                                             evtchn_port_t *bufioreq_evtchn)
 {
     if (use_default_ioreq_server) {
-        return xen_get_default_ioreq_server_info(xc, dom, ioreq_pfn,
+        return xen_get_default_ioreq_server_info(dom, ioreq_pfn,
                                                  bufioreq_pfn,
                                                  bufioreq_evtchn);
     }
 
-    return xc_hvm_get_ioreq_server_info(xc, dom, ioservid,
+    return xc_hvm_get_ioreq_server_info(xen_xc, dom, ioservid,
                                         ioreq_pfn, bufioreq_pfn,
                                         bufioreq_evtchn);
 }
 
-static inline int xen_set_ioreq_server_state(xc_interface *xc, domid_t dom,
+static inline int xen_set_ioreq_server_state(domid_t dom,
                                              ioservid_t ioservid,
                                              bool enable)
 {
@@ -379,7 +382,8 @@ static inline int xen_set_ioreq_server_state(xc_interface *xc, domid_t dom,
     }
 
     trace_xen_ioreq_server_state(ioservid, enable);
-    return xc_hvm_set_ioreq_server_state(xc, dom, ioservid, enable);
+    return xc_hvm_set_ioreq_server_state(xen_xc, dom, ioservid,
+                                         enable);
 }
 
 #endif
diff --git a/xen-common.c b/xen-common.c
index fd2c928..703e7a5 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -25,6 +25,9 @@
     do { } while (0)
 #endif
 
+xc_interface *xen_xc;
+xenforeignmemory_handle *xen_fmem;
+
 static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
     struct xs_handle *xs = NULL;
diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb..dbb8c66 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -454,10 +454,10 @@ static void xen_set_memory(struct MemoryListener *listener,
         return;
     } else {
         if (add) {
-            xen_map_memory_section(xen_xc, xen_domid, state->ioservid,
+            xen_map_memory_section(xen_domid, state->ioservid,
                                    section);
         } else {
-            xen_unmap_memory_section(xen_xc, xen_domid, state->ioservid,
+            xen_unmap_memory_section(xen_domid, state->ioservid,
                                      section);
         }
     }
@@ -521,7 +521,7 @@ static void xen_io_add(MemoryListener *listener,
 
     memory_region_ref(mr);
 
-    xen_map_io_section(xen_xc, xen_domid, state->ioservid, section);
+    xen_map_io_section(xen_domid, state->ioservid, section);
 }
 
 static void xen_io_del(MemoryListener *listener,
@@ -534,7 +534,7 @@ static void xen_io_del(MemoryListener *listener,
         return;
     }
 
-    xen_unmap_io_section(xen_xc, xen_domid, state->ioservid, section);
+    xen_unmap_io_section(xen_domid, state->ioservid, section);
 
     memory_region_unref(mr);
 }
@@ -547,7 +547,7 @@ static void xen_device_realize(DeviceListener *listener,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pci_dev = PCI_DEVICE(dev);
 
-        xen_map_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
+        xen_map_pcidev(xen_domid, state->ioservid, pci_dev);
     }
 }
 
@@ -559,7 +559,7 @@ static void xen_device_unrealize(DeviceListener *listener,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pci_dev = PCI_DEVICE(dev);
 
-        xen_unmap_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
+        xen_unmap_pcidev(xen_domid, state->ioservid, pci_dev);
     }
 }
 
@@ -1139,7 +1139,7 @@ static void xen_hvm_change_state_handler(void *opaque, int running,
         xen_main_loop_prepare(state);
     }
 
-    xen_set_ioreq_server_state(xen_xc, xen_domid,
+    xen_set_ioreq_server_state(xen_domid,
                                state->ioservid,
                                (rstate == RUN_STATE_RUNNING));
 }
@@ -1227,7 +1227,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    xen_create_ioreq_server(xen_xc, xen_domid, &state->ioservid);
+    xen_create_ioreq_server(xen_domid, &state->ioservid);
 
     state->exit.notify = xen_exit_notifier;
     qemu_add_exit_notifier(&state->exit);
@@ -1238,7 +1238,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     state->wakeup.notify = xen_wakeup_notifier;
     qemu_register_wakeup_notifier(&state->wakeup);
 
-    rc = xen_get_ioreq_server_info(xen_xc, xen_domid, state->ioservid,
+    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
                                    &ioreq_pfn, &bufioreq_pfn,
                                    &bufioreq_evtchn);
     if (rc < 0) {
@@ -1288,7 +1288,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     /* Note: cpus is empty at this point in init */
     state->cpu_by_vcpu_id = g_malloc0(max_cpus * sizeof(CPUState *));
 
-    rc = xen_set_ioreq_server_state(xen_xc, xen_domid, state->ioservid, true);
+    rc = xen_set_ioreq_server_state(xen_domid, state->ioservid, true);
     if (rc < 0) {
         error_report("failed to enable ioreq server info: error %d handle=%p",
                      errno, xen_xc);
-- 
2.1.4
