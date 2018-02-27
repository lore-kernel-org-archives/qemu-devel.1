Received: from eggs.gnu.org ([2001:4830:134:3::10]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcoz-0006Q5-Qk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcox-0004El-1Q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:21 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqcow-0004Do-QZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:18 -0500
Received: by mail-lf0-x243.google.com with SMTP id f75so21788873lfg.6
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:49:18 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 11:49:03 +0100
Message-Id: <20180227104903.21353-6-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-1-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] arm/vexpress: Add proper display connector
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, Linus Walleij <linus.walleij@linaro.org>

This adds the SiI9022 and EDID I2C devices to the ARM Versatile
Express machine, and selects the two I2C devices necessary in the
arm-softmmy.mak configuration so everything will build smoothly.

I am implementing proper handling of the graphics in the Linux
kernel and adding proper emulation of SiI9022 and EDID makes the
driver probe as nicely as before, retrieveing the resolutions
supported by the "QEMU monitor" and overall just working nice.

The assignment of the SiI9022 at address 0x39 and the EDID
DDC I2C at address 0x50 is not strictly correct: the DDC I2C
is there all the time but in the actual component it only
appears once activated inside the SiI9022, so ideally it should
be added and removed to the bus by the SiI9022. However for this
purpose it works fine to just have it around.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Only add the SII9022 now that it will by itself realize
  the DDCI2C as part of the bridge.
---
 default-configs/arm-softmmu.mak | 2 ++
 hw/arm/vexpress.c               | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index ca34cf446242..54f855d07206 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -21,6 +21,8 @@ CONFIG_STELLARIS_INPUT=y
 CONFIG_STELLARIS_ENET=y
 CONFIG_SSD0303=y
 CONFIG_SSD0323=y
+CONFIG_DDC=y
+CONFIG_SII9022=y
 CONFIG_ADS7846=y
 CONFIG_MAX111X=y
 CONFIG_SSI=y
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index dc5928ae1ab5..9fad79177a19 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -29,6 +29,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/devices.h"
+#include "hw/i2c/i2c.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -537,6 +538,7 @@ static void vexpress_common_init(MachineState *machine)
     uint32_t sys_id;
     DriveInfo *dinfo;
     pflash_t *pflash0;
+    I2CBus *i2c;
     ram_addr_t vram_size, sram_size;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *vram = g_new(MemoryRegion, 1);
@@ -628,7 +630,9 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
 
-    /* VE_SERIALDVI: not modelled */
+    dev = sysbus_create_simple("versatile_i2c", map[VE_SERIALDVI], NULL);
+    i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c_create_slave(i2c, "sii9022", 0x39);
 
     sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
 
-- 
2.14.3
