Received: from eggs.gnu.org ([2001:4830:134:3::10]:33311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csggw-0007oR-Lz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csggv-0004xB-EK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:17:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 28 Mar 2017 13:16:51 +1100
Message-Id: <20170328021651.19350-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170328021651.19350-1-david@gibson.dropbear.id.au>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.10 3/3] pseries: Allow PCIe virtio and XHCI
 on pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, aik@ozlabs.ru, marcel@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com, David Gibson <david@gibson.dropbear.id.au>

pseries now allows PCIe devices (both emulated and VFIO), although its
PCI bus is in most respects a plain PCI bus - this uses paravirtualized
access methods to PCIe extended config space defined in the PAPR spec.

However, because the bus is not PCIe, it means that virtio-pci and XHCI
devices will present themselves as plain PCI rather than PCIe, which would
be preferable.

This patch uses the new hook to override the behaviour for such PCI/PCIe
"hybrid" devices to allow PCIe virtio-pci and XHCI on pseries.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c       | 9 +++++++++
 tests/virtio-9p-test.c   | 2 +-
 tests/virtio-blk-test.c  | 4 ++--
 tests/virtio-net-test.c  | 2 +-
 tests/virtio-scsi-test.c | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e4..7686f7f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1979,6 +1979,14 @@ static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
     return sphb->dtbusname;
 }
 
+static bool spapr_phb_allow_hybrid_pcie(PCIHostState *host_bridge,
+                                        PCIDevice *pci_dev)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(host_bridge);
+
+    return sphb->pcie_ecs;
+}
+
 static void spapr_phb_class_init(ObjectClass *klass, void *data)
 {
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -1986,6 +1994,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     HotplugHandlerClass *hp = HOTPLUG_HANDLER_CLASS(klass);
 
     hc->root_bus_path = spapr_phb_root_bus_path;
+    hc->allow_hybrid_pcie = spapr_phb_allow_hybrid_pcie;
     dc->realize = spapr_phb_realize;
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 43a1ad8..ae0d51e 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -32,7 +32,7 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-fsdev local,id=fsdev0,security_model=none,path=%s "
-                      "-device %s,fsdev=fsdev0,mount_tag=%s";
+                      "-device %s,fsdev=fsdev0,mount_tag=%s,disable-legacy=off";
     QVirtIO9P *v9p = g_new0(QVirtIO9P, 1);
 
     v9p->test_share = g_strdup("/tmp/qtest.XXXXXX");
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 1eee95d..5fb7882 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -65,7 +65,7 @@ static QOSState *pci_test_start(void)
     const char *cmd = "-drive if=none,id=drive0,file=%s,format=raw "
                       "-drive if=none,id=drive1,file=/dev/null,format=raw "
                       "-device virtio-blk-pci,id=drv0,drive=drive0,"
-                      "addr=%x.%x";
+                      "addr=%x.%x,disable-legacy=off";
 
     tmp_path = drive_create();
 
@@ -656,7 +656,7 @@ static void pci_hotplug(void)
 
     /* plug secondary disk */
     qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
-                          "'drive': 'drive1'");
+                          "'drive': 'drive1', 'disable-legacy': 'off'");
 
     dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
     g_assert(dev);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 8f94360..a35d87b 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -55,7 +55,7 @@ static QOSState *pci_test_start(int socket)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
-                      "virtio-net-pci,netdev=hs0";
+                      "virtio-net-pci,netdev=hs0,disable-legacy=off";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         return qtest_pc_boot(cmd, socket);
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 0eabd56..5a802d9 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -36,7 +36,7 @@ static QOSState *qvirtio_scsi_start(const char *extra_opts)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-drive id=drv0,if=none,file=/dev/null,format=raw "
-                      "-device virtio-scsi-pci,id=vs0 "
+                      "-device virtio-scsi-pci,id=vs0,disable-legacy=off "
                       "-device scsi-hd,bus=vs0.0,drive=drv0 %s";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-- 
2.9.3
