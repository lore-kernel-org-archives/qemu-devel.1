Received: from eggs.gnu.org ([208.118.235.92]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gfQTa-00011D-CZ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gfQTV-0001LQ-5i
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:29:30 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 Jan 2019 15:29:21 +0100
Message-Id: <20190104142921.878-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/arm/allwinner-a10: Add the 'A' SRAM and
 the SRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Charlie Smurthwaite <charlie@atech.media>, Beniamino Galvani <b.galvani@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

>From the "A10 User Manual V1.20" p.29: "3.2. Memory Mapping" and:

 7. System Control
  7.1. Overview

  A10 embeds a high-speed SRAM which has been split into five segments.
  See detailed memory mapping in following table:

  Area          Address        Size (Bytes)
   A1    0x00000000-0x00003FFF 16K
   A2    0x00004000-0x00007FFF 16K
   A3    0x00008000-0x0000B3FF 13K
   A4    0x0000B400-0x0000BFFF  3K

Since for emulation purpose we don't need the segmentations, we simply define
the 'A' area as a single 48KB SRAM.

We don't implement the following others areas:
- 'B': 'Secure RAM' (64K),
- 'C': Debug/ISP SRAM
- 'D': USB SRAM

(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000000000bfff (prio 0, ram): sram A
    0000000001c00000-0000000001c00fff (prio -1000, i/o): a10-sram-ctrl
    0000000001c0b000-0000000001c0bfff (prio 0, i/o): aw_emac
    0000000001c18000-0000000001c18fff (prio 0, i/o): ahci
      0000000001c18080-0000000001c180ff (prio 0, i/o): allwinner-ahci
    0000000001c20400-0000000001c207ff (prio 0, i/o): allwinner-a10-pic
    0000000001c20c00-0000000001c20fff (prio 0, i/o): allwinner-A10-timer
    0000000001c28000-0000000001c2801f (prio 0, i/o): serial
    0000000040000000-0000000047ffffff (prio 0, ram): cubieboard.ram

Reported-by: Charlie Smurthwaite <charlie@atech.media>
Tested-by: Charlie Smurthwaite <charlie@atech.media>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Set owner=SoC in memory_region_init_ram() to avoid leak
    when SoC is destroyed (Peter Maydell)
---
 include/hw/arm/allwinner-a10.h | 1 +
 hw/arm/allwinner-a10.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index efb8fc8123..389e128d0f 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -35,6 +35,7 @@ typedef struct AwA10State {
     AwA10PICState intc;
     AwEmacState emac;
     AllwinnerAHCIState sata;
+    MemoryRegion sram_a;
 } AwA10State;
 
 #define ALLWINNER_H_
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 9fe875cdb5..df0d079ad0 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "hw/devices.h"
 #include "hw/arm/allwinner-a10.h"
+#include "hw/misc/unimp.h"
 
 static void aw_a10_init(Object *obj)
 {
@@ -85,6 +86,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
     sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
 
+    memory_region_init_ram(&s->sram_a, OBJECT(dev), "sram A", 48 * KiB,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x00000000, &s->sram_a);
+    create_unimplemented_device("a10-sram-ctrl", 0x01c00000, 4 * KiB);
+
     /* FIXME use qdev NIC properties instead of nd_table[] */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
-- 
2.19.1
