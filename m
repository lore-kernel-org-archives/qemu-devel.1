Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1eyJyo-0002bR-3W
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1eyJyj-00020y-4X
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:19:18 -0400
Received: from sauhun.de ([88.99.104.3]:32871 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1eyJyi-00020g-US
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:19:13 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 20 Mar 2018 17:18:50 +0100
Message-Id: <20180320161850.2104-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180320161850.2104-1-wsa+renesas@sang-engineering.com>
References: <20180320161850.2104-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3] nvram: at24c: use standard error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Replace the ERR macro with error_report() because fprintf is deprecated.
This also fixes the prefix printed out twice.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/nvram/eeprom_at24c.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index ab1ef686e2..c35b29e503 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -13,6 +13,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "sysemu/block-backend.h"
+#include "qemu/error-report.h"
=20
 /* #define DEBUG_AT24C */
=20
@@ -22,9 +23,6 @@
 #define DPRINTK(FMT, ...) do {} while (0)
 #endif
=20
-#define ERR(FMT, ...) fprintf(stderr, TYPE_AT24C_EE " : " FMT, \
-                            ## __VA_ARGS__)
-
 #define TYPE_AT24C_EE "at24c-eeprom"
 #define AT24C_EE(obj) OBJECT_CHECK(EEPROMState, (obj), TYPE_AT24C_EE)
=20
@@ -63,8 +61,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event even=
t)
         if (ee->blk && ee->changed) {
             int len =3D blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
             if (len !=3D ee->rsize) {
-                ERR(TYPE_AT24C_EE
-                        " : failed to write backing file\n");
+                error_report("failed to write backing file");
             }
             DPRINTK("Wrote to backing file\n");
         }
@@ -125,7 +122,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
     EEPROMState *ee =3D AT24C_EE(i2c);
=20
     if (!ee->rsize) {
-        ERR("rom-size not allowed to be 0\n");
+        error_report("rom-size not allowed to be 0");
         exit(1);
     }
=20
@@ -135,7 +132,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
         int64_t len =3D blk_getlength(ee->blk);
=20
         if (len !=3D ee->rsize) {
-            ERR(TYPE_AT24C_EE " : Backing file size %lu !=3D %u\n",
+            error_report("Backing file size %lu !=3D %u",
                     (unsigned long)len, (unsigned)ee->rsize);
             exit(1);
         }
@@ -143,8 +140,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
         if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WR=
ITE,
                          BLK_PERM_ALL, &error_fatal) < 0)
         {
-            ERR(TYPE_AT24C_EE
-                    " : Backing file incorrect permission\n");
+            error_report("Backing file incorrect permission");
             exit(1);
         }
     }
@@ -166,8 +162,7 @@ void at24c_eeprom_reset(DeviceState *state)
         int len =3D blk_pread(ee->blk, 0, ee->mem, ee->rsize);
=20
         if (len !=3D ee->rsize) {
-            ERR(TYPE_AT24C_EE
-                    " : Failed initial sync with backing file\n");
+            error_report("Failed initial sync with backing file");
         }
         DPRINTK("Reset read backing file\n");
     }
--=20
2.11.0
