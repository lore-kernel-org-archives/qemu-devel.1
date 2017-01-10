Received: from eggs.gnu.org ([2001:4830:134:3::10]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAR-0007q3-CW
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAQ-0005kB-9v
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:19 -0500
Received: from mail.kernel.org ([198.145.29.136]:48144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAQ-0005k1-06
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:18 -0500
Date: Tue, 10 Jan 2017 07:40:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-22-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/41] pcie_aer: Convert pcie_aer_init to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Marcel Apfelbaum <marcel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

When user specify invalid value for property aer_log_max, device should
fail to create, and report appropriate message.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Acked-by: Dmitry Fleytman <dmitry@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_aer.h          |  4 ++--
 hw/net/e1000e.c                    |  2 +-
 hw/pci-bridge/ioh3420.c            |  3 ++-
 hw/pci-bridge/xio3130_downstream.c |  3 ++-
 hw/pci-bridge/xio3130_upstream.c   |  3 ++-
 hw/pci/pcie_aer.c                  | 17 +++++++----------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index c2ee4e2..5891b68 100644
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
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 4994e1c..89f96eb 100644
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
index c8b5ac4..04180af 100644
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
index cef6e13..5713341 100644
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
index 4ad0440..94c1691 100644
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
index 048ce6a..2a4bd5a 100644
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
-- 
MST
