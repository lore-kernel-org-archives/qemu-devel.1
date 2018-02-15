Received: from eggs.gnu.org ([2001:4830:134:3::10]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnI-0005dv-6A
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnF-0005U3-9x
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:20 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnF-0005Tt-5R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:17 -0500
Received: by mail-qk0-x244.google.com with SMTP id b130so1566118qkg.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:20 -0300
Message-Id: <20180215221325.7611-16-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/20] sdcard: simplify SEND_IF_COND (CMD8)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

replace switch(single case) -> if()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5827379d0f..942143ab3e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1012,23 +1012,19 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
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
2.16.1
