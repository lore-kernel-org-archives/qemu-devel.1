Received: from eggs.gnu.org ([2001:4830:134:3::10]:37982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJE-0003rh-2L
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJA-0008Ms-Vn
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:40 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJA-0008Mf-Rk
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:36 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so26485693qtj.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:34 -0300
Message-Id: <20180123033034.29493-19-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/18] sdcard: add an enum for the SD PHY
 Spec version
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

So far this device intends to model the Spec v1.10

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f6c4ce2a4..9880a5d090 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -47,6 +47,11 @@
 
 //#define DEBUG_SD 1
 
+typedef enum {
+    SD_PHY_SPEC_VER_1_10 = 110,
+    SD_PHY_SPEC_VER_2_00 = 200, /* not yet supported */
+} sd_phy_spec_ver_t;
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -122,6 +127,7 @@ struct SDState {
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
     const char *proto_name;
+    int spec_version;
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
@@ -2191,6 +2197,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     sd->proto_name = sd->spi ? "SPI" : "SD";
+    sd->spec_version = SD_PHY_SPEC_VER_1_10;
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
-- 
2.15.1
