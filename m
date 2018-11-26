Received: from eggs.gnu.org ([2001:4830:134:3::10]:53728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN81-0001lo-PS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001Ln-UZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001Hj-HV
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:06 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so17838823otm.13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:04:58 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 14:04:24 -0600
Message-Id: <20181126200435.23408-6-minyard@acm.org>
In-Reply-To: <20181126200435.23408-1-minyard@acm.org>
References: <20181126200435.23408-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v3 05/16] i2c: Simplify and correct the SMBus
 state machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The SMBus slave code had an unneeded state, unnecessary function
pointers and incorrectly handled quick commands.  Rewrite it
to simplify the code and make it work correctly.

smbus_eeprom is the only user, so no other effects and the eeprom
code also gets a significant simplification.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c        | 58 ++++++-----------------
 hw/i2c/smbus_slave.c         | 91 ++++++++++++++++--------------------
 include/hw/i2c/smbus_slave.h | 45 +++++++++++++-----
 3 files changed, 86 insertions(+), 108 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index d82423aa7e..4d25222e23 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -36,28 +36,12 @@ typedef struct SMBusEEPROMDevice {
     uint8_t offset;
 } SMBusEEPROMDevice;
 
-static void eeprom_quick_cmd(SMBusDevice *dev, uint8_t read)
-{
-#ifdef DEBUG
-    printf("eeprom_quick_cmd: addr=0x%02x read=%d\n", dev->i2c.address, read);
-#endif
-}
-
-static void eeprom_send_byte(SMBusDevice *dev, uint8_t val)
-{
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-#ifdef DEBUG
-    printf("eeprom_send_byte: addr=0x%02x val=0x%02x\n",
-           dev->i2c.address, val);
-#endif
-    eeprom->offset = val;
-}
-
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
     uint8_t *data = eeprom->data;
     uint8_t val = data[eeprom->offset++];
+
 #ifdef DEBUG
     printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
            dev->i2c.address, val);
@@ -65,37 +49,26 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
     return val;
 }
 
-static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int len)
+static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-    int n;
+    uint8_t *data = eeprom->data;
+
 #ifdef DEBUG
     printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
            dev->i2c.address, cmd, buf[0]);
 #endif
-    /* A page write operation is not a valid SMBus command.
-       It is a block write without a length byte.  Fortunately we
-       get the full block anyway.  */
-    /* TODO: Should this set the current location?  */
-    if (cmd + len > 256)
-        n = 256 - cmd;
-    else
-        n = len;
-    memcpy(eeprom->data + cmd, buf, n);
-    len -= n;
-    if (len)
-        memcpy(eeprom->data, buf + n, len);
-}
+    /* len is guaranteed to be > 0 */
+    eeprom->offset = buf[0];
+    buf++;
+    len--;
+
+    for (; len > 0; len--) {
+        data[eeprom->offset] = *buf++;
+        eeprom->offset = (eeprom->offset + 1) % 256;
+    }
 
