Received: from eggs.gnu.org ([2001:4830:134:3::10]:37243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWT-0002Qr-1w
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWR-00046J-UX
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWR-00045M-NI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:55 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWQ-0001TB-RV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:54 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:44 +0000
Message-Id: <1483962824-29185-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/21] hw/ssi/imx_spi.c: Remove MSGDATA register
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

>From the documentation it is not clear what this SPI register is about.

Moreover, neither linux driver nor xvisor driver are using this SPI register.

For now we just remove it and issue a log on register write access.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 20170107122047.26300-1-jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/imx_spi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index e4e395f..b66505c 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -320,9 +320,6 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
                       TYPE_IMX_SPI, __func__);
         break;
     case ECSPI_TXDATA:
-    case ECSPI_MSGDATA:
-        /* Is there any difference between TXDATA and MSGDATA ? */
-        /* I'll have to look in the linux driver */
         if (!imx_spi_is_enabled(s)) {
             /* Ignore writes if device is disabled */
             break;
@@ -380,6 +377,14 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
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
2.7.4
