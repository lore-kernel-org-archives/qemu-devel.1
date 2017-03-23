Received: from eggs.gnu.org ([2001:4830:134:3::10]:44054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybv-0004uC-Ie
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybt-00073q-Ks
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:47 -0400
Received: from [59.151.112.132] (port=34027 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybt-00070x-9E
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:45 -0400
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Thu, 23 Mar 2017 17:09:21 +0800
Message-ID: <1490260163-6157-2-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/3] pcie aer: verify if AER functionality
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

For devices which support AER function, verify it can work or not in the
system:
1. AER capable device is a PCIe device, it can't be plugged into PCI bus
2. If root port doesn't support AER, then there is no need to expose the
   AER capability

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/pci/pcie_aer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index daf1f65..a2e9818 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -100,6 +100,34 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
 int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
                   uint16_t size, Error **errp)
 {
+    PCIDevice *parent_dev;
+    uint8_t type;
+    uint8_t parent_type;
+
+    /* Topology test: see if there is need to expose AER cap */
+    type = pcie_cap_get_type(dev);
+    parent_dev = pci_bridge_get_device(dev->bus);
+    while (parent_dev) {
+        parent_type = pcie_cap_get_type(parent_dev);
+
+        if (type == PCI_EXP_TYPE_ENDPOINT &&
+                (parent_type != PCI_EXP_TYPE_ROOT_PORT &&
+                 parent_type != PCI_EXP_TYPE_DOWNSTREAM)) {
+            error_setg(errp, "Parent device is not a PCIe component");
+            return -ENOTSUP;
+        }
+        
+        if (parent_type == PCI_EXP_TYPE_ROOT_PORT) {
+            if (!parent_dev->exp.aer_cap)
+            {
+                error_setg(errp, "Root port does not support AER");
+                return -ENOTSUP;
+            }
+        }
+
+        parent_dev = pci_bridge_get_device(parent_dev->bus);
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
                         offset, size);
     dev->exp.aer_cap = offset;
-- 
1.8.3.1
