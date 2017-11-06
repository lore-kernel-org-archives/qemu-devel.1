Received: from eggs.gnu.org ([2001:4830:134:3::10]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdc-000720-HX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdb-0000PJ-MW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:36 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:47 -0800
Message-Id: <20171106154813.19936-5-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/30] imx_fec: Use ENET_FTRL to determine
 truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

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
---
 hw/net/imx_fec.c         | 4 ++--
 include/hw/net/imx_fec.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eb034ffd0c..dda0816fb3 100644
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
 
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 4bc8f03ec2..0fcc4f0c71 100644
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
-- 
2.13.6
