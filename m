Received: from eggs.gnu.org ([2001:4830:134:3::10]:42211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuJ-0003kx-0r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuI-0007Tb-Bl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:16 +0100
Message-Id: <20180820141116.9118-23-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 22/22] hw/arm/mps2-tz: Fix MPS2 SCC config
 register values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Some of the config register values we were setting for the MPS2 SCC
weren't correct:
 * the SCC_AID bits [23:20] specify the FPGA build target board revision,
   and the SCC_CFG4 register specifies the actual board revision, so
   these should have matching values. Claim to be board revision C,
   consistently -- we had the revision in the wrong part of SCC_AID.
 * SCC_ID bits [15:4] should be 0x505, not decimal 505

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index cedf605e20e..cb252d8ebcc 100644
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
+    mmc->scc_id = 0x41040000 | (0x505 << 4);
 }
 
 static const TypeInfo mps2tz_info = {
-- 
2.18.0
