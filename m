Received: from eggs.gnu.org ([2001:4830:134:3::10]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWJCJ-0000EA-TS
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWJCE-0008JR-Uy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:44:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cWJCE-0008JJ-PN
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:44:50 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E273361B86
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:44:50 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 25 Jan 2017 10:44:46 +0200
Message-Id: <1485333886-6111-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V3] hw/pci: disable pci-bridge's shpc by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

The shpc component is optional while  ACPI hotplug is used
for hot-plugging PCI devices into a PCI-PCI bridge.
Disabling the shpc by default will make slot 0 usable at boot time
and not only for hot-plug, without loosing any functionality.
Older machines will have shpc enabled for compatibility reasons.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
v2 -> v3:
 - Rebased on master (Michael)

v1 -> v2:
 - Moved the compat property to HW_COMPAT_2_8

 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 include/hw/compat.h            | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 5dbd933..647ad80 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -163,7 +163,7 @@ static Property pci_bridge_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
-                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
+                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 34e9b4a..752a9d7 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -10,6 +10,10 @@
         .driver   = "fw_cfg_io",\
         .property = "x-file-slots",\
         .value    = stringify(0x10),\
+    },{\
+        .driver   = "pci-bridge",\
+        .property = "shpc",\
+        .value    = "on",\
     },
 
 #define HW_COMPAT_2_7 \
-- 
2.5.5
