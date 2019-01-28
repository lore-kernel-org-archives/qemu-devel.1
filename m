Received: from eggs.gnu.org ([209.51.188.92]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEF-0003b9-Rc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7r-0005WU-Sb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7r-0005WA-Np
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:15 -0500
Received: by mail-io1-xd41.google.com with SMTP id g8so14245248iok.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:15 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:44 -0600
Message-Id: <20190128175458.27255-6-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 05/19] i2c:smbus: Correct the working of
 quick commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The logic of handling quick SMBus commands was wrong.  If you get a
finish event with no data, that's a quick command.

Document the quick command while we are at it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_slave.c         | 35 +++++++++++++++++++----------------
 include/hw/i2c/smbus_slave.h |  5 +++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 6e4d542f51..6a89a286e3 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -54,9 +54,7 @@ static void smbus_do_write(SMBusDevice *dev)
 {
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
-    if (dev->data_len == 0) {
-        smbus_do_quick_cmd(dev, 0);
-    } else if (dev->data_len == 1) {
+    if (dev->data_len == 1) {
         DPRINTF("Send Byte\n");
         if (sc->send_byte) {
             sc->send_byte(dev, dev->data_buf[0]);
@@ -120,19 +118,24 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
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
         }
         dev->mode = SMBUS_IDLE;
         dev->data_len = 0;
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index 46b8948f0f..5ef1c72ad0 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -40,6 +40,11 @@ typedef struct SMBusDevice SMBusDevice;
 typedef struct SMBusDeviceClass
 {
     I2CSlaveClass parent_class;
+
+    /*
+     * An operation with no data, special in SMBus.
+     * This may be NULL, quick commands are ignore in that case.
+     */
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
     void (*send_byte)(SMBusDevice *dev, uint8_t val);
     uint8_t (*receive_byte)(SMBusDevice *dev);
-- 
2.17.1
