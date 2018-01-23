Received: from eggs.gnu.org ([2001:4830:134:3::10]:35468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9w-0003dp-1c
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9s-0000gh-TK
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:04 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9s-0000g4-OO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:00 -0500
Received: by mail-qt0-x243.google.com with SMTP id l20so25095922qtj.11
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:22:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:29 -0300
Message-Id: <20180123032135.28863-7-f4bug@amsat.org>
In-Reply-To: <20180123032135.28863-1-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/12] sdcard: do not trace CMD55 when
 expecting ACMD
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
 hw/sd/sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dc4b2329e4..27c08aa894 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -816,13 +816,15 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
 }
 
-static sd_rsp_type_t sd_normal_command(SDState *sd,
-                                       SDRequest req)
+static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
-    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+    if (req.cmd != 55 || sd->expecting_acmd) {
+        trace_sdcard_normal_command(req.cmd, req.arg,
+                                    sd_state_name(sd->state));
+    }
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
-- 
2.15.1
