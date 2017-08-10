Received: from eggs.gnu.org ([2001:4830:134:3::10]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfwv4-0000La-0b
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfwv2-0001bP-Nt
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:31:14 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dfwv2-0001ZF-Go
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:31:12 -0400
Received: by mail-lf0-x243.google.com with SMTP id w199so1376448lff.2
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 16:31:12 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 11 Aug 2017 02:31:02 +0300
Message-Id: <1502407863-23182-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1502407863-23182-1-git-send-email-zuban32s@gmail.com>
References: <1502407863-23182-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v5 3/4] hw/pci: add QEMU-specific PCI
 capability to the Generic PCI Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

To enable hotplugging of a newly created pcie-pci-bridge,
we need to tell firmware (e.g. SeaBIOS) to reserve
additional buses or IO/MEM/PREF space for pcie-root-port.
Additional bus reservation allows us to hotplug pcie-pci-bridge into this root port.
The number of buses and IO/MEM/PREF space to reserve are provided to the device via
a corresponding property, and to the firmware via new PCI capability.
The properties' default values are -1 to keep default behavior unchanged.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie_port.h         |  1 +
 2 files changed, 37 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index cb694d6..bd65479 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -16,6 +16,8 @@
 #include "hw/pci/pcie_port.h"
 
 #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
+#define GEN_PCIE_ROOT_PORT(obj) \
+        OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
 
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
@@ -26,6 +28,13 @@ typedef struct GenPCIERootPort {
     /*< public >*/
 
     bool migrate_msix;
+
+    /* additional resources to reserve on firmware init */
+    uint32_t bus_reserve;
+    uint64_t io_reserve;
+    uint32_t mem_reserve;
+    uint32_t pref32_reserve;
+    uint64_t pref64_reserve;
 } GenPCIERootPort;
 
 static uint8_t gen_rp_aer_vector(const PCIDevice *d)
@@ -60,6 +69,24 @@ static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
     return rp->migrate_msix;
 }
 
+static void gen_rp_realize(DeviceState *dev, Error **errp)
+{
+    PCIDevice *d = PCI_DEVICE(dev);
+    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+
+    rpc->parent_realize(dev, errp);
+
+    int rc = pci_bridge_qemu_reserve_cap_init(d, 0, grp->bus_reserve,
+            grp->io_reserve, grp->mem_reserve, grp->pref32_reserve,
+            grp->pref64_reserve, errp);
+
+    if (rc < 0) {
+        rpc->parent_class.exit(d);
+        return;
+    }
+}
+
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
     .version_id = 1,
@@ -78,6 +105,11 @@ static const VMStateDescription vmstate_rp_dev = {
 
 static Property gen_rp_props[] = {
     DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
+    DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort, bus_reserve, -1),
+    DEFINE_PROP_UINT64("io-reserve", GenPCIERootPort, io_reserve, -1),
+    DEFINE_PROP_UINT32("mem-reserve", GenPCIERootPort, mem_reserve, -1),
+    DEFINE_PROP_UINT32("pref32-reserve", GenPCIERootPort, pref32_reserve, -1),
+    DEFINE_PROP_UINT64("pref64-reserve", GenPCIERootPort, pref64_reserve, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -92,6 +124,10 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     dc->desc = "PCI Express Root Port";
     dc->vmsd = &vmstate_rp_dev;
     dc->props = gen_rp_props;
+
+    rpc->parent_realize = dc->realize;
+    dc->realize = gen_rp_realize;
+
     rpc->aer_vector = gen_rp_aer_vector;
     rpc->interrupts_init = gen_rp_interrupts_init;
     rpc->interrupts_uninit = gen_rp_interrupts_uninit;
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1333266..0736014 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -65,6 +65,7 @@ void pcie_chassis_del_slot(PCIESlot *s);
 
 typedef struct PCIERootPortClass {
     PCIDeviceClass parent_class;
+    DeviceRealize parent_realize;
 
     uint8_t (*aer_vector)(const PCIDevice *dev);
     int (*interrupts_init)(PCIDevice *dev, Error **errp);
-- 
2.7.4
