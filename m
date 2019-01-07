Received: from eggs.gnu.org ([209.51.188.92]:46497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoi-00056A-97
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXof-0002HQ-5I
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:54 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXod-0002C4-6S
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id 96so1090368wrb.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:03 +0000
Message-Id: <20190107163117.16269-24-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/37] hw/arm/allwinner-a10: Add the 'A' SRAM
 and the SRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-id: 20190104142921.878-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-a10.h | 1 +
 hw/arm/allwinner-a10.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index efb8fc81236..389e128d0fc 100644
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
index 9fe875cdb5e..df0d079ad0a 100644
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
2.19.2
