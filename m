Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-0003gR-Sg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJr-00085e-Sd
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJr-00084T-LF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJm-0000Yw-00
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:10 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:29 +0000
Message-Id: <20180301112403.12487-9-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/42] arm/vexpress: Add proper display
 connector emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the SiI9022 (and implicitly EDID I2C) device to the ARM
Versatile Express machine, and selects the two I2C devices necessary
in the arm-softmmu.mak configuration so everything will build
smoothly.

I am implementing proper handling of the graphics in the Linux
kernel and adding proper emulation of SiI9022 and EDID makes the
driver probe as nicely as before, retrieving the resolutions
supported by the "QEMU monitor" and overall just working nice.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180227104903.21353-6-linus.walleij@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/vexpress.c               | 6 +++++-
 default-configs/arm-softmmu.mak | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index dc5928ae1a..9fad79177a 100644
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
 
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index ca34cf4462..54f855d072 100644
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
-- 
2.16.2
