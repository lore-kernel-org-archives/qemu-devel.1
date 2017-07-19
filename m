Received: from eggs.gnu.org ([2001:4830:134:3::10]:38834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXou0-00075M-0c
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXotv-0006DQ-AZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:32 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dXotv-0006CI-3i
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:27 -0400
Received: by mail-lf0-x242.google.com with SMTP id t72so4308340lff.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:20:25 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 19 Jul 2017 16:20:13 +0300
Message-Id: <1500470414-7911-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 1/2] pci: add support for direct usage of
 bdf for capability lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, marcel@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Add a capability lookup function which gets bdf instead of pci_device
as its first argument. It may be useful when we have bdf,
but don't have the whole pci_device structure.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
 src/hw/pcidevice.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/src/hw/pcidevice.c b/src/hw/pcidevice.c
index cfebf66..3fa240e 100644
--- a/src/hw/pcidevice.c
+++ b/src/hw/pcidevice.c
@@ -158,6 +158,30 @@ u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap)
     return 0;
 }
 
+u8 pci_find_capability_bdf(int bdf, u8 cap_id, u8 cap)
+{
+    int i;
+    u16 status = pci_config_readw(bdf, PCI_STATUS);
+
+    if (!(status & PCI_STATUS_CAP_LIST))
+        return 0;
+
+    if (cap == 0) {
+        /* find first */
+        cap = pci_config_readb(bdf, PCI_CAPABILITY_LIST);
+    } else {
+        /* find next */
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
+    }
+    for (i = 0; cap && i <= 0xff; i++) {
+        if (pci_config_readb(bdf, cap + PCI_CAP_LIST_ID) == cap_id)
+            return cap;
+        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
+    }
+
+    return 0;
+}
+
 // Enable PCI bus-mastering (ie, DMA) support on a pci device
 void
 pci_enable_busmaster(struct pci_device *pci)
diff --git a/src/hw/pcidevice.h b/src/hw/pcidevice.h
index 354b549..e4ed5cf 100644
--- a/src/hw/pcidevice.h
+++ b/src/hw/pcidevice.h
@@ -70,6 +70,7 @@ int pci_init_device(const struct pci_device_id *ids
 struct pci_device *pci_find_init_device(const struct pci_device_id *ids
                                         , void *arg);
 u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap);
+u8 pci_find_capability_bdf(int bdf, u8 cap_id, u8 cap);
 void pci_enable_busmaster(struct pci_device *pci);
 u16 pci_enable_iobar(struct pci_device *pci, u32 addr);
 void *pci_enable_membar(struct pci_device *pci, u32 addr);
-- 
2.7.4
