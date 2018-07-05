Received: from eggs.gnu.org ([2001:4830:134:3::10]:51393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fayfc-00071S-RD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fayfb-0003R9-Tr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:27:16 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu,  5 Jul 2018 09:27:03 +0200
Message-Id: <1530775623-32399-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.0] hw/arm/smmu-common: Fix devfn
 computation in smmu_iommu_mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

smmu_iommu_mr() aims at returning the IOMMUMemoryRegion corresponding
to a given sid. The function extracts both the PCIe bus number and
the devfn to return this data. Current computation of devfn is wrong
as it only returns the PCIe function instead of slot | function.

Fixes 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         | 2 +-
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3098915..55c75d6 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -351,7 +351,7 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
     bus_n = PCI_BUS_NUM(sid);
     smmu_bus = smmu_find_smmu_pcibus(s, bus_n);
     if (smmu_bus) {
-        devfn = sid & 0x7;
+        devfn = SMMU_PCI_DEVFN(sid);
         smmu = smmu_bus->pbdev[devfn];
         if (smmu) {
             return &smmu->iommu;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 50e2912..b07cadd 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -24,6 +24,7 @@
 
 #define SMMU_PCI_BUS_MAX      256
 #define SMMU_PCI_DEVFN_MAX    256
+#define SMMU_PCI_DEVFN(sid)   (sid & 0xFF)
 
 #define SMMU_MAX_VA_BITS      48
 
-- 
2.5.5
