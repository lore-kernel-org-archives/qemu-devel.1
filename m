Received: from eggs.gnu.org ([2001:4830:134:3::10]:43570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cO9t3-0002DJ-R6
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cO9t0-0005Cq-LV
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:11:21 -0500
Received: from relay6-d.mail.gandi.net ([2001:4b98:c:538::198]:48851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cO9t0-0005Bn-FE
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:11:18 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon,  2 Jan 2017 22:11:10 +0100
Message-Id: <20170102211110.4801-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v2] [i.MX] Remove MSGDATA register support.
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

 hw/ssi/imx_spi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index c2d293c..3a0400e 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -338,9 +338,6 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
                       TYPE_IMX_SPI, __func__);
         break;
     case ECSPI_TXDATA:
-    case ECSPI_MSGDATA:
-        /* Is there any difference between TXDATA and MSGDATA ? */
-        /* I'll have to look in the linux driver */
         if (!imx_spi_is_enabled(s)) {
             /* Ignore writes if device is disabled */
             break;
@@ -391,6 +388,14 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         break;
+    case ECSPI_MSGDATA:
+        /* it is not clear from the spec what MSGDATA is for */
+        /* Anyway it is not used by Linux driver */
+        /* So for now we just ignore it */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[%s]%s: Trying to write to MSGDATA, ignoring\n",
+                      TYPE_IMX_SPI, __func__);
+        break;
     default:
         s->regs[index] = value;
 
-- 
2.9.3
