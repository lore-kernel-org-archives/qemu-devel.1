Received: from eggs.gnu.org ([2001:4830:134:3::10]:59206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EX-0001VB-48
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3ET-0007o4-5t
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ3ES-0007nn-Sy
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:37 -0400
Date: Thu, 8 Jun 2017 22:36:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496950567-26343-4-git-send-email-mst@redhat.com>
References: <1496950567-26343-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496950567-26343-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] hw/pcie: fix the generic pcie root port to
 support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

Add msix state to pcie-root-ports's vmstate
in order to support migration.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h                |  4 ++++
 hw/pci-bridge/gen_pcie_root_port.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 400c64b..26cd585 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -14,6 +14,10 @@
         .driver   = "virtio-net-device",\
         .property = "x-mtu-bypass-backend",\
         .value    = "off",\
+    },{\
+        .driver   = "pcie-root-port",\
+        .property = "x-migrate-msix",\
+        .value    = "false",\
     },
 
 #define HW_COMPAT_2_8 \
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 8ebffa8..cb694d6 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -20,6 +20,14 @@
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 
+typedef struct GenPCIERootPort {
+    /*< private >*/
+    PCIESlot parent_obj;
+    /*< public >*/
+
+    bool migrate_msix;
+} GenPCIERootPort;
+
 static uint8_t gen_rp_aer_vector(const PCIDevice *d)
 {
     return 0;
@@ -45,6 +53,13 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
     msix_uninit_exclusive_bar(d);
 }
 
+static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
+{
+    GenPCIERootPort *rp = opaque;
+
+    return rp->migrate_msix;
+}
+
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
     .version_id = 1,
@@ -54,10 +69,18 @@ static const VMStateDescription vmstate_rp_dev = {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_MSIX_TEST(parent_obj.parent_obj.parent_obj.parent_obj,
+                          GenPCIERootPort,
+                          gen_rp_test_migrate_msix),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static Property gen_rp_props[] = {
+    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -68,6 +91,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
     dc->desc = "PCI Express Root Port";
     dc->vmsd = &vmstate_rp_dev;
+    dc->props = gen_rp_props;
     rpc->aer_vector = gen_rp_aer_vector;
     rpc->interrupts_init = gen_rp_interrupts_init;
     rpc->interrupts_uninit = gen_rp_interrupts_uninit;
@@ -77,6 +101,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
 static const TypeInfo gen_rp_dev_info = {
     .name          = TYPE_GEN_PCIE_ROOT_PORT,
     .parent        = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(GenPCIERootPort),
     .class_init    = gen_rp_dev_class_init,
 };
 
-- 
MST
