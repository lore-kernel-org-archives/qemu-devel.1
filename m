Received: from eggs.gnu.org ([2001:4830:134:3::10]:39273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAFpr-0006kC-KC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAFpn-0005md-JS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dAFpn-0005m9-AW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B61CC059730
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:14:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 May 2017 21:14:33 +0800
Message-Id: <1494854073-19898-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

MSI should be supported by all interrupt controllers. Switching the old
check for msi_nonbroken into assertion. Do similar thing to
pci_add_capability2() below that. Then time to remove *errp.

Since msi_init() won't fail now, touch up all the callers to avoid
checks against it. One side effect is that we fixed a possible leak in
current edu device.

Reported-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/audio/intel-hda.c               | 18 +-----------------
 hw/i386/amd_iommu.c                |  2 +-
 hw/ide/ich.c                       |  6 +-----
 hw/misc/edu.c                      |  4 +---
 hw/net/e1000e.c                    |  6 +-----
 hw/net/trace-events                |  1 -
 hw/net/vmxnet3.c                   |  8 ++------
 hw/pci-bridge/ioh3420.c            | 17 ++++-------------
 hw/pci-bridge/pci_bridge_dev.c     | 19 +------------------
 hw/pci-bridge/xio3130_downstream.c | 11 +++--------
 hw/pci-bridge/xio3130_upstream.c   | 11 +++--------
 hw/pci/msi.c                       | 25 ++++++-------------------
 hw/scsi/megasas.c                  | 18 +-----------------
 hw/scsi/mptsas.c                   | 20 ++------------------
 hw/scsi/trace-events               |  1 -
 hw/scsi/vmw_pvscsi.c               | 12 +++---------
 hw/usb/hcd-xhci.c                  | 16 +---------------
 hw/vfio/pci.c                      | 13 ++-----------
 include/hw/pci/msi.h               |  6 +++---
 19 files changed, 36 insertions(+), 178 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 537face..cdbef63 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1133,8 +1133,6 @@ static void intel_hda_realize(PCIDevice *pci, Error **errp)
 {
     IntelHDAState *d = INTEL_HDA(pci);
     uint8_t *conf = d->pci.config;
-    Error *err = NULL;
-    int ret;
 
     d->name = object_get_typename(OBJECT(d));
 
@@ -1144,21 +1142,7 @@ static void intel_hda_realize(PCIDevice *pci, Error **errp)
     conf[0x40] = 0x01;
 
     if (d->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(&d->pci, d->old_msi_addr ? 0x50 : 0x60,
-                       1, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && d->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        }
-        assert(!err || d->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
+        msi_init(&d->pci, d->old_msi_addr ? 0x50 : 0x60, 1, true, false);
     }
 
     memory_region_init_io(&d->mmio, OBJECT(d), &intel_hda_mmio_ops, d,
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40a..91405b0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1161,7 +1161,7 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
     pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
     s->devid = object_property_get_int(OBJECT(&s->pci), "addr", err);
-    msi_init(&s->pci.dev, 0, 1, true, false, err);
+    msi_init(&s->pci.dev, 0, 1, true, false);
     amdvi_init(s);
 }
 
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 4599169..c18ad3a 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -110,7 +110,6 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     int sata_cap_offset;
     uint8_t *sata_cap;
     d = ICH_AHCI(dev);
-    int ret;
 
     ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev), 6);
 
@@ -146,10 +145,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     /* Although the AHCI 1.3 specification states that the first capability
      * should be PMCAP, the Intel ICH9 data sheet specifies that the ICH9
      * AHCI device puts the MSI capability first, pointing to 0x80. */
-    ret = msi_init(dev, ICH9_MSI_CAP_OFFSET, 1, true, false, NULL);
-    /* Any error other than -ENOTSUP(board's MSI support is broken)
-     * is a programming error.  Fall back to INTx silently on -ENOTSUP */
-    assert(!ret || ret == -ENOTSUP);
+    msi_init(dev, ICH9_MSI_CAP_OFFSET, 1, true, false);
 }
 
 static void pci_ich9_uninit(PCIDevice *dev)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 401039c..56bf2a3 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -352,9 +352,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     pci_config_set_interrupt_pin(pci_conf, 1);
 
