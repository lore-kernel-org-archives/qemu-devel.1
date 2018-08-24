Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UK-0007gk-Sv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UI-0004nE-Rw
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UH-0004kS-72
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UB-0006cp-Ew
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:31 +0100
Message-Id: <20180824093343.11346-41-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 40/52] hw/arm/mps2-tz: Fix MPS2 SCC config
 register values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some of the config register values we were setting for the MPS2 SCC
weren't correct:
 * the SCC_AID bits [23:20] specify the FPGA build target board revision,
   and the SCC_CFG4 register specifies the actual board revision, so
   these should have matching values. Claim to be board revision C,
   consistently -- we had the revision in the wrong part of SCC_AID.
 * SCC_ID bits [15:4] should be 0x505, not decimal 505

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180820141116.9118-23-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/mps2-tz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index cedf605e20e..6dd02ae47e8 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -192,7 +192,7 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
     sccdev = DEVICE(scc);
     qdev_set_parent_bus(sccdev, sysbus_get_default());
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
-    qdev_prop_set_uint32(sccdev, "scc-aid", 0x02000008);
+    qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
     object_property_set_bool(OBJECT(scc), true, "realized", &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(sccdev), 0);
@@ -604,7 +604,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN505 FPGA image for Cortex-M33";
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
-    mmc->scc_id = 0x41040000 | (505 << 4);
+    mmc->scc_id = 0x41045050;
 }
 
 static const TypeInfo mps2tz_info = {
-- 
2.18.0
