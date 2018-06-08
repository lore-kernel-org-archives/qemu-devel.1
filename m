Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlo-00034D-Gv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlm-0004Fj-TR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlm-0004D2-Mc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGld-0003ce-Sp
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:51 +0100
Message-Id: <20180608124517.29475-6-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/31] smbus: add a smbus_eeprom_init_one()
 routine
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

This is an helper routine to add a single EEPROM on an I2C bus. It can
be directly used by smbus_eeprom_init() which adds a certain number of
EEPROMs on mips and x86 machines.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180530064049.27976-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/smbus.h |  1 +
 hw/i2c/smbus_eeprom.c  | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index cfe3fa69f32..4fdba022c1f 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -76,6 +76,7 @@ int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data);
 int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
                       int len);
 
+void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int size);
 
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 125c887d1f6..f18aa3de35a 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -139,6 +139,16 @@ static void smbus_eeprom_register_types(void)
 
 type_init(smbus_eeprom_register_types)
 
+void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
+{
+    DeviceState *dev;
+
+    dev = qdev_create((BusState *) smbus, "smbus-eeprom");
+    qdev_prop_set_uint8(dev, "address", address);
+    qdev_prop_set_ptr(dev, "data", eeprom_buf);
+    qdev_init_nofail(dev);
+}
+
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int eeprom_spd_size)
 {
@@ -149,10 +159,6 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
     }
 
     for (i = 0; i < nb_eeprom; i++) {
-        DeviceState *eeprom;
-        eeprom = qdev_create((BusState *)smbus, "smbus-eeprom");
-        qdev_prop_set_uint8(eeprom, "address", 0x50 + i);
-        qdev_prop_set_ptr(eeprom, "data", eeprom_buf + (i * 256));
-        qdev_init_nofail(eeprom);
+        smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
     }
 }
-- 
2.17.1
