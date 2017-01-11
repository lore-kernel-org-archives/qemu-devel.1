Received: from eggs.gnu.org ([2001:4830:134:3::10]:56278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHMZ-0003qz-CG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHMW-0001ap-B5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cRHMW-0001Xz-5L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:46:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF2DB369C4
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:46:38 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 11 Jan 2017 13:46:35 +0200
Message-Id: <1484135195-29232-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2] hw/pci: disable pci-bridge's shpc by default
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
v1 -> v2:
 - Moved the compat property to HW_COMPAT_2_8

 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 include/hw/compat.h            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index 4fe44d1..428c127 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_8 \
-    /* empty */
+    {\
+        .driver   = "pci-bridge",\
+        .property = "shpc",\
+        .value    = "on",\
+    },
 
 #define HW_COMPAT_2_7 \
     {\
-- 
2.5.5
