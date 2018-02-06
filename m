Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8if-0005Ai-EF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ia-0007tW-Nw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36246
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ia-0007sj-8b
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEIDk131010
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:47 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyfvm6yt8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:46 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:46 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:40 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-20-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 19/54] hw/pci-bridge: fix QEMU crash because of
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
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit fced4d00e68e7559c73746d963265f7fd0b6abf9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
