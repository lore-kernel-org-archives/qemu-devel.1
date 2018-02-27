Received: from eggs.gnu.org ([2001:4830:134:3::10]:54711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcos-0006Jh-Gr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcor-0004BV-Gv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:14 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqcor-0004Ah-8D
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:13 -0500
Received: by mail-lf0-x241.google.com with SMTP id 37so26791850lfs.7
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:49:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 11:49:00 +0100
Message-Id: <20180227104903.21353-3-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-1-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] i2c: Move the bus class to i2c.h
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

From: Corey Minyard <cminyard@mvista.com>

Some devices need access to it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 hw/i2c/core.c        | 17 -----------------
 include/hw/i2c/i2c.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 9a54b61c1dbd..cfccefca3d6c 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -10,30 +10,13 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 
-typedef struct I2CNode I2CNode;
-
-struct I2CNode {
-    I2CSlave *elt;
-    QLIST_ENTRY(I2CNode) next;
-};
-
 #define I2C_BROADCAST 0x00
 
-struct I2CBus {
-    BusState qbus;
-    QLIST_HEAD(, I2CNode) current_devs;
-    uint8_t saved_address;
-    bool broadcast;
-};
-
 static Property i2c_props[] = {
     DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-#define TYPE_I2C_BUS "i2c-bus"
-#define I2C_BUS(obj) OBJECT_CHECK(I2CBus, (obj), TYPE_I2C_BUS)
-
 static const TypeInfo i2c_bus_info = {
     .name = TYPE_I2C_BUS,
     .parent = TYPE_BUS,
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 8fd449f645f0..d727379b487a 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -56,6 +56,23 @@ struct I2CSlave {
     uint8_t address;
 };
 
+#define TYPE_I2C_BUS "i2c-bus"
+#define I2C_BUS(obj) OBJECT_CHECK(I2CBus, (obj), TYPE_I2C_BUS)
+
+typedef struct I2CNode I2CNode;
+
+struct I2CNode {
+    I2CSlave *elt;
+    QLIST_ENTRY(I2CNode) next;
+};
+
+struct I2CBus {
+    BusState qbus;
+    QLIST_HEAD(, I2CNode) current_devs;
+    uint8_t saved_address;
+    bool broadcast;
+};
+
 I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
 void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
 int i2c_bus_busy(I2CBus *bus);
-- 
2.14.3
