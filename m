Received: from eggs.gnu.org ([209.51.188.92]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEC-000396-By
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB8U-0005si-JM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:56:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB8U-0005Z4-DR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:54 -0500
Received: by mail-pl1-x644.google.com with SMTP id a14so8043357plm.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:20 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:55 -0600
Message-Id: <20190128175458.27255-17-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/19] i2c:smbus_eeprom: Add a size constant
 for the smbus_eeprom size
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
