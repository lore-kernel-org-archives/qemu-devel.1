Received: from eggs.gnu.org ([2001:4830:134:3::10]:58792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnU-0005xt-RS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnU-0005bR-0K
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:32 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnT-0005bL-S8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:31 -0500
Received: by mail-qk0-x244.google.com with SMTP id g129so1548600qkb.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:25 -0300
Message-Id: <20180215221325.7611-21-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 20/20] sdcard: add an enum for the SD PHY
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

So far this device intends to model the Spec v1.10

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b9429b06ca..d4565626ce 100644
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
@@ -2169,6 +2175,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     sd->proto_name = sd->spi ? "SPI" : "SD";
+    sd->spec_version = SD_PHY_SPEC_VER_1_10;
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
-- 
2.16.1
