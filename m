Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHys-0005kh-Jg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHym-0002Ij-OC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHym-0002Gy-Dn
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:20 -0500
Date: Tue, 18 Dec 2018 11:12:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-12-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/30] pci: Sync PCIe downstream port LNKSTA
 on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>, Eric Auger <eric.auger@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

The PCIe link speed and width between a downstream device and its
upstream port is negotiated on real hardware and susceptible to
dynamic changes due to signal issues and power management.  In the
emulated device case there is no real hardware link, but we still
might wish to have some consistency between endpoint and downstream
port via a virtual negotiation.  There is of course a real link for
assigned devices and this same virtual negotiation allows the
downstream port to match the endpoint, synchronizing on every read
to support underlying physical hardware dynamically adjusting the
link.

This negotiation is intentionally unidirectional for compatibility.
If the endpoint exceeds the capabilities of the downstream port or
there is no endpoint device, the downstream port reports negotiation
to its maximum speed and width, matching the previous case where
negotiation was absent.  De-tuning the endpoint to match a virtual
link doesn't seem to benefit anyone and is a condition we've thus
far reported without functional issues.

Note that PCI_EXP_LNKSTA is already ignored for migration
compatibility via pcie_cap_v1_fill().

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h  | 13 +++++++++++++
 include/hw/pci/pcie.h |  1 +
 hw/pci/pci.c          |  4 ++++
 hw/pci/pcie.c         | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bba23..eb12fa112e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -737,6 +737,19 @@ static inline int pci_is_express(const PCIDevice *d)
     return d->cap_present & QEMU_PCI_CAP_EXPRESS;
 }
 
+static inline int pci_is_express_downstream_port(const PCIDevice *d)
+{
+    uint8_t type;
+
+    if (!pci_is_express(d) || !d->exp.exp_cap) {
+        return 0;
+    }
+
+    type = pcie_cap_get_type(d);
+
+    return type == PCI_EXP_TYPE_DOWNSTREAM || type == PCI_EXP_TYPE_ROOT_PORT;
+}
+
 static inline uint32_t pci_config_size(const PCIDevice *d)
 {
     return pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b71e369703..1976909ab4 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -126,6 +126,7 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
+void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index efb5ce196f..d831fa0a36 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1353,6 +1353,10 @@ uint32_t pci_default_read_config(PCIDevice *d,
 {
     uint32_t val = 0;
 
+    if (pci_is_express_downstream_port(d) &&
+        ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
+        pcie_sync_bridge_lnk(d);
+    }
     memcpy(&val, d->config + address, len);
     return le32_to_cpu(val);
 }
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index aef84c665b..6891deb711 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -741,6 +741,45 @@ void pcie_add_capability(PCIDevice *dev,
     memset(dev->cmask + offset, 0xFF, size);
 }
 
+/*
+ * Sync the PCIe Link Status negotiated speed and width of a bridge with the
+ * downstream device.  If downstream device is not present, re-write with the
+ * Link Capability fields.  Limit width and speed to bridge capabilities for
+ * compatibility.  Use config_read to access the downstream device since it
+ * could be an assigned device with volatile link information.
+ */
+void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
+{
+    PCIBridge *br = PCI_BRIDGE(bridge_dev);
+    PCIBus *bus = pci_bridge_get_sec_bus(br);
+    PCIDevice *target = bus->devices[0];
+    uint8_t *exp_cap = bridge_dev->config + bridge_dev->exp.exp_cap;
+    uint16_t lnksta, lnkcap = pci_get_word(exp_cap + PCI_EXP_LNKCAP);
+
+    if (!target || !target->exp.exp_cap) {
+        lnksta = lnkcap;
+    } else {
+        lnksta = target->config_read(target,
+                                     target->exp.exp_cap + PCI_EXP_LNKSTA,
+                                     sizeof(lnksta));
+
+        if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
+            lnksta &= ~PCI_EXP_LNKSTA_NLW;
+            lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
+        }
+
+        if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
+            lnksta &= ~PCI_EXP_LNKSTA_CLS;
+            lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
+        }
+    }
+
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                 PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+    pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &
+                               (PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW));
+}
+
 /**************************************************************************
  * pci express extended capability helper functions
  */
-- 
MST
