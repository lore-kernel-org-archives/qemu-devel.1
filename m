Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0Q-0002HK-02
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0O-0000E9-Pn
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:05 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0O-0000Dm-K2
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:04 -0500
Received: by mail-pg0-x242.google.com with SMTP id b1so22369286pgc.1
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:04 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:48 -0600
Message-Id: <1483111310-24808-18-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 17/19] i2c: Allow SMBus device to NAK start
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The I2C code has been modified to allow devices to NAK start
events, the SMBus code should, too.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus.c         | 11 +++++++++++
 include/hw/i2c/smbus.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 4cb651e..87a1669 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -71,6 +71,17 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
 
+    if (event == I2C_START_SEND || event == I2C_START_RECV) {
+        /* Allow the device to NAK the start event. */
+        SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+
+        if (sc->event) {
+            int rv = sc->event(dev, event);
+            if (rv)
+                return rv;
+        }
+    }
+
     switch (event) {
     case I2C_START_SEND:
         switch (dev->mode) {
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index f1b8078..fc995eb 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -39,6 +39,8 @@ typedef struct SMBusDeviceClass
 {
     I2CSlaveClass parent_class;
     int (*init)(SMBusDevice *dev);
+    /* Allow the device to get start and stop events so they can NAK them. */
+    int (*event)(SMBusDevice *dev, enum i2c_event event);
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
     void (*send_byte)(SMBusDevice *dev, uint8_t val);
     uint8_t (*receive_byte)(SMBusDevice *dev);
-- 
2.7.4
