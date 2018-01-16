Received: from eggs.gnu.org ([2001:4830:134:3::10]:45056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVN8-00078k-3h
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVN7-0001vA-BF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVN7-0001uc-5H
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:05 -0500
Date: Tue, 16 Jan 2018 19:49:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-14-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/34] hw/pci-bridge: fix QEMU crash because
 of pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

If we try to use more pcie_root_ports then available slots
and an IO hint is passed to the port, QEMU crashes because
we try to init the "IO hint" capability even if the device
is not created.
Fix it by checking for error before adding the capability,
so QEMU can fail gracefully.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ad4e6aa..0e2f2e8 100644
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
MST
