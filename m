Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosij-0004xN-UR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosif-0001kw-QA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosif-0001ix-IX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosie-00024R-G7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:36 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:53 +0000
Message-Id: <20180222152307.7499-19-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/32] sdcard: update the CSD CRC register
 regardless the CSD structure version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cc347ff782..110f2f1d0a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -378,7 +378,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x20 |	/* Max. write data block length */
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
-        sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
     } else {			/* SDHC */
         size /= 512 * 1024;
         size -= 1;
@@ -397,8 +396,8 @@ static void sd_set_csd(SDState *sd, uint64_t size)
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
