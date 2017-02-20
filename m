Received: from eggs.gnu.org ([2001:4830:134:3::10]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfuny-0001dq-Li
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfunx-00005t-Su
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cfunx-00005h-K0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF87580473
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:43:29 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 20 Feb 2017 22:43:12 +0200
Message-Id: <1487623393-2492-4-git-send-email-marcel@redhat.com>
In-Reply-To: <1487623393-2492-1-git-send-email-marcel@redhat.com>
References: <1487623393-2492-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 3/4] hw/virtio: fix Link Control Register
 for PCI Express virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

Make several Link Control Register flags writable to conform
with the PCI Express spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pcie.c          | 14 ++++++++++++++
 hw/virtio/virtio-pci.c |  8 ++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 include/hw/compat.h    |  4 ++++
 include/hw/pci/pcie.h  |  3 +++
 5 files changed, 33 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 2526e3a..1804163 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -223,6 +223,20 @@ void pcie_cap_deverr_reset(PCIDevice *dev)
                                  PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
 }
 
+void pcie_cap_lnkctl_init(PCIDevice *dev)
+{
+    uint32_t pos = dev->exp.exp_cap;
+    pci_long_test_and_set_mask(dev->wmask + pos + PCI_EXP_LNKCTL,
+                               PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKCTL_ES);
+}
+
+void pcie_cap_lnkctl_reset(PCIDevice *dev)
+{
+    uint8_t *lnkctl = dev->config + dev->exp.exp_cap + PCI_EXP_LNKCTL;
+    pci_long_test_and_clear_mask(lnkctl,
+                                 PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKCTL_ES);
+}
+
 static void hotplug_event_update_event_status(PCIDevice *dev)
 {
     uint32_t pos = dev->exp.exp_cap;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9e2bca6..1fb0a03 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1824,6 +1824,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_deverr_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
+            /* Init Link Control Register */
+            pcie_cap_lnkctl_init(pci_dev);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
             pcie_ats_init(pci_dev, 256);
         }
@@ -1867,6 +1872,7 @@ static void virtio_pci_reset(DeviceState *qdev)
 
     if (pci_is_express(dev)) {
         pcie_cap_deverr_reset(dev);
+        pcie_cap_lnkctl_reset(dev);
     }
 }
 
@@ -1890,6 +1896,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 120661d..9b5dd5a 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -74,6 +74,7 @@ enum {
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
+    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -104,6 +105,9 @@ enum {
 /* Init error enabling flags */
 #define VIRTIO_PCI_FLAG_INIT_DEVERR (1 << VIRTIO_PCI_FLAG_INIT_DEVERR_BIT)
 
+/* Init Link Control register */
+#define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
diff --git a/include/hw/compat.h b/include/hw/compat.h
index c98776a..0931aa5 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -26,6 +26,10 @@
         .driver   = "virtio-pci",\
         .property = "x-pcie-deverr-init",\
         .value    = "off",\
+    },{\
+        .driver   = "virtio-pci",\
+        .property = "x-pcie-lnkctl-init",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_7 \
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 163c519..11c6247 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -96,6 +96,9 @@ uint8_t pcie_cap_flags_get_vector(PCIDevice *dev);
 void pcie_cap_deverr_init(PCIDevice *dev);
 void pcie_cap_deverr_reset(PCIDevice *dev);
 
+void pcie_cap_lnkctl_init(PCIDevice *dev);
+void pcie_cap_lnkctl_reset(PCIDevice *dev);
+
 void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
 void pcie_cap_slot_reset(PCIDevice *dev);
 void pcie_cap_slot_write_config(PCIDevice *dev,
-- 
2.5.5
