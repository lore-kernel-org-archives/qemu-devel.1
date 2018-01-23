Received: from eggs.gnu.org ([2001:4830:134:3::10]:37887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIw-0003ev-I9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIv-0008BF-Lg
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:22 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIv-0008At-H9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:21 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so26454696qtm.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:29 -0300
Message-Id: <20180123033034.29493-14-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 13/18] sdcard: simplify SEND_IF_COND (CMD8)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

replace switch(single case) -> if()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b5c947df62..707c294169 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1015,23 +1015,19 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 8:	/* CMD8:   SEND_IF_COND */
         /* Physical Layer Specification Version 2.00 command */
-        switch (sd->state) {
-        case sd_idle_state:
-            sd->vhs = 0;
-
-            /* No response if not exactly one VHS bit is set.  */
-            if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-                return sd->spi ? sd_r7 : sd_r0;
-            }
-
-            /* Accept.  */
-            sd->vhs = req.arg;
-            return sd_r7;
-
-        default:
+        if (sd->state != sd_idle_state) {
             break;
         }
-        break;
+        sd->vhs = 0;
+
+        /* No response if not exactly one VHS bit is set.  */
+        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
+            return sd->spi ? sd_r7 : sd_r0;
+        }
+
+        /* Accept.  */
+        sd->vhs = req.arg;
+        return sd_r7;
 
     case 9:	/* CMD9:   SEND_CSD */
         switch (sd->state) {
-- 
2.15.1
