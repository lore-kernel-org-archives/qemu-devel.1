Received: from eggs.gnu.org ([2001:4830:134:3::10]:37398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5N-0004kI-ET
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5M-0000EA-07
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:17 -0500
Received: from [59.151.112.132] (port=46652 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5K-0000Co-Lp
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:15 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 16:21:30 +0800
Message-ID: <1482308491-25426-2-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1482308491-25426-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1482308491-25426-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/2] pcie_aer: Convert pcie_aer_init to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, dmitry@daynix.com, jasowang@redhat.com

When user specify invalid value for property aer_log_max, device should
fail to create, and report appropriate message.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Acked-by: Dmitry Fleytman <dmitry@daynix.com>
---
 hw/net/e1000e.c                    |  2 +-
 hw/pci-bridge/ioh3420.c            |  3 ++-
 hw/pci-bridge/xio3130_downstream.c |  3 ++-
 hw/pci-bridge/xio3130_upstream.c   |  3 ++-
 hw/pci/pcie_aer.c                  | 17 +++++++----------
 include/hw/pci/pcie_aer.h          |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 4994e1ca0062..89f96eb4a076 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -472,7 +472,7 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize PM capability");
     }
 
-    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF) < 0) {
+    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF, NULL) < 0) {
         hw_error("Failed to initialize AER capability");
     }
 
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index c8b5ac4207c5..04180af79471 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -135,8 +135,9 @@ static int ioh3420_initfn(PCIDevice *d)
         goto err_pcie_cap;
     }
 
-    rc = pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF, &err);
     if (rc < 0) {
+        error_report_err(err);
         goto err;
     }
     pcie_aer_root_init(d);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index cef6e1325ebf..571334185b42 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -97,8 +97,9 @@ static int xio3130_downstream_initfn(PCIDevice *d)
         goto err_pcie_cap;
     }
 
-    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, &err);
     if (rc < 0) {
+        error_report_err(err);
         goto err;
     }
 
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 4ad0440aa164..94c16910069e 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -85,8 +85,9 @@ static int xio3130_upstream_initfn(PCIDevice *d)
     pcie_cap_flr_init(d);
     pcie_cap_deverr_init(d);
 
-    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
+    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, &err);
     if (rc < 0) {
+        error_report_err(err);
         goto err;
     }
 
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 048ce6a42455..2a4bd5aef639 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -29,6 +29,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
+#include "qapi/error.h"
 
 //#define DEBUG_PCIE
 #ifdef DEBUG_PCIE
@@ -96,21 +97,17 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
     aer_log->log_num = 0;
 }
 
-int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size)
+int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
+                  Error **errp)
 {
-    PCIExpressDevice *exp;
-
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, PCI_ERR_VER,
                         offset, size);
-    exp = &dev->exp;
-    exp->aer_cap = offset;
+    dev->exp.aer_cap = offset;
 
-    /* log_max is property */
-    if (dev->exp.aer_log.log_max == PCIE_AER_LOG_MAX_UNSET) {
-        dev->exp.aer_log.log_max = PCIE_AER_LOG_MAX_DEFAULT;
-    }
-    /* clip down the value to avoid unreasobale memory usage */
+    /* clip down the value to avoid unreasonable memory usage */
     if (dev->exp.aer_log.log_max > PCIE_AER_LOG_MAX_LIMIT) {
+        error_setg(errp, "Invalid aer_log_max %d. The max number of aer log "
+                "is %d", dev->exp.aer_log.log_max, PCIE_AER_LOG_MAX_LIMIT);
         return -EINVAL;
     }
     dev->exp.aer_log.log = g_malloc0(sizeof dev->exp.aer_log.log[0] *
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index c2ee4e2bdbfc..5891b6816e85 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -44,7 +44,6 @@ struct PCIEAERLog {
      */
 #define PCIE_AER_LOG_MAX_DEFAULT        8
 #define PCIE_AER_LOG_MAX_LIMIT          128
-#define PCIE_AER_LOG_MAX_UNSET          0xffff
     uint16_t log_max;
 
     /* Error log. log_max-sized array */
@@ -87,7 +86,8 @@ struct PCIEAERErr {
 
 extern const VMStateDescription vmstate_pcie_aer_log;
 
-int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size);
+int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
+                  Error **errp);
 void pcie_aer_exit(PCIDevice *dev);
 void pcie_aer_write_config(PCIDevice *dev,
                            uint32_t addr, uint32_t val, int len);
-- 
2.1.0
