Received: from eggs.gnu.org ([2001:4830:134:3::10]:35831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fpwHW-0006Hw-F6
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fpwHS-0003xM-VA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:56:14 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:47040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hans-erik.floryd@rt-labs.com>)
	id 1fpwHS-0003ns-AM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:56:10 -0400
Received: by mail-lf1-x142.google.com with SMTP id l16-v6so923294lfc.13
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 06:56:10 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Date: Wed, 15 Aug 2018 15:55:54 +0200
Message-Id: <1534341354-11956-1-git-send-email-hans-erik.floryd@rt-labs.com>
Subject: [Qemu-devel] [PATCH] imx_serial: Generate interrupt on receive data
 ready if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, Peter Chubb <peter.chubb@nicta.com.au>, Paolo Bonzini <pbonzini@redhat.com>, "open list:i.MX31" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Generate an interrupt if USR2_RDR and UCR4_DREN are both set.

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 hw/char/imx_serial.c         | 3 ++-
 include/hw/char/imx_serial.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 0747db9..1e36319 100644
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
 
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index ee80da1..c8b7428 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -68,6 +68,7 @@
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
 
+#define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
 #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
 
 #define UTS1_TXEMPTY    (1<<6)
-- 
2.7.4
