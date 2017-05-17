Received: from eggs.gnu.org ([2001:4830:134:3::10]:48281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6lA-0000zq-0h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6l9-0005RH-0N
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dB6l8-0005Qr-QY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:30 -0400
Date: Thu, 18 May 2017 00:45:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1495057396-13387-11-git-send-email-mst@redhat.com>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] Revert "hw/pci: disable pci-bridge's shpc
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h            | 6 +++++-
 hw/pci-bridge/pci_bridge_dev.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
 
-- 
MST
