Received: from eggs.gnu.org ([2001:4830:134:3::10]:52573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY7-00036e-Mg
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY2-0008Tk-6b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:11 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY1-0008Ss-TE
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:06 -0500
Received: by mail-qt0-x243.google.com with SMTP id g9so3788901qth.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:29 -0300
Message-Id: <20180103212436.15762-19-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/25] sdcard: add an enum for the SD PHY
 Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

So far this device intends to model the Spec v2.00

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 024a9fa1df..ed5874e4d6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -58,6 +58,11 @@ do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
 
 #define SDCARD_CMD_MAX 64
 
+typedef enum {
+    SD_PHY_SPEC_VER_2_00 = 200,
+    SD_PHY_SPEC_VER_3_01 = 301, /* not yet supported */
+} sd_phy_spec_ver_t;
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -114,6 +119,7 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
 
+    int spec_version;
     bool spi;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -1977,6 +1983,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     sd->proto_name = sd->spi ? "SPI" : "SD";
+    sd->spec_version = SD_PHY_SPEC_VER_2_00;
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
-- 
2.15.1
