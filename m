Received: from eggs.gnu.org ([2001:4830:134:3::10]:35553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tv-0007Io-Rf
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tu-00042g-TE
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tu-0003xu-KK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tt-0006VZ-K3
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:14 +0100
Message-Id: <20180824093343.11346-24-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/52] hw/arm/mps2: Wire up dual-timer in
 mps2-an385 and mps2-an511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The MPS2 FPGA images for the Cortex-M3 (mps2-an385 and mps2-511)
both include a CMSDK dual-timer module. Wire this up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180820141116.9118-6-peter.maydell@linaro.org
---
 hw/arm/mps2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 0a0ae867d9b..564624629d0 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -34,6 +34,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/timer/cmsdk-apb-timer.h"
+#include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/devices.h"
 #include "net/net.h"
@@ -64,6 +65,7 @@ typedef struct {
     MemoryRegion blockram_m3;
     MemoryRegion sram;
     MPS2SCC scc;
+    CMSDKAPBDualTimer dualtimer;
 } MPS2MachineState;
 
 #define TYPE_MPS2_MACHINE "mps2"
@@ -297,6 +299,15 @@ static void mps2_common_init(MachineState *machine)
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
     cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
 
+    sysbus_init_child_obj(OBJECT(mms), "dualtimer", &mms->dualtimer,
+                          sizeof(mms->dualtimer), TYPE_CMSDK_APB_DUALTIMER);
+    qdev_prop_set_uint32(DEVICE(&mms->dualtimer), "pclk-frq", SYSCLK_FRQ);
+    object_property_set_bool(OBJECT(&mms->dualtimer), true, "realized",
+                             &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
+                       qdev_get_gpio_in(armv7m, 10));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
+
     object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
     qdev_set_parent_bus(sccdev, sysbus_get_default());
-- 
2.18.0
