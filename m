Received: from eggs.gnu.org ([2001:4830:134:3::10]:52795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVRC-0007mO-6t
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVR8-00036P-VM
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dzVR8-00035j-Lw
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C78F0356D9
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 22:13:09 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 03 Oct 2017 16:13:07 -0600
Message-ID: <20171003221257.17156.88241.stgit@gimli.home>
In-Reply-To: <20171003221012.17156.23559.stgit@gimli.home>
References: <20171003221012.17156.23559.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/3] vfio/pci: Add NVIDIA GPUDirect Cliques
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

NVIDIA has defined a specification for creating GPUDirect "cliques",
where devices with the same clique ID support direct peer-to-peer DMA.
When running on bare-metal, tools like NVIDIA's p2pBandwidthLatencyTest
(part of cuda-samples) determine which GPUs can support peer-to-peer
based on chipset and topology.  When running in a VM, these tools have
no visibility to the physical hardware support or topology.  This
option allows the user to specify hints via a vendor defined
capability.  For instance:

  <qemu:commandline>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev0.x-nv-gpudirect-clique=0'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev1.x-nv-gpudirect-clique=1'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev2.x-nv-gpudirect-clique=1'/>
  </qemu:commandline>

This enables two cliques.  The first is a singleton clique with ID 0,
for the first hostdev defined in the XML (note that since cliques
define peer-to-peer sets, singleton clique offer no benefit).  The
subsequent two hostdevs are both added to clique ID 1, indicating
peer-to-peer is possible between these devices.

QEMU only provides validation that the clique ID is valid and applied
to an NVIDIA graphics device, any validation that the resulting
cliques are functional and valid is the user's responsibility.  The
NVIDIA specification allows a 4-bit clique ID, thus valid values are
0-15.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |    5 ++
 hw/vfio/pci.h        |    3 +
 3 files changed, 118 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 40aaae76feb9..14291c2a16b2 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "trace.h"
@@ -1850,7 +1851,116 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
         break;
     }
 }
+
+/*
+ * The NVIDIA GPUDirect P2P Vendor capability allows the user to specify
+ * devices as a member of a clique.  Devices within the same clique ID
+ * are capable of direct P2P.  It's the user's responsibility that this
+ * is correct.  The spec says that this may reside at any unused config
+ * offset, but reserves and recommends hypervisors place this at C8h.
+ * The spec also states that the hypervisor should place this capability
+ * at the end of the capability list, thus next is defined as 0h.
+ *
+ * +----------------+----------------+----------------+----------------+
+ * | sig 7:0 ('P')  |  vndr len (8h) |    next (0h)   |   cap id (9h)  |
+ * +----------------+----------------+----------------+----------------+
+ * | rsvd 15:7(0h),id 6:3,ver 2:0(0h)|          sig 23:8 ('P2')        |
+ * +---------------------------------+---------------------------------+
+ *
+ * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
+ */
+static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
+
+    visit_type_uint8(v, name, ptr, errp);
+}
+
+static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint8_t value, *ptr = qdev_get_prop_ptr(dev, prop);
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_uint8(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (value & ~0xF) {
+        error_setg(errp, "Property %s: valid range 0-15", name);
+        return;
+    }
+
+    *ptr = value;
+}
+
+const PropertyInfo qdev_prop_nv_gpudirect_clique = {
+    .name = "uint4",
+    .description = "NVIDIA GPUDirect Clique ID (0 - 15)",
+    .get = get_nv_gpudirect_clique_id,
+    .set = set_nv_gpudirect_clique_id,
+};
+
+static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    int ret, pos = 0xC8;
+
+    if (vdev->nv_gpudirect_clique == 0xFF) {
+        return 0;
+    }
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID)) {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid device vendor");
+        return -EINVAL;
+    }
+
+    if (pci_get_byte(pdev->config + PCI_CLASS_DEVICE + 1) !=
+        PCI_BASE_CLASS_DISPLAY) {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: unsupported PCI class");
+        return -EINVAL;
+    }
+
+    ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
+    if (ret < 0) {
+        error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
+        return ret;
+    }
+
+    memset(vdev->emulated_config_bits + pos, 0xFF, 8);
+    pos += PCI_CAP_FLAGS;
+    pci_set_byte(pdev->config + pos++, 8);
+    pci_set_byte(pdev->config + pos++, 'P');
+    pci_set_byte(pdev->config + pos++, '2');
+    pci_set_byte(pdev->config + pos++, 'P');
+    pci_set_byte(pdev->config + pos++, vdev->nv_gpudirect_clique << 3);
+    pci_set_byte(pdev->config + pos, 0);
+
+    return 0;
+}
+
 int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 {
+    int ret;
+
+    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
+    if (ret) {
+        return ret;
+    }
+
     return 0;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bfeaaef22d00..9e86db7c3b6d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2970,6 +2970,8 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
+
+    vdev->nv_gpudirect_clique = 0xFF;
 }
 
 static Property vfio_pci_dev_properties[] = {
@@ -2994,6 +2996,9 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
+                                   nv_gpudirect_clique,
+                                   qdev_prop_nv_gpudirect_clique, uint8_t),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 958cee058b3b..502a5755b944 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
     int32_t bootindex;
     uint32_t igd_gms;
     uint8_t pm_cap;
+    uint8_t nv_gpudirect_clique;
     bool pci_aer;
     bool req_enabled;
     bool has_flr;
@@ -162,6 +163,8 @@ void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 
+extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
+
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
