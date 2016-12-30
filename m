Received: from eggs.gnu.org ([2001:4830:134:3::10]:51017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8e-0001Lq-83
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8b-0005iv-08
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8a-0005ii-MZ
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:12 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:15 +0800
Message-Id: <1483092559-24488-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 06/10] virtio-pci: address space translation
 service (ATS) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>

This patches enable the Address Translation Service support for virtio
pci devices. This is needed for a guest visible Device IOTLB
implementation and will be required by vhost device IOTLB API
implementation for intel IOMMU.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/pci/pcie.c                             | 16 ++++++++++++++++
 hw/virtio/virtio-pci.c                    |  7 +++++++
 hw/virtio/virtio-pci.h                    |  4 ++++
 include/hw/pci/pcie.h                     |  4 ++++
 include/standard-headers/linux/pci_regs.h |  1 +
 5 files changed, 32 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 99cfb45..02195d9 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -717,3 +717,19 @@ void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num)
                         PCI_EXT_CAP_DSN_SIZEOF);
     pci_set_quad(dev->config + offset + pci_dsn_cap, ser_num);
 }
+
+void pcie_ats_init(PCIDevice *dev, uint16_t offset)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_ATS, 0x1,
+                        offset, PCI_EXT_CAP_ATS_SIZEOF);
+
+    dev->exp.ats_cap = offset;
+
+    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
+    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
+    /* STU 0, Disabled by default */
+    pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
+
+    pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
+}
+
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 213d57e..854b8f2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1815,6 +1815,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
          * PCI Power Management Interface Specification.
          */
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
+
+        if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
+            pcie_ats_init(pci_dev, 256);
+        }
+
     } else {
         /*
          * make future invocations of pci_is_express() return false
@@ -1868,6 +1873,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
                      ignore_backend_features, false),
+    DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 5e07886..d00064c 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -72,6 +72,7 @@ enum {
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
+    VIRTIO_PCI_FLAG_ATS_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -96,6 +97,9 @@ enum {
 #define VIRTIO_PCI_FLAG_PAGE_PER_VQ \
     (1 << VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT)
 
+/* address space translation service */
+#define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 056d25e..b08451d 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -74,6 +74,9 @@ struct PCIExpressDevice {
     /* AER */
     uint16_t aer_cap;
     PCIEAERLog aer_log;
+
+    /* Offset of ATS capability in config space */
+    uint16_t ats_cap;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -120,6 +123,7 @@ void pcie_add_capability(PCIDevice *dev,
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
+void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
 extern const VMStateDescription vmstate_pcie_device;
 
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index e5a2e68..be5b066 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -678,6 +678,7 @@
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
+#define PCI_EXT_CAP_ATS_SIZEOF	8
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
 
 /* Advanced Error Reporting */
-- 
2.7.4
