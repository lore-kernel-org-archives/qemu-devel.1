Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZLkk-00020e-CP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZLkf-0000zc-ER
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:09:34 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 10 Jan 2018 21:09:09 +0200
Message-Id: <20180110190909.20652-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/pci-bridge: fix QEMU crash because of
 pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, zuban32s@gmail.com, qemu-stable@nongnu.org

If we try to use more pcie_root_ports then available slots
and an IO hint is passed to the port, QEMU crashes because
we try to init the "IO hint" capability even if the device
is not created.
Fix it by checking for error before adding the capability,
so QEMU can fail gracefully.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ad4e6aa7ff..0e2f2e8bf1 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -74,8 +74,13 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
     PCIDevice *d = PCI_DEVICE(dev);
     GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    Error *local_err = NULL;
 
-    rpc->parent_realize(dev, errp);
+    rpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     int rc = pci_bridge_qemu_reserve_cap_init(d, 0, grp->bus_reserve,
             grp->io_reserve, grp->mem_reserve, grp->pref32_reserve,
-- 
2.13.5
