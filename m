Received: from eggs.gnu.org ([2001:4830:134:3::10]:60841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0001ee-2a
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfR-0006CB-QR
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfR-00065w-Iq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfN-0003dz-75
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:47 +0100
Message-Id: <20180615142521.19143-10-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/43] stellaris: Stop using armv7m_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The stellaris board is still using the legacy armv7m_init() function,
which predates conversion of the ARMv7M into a proper QOM container
object. Make the board code directly create the ARMv7M object instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180601144328.23817-2-peter.maydell@linaro.org
---
 hw/arm/stellaris.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 502a20842c0..a8f1f6a9128 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
@@ -1298,8 +1299,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                            &error_fatal);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
 
-    nvic = armv7m_init(system_memory, flash_size, NUM_IRQ_LINES,
-                       ms->kernel_filename, ms->cpu_type);
+    nvic = qdev_create(NULL, TYPE_ARMV7M);
+    qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
+    qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
+    object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
+                                     "memory", &error_abort);
+    /* This will exit with an error if the user passed us a bad cpu_type */
+    qdev_init_nofail(nvic);
 
     qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
                                 qemu_allocate_irq(&do_sys_reset, NULL, 0));
@@ -1431,6 +1437,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     create_unimplemented_device("analogue-comparator", 0x4003c000, 0x1000);
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size);
 }
 
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
-- 
2.17.1
