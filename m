Received: from eggs.gnu.org ([2001:4830:134:3::10]:48793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFq-0000AZ-9z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFp-00010g-7i
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:06 -0400
Received: from mail.kernel.org ([198.145.29.136]:60956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFo-00010T-UJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:05 -0400
Date: Thu, 16 Mar 2017 04:35:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489631689-6382-2-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] hw/pcie: fix Extended Configuration Space
 for devices with no Extended Capabilities
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

Absence of any Extended Capabilities is required to be
indicated by an Extended Capability header with a Capability ID of
0000h, a Capability Version of 0h, and a Next Capability Offset of 000h.

Instead of inserting a 'NULL' capability is simpler to mark the start
of the Extended Configuration Space as read-only to achieve the same
behaviour.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h  | 4 ++++
 include/hw/pci/pci.h | 2 ++
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 6 ++++++
 4 files changed, 14 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index b7db438..ce3bfe3 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -18,6 +18,10 @@
         .driver   = "pci-bridge",\
         .property = "shpc",\
         .value    = "on",\
+    },{\
+        .driver   = TYPE_PCI_DEVICE,\
+        .property = "x-pcie-extcap-init",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_7 \
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 713ede0..a37a2d5 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -183,6 +183,8 @@ enum {
     /* Link active status in endpoint capability is always set */
 #define QEMU_PCIE_LNKSTA_DLLLA_BITNR 8
     QEMU_PCIE_LNKSTA_DLLLA = (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
+#define QEMU_PCIE_EXTCAP_INIT_BITNR 9
+    QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 };
 
 #define TYPE_PCI_DEVICE "pci-device"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ad46390..e6b08e1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,6 +64,8 @@ static Property pci_props[] = {
                     QEMU_PCI_CAP_SERR_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
+                    QEMU_PCIE_EXTCAP_INIT_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index fc54bfd..82a8902 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -109,6 +109,12 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
                  PCI_EXP_DEVCAP2_EFF | PCI_EXP_DEVCAP2_EETLPP);
 
     pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
+
+    if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {
+        /* read-only to behave like a 'NULL' Extended Capability Header */
+        pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
+    }
+
     return pos;
 }
 
-- 
MST
