Received: from eggs.gnu.org ([2001:4830:134:3::10]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeT-0005wa-0Q
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeO-00071k-50
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:32 -0500
Received: from [59.151.112.132] (port=15022 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeN-0006yx-Ev
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:28 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 31 Dec 2016 17:13:05 +0800
Message-ID: <1483175588-17006-2-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 1/4] pcie_aer: support configurable AER
 capa version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Now, AER capa version is fixed to v2, if assigned device is actually
v1, this value will be inconsistent between guest and host

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/net/e1000e.c                    | 3 ++-
 hw/pci-bridge/ioh3420.c            | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 2 +-
 hw/pci-bridge/xio3130_upstream.c   | 2 +-
 hw/pci/pcie_aer.c                  | 5 +++--
 include/hw/pci/pcie_aer.h          | 3 ++-
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 4994e1c..66de849 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -472,7 +472,8 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize PM capability");
     }
 
-    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF) < 0) {
+    if (pcie_aer_init(pci_dev, PCI_ERR_VER, e1000e_aer_offset,
+                              PCI_ERR_SIZEOF) < 0) {
         hw_error("Failed to initialize AER capability");
     }
 
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index c8b5ac4..d70784c 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -135,7 +135,7 @@ static int ioh3420_initfn(PCIDevice *d)
         goto err_pcie_cap;
     }
 
-    rc = pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, PCI_ERR_VER, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF);
     if (rc < 0) {
         goto err;
     }
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index cef6e13..5d1ce01 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -97,7 +97,7 @@ static int xio3130_downstream_initfn(PCIDevice *d)
         goto err_pcie_cap;
     }
 
-    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
     if (rc < 0) {
         goto err;
     }
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 4ad0440..3819964 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -85,7 +85,7 @@ static int xio3130_upstream_initfn(PCIDevice *d)
     pcie_cap_flr_init(d);
     pcie_cap_deverr_init(d);
 
-    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
     if (rc < 0) {
         goto err;
     }
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 048ce6a..ac47f34 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -96,11 +96,12 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
     aer_log->log_num = 0;
 }
 
-int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size)
+int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
+                  uint16_t size)
 {
     PCIExpressDevice *exp;
 
-    pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, PCI_ERR_VER,
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
                         offset, size);
     exp = &dev->exp;
     exp->aer_cap = offset;
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index c2ee4e2..c373591 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -87,7 +87,8 @@ struct PCIEAERErr {
 
 extern const VMStateDescription vmstate_pcie_aer_log;
 
-int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size);
+int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
+                  uint16_t size);
 void pcie_aer_exit(PCIDevice *dev);
 void pcie_aer_write_config(PCIDevice *dev,
                            uint32_t addr, uint32_t val, int len);
-- 
1.8.3.1
