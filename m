Received: from eggs.gnu.org ([2001:4830:134:3::10]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diTy5-0005JX-PM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diTy1-0006zd-Eg
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:49 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1diTy1-0006zK-2l
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:45 -0400
Received: by mail-lf0-x243.google.com with SMTP id y15so5220472lfd.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:12:45 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 18 Aug 2017 02:12:29 +0300
Message-Id: <1503011551-7246-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1503011551-7246-1-git-send-email-zuban32s@gmail.com>
References: <1503011551-7246-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v7 1/3] pci: refactor pci_find_capapibilty to
 get bdf as the first argument instead of the whole pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, mst@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Refactor pci_find_capability function to get bdf instead of
a whole pci_device* as the only necessary field for this function
is still bdf.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 src/fw/pciinit.c    |  4 ++--
 src/hw/pci.c        | 25 +++++++++++++++++++++++++
 src/hw/pci.h        |  1 +
 src/hw/pcidevice.c  | 24 ------------------------
 src/hw/pcidevice.h  |  1 -
 src/hw/virtio-pci.c |  6 +++---
 6 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 08221e6..864954f 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -762,7 +762,7 @@ static int pci_bus_hotplug_support(struct pci_bus *bus, u8 pcie_cap)
         return downstream_port && slot_implemented;
     }
 
-    shpc_cap = pci_find_capability(bus->bus_dev, PCI_CAP_ID_SHPC, 0);
+    shpc_cap = pci_find_capability(bus->bus_dev->bdf, PCI_CAP_ID_SHPC, 0);
     return !!shpc_cap;
 }
 
@@ -844,7 +844,7 @@ static int pci_bios_check_devices(struct pci_bus *busses)
              */
             parent = &busses[0];
         int type;
-        u8 pcie_cap = pci_find_capability(s->bus_dev, PCI_CAP_ID_EXP, 0);
+        u8 pcie_cap = pci_find_capability(s->bus_dev->bdf, PCI_CAP_ID_EXP, 0);
         int hotplug_support = pci_bus_hotplug_support(s, pcie_cap);
         for (type = 0; type < PCI_REGION_TYPE_COUNT; type++) {
             u64 align = (type == PCI_REGION_TYPE_IO) ?
diff --git a/src/hw/pci.c b/src/hw/pci.c
index 8e3d617..50d9d2d 100644
--- a/src/hw/pci.c
+++ b/src/hw/pci.c
@@ -58,6 +58,30 @@ pci_config_maskw(u16 bdf, u32 addr, u16 off, u16 on)
     pci_config_writew(bdf, addr, val);
 }
 
+u8 pci_find_capability(u16 bdf, u8 cap_id, u8 cap)
+{
+    int i;
+    u16 status = pci_config_readw(bdf, PCI_STATUS);
+
+    if (!(status & PCI_STATUS_CAP_LIST))
+        return 0;
+
+    if (cap == 0) {
+        /* find first */
+        cap = pci_config_readb(bdf, PCI_CAPABILITY_LIST);
+    } else {
+        /* find next */
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
+    }
+    for (i = 0; cap && i <= 0xff; i++) {
+        if (pci_config_readb(bdf, cap + PCI_CAP_LIST_ID) == cap_id)
+            return cap;
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
+    }
+
+    return 0;
+}
+
 // Helper function for foreachbdf() macro - return next device
 int
 pci_next(int bdf, int bus)
@@ -107,3 +131,4 @@ pci_reboot(void)
     outb(v|6, PORT_PCI_REBOOT); /* Actually do the reset */
     udelay(50);
 }
+
diff --git a/src/hw/pci.h b/src/hw/pci.h
index ee6e196..2e30e28 100644
--- a/src/hw/pci.h
+++ b/src/hw/pci.h
@@ -39,6 +39,7 @@ u32 pci_config_readl(u16 bdf, u32 addr);
 u16 pci_config_readw(u16 bdf, u32 addr);
 u8 pci_config_readb(u16 bdf, u32 addr);
 void pci_config_maskw(u16 bdf, u32 addr, u16 off, u16 on);
+u8 pci_find_capability(u16 bdf, u8 cap_id, u8 cap);
 int pci_next(int bdf, int bus);
 int pci_probe_host(void);
 void pci_reboot(void);
diff --git a/src/hw/pcidevice.c b/src/hw/pcidevice.c
index cfebf66..8853cf7 100644
--- a/src/hw/pcidevice.c
+++ b/src/hw/pcidevice.c
@@ -134,30 +134,6 @@ pci_find_init_device(const struct pci_device_id *ids, void *arg)
     return NULL;
 }
 
-u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap)
-{
-    int i;
-    u16 status = pci_config_readw(pci->bdf, PCI_STATUS);
-
-    if (!(status & PCI_STATUS_CAP_LIST))
-        return 0;
-
-    if (cap == 0) {
-        /* find first */
-        cap = pci_config_readb(pci->bdf, PCI_CAPABILITY_LIST);
-    } else {
-        /* find next */
-        cap = pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_NEXT);
-    }
-    for (i = 0; cap && i <= 0xff; i++) {
-        if (pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_ID) == cap_id)
-            return cap;
-        cap = pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_NEXT);
-    }
-
-    return 0;
-}
-
 // Enable PCI bus-mastering (ie, DMA) support on a pci device
 void
 pci_enable_busmaster(struct pci_device *pci)
diff --git a/src/hw/pcidevice.h b/src/hw/pcidevice.h
index 354b549..225d545 100644
--- a/src/hw/pcidevice.h
+++ b/src/hw/pcidevice.h
@@ -69,7 +69,6 @@ int pci_init_device(const struct pci_device_id *ids
                     , struct pci_device *pci, void *arg);
 struct pci_device *pci_find_init_device(const struct pci_device_id *ids
                                         , void *arg);
-u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap);
 void pci_enable_busmaster(struct pci_device *pci);
 u16 pci_enable_iobar(struct pci_device *pci, u32 addr);
 void *pci_enable_membar(struct pci_device *pci, u32 addr);
diff --git a/src/hw/virtio-pci.c b/src/hw/virtio-pci.c
index e5c2c33..96f9c6b 100644
--- a/src/hw/virtio-pci.c
+++ b/src/hw/virtio-pci.c
@@ -19,7 +19,7 @@
 #include "malloc.h" // free
 #include "output.h" // dprintf
 #include "pci.h" // pci_config_readl
-#include "pcidevice.h" // pci_find_capability
+#include "pcidevice.h" // struct pci_device
 #include "pci_regs.h" // PCI_BASE_ADDRESS_0
 #include "string.h" // memset
 #include "virtio-pci.h"
@@ -381,7 +381,7 @@ fail:
 
 void vp_init_simple(struct vp_device *vp, struct pci_device *pci)
 {
-    u8 cap = pci_find_capability(pci, PCI_CAP_ID_VNDR, 0);
+    u8 cap = pci_find_capability(pci->bdf, PCI_CAP_ID_VNDR, 0);
     struct vp_cap *vp_cap;
     const char *mode;
     u32 offset, base, mul;
@@ -479,7 +479,7 @@ void vp_init_simple(struct vp_device *vp, struct pci_device *pci)
                     vp_cap->cap, type, vp_cap->bar, addr, offset, mode);
         }
 
-        cap = pci_find_capability(pci, PCI_CAP_ID_VNDR, cap);
+        cap = pci_find_capability(pci->bdf, PCI_CAP_ID_VNDR, cap);
     }
 
     if (vp->common.cap && vp->notify.cap && vp->isr.cap && vp->device.cap) {
-- 
2.7.4
