Received: from eggs.gnu.org ([2001:4830:134:3::10]:47606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPu-00011T-82
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-0005Ex-Cq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPs-00059u-3w
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPZ-00034l-Uo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:57 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:23 +0000
Message-Id: <1484834995-26826-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/36] block: m25p80: Improve 1GiB Micron flash
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Marcin Krzeminski <mar.krzeminski@gmail.com>

n25q00 and mt25q01 devices share the same JEDEC ID. The difference
between those two devices is number of dies and one bit in extended
JEDEC bytes. This commit adds proper entry for both devices by
introduction the number of dies and and new 25q00 entries.

Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20170108083854.5006-4-mar.krzeminski@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 74c6e39..e904514 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -243,8 +243,10 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
     { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
     { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
-    { INFO("mt25ql01g",   0x20ba21,      0,  64 << 10, 2048, ER_4K) },
-    { INFO("mt25qu01g",   0x20bb21,      0,  64 << 10, 2048, ER_4K) },
+    { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
+    { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
+    { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
+    { INFO_STACKED("mt25qu01g", 0x20bb21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
 
     /* Spansion -- single (large) sector size only, at least
      * for the chips listed here (without boot sectors).
-- 
2.7.4
