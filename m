Received: from eggs.gnu.org ([2001:4830:134:3::10]:53511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgTu-0005ZR-Qv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgTr-0000k5-M4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:14 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:29 -0300
Message-Id: <20171215031547.31006-3-f4bug@amsat.org>
In-Reply-To: <20171215031547.31006-1-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/20] sdhci: use deposit64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

This makes the code slightly safer, also easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b7d2a20985..3c78033d49 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1132,12 +1132,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->admaerr, mask, value);
         break;
     case SDHC_ADMASYSADDR:
-        s->admasysaddr = (s->admasysaddr & (0xFFFFFFFF00000000ULL |
-                (uint64_t)mask)) | (uint64_t)value;
+        s->admasysaddr = deposit64(s->admasysaddr, 0, 32, value);
         break;
     case SDHC_ADMASYSADDR + 4:
-        s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
-                ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
+        s->admasysaddr = deposit64(s->admasysaddr, 32, 32, value);
         break;
     case SDHC_FEAER:
         s->acmd12errsts |= value;
-- 
2.15.1
