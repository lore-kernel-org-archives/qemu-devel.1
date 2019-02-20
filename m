Received: from eggs.gnu.org ([209.51.188.92]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTxK-00036O-2w
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTxH-00070z-QJ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:41 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTxH-0006t2-9Y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:39 -0500
Received: by mail-ot1-x341.google.com with SMTP id b3so40834618otp.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:38:17 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:51 -0600
Message-Id: <20190220135956.22589-15-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 14/19] i2c:smbus_slave: Add an SMBus vmstate
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

There is no vmstate handling for SMBus, so no device sitting on SMBus
can have a state transfer that works reliably.  So add it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/i2c/smbus_slave.c         | 18 ++++++++++++++++++
 include/hw/i2c/smbus_slave.h | 24 +++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 5b3046f6a3..9a2d314d1a 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,6 +201,24 @@ static void smbus_device_class_init(ObjectClass *klass, void *data)
     sc->send = smbus_i2c_send;
 }
 
+bool smbus_vmstate_needed(SMBusDevice *dev)
+{
+    return dev->mode != SMBUS_IDLE;
+}
+
+const VMStateDescription vmstate_smbus_device = {
+    .name = TYPE_SMBUS_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
+        VMSTATE_INT32(mode, SMBusDevice),
+        VMSTATE_INT32(data_len, SMBusDevice),
+        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const TypeInfo smbus_device_type_info = {
     .name = TYPE_SMBUS_DEVICE,
     .parent = TYPE_I2C_SLAVE,
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index 79050fb92d..ebe068304e 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -69,14 +69,32 @@ typedef struct SMBusDeviceClass
     uint8_t (*receive_byte)(SMBusDevice *dev);
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
 };
 
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
+/*
+ * Users should call this in their .needed functions to know if the
+ * SMBus slave data needs to be transferred.
+ */
+bool smbus_vmstate_needed(SMBusDevice *dev);
+
 #endif
-- 
2.17.1
