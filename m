Received: from eggs.gnu.org ([2001:4830:134:3::10]:33762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-0003iB-Ef
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-00086h-76
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJt-00082m-0U
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJj-0000YG-WC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:26 +0000
Message-Id: <20180301112403.12487-6-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/42] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Corey Minyard <cminyard@mvista.com>

Some devices need access to it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180227104903.21353-3-linus.walleij@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/i2c.h | 17 +++++++++++++++++
 hw/i2c/core.c        | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 8fd449f645..d727379b48 100644
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
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 9a54b61c1d..cfccefca3d 100644
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
-- 
2.16.2
