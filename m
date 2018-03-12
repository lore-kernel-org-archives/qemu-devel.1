Received: from eggs.gnu.org ([2001:4830:134:3::10]:44529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDQ-0002bb-NQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004Z9-Sm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:44 -0400
Received: from sauhun.de ([88.99.104.3]:53438 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004YX-Hy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:40 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 12 Mar 2018 22:42:28 +0100
Message-Id: <20180312214230.17561-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [PATCH 1/3] nvram: at24c: remove doubled prefix for ERR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Davidsaver <mdavidsaver@gmail.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

The ERR macro already has the TYPE_AT24C_EE prefix, no need to repeat in
the error message.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/nvram/eeprom_at24c.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 5494351976..8507516b7e 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -60,8 +60,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
         if (ee->blk && ee->changed) {
             int len = blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
             if (len != ee->rsize) {
-                ERR(TYPE_AT24C_EE
-                        " : failed to write backing file\n");
+                ERR("failed to write backing file\n");
             }
             DPRINTK("Wrote to backing file\n");
         }
@@ -127,7 +126,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
         int64_t len = blk_getlength(ee->blk);
 
         if (len != ee->rsize) {
-            ERR(TYPE_AT24C_EE " : Backing file size %lu != %u\n",
+            ERR("Backing file size %lu != %u\n",
                     (unsigned long)len, (unsigned)ee->rsize);
             exit(1);
         }
@@ -135,8 +134,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
         if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                          BLK_PERM_ALL, &error_fatal) < 0)
         {
-            ERR(TYPE_AT24C_EE
-                    " : Backing file incorrect permission\n");
+            ERR("Backing file incorrect permission\n");
             exit(1);
         }
     }
@@ -158,8 +156,7 @@ void at24c_eeprom_reset(DeviceState *state)
         int len = blk_pread(ee->blk, 0, ee->mem, ee->rsize);
 
         if (len != ee->rsize) {
-            ERR(TYPE_AT24C_EE
-                    " : Failed initial sync with backing file\n");
+            ERR("Failed initial sync with backing file\n");
         }
         DPRINTK("Reset read backing file\n");
     }
-- 
2.11.0
