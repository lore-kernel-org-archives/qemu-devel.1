Received: from eggs.gnu.org ([209.51.188.92]:46138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTqJ-0005qN-Tc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTqH-000237-NY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:31:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTq7-0001yu-R0
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:31:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so40771762otl.6
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:31:15 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:53 -0600
Message-Id: <20190220135956.22589-17-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/19] i2c:smbus_eeprom: Add a size constant
 for the smbus_eeprom size
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

It was hard-coded to 256 in a number of places, create a constant
for that.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 91d68ff588..b3cc9c7083 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -35,6 +35,8 @@
 #define SMBUS_EEPROM(obj) \
     OBJECT_CHECK(SMBusEEPROMDevice, (obj), TYPE_SMBUS_EEPROM)
 
+#define SMBUS_EEPROM_SIZE 256
+
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     void *data;
@@ -70,7 +72,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
     for (; len > 0; len--) {
         data[eeprom->offset] = *buf++;
-        eeprom->offset = (eeprom->offset + 1) % 256;
+        eeprom->offset = (eeprom->offset + 1) % SMBUS_EEPROM_SIZE;
     }
 
     return 0;
@@ -129,12 +131,14 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int eeprom_spd_size)
 {
     int i;
-    uint8_t *eeprom_buf = g_malloc0(8 * 256); /* XXX: make this persistent */
+     /* XXX: make this persistent */
+    uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
     if (eeprom_spd_size > 0) {
         memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
     }
 
     for (i = 0; i < nb_eeprom; i++) {
-        smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
+        smbus_eeprom_init_one(smbus, 0x50 + i,
+                              eeprom_buf + (i * SMBUS_EEPROM_SIZE));
     }
 }
-- 
2.17.1