-static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
-{
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-    /* If this is the first byte then set the current position.  */
-    if (n == 0)
-        eeprom->offset = cmd;
-    /* As with writes, we implement block reads without the
-       SMBus length byte.  */
-    return eeprom_receive_byte(dev);
+    return 0;
 }
 
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
@@ -116,11 +89,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
-    sc->quick_cmd = eeprom_quick_cmd;
-    sc->send_byte = eeprom_send_byte;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
-    sc->read_data = eeprom_read_data;
     dc->props = smbus_eeprom_properties;
     /* Reason: pointer property "data" */
     dc->user_creatable = false;
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 549e7ae933..70ff29c095 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -34,7 +34,6 @@ do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
 enum {
     SMBUS_IDLE,
     SMBUS_WRITE_DATA,
-    SMBUS_RECV_BYTE,
     SMBUS_READ_DATA,
     SMBUS_DONE,
     SMBUS_CONFUSED = -1
@@ -54,20 +53,9 @@ static void smbus_do_write(SMBusDevice *dev)
 {
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
-    if (dev->data_len == 0) {
-        smbus_do_quick_cmd(dev, 0);
-    } else if (dev->data_len == 1) {
-        DPRINTF("Send Byte\n");
-        if (sc->send_byte) {
-            sc->send_byte(dev, dev->data_buf[0]);
-        }
-    } else {
-        dev->command = dev->data_buf[0];
-        DPRINTF("Command %d len %d\n", dev->command, dev->data_len - 1);
-        if (sc->write_data) {
-            sc->write_data(dev, dev->command, dev->data_buf + 1,
-                           dev->data_len - 1);
-        }
+    DPRINTF("Command %d len %d\n", dev->data_buf[0], dev->data_len);
+    if (sc->write_data) {
+        sc->write_data(dev, dev->data_buf, dev->data_len);
     }
 }
 
@@ -82,6 +70,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
             DPRINTF("Incoming data\n");
             dev->mode = SMBUS_WRITE_DATA;
             break;
+
         default:
             BADF("Unexpected send start condition in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -93,25 +82,20 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
         switch (dev->mode) {
         case SMBUS_IDLE:
             DPRINTF("Read mode\n");
-            dev->mode = SMBUS_RECV_BYTE;
+            dev->mode = SMBUS_READ_DATA;
             break;
+
         case SMBUS_WRITE_DATA:
             if (dev->data_len == 0) {
                 BADF("Read after write with no data\n");
                 dev->mode = SMBUS_CONFUSED;
             } else {
-                if (dev->data_len > 1) {
-                    smbus_do_write(dev);
-                } else {
-                    dev->command = dev->data_buf[0];
-                    DPRINTF("%02x: Command %d\n", dev->i2c.address,
-                            dev->command);
-                }
+                smbus_do_write(dev);
                 DPRINTF("Read mode\n");
-                dev->data_len = 0;
                 dev->mode = SMBUS_READ_DATA;
             }
             break;
+
         default:
             BADF("Unexpected recv start condition in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -120,19 +104,29 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
         break;
 
     case I2C_FINISH:
-        switch (dev->mode) {
-        case SMBUS_WRITE_DATA:
-            smbus_do_write(dev);
-            break;
-        case SMBUS_RECV_BYTE:
-            smbus_do_quick_cmd(dev, 1);
-            break;
-        case SMBUS_READ_DATA:
-            BADF("Unexpected stop during receive\n");
-            break;
-        default:
-            /* Nothing to do.  */
-            break;
+        if (dev->data_len == 0) {
+            if (dev->mode == SMBUS_WRITE_DATA || dev->mode == SMBUS_READ_DATA) {
+                smbus_do_quick_cmd(dev, dev->mode == SMBUS_READ_DATA);
+            }
+        } else {
+            SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+
+            switch (dev->mode) {
+            case SMBUS_WRITE_DATA:
+                smbus_do_write(dev);
+                break;
+
+            case SMBUS_READ_DATA:
+                BADF("Unexpected stop during receive\n");
+                break;
+
+            default:
+                /* Nothing to do.  */
+                break;
+            }
+            if (sc->transaction_complete) {
+                sc->transaction_complete(dev);
+            }
         }
         dev->mode = SMBUS_IDLE;
         dev->data_len = 0;
@@ -143,9 +137,11 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
         case SMBUS_DONE:
             /* Nothing to do.  */
             break;
+
         case SMBUS_READ_DATA:
             dev->mode = SMBUS_DONE;
             break;
+
         default:
             BADF("Unexpected NACK in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -160,33 +156,22 @@ static uint8_t smbus_i2c_recv(I2CSlave *s)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
-    uint8_t ret;
+    uint8_t ret = 0xff;
 
     switch (dev->mode) {
-    case SMBUS_RECV_BYTE:
+    case SMBUS_READ_DATA:
         if (sc->receive_byte) {
             ret = sc->receive_byte(dev);
-        } else {
-            ret = 0;
-        }
-        DPRINTF("Receive Byte %02x\n", ret);
-        dev->mode = SMBUS_DONE;
-        break;
-    case SMBUS_READ_DATA:
-        if (sc->read_data) {
-            ret = sc->read_data(dev, dev->command, dev->data_len);
-            dev->data_len++;
-        } else {
-            ret = 0;
         }
         DPRINTF("Read data %02x\n", ret);
         break;
+
     default:
         BADF("Unexpected read in state %d\n", dev->mode);
         dev->mode = SMBUS_CONFUSED;
-        ret = 0;
         break;
     }
+
     return ret;
 }
 
@@ -199,10 +184,12 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
         DPRINTF("Write data %02x\n", data);
         dev->data_buf[dev->data_len++] = data;
         break;
+
     default:
         BADF("Unexpected write in state %d\n", dev->mode);
         break;
     }
+
     return 0;
 }
 
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index ff07ee005d..fad2db9c76 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -38,19 +38,41 @@
 typedef struct SMBusDeviceClass
 {
     I2CSlaveClass parent_class;
+
+    /*
+     * An operation with no data, special in SMBus.
+     * This may be NULL, quick commands are ignore in that case.
+     */
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
-    void (*send_byte)(SMBusDevice *dev, uint8_t val);
+
+    /*
+     * We can't distinguish between a word write and a block write with
+     * length 1, so pass the whole data block including the length byte
+     * (if present).  The device is responsible figuring out what type of
+     * command this is.
+     * This may be NULL if no data is written to the device.  Writes
+     * will be ignore in that case.
+     */
+    int (*write_data)(SMBusDevice *dev, uint8_t *buf, uint8_t len);
+
+    /*
+     * Likewise we can't distinguish between different reads, or even know
+     * the length of the read until the read is complete, so read data a
+     * byte at a time.  The device is responsible for adding the length
+     * byte on block reads.  This call cannot fail, it should return
+     * something, preferably 0xff if nothing is available.
+     * This may be NULL if no data is read from the device.  Reads will
+     * return 0xff in that case.
+     */
     uint8_t (*receive_byte)(SMBusDevice *dev);
-    /* We can't distinguish between a word write and a block write with
-       length 1, so pass the whole data block including the length byte
-       (if present).  The device is responsible figuring out what type of
-       command  this is.  */
-    void (*write_data)(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int len);
-    /* Likewise we can't distinguish between different reads, or even know
-       the length of the read until the read is complete, so read data a
-       byte at a time.  The device is responsible for adding the length
-       byte on block reads.  */
-    uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
+
+    /*
+     * Called whan an SMBus transaction has completed.  This can be used
+     * so the device knows when an operation completes.  This is not
+     * called after quick commands, those are complete by nature.
+     * This may be NULL if the device doesn't need this.
+     */
+    void (*transaction_complete)(SMBusDevice *dev);
 } SMBusDeviceClass;
 
 struct SMBusDevice {
@@ -61,7 +83,6 @@ struct SMBusDevice {
     int mode;
     int data_len;
     uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
-    uint8_t command;
 };
 
 #endif
-- 
2.17.1
