Received: from eggs.gnu.org ([2001:4830:134:3::10]:51394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN403-00042v-0F
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN401-0006Rh-VK
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:35 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN401-0006Qe-Oq
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:33 -0500
Received: by mail-pf0-x244.google.com with SMTP id p84so5683269pfd.3
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:33 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:15 -0600
Message-Id: <1512683181-8420-9-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 08/14] i2c: Add an SMBus vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus.c         | 14 ++++++++++++++
 include/hw/i2c/smbus.h | 18 +++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 4b0e264..e15f3f2 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -357,6 +357,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
     return 0;
 }
 
+const VMStateDescription vmstate_smbus_device = {
+    .name = TYPE_SMBUS_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
+        VMSTATE_INT32(mode, SMBusDevice),
+        VMSTATE_INT32(data_len, SMBusDevice),
+        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
+        VMSTATE_UINT8(command, SMBusDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index f1b8078..7794026 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -54,14 +54,16 @@ typedef struct SMBusDeviceClass
     uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
 } SMBusDeviceClass;
 
+#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
+
 struct SMBusDevice {
     /* The SMBus protocol is implemented on top of I2C.  */
     I2CSlave i2c;
 
     /* Remaining fields for internal use only.  */
-    int mode;
-    int data_len;
-    uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
+    int32_t mode;
+    int32_t data_len;
+    uint8_t data_buf[SMBUS_DATA_MAX_LEN];
     uint8_t command;
 };
 
@@ -93,4 +95,14 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int size);
 
+extern const VMStateDescription vmstate_smbus_device;
+
+#define VMSTATE_SMBUS_DEVICE(_field, _state) {                       \
+    .name       = (stringify(_field)),                               \
+    .size       = sizeof(SMBusDevice),                               \
+    .vmsd       = &vmstate_smbus_device,                             \
+    .flags      = VMS_STRUCT,                                        \
+    .offset     = vmstate_offset_value(_state, _field, SMBusDevice), \
+}
+
 #endif
-- 
2.7.4
