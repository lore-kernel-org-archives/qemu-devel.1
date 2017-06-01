Received: from eggs.gnu.org ([2001:4830:134:3::10]:35346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcc-0001Af-2D
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTca-0006Fc-Ng
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:53 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTca-0006DU-E9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcZ-0007UQ-9E
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:30 +0100
Message-Id: <1496337035-30213-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/27] aspeed/i2c: introduce a state machine
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

The Aspeed I2C controller maintains a state machine in the command
register, which is mostly used for debug.

Let's start adding a few states to handle abnormal STOP
commands. Today, the model uses the busy status of the bus as a
condition to do so but it is not precise enough.

Also remove the ABNORMAL bit for failing TX commands. This is
incorrect with respect to the specs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1494827476-1487-4-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/aspeed_i2c.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 67004c6..c762c73 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -169,6 +169,21 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
     }
 }
 
+static void aspeed_i2c_set_state(AspeedI2CBus *bus, uint8_t state)
+{
+    bus->cmd &= ~(I2CD_TX_STATE_MASK << I2CD_TX_STATE_SHIFT);
+    bus->cmd |= (state & I2CD_TX_STATE_MASK) << I2CD_TX_STATE_SHIFT;
+}
+
+static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
+{
+    return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
+}
+
+/*
+ * The state machine needs some refinement. It is only used to track
+ * invalid STOP commands for the moment.
+ */
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
     bus->cmd &= ~0xFFFF;
@@ -176,6 +191,11 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
     bus->intr_status = 0;
 
     if (bus->cmd & I2CD_M_START_CMD) {
+        uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
+            I2CD_MSTARTR : I2CD_MSTART;
+
+        aspeed_i2c_set_state(bus, state);
+
         if (i2c_start_transfer(bus->bus, extract32(bus->buf, 1, 7),
                                extract32(bus->buf, 0, 1))) {
             bus->intr_status |= I2CD_INTR_TX_NAK;
@@ -191,20 +211,26 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
         if (!i2c_bus_busy(bus->bus)) {
             return;
         }
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
 
     if (bus->cmd & I2CD_M_TX_CMD) {
+        aspeed_i2c_set_state(bus, I2CD_MTXD);
         if (i2c_send(bus->bus, bus->buf)) {
-            bus->intr_status |= (I2CD_INTR_TX_NAK | I2CD_INTR_ABNORMAL);
+            bus->intr_status |= (I2CD_INTR_TX_NAK);
             i2c_end_transfer(bus->bus);
         } else {
             bus->intr_status |= I2CD_INTR_TX_ACK;
         }
         bus->cmd &= ~I2CD_M_TX_CMD;
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
 
     if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
-        int ret = i2c_recv(bus->bus);
+        int ret;
+
+        aspeed_i2c_set_state(bus, I2CD_MRXD);
+        ret = i2c_recv(bus->bus);
         if (ret < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
             ret = 0xff;
@@ -216,16 +242,20 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
             i2c_nack(bus->bus);
         }
         bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
+        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
 
     if (bus->cmd & I2CD_M_STOP_CMD) {
-        if (!i2c_bus_busy(bus->bus)) {
+        if (!(aspeed_i2c_get_state(bus) & I2CD_MACTIVE)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: abnormal stop\n", __func__);
             bus->intr_status |= I2CD_INTR_ABNORMAL;
         } else {
+            aspeed_i2c_set_state(bus, I2CD_MSTOP);
             i2c_end_transfer(bus->bus);
             bus->intr_status |= I2CD_INTR_NORMAL_STOP;
         }
         bus->cmd &= ~I2CD_M_STOP_CMD;
+        aspeed_i2c_set_state(bus, I2CD_IDLE);
     }
 }
 
-- 
2.7.4