-    if (msi_init(pdev, 0, 1, true, false, errp)) {
-        return;
-    }
+    msi_init(pdev, 0, 1, true, false);
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 << 20);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6e23493..feaba7c 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -412,7 +412,6 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     static const uint16_t e1000e_dsn_offset =  0x140;
     E1000EState *s = E1000E(pci_dev);
     uint8_t *macaddr;
-    int ret;
 
     trace_e1000e_cb_pci_realize();
 
@@ -462,10 +461,7 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize PCIe capability");
     }
 
-    ret = msi_init(PCI_DEVICE(s), 0xD0, 1, true, false, NULL);
-    if (ret) {
-        trace_e1000e_msi_init_fail(ret);
-    }
+    msi_init(PCI_DEVICE(s), 0xD0, 1, true, false);
 
     if (e1000e_add_pm_capability(pci_dev, e1000e_pmrb_offset,
                                   PCI_PM_CAP_DSI) < 0) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c714805..39aa47f 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -254,7 +254,6 @@ e1000e_wrn_io_addr_undefined(uint64_t addr) "IO undefined register 0x%"PRIx64
 e1000e_wrn_io_addr_flash(uint64_t addr) "IO flash access (0x%"PRIx64") not implemented"
 e1000e_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 
-e1000e_msi_init_fail(int32_t res) "Failed to initialize MSI, error %d"
 e1000e_msix_init_fail(int32_t res) "Failed to initialize MSI-X, error %d"
 e1000e_msix_use_vector_fail(uint32_t vec, int32_t res) "Failed to use MSI-X vector %d, error %d"
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8b1fab2..4425ab6 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2286,7 +2286,6 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     DeviceState *dev = DEVICE(pci_dev);
     VMXNET3State *s = VMXNET3(pci_dev);
-    int ret;
 
     VMW_CBPRN("Starting init...");
 
@@ -2310,11 +2309,8 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
     /* Interrupt pin A */
     pci_dev->config[PCI_INTERRUPT_PIN] = 0x01;
 
-    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
-                   VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK, NULL);
-    /* Any error other than -ENOTSUP(board's MSI support is broken)
-     * is a programming error. Fall back to INTx silently on -ENOTSUP */
-    assert(!ret || ret == -ENOTSUP);
+    msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
+             VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK);
 
     if (!vmxnet3_init_msix(s)) {
         VMW_WRPRN("Failed to initialize MSI-X, configuration is inconsistent.");
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index da4e5bd..2945abc 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -63,19 +63,10 @@ static uint8_t ioh3420_aer_vector(const PCIDevice *d)
 
 static int ioh3420_interrupts_init(PCIDevice *d, Error **errp)
 {
-    int rc;
-    Error *local_err = NULL;
-
-    rc = msi_init(d, IOH_EP_MSI_OFFSET, IOH_EP_MSI_NR_VECTOR,
-                  IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
-                  &local_err);
-    if (rc < 0) {
-        assert(rc == -ENOTSUP);
-        error_propagate(errp, local_err);
-    }
-
-    return rc;
+    msi_init(d, IOH_EP_MSI_OFFSET, IOH_EP_MSI_NR_VECTOR,
+             IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+             IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT);
+    return 0;
 }
 
 static void ioh3420_interrupts_uninit(PCIDevice *d)
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 647ad80..71e595e 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -54,7 +54,6 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
     PCIBridge *br = PCI_BRIDGE(dev);
     PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
     int err;
-    Error *local_err = NULL;
 
     pci_bridge_initfn(dev, TYPE_PCI_BUS);
 
@@ -78,21 +77,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
 
     if (bridge_dev->msi != ON_OFF_AUTO_OFF) {
         /* it means SHPC exists, because MSI is needed by SHPC */
-
-        err = msi_init(dev, 0, 1, true, true, &local_err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!err || err == -ENOTSUP);
-        if (err && bridge_dev->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&local_err, "You have to use msi=auto (default) "
-                    "or msi=off with this machine type.\n");
-            error_report_err(local_err);
-            goto msi_error;
-        }
-        assert(!local_err || bridge_dev->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(local_err);
+        msi_init(dev, 0, 1, true, true);
     }
 
     if (shpc_present(dev)) {
@@ -103,8 +88,6 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
     }
     return 0;
 
-msi_error:
-    slotid_cap_cleanup(dev);
 slotid_error:
     if (shpc_present(dev)) {
         shpc_cleanup(dev, &bridge_dev->bar);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index cfe8a36..71a2d7d 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -66,14 +66,9 @@ static int xio3130_downstream_initfn(PCIDevice *d)
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
-    rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT, &err);
-    if (rc < 0) {
-        assert(rc == -ENOTSUP);
-        error_report_err(err);
-        goto err_bridge;
-    }
+    msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
+             XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+             XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT);
 
     rc = pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
                                XIO3130_SSVID_SVID, XIO3130_SSVID_SSID);
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 401c784..e45ad03 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -62,14 +62,9 @@ static int xio3130_upstream_initfn(PCIDevice *d)
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
-    rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT, &err);
-    if (rc < 0) {
-        assert(rc == -ENOTSUP);
-        error_report_err(err);
-        goto err_bridge;
-    }
+    msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
+             XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+             XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT);
 
     rc = pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
                                XIO3130_SSVID_SVID, XIO3130_SSVID_SSID);
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..6b1fc8b 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -174,27 +174,18 @@ bool msi_enabled(const PCIDevice *dev)
  * If @msi64bit, make the device capable of sending a 64-bit message
  * address.
  * If @msi_per_vector_mask, make the device support per-vector masking.
