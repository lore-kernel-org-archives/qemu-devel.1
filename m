Received: from eggs.gnu.org ([2001:4830:134:3::10]:36284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpe0-0004x2-H2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpdv-0002CZ-Sj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:12 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:06 +0200
Message-Id: <1504286483-23327-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 03/20] hw/arm/smmu-common:
 smmu_read/write_sysmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

Those two functions will be used to access configuration
data (STE, CD) and page table entries in guest RAM.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmu-common.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3e67992..2a94547 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,43 @@
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
 
+inline MemTxResult smmu_read_sysmem(dma_addr_t addr, void *buf, dma_addr_t len,
+                                    bool secure)
+{
+    MemTxAttrs attrs = {.unspecified = 1, .secure = secure};
+
+    switch (len) {
+    case 4:
+        *(uint32_t *)buf = ldl_le_phys(&address_space_memory, addr);
+        break;
+    case 8:
+        *(uint64_t *)buf = ldq_le_phys(&address_space_memory, addr);
+        break;
+    default:
+        return address_space_rw(&address_space_memory, addr,
+                                attrs, buf, len, false);
+    }
+    return MEMTX_OK;
+}
+
+inline void
+smmu_write_sysmem(dma_addr_t addr, void *buf, dma_addr_t len, bool secure)
+{
+    MemTxAttrs attrs = {.unspecified = 1, .secure = secure};
+
+    switch (len) {
+    case 4:
+        stl_le_phys(&address_space_memory, addr, *(uint32_t *)buf);
+        break;
+    case 8:
+        stq_le_phys(&address_space_memory, addr, *(uint64_t *)buf);
+        break;
+    default:
+        address_space_rw(&address_space_memory, addr,
+                         attrs, buf, len, true);
+    }
+}
+
 /******************/
 /* Infrastructure */
 /******************/
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 20f3fe6..a5999b0 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -111,4 +111,9 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
     return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
 }
+
+MemTxResult smmu_read_sysmem(dma_addr_t addr, void *buf,
+                             dma_addr_t len, bool secure);
+void smmu_write_sysmem(dma_addr_t addr, void *buf, dma_addr_t len, bool secure);
+
 #endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
