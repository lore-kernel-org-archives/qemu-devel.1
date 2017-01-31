Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPR-0007av-9j
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPQ-0000ht-Ie
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:44:05 -0500
Received: from mail.kernel.org ([198.145.29.136]:38482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPQ-0000hU-CQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:44:04 -0500
Date: Tue, 31 Jan 2017 20:44:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-22-git-send-email-mst@redhat.com>
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 21/23] hw/pci: disable pci-bridge's shpc by
 default
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

The shpc component is optional while  ACPI hotplug is used
for hot-plugging PCI devices into a PCI-PCI bridge.
Disabling the shpc by default will make slot 0 usable at boot time
and not only for hot-plug, without loosing any functionality.
Older machines will have shpc enabled for compatibility reasons.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h            | 4 ++++
 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index ee0dd1b..b7db438 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -14,6 +14,10 @@
         .driver   = "pflash_cfi01",\
         .property = "old-multiple-chip-handling",\
         .value    = "on",\
+    },{\
+        .driver   = "pci-bridge",\
+        .property = "shpc",\
+        .value    = "on",\
     },
 
 #define HW_COMPAT_2_7 \
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
 
-- 
MST
