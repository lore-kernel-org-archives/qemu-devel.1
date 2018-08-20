Received: from eggs.gnu.org ([2001:4830:134:3::10]:37033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUC-0003oi-Qk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUA-0005XA-St
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhU8-0005PL-Te
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhTv-000366-Um
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:51 +0100
Message-Id: <20180820103212.2810-5-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/25] imx_serial: Generate interrupt on receive
 data ready if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Generate an interrupt if USR2_RDR and UCR4_DREN are both set.

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Message-id: 1534341354-11956-1-git-send-email-hans-erik.floryd@rt-labs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/imx_serial.h | 1 +
 hw/char/imx_serial.c         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index ee80da12e60..c8b74284f87 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -68,6 +68,7 @@
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
 
+#define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
 #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
 
 #define UTS1_TXEMPTY    (1<<6)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 0747db9f2b9..1e363190e3d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -74,8 +74,9 @@ static void imx_update(IMXSerialState *s)
     mask = (s->ucr1 & UCR1_TXMPTYEN) ? USR2_TXFE : 0;
     /*
      * TCEN and TXDC are both bit 3
+     * RDR and DREN are both bit 0
      */
-    mask |= s->ucr4 & UCR4_TCEN;
+    mask |= s->ucr4 & (UCR4_TCEN | UCR4_DREN);
 
     usr2 = s->usr2 & mask;
 
-- 
2.18.0
