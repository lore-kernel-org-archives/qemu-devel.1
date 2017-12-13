Received: from eggs.gnu.org ([2001:4830:134:3::10]:57591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBf-0002i4-BJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBb-0005Rm-OJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:27 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBb-0005Rc-Jk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:23 -0500
Received: by mail-qk0-x244.google.com with SMTP id 84so3515202qks.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 11:59:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 16:58:41 -0300
Message-Id: <20171213195852.30439-4-f4bug@amsat.org>
In-Reply-To: <20171213195852.30439-1-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/14] sdhci: use the ldst_le_dma() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

This makes the code slightly safer, also easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 312b167bfa..e39623baba 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -603,14 +603,12 @@ typedef struct ADMADescr {
 
 static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 {
-    uint32_t adma1 = 0;
-    uint64_t adma2 = 0;
+    uint32_t adma1;
+    uint64_t adma2;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma2,
-                        sizeof(adma2));
-        adma2 = le64_to_cpu(adma2);
+        adma2 = ldq_le_dma(&address_space_memory, entry_addr);
         /* The spec does not specify endianness of descriptor table.
          * We currently assume that it is LE.
          */
@@ -620,9 +618,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->incr = 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma1,
-                        sizeof(adma1));
-        adma1 = le32_to_cpu(adma1);
+        adma1 = ldl_le_dma(&address_space_memory, entry_addr);
         dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
         dscr->attr = (uint8_t)extract32(adma1, 0, 7);
         dscr->incr = 4;
@@ -633,14 +629,9 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(&address_space_memory, entry_addr,
-                        (uint8_t *)(&dscr->attr), 1);
-        dma_memory_read(&address_space_memory, entry_addr + 2,
-                        (uint8_t *)(&dscr->length), 2);
-        dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(&address_space_memory, entry_addr + 4,
-                        (uint8_t *)(&dscr->addr), 8);
-        dscr->attr = le64_to_cpu(dscr->attr);
+        dscr->attr = ldub_dma(&address_space_memory, entry_addr);
+        dscr->length = lduw_le_dma(&address_space_memory, entry_addr + 2);
+        dscr->attr = ldq_le_dma(&address_space_memory, entry_addr + 4);
         dscr->attr &= 0xfffffff8;
         dscr->incr = 12;
         break;
-- 
2.15.1
