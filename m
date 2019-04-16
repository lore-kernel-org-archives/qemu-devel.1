Received: from eggs.gnu.org ([209.51.188.92]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4U-0006VI-7K
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4T-0007pr-87
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:38 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:39:01 -0700
Message-Id: <20190416013902.4941-5-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] pci: designware: Update MSI mapping when
 MSI address changes
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

MSI mapping needs to be update when MSI address changes, so add the
code to do so.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/pci-host/designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 6affe823c0..e80facc4a0 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -289,11 +289,13 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_ADDR_LO:
         root->msi.base &= 0xFFFFFFFF00000000ULL;
         root->msi.base |= val;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_ADDR_HI:
         root->msi.base &= 0x00000000FFFFFFFFULL;
         root->msi.base |= (uint64_t)val << 32;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
-- 
2.20.1