- * @errp is for returning errors.
- * Return 0 on success; set @errp and return -errno on error.
  *
- * -ENOTSUP means lacking msi support for a msi-capable platform.
- * -EINVAL means capability overlap, happens when @offset is non-zero,
- *  also means a programming error, except device assignment, which can check
- *  if a real HW is broken.
+ * This function never fails.
  */
-int msi_init(struct PCIDevice *dev, uint8_t offset,
-             unsigned int nr_vectors, bool msi64bit,
-             bool msi_per_vector_mask, Error **errp)
+void msi_init(struct PCIDevice *dev, uint8_t offset, unsigned int nr_vectors,
+              bool msi64bit, bool msi_per_vector_mask)
 {
     unsigned int vectors_order;
     uint16_t flags;
     uint8_t cap_size;
     int config_offset;
 
-    if (!msi_nonbroken) {
-        error_setg(errp, "MSI is not supported by interrupt controller");
-        return -ENOTSUP;
-    }
+    assert(msi_nonbroken);
 
     MSI_DEV_PRINTF(dev,
                    "init offset: 0x%"PRIx8" vector: %"PRId8
@@ -217,10 +208,8 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
 
     cap_size = msi_cap_sizeof(flags);
     config_offset = pci_add_capability2(dev, PCI_CAP_ID_MSI, offset,
-                                        cap_size, errp);
-    if (config_offset < 0) {
-        return config_offset;
-    }
+                                        cap_size, NULL);
+    assert(config_offset >= 0);
 
     dev->msi_cap = config_offset;
     dev->cap_present |= QEMU_PCI_CAP_MSI;
@@ -240,8 +229,6 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
         pci_set_long(dev->wmask + msi_mask_off(dev, msi64bit),
                      0xffffffff >> (PCI_MSI_VECTORS_MAX - nr_vectors));
     }
-
-    return 0;
 }
 
 void msi_uninit(struct PCIDevice *dev)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf..9199d5c 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2329,8 +2329,6 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     MegasasBaseClass *b = MEGASAS_DEVICE_GET_CLASS(s);
     uint8_t *pci_conf;
     int i, bar_type;
-    Error *err = NULL;
-    int ret;
 
     pci_conf = dev->config;
 
