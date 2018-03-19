Received: from eggs.gnu.org ([2001:4830:134:3::10]:36515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2NA-0003VM-3C
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2N5-0005Ji-77
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:16 -0400
Received: from sauhun.de ([88.99.104.3]:57191 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2N5-0005Hw-0p
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:11 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 19 Mar 2018 22:30:59 +0100
Message-Id: <20180319213101.6100-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
References: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [PATCH v2 1/3] nvram: at24c: prevent segfault by
 checking "rom-size"
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

The value for "rom-size" is used as a divisor, so it must not be 0 or it
will segfault. A size of 0 wouldn't make sense anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/nvram/eeprom_at24c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 22183f5360..ccf78b25e4 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -121,6 +121,11 @@ int at24c_eeprom_init(I2CSlave *i2c)
 {
     EEPROMState *ee = AT24C_EE(i2c);
 
+    if (!ee->rsize) {
+        ERR("rom-size not allowed to be 0\n");
+        exit(1);
+    }
+
     ee->mem = g_malloc0(ee->rsize);
 
     if (ee->blk) {
-- 
2.11.0
