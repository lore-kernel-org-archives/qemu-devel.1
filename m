Received: from eggs.gnu.org ([2001:4830:134:3::10]:52308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd46-0007Y2-Hs
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-00006p-Of
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd40-00005e-F3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3z-0005gn-Dj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:10 +0000
Message-Id: <1515677902-23436-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/26] imx_fec: Use ENET_FTRL to determine
 truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Frame truncation length, TRUNC_FL, is determined by the contents of
ENET_FTRL register, so convert the code to use it instead of a
hardcoded constant.

To avoid the case where TRUNC_FL is greater that ENET_MAX_FRAME_SIZE,
increase the value of the latter to its theoretical maximum of 16K.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/imx_fec.h | 3 ++-
 hw/net/imx_fec.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 6799387..a390d70 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -86,7 +86,6 @@
 #define ENET_TCCR3             393
 #define ENET_MAX               400
 
-#define ENET_MAX_FRAME_SIZE    2032
 
 /* EIR and EIMR */
 #define ENET_INT_HB            (1 << 31)
@@ -155,6 +154,8 @@
 #define ENET_RCR_NLC           (1 << 30)
 #define ENET_RCR_GRS           (1 << 31)
 
+#define ENET_MAX_FRAME_SIZE    (1 << ENET_RCR_MAX_FL_LENGTH)
+
 /* TCR */
 #define ENET_TCR_GTS           (1 << 0)
 #define ENET_TCR_FDEN          (1 << 2)
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 56cb722..50da91b 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1052,8 +1052,8 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     crc_ptr = (uint8_t *) &crc;
 
     /* Huge frames are truncted.  */
-    if (size > ENET_MAX_FRAME_SIZE) {
-        size = ENET_MAX_FRAME_SIZE;
+    if (size > s->regs[ENET_FTRL]) {
+        size = s->regs[ENET_FTRL];
         flags |= ENET_BD_TR | ENET_BD_LG;
     }
 
-- 
2.7.4
