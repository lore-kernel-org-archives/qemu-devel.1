Received: from eggs.gnu.org ([209.51.188.92]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4T-0006U1-3F
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4S-0007p5-4V
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:37 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:39:00 -0700
Message-Id: <20190416013902.4941-4-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] pci: designware: Update MSI mapping
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Expression to calculate update_msi_mapping in code handling writes to
DESIGNWARE_PCIE_MSI_INTR0_ENABLE is missing an ! operator and should
be:

    !!root->msi.intr[0].enable ^ !!val;

so that MSI mapping is updated when enabled transitions from either
"none" -> "any" or "any" -> "none". Since that register shouldn't be
written to very often, change the code to update MSI mapping
unconditionally instead of trying to fix the update_msi_mapping logic.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/pci-host/designware.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..6affe823c0 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -296,16 +296,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         root->msi.base |= (uint64_t)val << 32;
         break;
 
-    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE: {
-        const bool update_msi_mapping = !root->msi.intr[0].enable ^ !!val;
-
+    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
         root->msi.intr[0].enable = val;
-
-        if (update_msi_mapping) {
-            designware_pcie_root_update_msi_mapping(root);
-        }
+        designware_pcie_root_update_msi_mapping(root);
         break;
-    }
 
     case DESIGNWARE_PCIE_MSI_INTR0_MASK:
         root->msi.intr[0].mask = val;
-- 
2.20.1
