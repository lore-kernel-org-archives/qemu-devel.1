Received: from eggs.gnu.org ([2001:4830:134:3::10]:48697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d8lHz-0003RZ-2N
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d8lHv-0004oW-Tt
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1d8lHv-0004lg-OT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:25:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5C1F15552
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 10:25:36 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Thu, 11 May 2017 13:25:29 +0300
Message-Id: <20170511102529.21618-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2] Revert "hw/pci: disable pci-bridge's shpc
 by default"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, lersek@redhat.com, dgilbert@redhat.com

This reverts commit dc0ae767700c156894e36fab89a745a2dc4173de.

Disabling the shpc controller has an undesired side effect.
The PCI bridge remains with no attached devices at boot time,
and the guest operating systems do not allocate any resources
for it, leaving the bridge unusable. Note that the behaviour
is dictated by the pci bridge specification.

Revert the commit and leave the shpc controller even if is not
actually used by any architecture. Slot 0 remains unusable at boot time.

Keep shpc off for QEMU 2.9 machines.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

V1 -> V2:
 - Keep shpc off for QEMU 2.9 machines
 - Rebased on Michael's tree to get QEMU 2.10 machine types

Thanks,
Marcel

 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 include/hw/compat.h            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index 846b90e..55b1765 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_9 \
-    /* empty */
+    {\
+        .driver   = "pci-bridge",\
+        .property = "shpc",\
+        .value    = "off",\
+    },
 
 #define HW_COMPAT_2_8 \
     {\
-- 
2.9.3
