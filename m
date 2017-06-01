Received: from eggs.gnu.org ([2001:4830:134:3::10]:35296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTca-00018A-B4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcZ-0006EG-61
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcY-00067A-Tv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcX-0007TI-VJ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:28 +0100
Message-Id: <1496337035-30213-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/27] aspeed/i2c: improve command handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Multiple I2C commands can be fired simultaneously and the controller
execute the commands following these priorities:

  (1) Master Start Command
  (2) Master Transmit Command
  (3) Slave Transmit Command or Master Receive Command
  (4) Master Stop Command

The current code is incorrect with respect to the above sequence and
needs to be reworked to handle each individual command.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1494827476-1487-2-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/aspeed_i2c.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ce5b1f0..56a4fdf 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -171,6 +171,7 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
 
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
+    bus->cmd &= ~0xFFFF;
     bus->cmd |= value & 0xFFFF;
     bus->intr_status = 0;
 
@@ -182,15 +183,27 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
             bus->intr_status |= I2CD_INTR_TX_ACK;
         }
 
-    } else if (bus->cmd & I2CD_M_TX_CMD) {
+        /* START command is also a TX command, as the slave address is
+         * sent on the bus */
+        bus->cmd &= ~(I2CD_M_START_CMD | I2CD_M_TX_CMD);
+
+        /* No slave found */
+        if (!i2c_bus_busy(bus->bus)) {
+            return;
+        }
+    }
+
+    if (bus->cmd & I2CD_M_TX_CMD) {
         if (i2c_send(bus->bus, bus->buf)) {
             bus->intr_status |= (I2CD_INTR_TX_NAK | I2CD_INTR_ABNORMAL);
             i2c_end_transfer(bus->bus);
         } else {
             bus->intr_status |= I2CD_INTR_TX_ACK;
         }
+        bus->cmd &= ~I2CD_M_TX_CMD;
+    }
 
-    } else if (bus->cmd & I2CD_M_RX_CMD) {
+    if (bus->cmd & I2CD_M_RX_CMD) {
         int ret = i2c_recv(bus->bus);
         if (ret < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
@@ -199,6 +212,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
             bus->intr_status |= I2CD_INTR_RX_DONE;
         }
         bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
+        bus->cmd &= ~I2CD_M_RX_CMD;
     }
 
     if (bus->cmd & (I2CD_M_STOP_CMD | I2CD_M_S_RX_CMD_LAST)) {
@@ -208,11 +222,8 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
             i2c_end_transfer(bus->bus);
             bus->intr_status |= I2CD_INTR_NORMAL_STOP;
         }
+        bus->cmd &= ~I2CD_M_STOP_CMD;
     }
-
-    /* command is handled, reset it and check for interrupts  */
-    bus->cmd &= ~0xFFFF;
-    aspeed_i2c_bus_raise_interrupt(bus);
 }
 
 static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
@@ -262,6 +273,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
         }
 
         aspeed_i2c_bus_handle_cmd(bus, value);
+        aspeed_i2c_bus_raise_interrupt(bus);
         break;
 
     default:
-- 
2.7.4
