Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfunt-0001a5-Ru
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfuns-0008VR-Tc
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cfuns-0008Uc-No
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:24 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2BD68047A
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:43:24 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 20 Feb 2017 22:43:10 +0200
Message-Id: <1487623393-2492-2-git-send-email-marcel@redhat.com>
In-Reply-To: <1487623393-2492-1-git-send-email-marcel@redhat.com>
References: <1487623393-2492-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 1/4] hw/pcie: fix Extended Configuration
 Space for devices with no Extended Capabilities
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

Absence of any Extended Capabilities is required to be
indicated by an Extended Capability header with a Capability ID of
0000h, a Capability Version of 0h, and a Next Capability Offset of 000h.

Instead of inserting a 'NULL' capability is simpler to mark the start
of the Extended Configuration Space as read-only to achieve the same
behaviour.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 6 ++++++
 include/hw/compat.h  | 4 ++++
 include/hw/pci/pci.h | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a563555..4d2c0e1 100644
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
index cbd4bb4..2526e3a 100644
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
index cbc1fdf..ded978c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -182,6 +182,8 @@ enum {
     /* Link active status in endpoint capability is always set */
 #define QEMU_PCIE_LNKSTA_DLLLA_BITNR 8
     QEMU_PCIE_LNKSTA_DLLLA = (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
+#define QEMU_PCIE_EXTCAP_INIT_BITNR 9
+    QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 };
 
 #define TYPE_PCI_DEVICE "pci-device"
-- 
2.5.5
