Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi60-0000A8-KO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5z-0004rL-Dg
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:27 -0300
Message-Id: <20170724182751.18261-12-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 11/35] i2c/exynos4210: correctly check
 i2c_recv() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

i2c_recv() returns -1 on error, if the I2CCON_ACK_GEN bit was not set this code
was setting i2cds = -1.

i2c/exynos4210_i2c.c:117:20: warning: Loss of sign in implicit conversion
        s->i2cds = ret;
                   ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/exynos4210_i2c.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index c96fa7d7be..4424dbd233 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -111,10 +111,12 @@ static void exynos4210_i2c_data_receive(void *opaque)
     s->i2cstat &= ~I2CSTAT_LAST_BIT;
     s->scl_free = false;
     ret = i2c_recv(s->bus);
-    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
-        s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
-    } else {
+    if (ret >= 0) {
         s->i2cds = ret;
+    } else {
+        if (s->i2ccon & I2CCON_ACK_GEN) {
+            s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
+        }
     }
     exynos4210_i2c_raise_interrupt(s);
 }
-- 
2.13.3
