Received: from eggs.gnu.org ([2001:4830:134:3::10]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fstmc-0004Eg-02
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fstmb-0003iR-7B
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:52:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 18:52:25 +0100
Message-Id: <20180823175225.22612-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/mps2: Fix ID register errors on AN511
 and AN385
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Fix MPS2 SCC config register values for the mps2-an511
and mps2-an385 boards:
 * the SCC_AID bits [23:20] specify the FPGA build target board revision,
   and the SCC_CFG4 register specifies the actual board revision, so
   these should have matching values. Claim to be board revision C,
   consistently -- we had the revision in the wrong part of SCC_AID.
 * SCC_ID bits [15:4] should be the board number in hex, not decimal

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This fixes a bug that I noticed for the AN505 model and fixed there,
but forgot to also fix on our other MPS image models.

 hw/arm/mps2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 0a0ae867d9b..26934ecb31c 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -301,7 +301,7 @@ static void mps2_common_init(MachineState *machine)
     sccdev = DEVICE(&mms->scc);
     qdev_set_parent_bus(sccdev, sysbus_get_default());
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
-    qdev_prop_set_uint32(sccdev, "scc-aid", 0x02000008);
+    qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
     object_property_set_bool(OBJECT(&mms->scc), true, "realized",
                              &error_fatal);
@@ -336,7 +336,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN385 FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mmc->scc_id = 0x41040000 | (385 << 4);
+    mmc->scc_id = 0x41043850;
 }
 
 static void mps2_an511_class_init(ObjectClass *oc, void *data)
@@ -347,7 +347,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mmc->scc_id = 0x4104000 | (511 << 4);
+    mmc->scc_id = 0x41045110;
 }
 
 static const TypeInfo mps2_info = {
-- 
2.18.0
