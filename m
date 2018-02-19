Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEu-0003CD-F7
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEo-0008Uk-E6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:24 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 19 Feb 2018 09:20:06 -0600
Message-Id: <1519053606-9817-3-git-send-email-minyard@acm.org>
In-Reply-To: <1519053606-9817-1-git-send-email-minyard@acm.org>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Some devices need access to it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/core.c        | 17 -----------------
 include/hw/i2c/i2c.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 9a54b61..cfccefc 100644
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
index 8fd449f..d727379 100644
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
2.7.4
