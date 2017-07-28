Received: from eggs.gnu.org ([2001:4830:134:3::10]:59321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpb-0004DD-IF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpZ-0002RU-CL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:07 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEpZ-0002Qq-4C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:05 -0400
Received: by mail-lf0-x243.google.com with SMTP id 65so7022457lfa.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:38:04 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:37:52 +0300
Message-Id: <1501285073-2215-5-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v3 4/5] hw/pci: add QEMU-specific PCI
 capability to Generic PCI Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <abezzubikov@ispras.ru>, Aleksandr Bezzubikov <zuban32s@gmail.com>

From: Aleksandr Bezzubikov <abezzubikov@ispras.ru>

To enable hotplugging of a newly created pcie-pci-bridge,
we need to tell firmware (SeaBIOS in this case) to reserve
additional buses for pcie-root-port, that allows us to
hotplug pcie-pci-bridge into this root port.
The number of buses to reserve is provided to the device via a corresponding
property, and to the firmware via new PCI capability.
The property's default value is 0 to keep default behavior unchanged.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 23 +++++++++++++++++++++++
 hw/pci-bridge/pcie_root_port.c     |  2 +-
 include/hw/pci/pcie_port.h         |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index cb694d6..da3caa1 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -16,6 +16,8 @@
 #include "hw/pci/pcie_port.h"
 
 #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
+#define GEN_PCIE_ROOT_PORT(obj) \
+        OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
 
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
@@ -26,6 +28,9 @@ typedef struct GenPCIERootPort {
     /*< public >*/
 
     bool migrate_msix;
+
+    /* additional buses to reserve on firmware init */
+    uint8_t bus_reserve;
 } GenPCIERootPort;
 
 static uint8_t gen_rp_aer_vector(const PCIDevice *d)
@@ -60,6 +65,21 @@ static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
     return rp->migrate_msix;
 }
 
+static void gen_rp_realize(PCIDevice *d, Error **errp)
+{
+    rp_realize(d, errp);
+    PCIESlot *s = PCIE_SLOT(d);
+    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
+
+    int rc = pci_bridge_qemu_cap_init(d, 0, grp->bus_reserve, 0, 0, 0, errp);
+    if (rc < 0) {
+        pcie_chassis_del_slot(s);
+        pcie_cap_exit(d);
+        gen_rp_interrupts_uninit(d);
+        pci_bridge_exitfn(d);
+    }
+}
+
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
     .version_id = 1,
@@ -78,6 +98,7 @@ static const VMStateDescription vmstate_rp_dev = {
 
 static Property gen_rp_props[] = {
     DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
+    DEFINE_PROP_UINT8("bus-reserve", GenPCIERootPort, bus_reserve, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -89,6 +110,8 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
 
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
+    k->realize = gen_rp_realize;
+
     dc->desc = "PCI Express Root Port";
     dc->vmsd = &vmstate_rp_dev;
     dc->props = gen_rp_props;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 4d588cb..2f3bcb1 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -52,7 +52,7 @@ static void rp_reset(DeviceState *qdev)
     pci_bridge_disable_base_limit(d);
 }
 
-static void rp_realize(PCIDevice *d, Error **errp)
+void rp_realize(PCIDevice *d, Error **errp)
 {
     PCIEPort *p = PCIE_PORT(d);
     PCIESlot *s = PCIE_SLOT(d);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1333266..febd96a 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -63,6 +63,8 @@ void pcie_chassis_del_slot(PCIESlot *s);
 #define PCIE_ROOT_PORT_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PCIERootPortClass, (obj), TYPE_PCIE_ROOT_PORT)
 
+void rp_realize(PCIDevice *d, Error **errp);
+
 typedef struct PCIERootPortClass {
     PCIDeviceClass parent_class;
 
-- 
2.7.4