@@ -2340,21 +2338,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
 
     if (s->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x50, 1, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && s->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        } else if (ret) {
-            /* With msi=auto, we fall back to MSI off silently */
-            s->msi = ON_OFF_AUTO_OFF;
-            error_free(err);
-        }
+        msi_init(dev, 0x50, 1, true, false);
     }
 
     memory_region_init_io(&s->mmio_io, OBJECT(s), &megasas_mmio_ops, s,
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 765ab53..e371ee4 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1272,30 +1272,14 @@ static const struct SCSIBusInfo mptsas_scsi_info = {
 static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
 {
     MPTSASState *s = MPT_SAS(dev);
-    Error *err = NULL;
-    int ret;
 
     dev->config[PCI_LATENCY_TIMER] = 0;
     dev->config[PCI_INTERRUPT_PIN] = 0x01;
 
     if (s->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0, 1, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && s->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        }
-        assert(!err || s->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
-
+        msi_init(dev, 0, 1, true, false);
         /* Only used for migration.  */
-        s->msi_in_use = (ret == 0);
+        s->msi_in_use = true;
     }
 
     memory_region_init_io(&s->mmio_io, OBJECT(s), &mptsas_mmio_ops, s,
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 4a2e5d6..491ccd2 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -148,7 +148,6 @@ pvscsi_io_write(const char* cmd, uint64_t val) "%s write: %"PRIx64
 pvscsi_io_write_unknown(unsigned long addr, unsigned sz, uint64_t val) "unknown write address: 0x%lx size: %u bytes value: 0x%"PRIx64
 pvscsi_io_read(const char* cmd, uint64_t status) "%s read: 0x%"PRIx64
 pvscsi_io_read_unknown(unsigned long addr, unsigned sz) "unknown read address: 0x%lx size: %u bytes"
-pvscsi_init_msi_fail(int res) "failed to initialize MSI, error %d"
 pvscsi_state(const char* state) "starting %s ..."
 pvscsi_tx_rings_ppn(const char* label, uint64_t ppn) "%s page: %"PRIx64
 pvscsi_tx_rings_num_pages(const char* label, uint32_t num) "Number of %s pages: %u"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7557546..8e93ada 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1061,17 +1061,11 @@ pvscsi_io_read(void *opaque, hwaddr addr, unsigned size)
 static void
 pvscsi_init_msi(PVSCSIState *s)
 {
-    int res;
     PCIDevice *d = PCI_DEVICE(s);
 
-    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
-                   PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
-    if (res < 0) {
-        trace_pvscsi_init_msi_fail(res);
-        s->msi_used = false;
-    } else {
-        s->msi_used = true;
-    }
+    msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
+             PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK);
+    s->msi_used = true;
 }
 
 static void
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a2d3143..46018c4 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3540,7 +3540,6 @@ static void usb_xhci_init(XHCIState *xhci)
 static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
 {
     int i, ret;
-    Error *err = NULL;
 
     XHCIState *xhci = XHCI(dev);
 
@@ -3574,20 +3573,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (xhci->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, xhci->numintrs, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && xhci->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        }
-        assert(!err || xhci->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
+        msi_init(dev, 0x70, xhci->numintrs, true, false);
     }
 
     usb_xhci_init(xhci);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d01..7d34768 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1251,8 +1251,7 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     uint16_t ctrl;
     bool msi_64bit, msi_maskbit;
-    int ret, entries;
-    Error *err = NULL;
+    int entries;
 
     if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
               vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
@@ -1267,15 +1266,7 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
     trace_vfio_msi_setup(vdev->vbasedev.name, pos);
 
-    ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
-    if (ret < 0) {
-        if (ret == -ENOTSUP) {
-            return 0;
-        }
-        error_prepend(&err, "msi_init failed: ");
-        error_propagate(errp, err);
-        return ret;
-    }
+    msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit);
     vdev->msi_cap_size = 0xa + (msi_maskbit ? 0xa : 0) + (msi_64bit ? 0x4 : 0);
 
     return 0;
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index 4837bcf..1cb23a4 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -34,9 +34,9 @@ extern bool msi_nonbroken;
 void msi_set_message(PCIDevice *dev, MSIMessage msg);
 MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector);
 bool msi_enabled(const PCIDevice *dev);
-int msi_init(struct PCIDevice *dev, uint8_t offset,
-             unsigned int nr_vectors, bool msi64bit,
-             bool msi_per_vector_mask, Error **errp);
+void msi_init(struct PCIDevice *dev, uint8_t offset,
+              unsigned int nr_vectors, bool msi64bit,
+              bool msi_per_vector_mask);
 void msi_uninit(struct PCIDevice *dev);
 void msi_reset(PCIDevice *dev);
 void msi_notify(PCIDevice *dev, unsigned int vector);
-- 
2.7.4
