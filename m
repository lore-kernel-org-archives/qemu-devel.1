Received: from eggs.gnu.org ([2001:4830:134:3::10]:58309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmd-0004gP-8a
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmc-00050v-Bn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:39 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmc-00050L-6l
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:38 -0500
Received: by mail-qt0-x242.google.com with SMTP id u6so1590354qtg.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:07 -0300
Message-Id: <20180215221325.7611-3-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/20] sdcard: update the CSD CRC register
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9dfbd65ac8..c1ba098d86 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -379,7 +379,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x20 |	/* Max. write data block length */
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
-        sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
     } else {			/* SDHC */
         size /= 512 * 1024;
         size -= 1;
@@ -398,8 +397,8 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[12] = 0x0a;
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
-        sd->csd[15] = 0x00;
     }
+    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
 static void sd_set_rca(SDState *sd)
-- 
2.16.1
