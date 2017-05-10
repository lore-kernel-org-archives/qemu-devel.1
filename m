Received: from eggs.gnu.org ([2001:4830:134:3::10]:60621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d8Nvn-0002gp-1E
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d8Nvj-0008AY-Sz
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:29:15 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 10 May 2017 12:29:03 +0300
Message-Id: <20170510092903.23649-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] Revert "hw/pci: disable pci-bridge's shpc by
 default"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, marcel@redhat.com, mst@redhat.com

This reverts commit dc0ae767700c156894e36fab89a745a2dc4173de.

Disabling the shpc controller has an undesired side effect.
The PCI bridge remains with no attached devices at boot time,
and the guest operating systems do not all allocate any resources
for it leaving the bridge unusable. Note that the behaviour
is dictated by the pci bridge specification.

Revert the commit and leave the shpc controller even if is not
actually used by any architecture. Slot 0 remains unusable at boot time.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 include/hw/compat.h            | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 647ad80..5dbd933 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -163,7 +163,7 @@ static Property pci_bridge_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
-                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
+                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 846b90e..eff021f 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -18,10 +18,6 @@
         .property = "old-multiple-chip-handling",\
         .value    = "on",\
     },{\
-        .driver   = "pci-bridge",\
-        .property = "shpc",\
-        .value    = "on",\
-    },{\
         .driver   = TYPE_PCI_DEVICE,\
         .property = "x-pcie-extcap-init",\
         .value    = "off",\
-- 
2.9.3
