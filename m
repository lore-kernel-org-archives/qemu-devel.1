Received: from eggs.gnu.org ([2001:4830:134:3::10]:60301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbIi-0008T3-3C
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbIg-0004oc-SB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dpbIg-0004ng-JJ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:30 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  6 Sep 2017 17:26:58 +0300
Message-Id: <20170906142658.58298-3-marcel@redhat.com>
In-Reply-To: <20170906142658.58298-1-marcel@redhat.com>
References: <20170906142658.58298-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by default
 for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

For most cases the devices attached to PCIe Root Ports
do not need IO ports range, add an 'enable-io-fwd' property
making it false by default, but keeping it true for older machines.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/compat.h                |  6 +++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index cb694d6da5..cbdeb73e2c 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -20,12 +20,26 @@
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 
+#define GEN_PCIE_ROOT_PORT(obj) \
+     OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
+#define GEN_PCIE_ROOT_PORT_CLASS(klass) \
+     OBJECT_CLASS_CHECK(GenPCIERootPortClass, (klass), TYPE_GEN_PCIE_ROOT_PORT)
+#define GEN_PCIE_ROOT_PORT_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(GenPCIERootPortClass, (obj), TYPE_GEN_PCIE_ROOT_PORT)
+
+typedef struct GenPCIERootPortClass {
+    PCIERootPortClass parent_class;
+
+    DeviceRealize parent_realize;
+} GenPCIERootPortClass;
+
 typedef struct GenPCIERootPort {
     /*< private >*/
     PCIESlot parent_obj;
     /*< public >*/
 
     bool migrate_msix;
+    bool enable_io_fwd;
 } GenPCIERootPort;
 
 static uint8_t gen_rp_aer_vector(const PCIDevice *d)
@@ -60,6 +74,25 @@ static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
     return rp->migrate_msix;
 }
 
+static void gen_rp_realize(DeviceState *d, Error **errp)
+{
+    GenPCIERootPortClass *grpc = GEN_PCIE_ROOT_PORT_GET_CLASS(d);
+    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
+    PCIDevice *pci_dev = PCI_DEVICE(d);
+
+    grpc->parent_realize(DEVICE(d), errp);
+    if (*errp) {
+        return;
+    }
+
+    if (!grp->enable_io_fwd) {
+        pci_word_test_and_clear_mask(pci_dev->wmask + PCI_COMMAND,
+                                     PCI_COMMAND_IO);
+        pci_dev->wmask[PCI_IO_BASE] = 0;
+        pci_dev->wmask[PCI_IO_LIMIT] = 0;
+    }
+}
+
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
     .version_id = 1,
@@ -78,6 +111,7 @@ static const VMStateDescription vmstate_rp_dev = {
 
 static Property gen_rp_props[] = {
     DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
+    DEFINE_PROP_BOOL("enable-io-fwd", GenPCIERootPort, enable_io_fwd, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -86,6 +120,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+    GenPCIERootPortClass *grpc = GEN_PCIE_ROOT_PORT_CLASS(klass);
 
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
@@ -96,6 +131,8 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     rpc->interrupts_init = gen_rp_interrupts_init;
     rpc->interrupts_uninit = gen_rp_interrupts_uninit;
     rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
+    grpc->parent_realize = dc->realize;
+    dc->realize = gen_rp_realize;
 }
 
 static const TypeInfo gen_rp_dev_info = {
@@ -103,6 +140,7 @@ static const TypeInfo gen_rp_dev_info = {
     .parent        = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(GenPCIERootPort),
     .class_init    = gen_rp_dev_class_init,
+    .class_size    = sizeof(GenPCIERootPortClass),
 };
 
  static void gen_rp_register_types(void)
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 3e101f8f67..843bf4a3a5 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_10 \
-    /* empty */
+    {\
+        .driver   = "pcie-root-port",\
+        .property = "enable-io-fwd",\
+        .value    = "true",\
+    },
 
 #define HW_COMPAT_2_9 \
     {\
-- 
2.13.5
