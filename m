Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKj-0005zL-3F
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKg-0004k6-De
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from sauhun.de ([88.99.104.3]:54052 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKg-0004jS-7K
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:42 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 20 May 2018 09:00:35 +0200
Message-Id: <20180520070037.8593-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
References: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 RESEND 1/3] nvram: at24c: prevent segfault
 by checking "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The value for "rom-size" is used as a divisor, so it must not be 0 or it
will segfault. A size of 0 wouldn't make sense anyhow.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
     EEPROMState *ee =3D AT24C_EE(i2c);
=20
+    if (!ee->rsize) {
+        ERR("rom-size not allowed to be 0\n");
+        exit(1);
+    }
+
     ee->mem =3D g_malloc0(ee->rsize);
=20
     if (ee->blk) {
--=20
2.11.0
