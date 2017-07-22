Received: from eggs.gnu.org ([2001:4830:134:3::10]:59907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dD-0000Qi-UE
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dB-0006kf-HG
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:15 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2dB-0006kQ-9l
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:13 -0400
Received: by mail-lf0-x242.google.com with SMTP id x16so861235lfb.4
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:12:13 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:11:47 +0300
Message-Id: <1500761510-1556-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/4] pci: refactor pci_find_capapibilty
 to get bdf as the first argument instead of the whole pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Refactor pci_find_capability function to get bdf instead of
a whole pci_device* as the only necessary field for this function 
is still bdf.
It greatly helps when we have bdf but not pci_device.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/pciinit.c    |  4 ++--
 src/hw/pcidevice.c  | 12 ++++++------
 src/hw/pcidevice.h  |  2 +-
 src/hw/virtio-pci.c |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

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
diff --git a/src/hw/pcidevice.c b/src/hw/pcidevice.c
index cfebf66..d01e27b 100644
--- a/src/hw/pcidevice.c
+++ b/src/hw/pcidevice.c
@@ -134,25 +134,25 @@ pci_find_init_device(const struct pci_device_id *ids, void *arg)
     return NULL;
 }
 
-u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap)
+u8 pci_find_capability(u16 bdf, u8 cap_id, u8 cap)
 {
     int i;
-    u16 status = pci_config_readw(pci->bdf, PCI_STATUS);
+    u16 status = pci_config_readw(bdf, PCI_STATUS);
 
     if (!(status & PCI_STATUS_CAP_LIST))
         return 0;
 
     if (cap == 0) {
         /* find first */
-        cap = pci_config_readb(pci->bdf, PCI_CAPABILITY_LIST);
+        cap = pci_config_readb(bdf, PCI_CAPABILITY_LIST);
     } else {
         /* find next */
-        cap = pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_NEXT);
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
     }
     for (i = 0; cap && i <= 0xff; i++) {
-        if (pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_ID) == cap_id)
+        if (pci_config_readb(bdf, cap + PCI_CAP_LIST_ID) == cap_id)
             return cap;
-        cap = pci_config_readb(pci->bdf, cap + PCI_CAP_LIST_NEXT);
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
     }
 
     return 0;
diff --git a/src/hw/pcidevice.h b/src/hw/pcidevice.h
index 354b549..adcc75a 100644
--- a/src/hw/pcidevice.h
+++ b/src/hw/pcidevice.h
@@ -69,7 +69,7 @@ int pci_init_device(const struct pci_device_id *ids
                     , struct pci_device *pci, void *arg);
 struct pci_device *pci_find_init_device(const struct pci_device_id *ids
                                         , void *arg);
-u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap);
+u8 pci_find_capability(u16 bdf, u8 cap_id, u8 cap);
 void pci_enable_busmaster(struct pci_device *pci);
 u16 pci_enable_iobar(struct pci_device *pci, u32 addr);
 void *pci_enable_membar(struct pci_device *pci, u32 addr);
diff --git a/src/hw/virtio-pci.c b/src/hw/virtio-pci.c
index e5c2c33..4e33033 100644
--- a/src/hw/virtio-pci.c
+++ b/src/hw/virtio-pci.c
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
