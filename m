Received: from eggs.gnu.org ([2001:4830:134:3::10]:48840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFv-0000HX-F5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFu-00017D-C0
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:11 -0400
Received: from mail.kernel.org ([198.145.29.136]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFu-00016Y-2e
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:10 -0400
Date: Thu, 16 Mar 2017 04:35:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489631689-6382-4-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] hw/virtio: fix Link Control Register for
 PCI Express virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

Make several Link Control Register flags writable to conform
with the PCI Express spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h |  4 ++++
 include/hw/compat.h    |  4 ++++
 include/hw/pci/pcie.h  |  3 +++
 hw/pci/pcie.c          | 14 ++++++++++++++
 hw/virtio/virtio-pci.c |  8 ++++++++
 5 files changed, 33 insertions(+)

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
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 82a8902..18e634f 100644
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
index f6de5ee..300aa4a 100644
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
@@ -1871,6 +1876,7 @@ static void virtio_pci_reset(DeviceState *qdev)
 
     if (pci_is_express(dev)) {
         pcie_cap_deverr_reset(dev);
+        pcie_cap_lnkctl_reset(dev);
     }
 }
 
@@ -1894,6 +1900,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST
