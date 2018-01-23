Received: from eggs.gnu.org ([2001:4830:134:3::10]:37850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIq-0003Yc-FM
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIp-00084y-M5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:16 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIp-00084e-Hl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:15 -0500
Received: by mail-qt0-x242.google.com with SMTP id d8so17866422qtm.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:27 -0300
Message-Id: <20180123033034.29493-12-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/18] sdcard: check the card is in correct
 state for APP CMD (CMD55)
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bbf9496e8a..434d1fbc47 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1389,6 +1389,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:	/* CMD55:  APP_CMD */
+        switch (sd->state) {
+        case sd_ready_state:
+        case sd_identification_state:
+        case sd_inactive_state:
+            return sd_illegal;
+        default:
+            break;
+        }
         if (!sd->spi) {
             if (sd->rca != rca) {
                 return sd_r0;
-- 
2.15.1
