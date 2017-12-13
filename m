Received: from eggs.gnu.org ([2001:4830:134:3::10]:60445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLo-0005Nq-06
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLn-0007XX-1s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:07 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLm-0007X3-Ub
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:07 -0500
Received: by mail-qk0-x241.google.com with SMTP id i130so4146162qke.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:05 -0300
Message-Id: <20171213232025.24503-7-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/26] sdcard: add sd_set_mode()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

This will ease to trace mode changes (in the following patch).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f63459d2c0..2c0f8a7dbd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -128,17 +128,22 @@ struct SDState {
     bool enable;
 };
 
+static void sd_set_mode(SDState *sd, enum SDCardModes mode)
+{
+    sd->mode = mode;
+}
+
 static void sd_update_mode(SDState *sd)
 {
     switch (sd->state) {
     case sd_inactive_state:
-        sd->mode = sd_inactive;
+        sd_set_mode(sd, sd_inactive);
         break;
 
     case sd_idle_state:
     case sd_ready_state:
     case sd_identification_state:
-        sd->mode = sd_card_identification_mode;
+        sd_set_mode(sd, sd_card_identification_mode);
         break;
 
     case sd_standby_state:
@@ -147,7 +152,7 @@ static void sd_update_mode(SDState *sd)
     case sd_receivingdata_state:
     case sd_programming_state:
     case sd_disconnect_state:
-        sd->mode = sd_data_transfer_mode;
+        sd_set_mode(sd, sd_data_transfer_mode);
         break;
     }
 }
-- 
2.15.1
