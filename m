Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIO-000380-TC
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIN-0007gf-Up
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:48 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIN-0007gS-QD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:47 -0500
Received: by mail-qt0-x243.google.com with SMTP id d54so26493538qtd.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:18 -0300
Message-Id: <20180123033034.29493-3-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/18] sdcard: update the CSD CRC register
 regardless the CSD structure version
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
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 20764451f2..f6318c6fdb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -377,7 +377,6 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x20 |	/* Max. write data block length */
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
-        sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
     } else {			/* SDHC */
         size /= 512 * 1024;
         size -= 1;
@@ -396,8 +395,8 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
         sd->csd[12] = 0x0a;
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
-        sd->csd[15] = 0x00;
     }
+    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
 static void sd_reset_rca(SDState *sd)
-- 
2.15.1
