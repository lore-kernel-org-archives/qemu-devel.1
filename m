Received: from eggs.gnu.org ([2001:4830:134:3::10]:39033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfuo1-0001g5-UN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfuo0-00006W-O5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cfuo0-00006M-FU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F74B20923C
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:43:32 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 20 Feb 2017 22:43:13 +0200
Message-Id: <1487623393-2492-5-git-send-email-marcel@redhat.com>
In-Reply-To: <1487623393-2492-1-git-send-email-marcel@redhat.com>
References: <1487623393-2492-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 4/4] hw/virtio: fix Power Management Control
 Register for PCI Express virtio devices
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

Make Power Management State flag writable to conform
with the PCI Express spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/virtio/virtio-pci.c | 11 +++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 include/hw/compat.h    |  4 ++++
 include/hw/pci/pcie.h  |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1fb0a03..fb86e58 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1812,6 +1812,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
         pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF);
         assert(pos > 0);
+        pci_dev->exp.pm_cap = pos;
 
         /*
          * Indicates that this function complies with revision 1.2 of the
@@ -1829,6 +1830,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_lnkctl_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            /* Init Power Management Control Register */
+            pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
+                         PCI_PM_CTRL_STATE_MASK);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
             pcie_ats_init(pci_dev, 256);
         }
@@ -1873,6 +1880,8 @@ static void virtio_pci_reset(DeviceState *qdev)
     if (pci_is_express(dev)) {
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
+
+        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
     }
 }
 
@@ -1898,6 +1907,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
     DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 9b5dd5a..b095dfc 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -75,6 +75,7 @@ enum {
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
+    VIRTIO_PCI_FLAG_INIT_PM_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -108,6 +109,9 @@ enum {
 /* Init Link Control register */
 #define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT)
 
+/* Init Power Management */
+#define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 0931aa5..90606f9 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -30,6 +30,10 @@
         .driver   = "virtio-pci",\
         .property = "x-pcie-lnkctl-init",\
         .value    = "off",\
+    },{\
+        .driver   = "virtio-pci",\
+        .property = "x-pcie-pm-init",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_7 \
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 11c6247..3d8f24b 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -63,6 +63,8 @@ typedef enum {
 struct PCIExpressDevice {
     /* Offset of express capability in config space */
     uint8_t exp_cap;
+    /* Offset of Power Management capability in config space */
+    uint8_t pm_cap;
 
     /* SLOT */
     bool hpev_notified; /* Logical AND of conditions for hot plug event.
-- 
2.5.5
