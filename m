Received: from eggs.gnu.org ([2001:4830:134:3::10]:44297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKQAG-0000Wc-4P
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKQAE-00024j-ES
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:44 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gKQAC-0001ww-9M
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:54:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id k19-v6so14162913oic.11
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 07:54:32 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed,  7 Nov 2018 09:54:04 -0600
Message-Id: <20181107155405.24013-3-minyard@acm.org>
In-Reply-To: <20181107155405.24013-1-minyard@acm.org>
References: <20181107155405.24013-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 2/3] i2c: Add an SMBus vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

There is no vmstate handling for SMBus, so no device sitting on SMBus
can have a state transfer that works reliable.  So add it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/i2c/smbus.c         | 14 ++++++++++++++
 include/hw/i2c/smbus.h | 18 +++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 6ff77c582f..b0774d7683 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -349,6 +349,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
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
index d8b1b9ee81..7b52020121 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -53,14 +53,16 @@ typedef struct SMBusDeviceClass
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
 
@@ -93,4 +95,14 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
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
2.17.1
