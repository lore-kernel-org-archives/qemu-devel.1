Received: from eggs.gnu.org ([2001:4830:134:3::10]:46393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1en362-0006bU-81
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1en35x-00049R-V8
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:04:10 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:43542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1en35x-00048k-OJ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:04:05 -0500
Received: by mail-lf0-x243.google.com with SMTP id q69so7577081lfi.10
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 06:04:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 17 Feb 2018 15:00:51 +0100
Message-Id: <20180217140051.22731-3-linus.walleij@linaro.org>
In-Reply-To: <20180217140051.22731-1-linus.walleij@linaro.org>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] arm/vexpress: Add proper display connector
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Linus Walleij <linus.walleij@linaro.org>

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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 default-configs/arm-softmmu.mak | 2 ++
 hw/arm/vexpress.c               | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index dc5928ae1ab5..d6c912c97684 100644
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
@@ -628,7 +630,10 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
 
-    /* VE_SERIALDVI: not modelled */
+    dev = sysbus_create_simple("versatile_i2c", map[VE_SERIALDVI], NULL);
+    i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c_create_slave(i2c, "sii9022", 0x39);
+    i2c_create_slave(i2c, "i2c-ddc", 0x50);
 
     sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
 
-- 
2.14.3
