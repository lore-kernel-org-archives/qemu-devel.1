Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dwGDx-0007P3-Mb
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 19:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dwGDu-00048j-HP
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 19:22:09 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dwGDu-000482-Aj
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 19:22:06 -0400
Received: by mail-wr0-x242.google.com with SMTP id b9so570014wra.0
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 16:22:05 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Mon, 25 Sep 2017 02:21:58 +0300
Message-Id: <1506295318-10479-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v2] hw/pci-bridge/pcie_pci_bridge: properly
 handle MSI unavailability case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

QEMU with the pcie-pci-bridge device crashes if the guest board doesn't support MSI,
e.g. 'qemu-system-ppc64 -M prep -device pcie-pci-bridge'.
This is caused by wrong pcie-pci-bridge instantiation error handling. This patch fixes this issue
by falling back to legacy INTx if MSI is not available.
Also set the bridge's 'msi' property default value to 'auto' in order to trigger errors 
only when user explicitly set msi=on.

v2:
rewrite the commit message

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/pcie_pci_bridge.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 9aa5cc3..da562fe 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -65,10 +65,18 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
         goto aer_error;
     }
 
+    Error *local_err = NULL;
     if (pcie_br->msi != ON_OFF_AUTO_OFF) {
-        rc = msi_init(d, 0, 1, true, true, errp);
+        rc = msi_init(d, 0, 1, true, true, &local_err);
         if (rc < 0) {
-            goto msi_error;
+            assert(rc == -ENOTSUP);
+            if (pcie_br->msi != ON_OFF_AUTO_ON) {
+                error_free(local_err);
+            } else {
+                /* failed to satisfy user's explicit request for MSI */
+                error_propagate(errp, local_err);
+                goto msi_error;
+            }
         }
     }
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -81,7 +89,7 @@ aer_error:
 pm_error:
     pcie_cap_exit(d);
 cap_error:
-    shpc_free(d);
+    shpc_cleanup(d, &pcie_br->shpc_bar);
 error:
     pci_bridge_exitfn(d);
 }
@@ -98,7 +106,9 @@ static void pcie_pci_bridge_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
     pci_bridge_reset(qdev);
-    msi_reset(d);
+    if (msi_present(d)) {
+        msi_reset(d);
+    }
     shpc_reset(d);
 }
 
@@ -106,12 +116,14 @@ static void pcie_pci_bridge_write_config(PCIDevice *d,
         uint32_t address, uint32_t val, int len)
 {
     pci_bridge_write_config(d, address, val, len);
-    msi_write_config(d, address, val, len);
+    if (msi_present(d)) {
+        msi_write_config(d, address, val, len);
+    }
     shpc_cap_write_config(d, address, val, len);
 }
 
 static Property pcie_pci_bridge_dev_properties[] = {
-        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_ON),
+        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_AUTO),
         DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
