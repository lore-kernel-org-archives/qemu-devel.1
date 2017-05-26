Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEDuZ-00009f-IV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEDuW-00065Z-Ix
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:00:07 -0400
Received: from [59.151.112.132] (port=42819 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEDuW-000622-7V
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:00:04 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 26 May 2017 19:58:32 +0800
Message-ID: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] pci: Set err to errp directly rather than
 through error_porpagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, imammedo@redhat.com, armbru@redhat.com

ioh3420_interrupts_init() and its callers rp_realize() fill error
message to local_err, then propagate it to errp by error_porpagate(),
which's not necessary. So eliminate it and pass errp directly instead
of local_err. Of course, error_propagate() also has been removed.

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
v2:
* Drop the part of wrong handling that ignored the fact that if 
  pci_qdev_realize()'s caller pass errp = NULL.

 hw/pci-bridge/ioh3420.c        | 4 +---
 hw/pci-bridge/pcie_root_port.c | 7 ++-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index da4e5bd..5f56a2f 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -64,15 +64,13 @@ static uint8_t ioh3420_aer_vector(const PCIDevice *d)
 static int ioh3420_interrupts_init(PCIDevice *d, Error **errp)
 {
     int rc;
-    Error *local_err = NULL;
 
     rc = msi_init(d, IOH_EP_MSI_OFFSET, IOH_EP_MSI_NR_VECTOR,
                   IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
                   IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
-                  &local_err);
+                  errp);
     if (rc < 0) {
         assert(rc == -ENOTSUP);
-        error_propagate(errp, local_err);
     }
 
     return rc;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index cf36318..9022996 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -59,7 +59,6 @@ static void rp_realize(PCIDevice *d, Error **errp)
     PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     int rc;
-    Error *local_err = NULL;
 
     pci_config_set_interrupt_pin(d->config, 1);
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
@@ -72,9 +71,8 @@ static void rp_realize(PCIDevice *d, Error **errp)
     }
 
     if (rpc->interrupts_init) {
-        rc = rpc->interrupts_init(d, &local_err);
+        rc = rpc->interrupts_init(d, errp);
         if (rc < 0) {
-            error_propagate(errp, local_err);
             goto err_bridge;
         }
     }
@@ -98,9 +96,8 @@ static void rp_realize(PCIDevice *d, Error **errp)
     }
 
     rc = pcie_aer_init(d, PCI_ERR_VER, rpc->aer_offset,
-                       PCI_ERR_SIZEOF, &local_err);
+                       PCI_ERR_SIZEOF, errp);
     if (rc < 0) {
-        error_propagate(errp, local_err);
         goto err;
     }
     pcie_aer_root_init(d);
-- 
2.9.3
