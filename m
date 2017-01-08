Received: from eggs.gnu.org ([2001:4830:134:3::10]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQ90O-0004Yf-Lo
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQ90N-0000OI-M8
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:39:08 -0500
From: Marcin Krzeminski <mar.krzeminski@gmail.com>
Date: Sun,  8 Jan 2017 09:38:54 +0100
Message-Id: <20170108083854.5006-4-mar.krzeminski@gmail.com>
In-Reply-To: <20170108083854.5006-1-mar.krzeminski@gmail.com>
References: <20170108083854.5006-1-mar.krzeminski@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/3] block: m25p80: Improve 1GiB Micron
 flash definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, clg@kaod.org, mar.krzeminski@gmail.com

n25q00 and mt25q01 devices share the same JEDEC ID. The difference
between those two devices is number of dies and one bit in extended
JEDEC bytes. This commit adds proper entry for both devices by
introduction the number of dies and and new 25q00 entries.

Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
---
 hw/block/m25p80.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a9b025b..fb5cef3 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -242,8 +242,10 @@ static const FlashPartInfo known_devices[] = {
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
2.9.3
