Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPpzZ-0004hu-MM
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 07:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPpzU-0000wh-PX
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 07:21:01 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPpzU-0000u4-GV
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 07:20:56 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Sat,  7 Jan 2017 13:20:47 +0100
Message-Id: <20170107122047.26300-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v3] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mar.krzeminski@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

>From the documentation it is not clear what this SPI register is about.

Moreover, neither linux driver nor xvisor driver are using this SPI register.

For now we just remove it and issue a log on register write access.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

Changes since v1:
* Fix coding style issue.

Changes since v2:
* change log form LOG_GUEST_ERROR to LOG_UNIMP..

 hw/ssi/imx_spi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index e57cb9a..b8f416c 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -345,9 +345,6 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
                       TYPE_IMX_SPI, __func__);
         break;
     case ECSPI_TXDATA:
-    case ECSPI_MSGDATA:
-        /* Is there any difference between TXDATA and MSGDATA ? */
-        /* I'll have to look in the linux driver */
         if (!imx_spi_is_enabled(s)) {
             /* Ignore writes if device is disabled */
             break;
@@ -398,6 +395,14 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         break;
+    case ECSPI_MSGDATA:
+        /* it is not clear from the spec what MSGDATA is for */
+        /* Anyway it is not used by Linux driver */
+        /* So for now we just ignore it */
+        qemu_log_mask(LOG_UNIMP,
+                      "[%s]%s: Trying to write to MSGDATA, ignoring\n",
+                      TYPE_IMX_SPI, __func__);
+        break;
     default:
         s->regs[index] = value;
 
-- 
2.9.3
