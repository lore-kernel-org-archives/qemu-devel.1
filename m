Received: from eggs.gnu.org ([2001:4830:134:3::10]:37090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc1B-0001EW-5o
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc17-0000Kp-Vq
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:21 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:45560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc17-0000FM-Od
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:17 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:17 +0100
Message-ID: <20180620120620.12806-33-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 32/35] hw/mips: Fix semihosting argument
 passing for nanoMIPS bare metal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Stefan Markovic <stefan.markovic@mips.com>

Fix semihosting argument passing for nanoMIPS bare metal

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 hw/mips/mips_malta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index c4139d6..6207d83 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -642,7 +642,12 @@ static void write_bootloader_nanomips(uint8_t *base, int64_t run_addr,
     stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
 
     /* to_here: */
-    stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    if (semihosting_get_argc()) {
+        /* Preserve a0 content as arguments have been passed */
+        stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    } else {
+        stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    }
     stw_p(p++, 0xe3a0 | NM_HI1(ENVP_ADDR - 64));
     stw_p(p++, NM_HI2(ENVP_ADDR - 64));
                                 /* lui sp,%hi(ENVP_ADDR - 64) */
-- 
1.9.1
