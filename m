Received: from eggs.gnu.org ([2001:4830:134:3::10]:59036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Ob-0007qm-EA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oa-0002D9-JA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Oa-0002Ci-BV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OZ-0003XV-Ee
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:45:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:53 +0100
Message-Id: <1500295494-8991-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/18] hw/arm/mps2: Add ethernet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The MPS2 FPGA images support ethernet via a LAN9220. We use
QEMU's LAN9118 model, which is software compatible except
that it is missing the checksum-offload feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1500029487-14822-9-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 80ee79e..f727b43 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -35,6 +35,8 @@
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/devices.h"
+#include "net/net.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -209,7 +211,6 @@ static void mps2_common_init(MachineState *machine)
     create_unimplemented_device("Extra peripheral region @0x40020000",
                                 0x40020000, 0x00010000);
     create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
-    create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
     create_unimplemented_device("VGA", 0x41000000, 0x0200000);
 
     switch (mmc->fpga_type) {
@@ -310,6 +311,13 @@ static void mps2_common_init(MachineState *machine)
                              &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
 
+    /* In hardware this is a LAN9220; the LAN9118 is software compatible
+     * except that it doesn't support the checksum-offload feature.
+     */
+    lan9118_init(&nd_table[0], 0x40200000,
+                 qdev_get_gpio_in(armv7m,
+                                  mmc->fpga_type == FPGA_AN385 ? 13 : 47));
+
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-- 
2.7.4
