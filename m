Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-0007eO-6I
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWci-00050v-F0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWci-0004zS-7Q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcf-0000gM-3Q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:25 +0100
Message-Id: <20180709135435.836-2-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/11] hw/arm/smmu-common: Fix devfn computation
 in smmu_iommu_mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

smmu_iommu_mr() aims at returning the IOMMUMemoryRegion corresponding
to a given sid. The function extracts both the PCIe bus number and
the devfn to return this data. Current computation of devfn is wrong
as it only returns the PCIe function instead of slot | function.

Fixes 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1530775623-32399-1-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 1 +
 hw/arm/smmu-common.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 50e2912a95e..b07cadd0ef9 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -24,6 +24,7 @@
 
 #define SMMU_PCI_BUS_MAX      256
 #define SMMU_PCI_DEVFN_MAX    256
+#define SMMU_PCI_DEVFN(sid)   (sid & 0xFF)
 
 #define SMMU_MAX_VA_BITS      48
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3098915d07c..55c75d65d2e 100644
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
-- 
2.17.1
