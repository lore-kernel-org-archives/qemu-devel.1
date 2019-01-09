Received: from eggs.gnu.org ([209.51.188.92]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghMfB-0007OM-2k
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 17:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghMf9-0006Lq-Cn
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 17:49:28 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 9 Jan 2019 23:37:33 +0100
Message-Id: <20190109224919.2082F7456A2@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ppc440: Avoid reporting error when reading
 non-existent RAM slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

When reading base register of RAM slot with no RAM we should not try
to calculate register value because that will result printing an error
due to invalid RAM size. Just return 0 without the error in this case.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index c489368905..9130eb314c 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -613,8 +613,10 @@ static uint32_t dcr_read_sdram(void *opaque, int dcrn)
     case SDRAM_R1BAS:
     case SDRAM_R2BAS:
     case SDRAM_R3BAS:
-        ret = sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
-                        sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
+        if (sdram->ram_sizes[dcrn - SDRAM_R0BAS]) {
+            ret = sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
+                            sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
+        }
         break;
     case SDRAM_CONF1HB:
     case SDRAM_CONF1LL:
-- 
2.13.7
